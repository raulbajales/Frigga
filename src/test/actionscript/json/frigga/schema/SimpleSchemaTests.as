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