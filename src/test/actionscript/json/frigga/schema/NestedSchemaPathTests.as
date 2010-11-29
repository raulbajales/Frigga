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