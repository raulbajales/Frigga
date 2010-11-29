package json.frigga
{
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	
	import json.frigga.report.FriggaMessage;
	import json.frigga.report.FriggaReport;

	/**
	 * 
	 * @author rbajales@playdom.com
	 */
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