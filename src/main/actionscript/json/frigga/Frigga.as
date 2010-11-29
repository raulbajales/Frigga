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
	import json.frigga.report.FriggaReport;
	import json.frigga.report.FriggaWriter;
	import json.frigga.schema.FriggaSchema;
	import json.frigga.validator.FriggaValidator;

	public class Frigga implements IFrigga
	{
		private var validator : FriggaValidator;
		
		public function Frigga(schema : FriggaSchema) {
			this.validator = new FriggaValidator(schema);
		}
		
		public static function forSchema(obj : Object) : Frigga {
			var schema : FriggaSchema = FriggaSchema.fromObject(obj);
			return new Frigga(schema);
		} 
		
		public function validate(obj : Object) : FriggaReport
		{
			var writer : FriggaWriter = FriggaReport.getWriter();
			this.validator.traverse(obj, writer);
			return writer.getOutput();
		}
	}
}