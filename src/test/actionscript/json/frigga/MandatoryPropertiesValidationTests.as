package json.frigga
{
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	
	import json.frigga.report.FriggaReport;

	/**
	 * 
	 * @author rbajales@playdom.com
	 */
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