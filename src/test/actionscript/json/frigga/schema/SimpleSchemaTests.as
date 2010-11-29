package json.frigga.schema
{
	import org.flexunit.asserts.assertTrue;

	public class SimpleSchemaTests
	{		
		[Test]
		public function testBuildSchemaFromObject() : void {
			var schema : FriggaSchema = FriggaSchema.fromObject({
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
					},
					tags : {
						optional : true,
						type : "array",
						items : {
							type : "string"
						}
					}
				}
			});
			
			assertTrue(schema.getHeader().name == "Product");
			assertTrue(schema.getHeader().description == "Product definition");
			assertTrue(schema.getHeader().type == "object");
			assertTrue(schema.getMandatory().length == 3);
			assertTrue(schema.getMandatory().indexOf("tags") == -1);
			assertTrue(schema.getPropDescriptorForPath("name") != null);
			assertTrue(schema.getPropDescriptorForPath("name").description == "Name of the product");
			assertTrue(schema.getPropDescriptorForPath("name").type is FriggaSchema);
			assertTrue(schema.getPropDescriptorForPath("name").type.getHeader().type == "string");
		}
	}
}