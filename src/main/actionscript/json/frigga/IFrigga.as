package json.frigga
{
	import json.frigga.report.FriggaReport;

	/**
	 * AS3 JSON Schema Validator
	 *
	 * @author raul.bajales@gmail.com 
	 */
	public interface IFrigga
	{
		function validate(jsonObj : Object) : FriggaReport;
	}
}