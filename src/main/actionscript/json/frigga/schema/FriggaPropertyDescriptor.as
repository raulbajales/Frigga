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
	public class FriggaPropertyDescriptor
	{
		public var title : String;
		public var description : String;
		public var optional : Boolean;
		public var minimum : Number;
		public var maximum : Number;
		public var minimumCanEqual : Boolean;
		public var maximumCanEqual : Boolean;
		public var minItems : Number;
		public var maxItems : Number;
		public var uniqueItems : Boolean;
		public var pattern : String;
		public var maxLength : Number;
		public var minLength : Number;
		public var enum : Array;
		public var defaultValue : Object;
		public var type : FriggaSchema;
		public var items : FriggaSchema;
		
		public function FriggaPropertyDescriptor(
			title : String,
			description : String,
			optional : Boolean,
			minimum : Number,
			maximum : Number,
			minimumCanEqual : Boolean,
			maximumCanEqual : Boolean,
			minItems : Number,
			maxItems : Number,
			uniqueItems : Boolean,
			pattern : String,
			maxLength : Number,
			minLength : Number,
			enum : Array,
			defaultValue : Object,
			type : FriggaSchema,
			items : FriggaSchema
		) {
			this.title = title;
			this.description = description;
			this.optional = optional;
			this.minimum = minimum;
			this.maximum = maximum;
			this.minimumCanEqual = minimumCanEqual;
			this.maximumCanEqual = maximumCanEqual;
			this.minItems = minItems;
			this.maxItems = maxItems;
			this.uniqueItems = uniqueItems;
			this.pattern = pattern;
			this.maxLength = maxLength;
			this.minLength = minLength;
			this.enum = enum;
			this.defaultValue = defaultValue;
			this.type = type;
			this.items = items;
		}
	}
}