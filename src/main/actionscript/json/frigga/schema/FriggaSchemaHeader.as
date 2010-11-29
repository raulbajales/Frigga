package json.frigga.schema
{
	public class FriggaSchemaHeader
	{
		public var name : String;
		public var description : String;
		public var type : String;
		
		public function FriggaSchemaHeader(name : String, description : String, type : String)
		{
			this.name = name;
			this.description = description;
			this.type = type;
		}
	}
}