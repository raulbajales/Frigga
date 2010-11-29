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
package json.frigga
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	
	import json.frigga.report.FriggaMessage;
	import json.frigga.report.FriggaReport;

	public class SimpleUsageTest
	{	
		private var invalidObject : Object = {
			id : "shoe 123",
			name : "Shoes",
			price : -20
		};

		private var validObject : Object = {
			id : 123,
			name : "Shoes",
			price : 15
		};
			
		private var schema : Object = {
			name : "Product",
			description : "Product definition",
			type : "object",
			properties : {
				id : {
					type : "number",
					description : "Product identifier"
				},
				name : {
					description : "Name of the product",
					type : "string"
				},
				price : {
					type : "number",
					minimum : 0
				}
			}
		}; 
		
		[Test]
		public function testValidateAndCheckReport() : void {
			var frigga : Frigga = Frigga.forSchema(this.schema);
			var report : FriggaReport = frigga.validate(this.invalidObject);
			assertFalse(report.isValid());
			assertTrue(report.getMessages().length == 2); 
			trace(report.getMessagesAsString());
		}
		
		[Test]
		public function testOneLineValidation() : void {
			assertTrue(Frigga.forSchema(this.schema).validate(this.validObject).isValid());
		}
	}
}