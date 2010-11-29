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
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	
	import json.frigga.report.FriggaReport;

	public class ItemsValidationTests
	{		
		private var schema : Object = {
			type : "object",
			properties : {
				firstName : {
					type : "string"
				},
				addresses : {
					type : "array",
					items : {
						properties : {
							street : {
								type : "string"
							},
							number : {
								type : "number"
							}
						}
					}
				}
			}
		}; 
		
		private var validObject : Object = {
			firstName : "Marcus",
			addresses : [
				    {
						street : "some street",
						number : 12
				    },
					{
						street : "some other street",
						number : 1029
					},
					{
						street : "some other street far away",
						number : 99
					}
			    ]
		};

		private var invalidObject : Object = {
			firstName : "Marcus",
			addresses : [
				{
					street : "some street",
					number : 12
				},
				{
					street : "some other street",
					number : "unknown number"
				},
				{
					street : "some other street far away",
					number : 99,
					extraInfo : "this is too far"
				}
			]
		};

		[Test]
		public function testItemsOnValidObject() : void {
			var frigga : Frigga = Frigga.forSchema(this.schema);
			var report : FriggaReport = frigga.validate(this.validObject);
			assertTrue(report.isValid());
		}

		[Test]
		public function testItemsOnInvalidObject() : void {
			var frigga : Frigga = Frigga.forSchema(this.schema);
			var report : FriggaReport = frigga.validate(this.invalidObject);
			assertFalse(report.isValid());
			trace(report.getMessagesAsString());
		}
    }
}