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
package json.frigga.report
{
	public class FriggaMessage
	{
		public static const INSTANCE_TYPE_ERROR : String = "invalid type on instance";
		public static const PROPERTY_TYPE_ERROR : String = "invalid type on property";
		public static const PROPERTY_NOT_FOUND_IN_SCHEMA_ERROR : String = "property not defined in schema";
		public static const PROPERTY_NOT_FOUND_IN_INSTANCE_ERROR : String = "mandatory property not found in instance";
		public static const PROPERTY_OUT_OF_RANGE_ERROR : String = "number is out of range";
		public static const PROPERTY_MIN_ITEMS_ERROR : String = "array items below the minimum";
		public static const PROPERTY_MAX_ITEMS_ERROR : String = "array items over the maximum";
		public static const PROPERTY_NOT_IN_ENUM_ERROR : String = "value is not in enum values";
		public static const PROPERTY_REGEX_ERROR : String = "value does not match the regular expression";
		public static const PROPERTY_LENGTH_ERROR : String = "value lenght is out of range";
		
		public var message : String = "";
		public var property : String = "";
		public var actual : * = "";
		
		public function FriggaMessage(message : String, property : String = "", actual : * = "")
		{
			this.message = message;
			this.property = property;
			this.actual = actual;
		}
	}
}