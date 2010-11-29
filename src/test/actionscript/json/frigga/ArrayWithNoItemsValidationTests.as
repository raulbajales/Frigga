package json.frigga
{
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	
	import json.frigga.report.FriggaReport;
	
	/**
	 * 
	 * @author rbajales@playdom.com
	 */
	public class ArrayWithNoItemsValidationTests
	{		
		private var schema : Object = {
			type : "object",
			properties : {
				userId : {
					type : "string"
				},
				friendIds : {
					type : "array"
				}
			}
		}; 
		
		private var validObject : Object = {
			userId : "user1",
			friendIds : ["user2", "user3"]
		};
		
		[Test]
		public function testItemsOnValidObject() : void {
			var frigga : Frigga = Frigga.forSchema(this.schema);
			var report : FriggaReport = frigga.validate(this.validObject);
			assertTrue(report.isValid());
		}
	}
}