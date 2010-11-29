package json.frigga
{
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	
	import json.frigga.report.FriggaReport;

	/**
	 * 
	 * @author rbajales@playdom.com
	 */
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