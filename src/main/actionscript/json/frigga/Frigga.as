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