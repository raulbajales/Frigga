package json.frigga.schema
{
	public class FriggaPropertyDescriptor
	{
		public var title : String;
		public var description : String;
		public var optional : Boolean;
		public var minimum : Number;
		public var maximum : Number;
		public var minimumCanEqual : Boolean;
		public var maximumCanEqual : Boolean;
		public var minItems : Number;
		public var maxItems : Number;
		public var uniqueItems : Boolean;
		public var pattern : String;
		public var maxLength : Number;
		public var minLength : Number;
		public var enum : Array;
		public var defaultValue : Object;
		public var type : FriggaSchema;
		public var items : FriggaSchema;
		
		public function FriggaPropertyDescriptor(
			title : String,
			description : String,
			optional : Boolean,
			minimum : Number,
			maximum : Number,
			minimumCanEqual : Boolean,
			maximumCanEqual : Boolean,
			minItems : Number,
			maxItems : Number,
			uniqueItems : Boolean,
			pattern : String,
			maxLength : Number,
			minLength : Number,
			enum : Array,
			defaultValue : Object,
			type : FriggaSchema,
			items : FriggaSchema
		) {
			this.title = title;
			this.description = description;
			this.optional = optional;
			this.minimum = minimum;
			this.maximum = maximum;
			this.minimumCanEqual = minimumCanEqual;
			this.maximumCanEqual = maximumCanEqual;
			this.minItems = minItems;
			this.maxItems = maxItems;
			this.uniqueItems = uniqueItems;
			this.pattern = pattern;
			this.maxLength = maxLength;
			this.minLength = minLength;
			this.enum = enum;
			this.defaultValue = defaultValue;
			this.type = type;
			this.items = items;
		}
	}
}