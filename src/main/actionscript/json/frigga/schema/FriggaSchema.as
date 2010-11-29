/*
Copyright (c) 2010 Raul Bajales

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
package json.frigga.schema
{
	import flash.utils.Dictionary;
	
	import json.frigga.report.FriggaMessage;

	public class FriggaSchema
	{
		private var header : FriggaSchemaHeader;
		private var mandatory : Vector.<String> = new Vector.<String>();
		private var index : Dictionary = new Dictionary();
		
		public function FriggaSchema(index : Dictionary = null, mandatory : Vector.<String> = null, name : String = "", description : String = "", type : String = "") {
			this.header = new FriggaSchemaHeader(name, description, type);
			if (mandatory != null) 
				this.mandatory = mandatory;
		    this.index = index;
		}
		
		public static function fromObject(obj : Object) : FriggaSchema {
			return FriggaSchema.builder()
				.extractNameFrom(obj)
				.extractDescriptionFrom(obj)
				.extractTypeFrom(obj)
				.extractPropertyDescriptorsFrom(obj)
				.getIt();
		}
		
		public function getPropDescriptorForPath(path : String) : FriggaPropertyDescriptor {
			if (path == null || path == "")
				return null;
			if (path.indexOf(".") == -1)
			    return index[path];
			var root : String = path.substr(0, path.indexOf("."));
			var rest : String = path.substr(path.indexOf(".") + 1, path.length - root.length - 1);
			var tmp : FriggaPropertyDescriptor = index[root] as FriggaPropertyDescriptor;
			if (tmp != null) {
				if (tmp.type.header.type == "array") {
					if (tmp.items != null) 
						return tmp.items.getPropDescriptorForPath(rest);
					else 
						return null;
				} else 
					return tmp.type.getPropDescriptorForPath(rest);	
			} else
				return null;
		}
		
		public static function builder() : FriggaSchemaBuilder {
			return new FriggaSchemaBuilder();
		}
		
		public function getHeader() : FriggaSchemaHeader {
			return this.header;
		}
		
		public function getMandatory() : Vector.<String> {
			return this.mandatory;
		}		
	}
}