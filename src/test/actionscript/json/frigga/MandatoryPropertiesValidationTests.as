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

	public class MandatoryPropertiesValidationTests
	{		
		private var placeInTheWorldSchema : Object = {
			properties : {
				city : {
					type : "string"
				},
				country : {
					type : "string"
				} 
			}
		};
		
		private var addressSchema : Object = {
			properties : {
				street : {
					type : "string"
				},
				number : {
					type : "number"
				},
				placeInTheWorld : {
					type : placeInTheWorldSchema
				}
			}
		};
		
		private var cardSchema : Object = {
			properties : {
				firstName : {
					type : "string"
				},
				address : {
					type : addressSchema
				}
			}
		}; 
		
		private var validObject : Object = {
			firstName : "Marcus",
			address : {
				street : "some street",
				number : 123,
				placeInTheWorld : {
					city : "some city",
					country : "some country"
				}
			}
		};
		
		private var invalidObject : Object = {
			firstName : "Marcus",
			address : {
				number : 123,
				placeInTheWorld : {
					country : 32,
					otherData : "none" 
				}
			}
		};
		
		[Test]
		public function testItemsOnValidObject() : void {
			var frigga : Frigga = Frigga.forSchema(this.cardSchema);
			var report : FriggaReport = frigga.validate(this.validObject);
			assertTrue(report.isValid());
		}
		
		[Test]
		public function testItemsOnInvalidObject() : void {
			var frigga : Frigga = Frigga.forSchema(this.cardSchema);
			var report : FriggaReport = frigga.validate(this.invalidObject);
			assertFalse(report.isValid());
			assertTrue(report.getMessages().length == 4);
			trace(report.getMessagesAsString());
		}
	}
}