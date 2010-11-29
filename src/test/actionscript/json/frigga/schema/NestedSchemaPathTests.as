package json.frigga.schema
{
	import org.flexunit.asserts.assertTrue;

	public class NestedSchemaPathTests
	{		
		[Test]
		public function testGetPathForNestedSchema() : void {
			var schema : FriggaSchema = FriggaSchema.fromObject({
				properties : {
					name : {
						type : "string"
					},
					address : {
						type : {
							properties : {
								neighbors : {
									type : "array",
									items : {
										properties : {
											name : "string"
										}
									}
								},
								street : {
									type : "string"
								},
								placeInTheWorld : {
									type : {
										properties : {
											city : {
												type : "string"
											},
											country : {
												type : "string"
											}
                                        }
									}
								}
							}
						}
					}
				}
			});
			
			assertTrue(schema.getPropDescriptorForPath("name") is FriggaPropertyDescriptor);
			assertTrue(schema.getPropDescriptorForPath("address") is FriggaPropertyDescriptor);
			assertTrue(schema.getPropDescriptorForPath("address.street") is FriggaPropertyDescriptor);
			assertTrue(schema.getPropDescriptorForPath("address.placeInTheWorld") is FriggaPropertyDescriptor);
			assertTrue(schema.getPropDescriptorForPath("address.placeInTheWorld.city") is FriggaPropertyDescriptor);
			assertTrue(schema.getPropDescriptorForPath("address.placeInTheWorld.country") is FriggaPropertyDescriptor);
			assertTrue(schema.getPropDescriptorForPath("address.neighbors") is FriggaPropertyDescriptor);
			assertTrue(schema.getPropDescriptorForPath("address.neighbors.name") is FriggaPropertyDescriptor);
		}
	}
}