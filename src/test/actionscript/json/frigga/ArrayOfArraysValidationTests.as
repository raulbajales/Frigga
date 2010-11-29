package json.frigga
{
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	
	import json.frigga.report.FriggaReport;

	/**
	 * 
	 * @author rbajales@playdom.com
	 */
	public class ArrayOfArraysValidationTests
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
							streets : {
								type : "array",
								items : {
									properties : {
										streetName : {
											type : "string"
										}
									}
								}
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
						streets : [
							{streetName : "street 1"},
							{streetName : "street 2"}
						]
				    }
			    ]
		};

		private var invalidObject : Object = {
			firstName : "Marcus",
			addresses : [
				{
					streets : [
						{
							streetName : "street 1",
							streetNumber : 123
						}
					]
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
			assertTrue(report.getMessages().length == 1);
			trace(report.getMessagesAsString());
		}
    }
}