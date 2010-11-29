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

	public class FriggaSchemaBuilder
	{
		private var name : String;
		private var description : String;
		private var type : String;
		private var mandatory : Vector.<String> = new Vector.<String>();
		private var index : Dictionary = new Dictionary();
		
		public function extractPropertyDescriptorsFrom(obj : Object) : FriggaSchemaBuilder {
			var value : Object = extractValueFromObject(obj, "properties");
			var tmpIndex : Dictionary = new Dictionary();
			for (var prop : String in value) {
				var descriptor : FriggaPropertyDescriptor = buildPropertyDescriptorFrom(value[prop]);
				if (!descriptor.optional) 
					mandatory.push(prop);
				tmpIndex[prop] = descriptor; 
			}
			setIndex(tmpIndex);
			setMandatory(mandatory);
			return this;
		}		

		public function extractNameFrom(obj : Object) : FriggaSchemaBuilder {
			var value : String = extractValueFromObject(obj, "name") as String;
			return setName(value);
		}
		
		public function extractDescriptionFrom(obj : Object) : FriggaSchemaBuilder {
			var value : String = extractValueFromObject(obj, "description") as String;
			return setDescription(value);
		}

		public function extractTypeFrom(obj : Object) : FriggaSchemaBuilder {
			var value : String = extractValueFromObject(obj, "type", "object") as String;
			return setType(value);
		}

		public function getIt() : FriggaSchema {
			return new FriggaSchema(this.index, this.mandatory, this.name, this.description, this.type);
		}
		
		public function setName(name : String) : FriggaSchemaBuilder {
		    this.name = name;
			return this;
		}			

		public function setDescription(description : String) : FriggaSchemaBuilder {
			this.description = description;
			return this;
		}			

		public function setType(type : String) : FriggaSchemaBuilder {
			this.type = type;
			return this;
		}

		public function setMandatory(mandatory : Vector.<String>) : FriggaSchemaBuilder {
			this.mandatory = mandatory;
			return this;
		}

		public function setIndex(index : Dictionary) : FriggaSchemaBuilder {
			this.index = index;
			return this;
		}

		private function extractValueFromObject(obj : Object, propertyName : String, defaultValue : * = "") : Object {
			if (obj == null)
				return defaultValue;
			if (propertyName in obj)
				return obj[propertyName];
			else 
				return defaultValue;
		}

		private function buildPropertyDescriptorFrom(obj : Object) : FriggaPropertyDescriptor {
			// Support for "title"
			var title : String = extractValueFromObject(obj, "title") as String;
			
			// Support for "description"
			var description : String = extractValueFromObject(obj, "description") as String;
			
			// Support for "optional"
			var optional : Boolean = extractValueFromObject(obj, "optional", false) as Boolean;
			
			// Support for "minimum"
			var minimum : Number = extractValueFromObject(obj, "minimum", -Number.MAX_VALUE) as Number;
			
			// Support for "maximum"
			var maximum : Number = extractValueFromObject(obj, "maximum", Number.MAX_VALUE) as Number;
			
			// Support for "minimumCanEqual"
			var minimumCanEqual : Boolean = extractValueFromObject(obj, "minimumCanEqual", false) as Boolean;
			
			// Support for "maximumCanEqual"
			var maximumCanEqual : Boolean = extractValueFromObject(obj, "maximumCanEqual", false) as Boolean;
			
			// Support for "minItems"
			var minItems : Number = extractValueFromObject(obj, "minItems", 0) as Number;
			
			// Support for "maxItems"
			var maxItems : Number = extractValueFromObject(obj, "maxItems", Number.MAX_VALUE) as Number;
			
			// Support for "uniqueItems"
			var uniqueItems : Boolean = extractValueFromObject(obj, "uniqueItems", false) as Boolean;
			
			// Support for "pattern"
			var pattern : String = extractValueFromObject(obj, "pattern", "") as String;
			
			// Support for "maxLength"
			var maxLength : Number = extractValueFromObject(obj, "maxLength", Number.MAX_VALUE) as Number;
			
			// Support for "minLength"
			var minLength : Number = extractValueFromObject(obj, "minLength", 0) as Number;
			
			// Support for "enum"
			var enum : Array = extractValueFromObject(obj, "enum", []) as Array;
			
			// Support for "default"
			var defaultValue : Object = extractValueFromObject(obj, "default", "");
			
			// Support for "type"
			// TODO (rbajales): add support for array of types here, also, if the type is a String, then it must be a reference to another schema,
			// then Frigga must handle a repository of schemas.
			var type : FriggaSchema;
			var tmpType : Object = extractValueFromObject(obj, "type", "object");
			if (tmpType is String) {
				validateSimpleType(tmpType as String);
				type = new FriggaSchema(null, null, null, null, tmpType as String);
			} else {
				type = FriggaSchema.fromObject(tmpType);
			}
			
			// Support for "items"
			// TODO (rbajales) Add support for array of schema names (and tupled typing).
			// Now it only support a single schema defined right here (inline).
			var items : FriggaSchema = null;
			var tmpItems : Object = extractValueFromObject(obj, "items");
			if (tmpItems != null)
				items = FriggaSchema.fromObject(tmpItems);
				
			return new FriggaPropertyDescriptor(
				title,
			    description,
				optional,
				minimum,
				maximum,
				minimumCanEqual,
				maximumCanEqual,
				minItems,
				maxItems,
				uniqueItems,
				pattern,
				maxLength,
				minLength,
				enum,
				defaultValue,
				type,
				items
			);
		}
		
		private function validateSimpleType(type : String) : void {
			if (["string", "number", "boolean", "object", "array", "any"].indexOf(type) == -1)
				throw new Error("Invalid schema: Frigga only handles simple types or a schema definition as 'type', reference to an existing schema is not supported: " + type as String);
		}
    }
}