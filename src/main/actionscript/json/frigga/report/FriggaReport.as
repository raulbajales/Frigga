package json.frigga.report
{
	public class FriggaReport
	{
		private var messages : Vector.<FriggaMessage> = new Vector.<FriggaMessage>();
		
		public function FriggaReport(messages : Vector.<FriggaMessage>) {
			this.messages = messages;
		}
		
		public function isValid() : Boolean {
			return this.getMessages().length == 0;
		}
		
		public function getMessages() : Vector.<FriggaMessage> {
			return this.messages;
		}
		
		public function getMessagesAsString() : String {
			if (this.messages.length == 0) return "";
			var out : String = "Errors (message | property | actualValue): \n";
			for each (var msg : FriggaMessage in this.messages) 
				out += msg.message 
					+ ((msg.property != null) ? (" | " + msg.property) : "") 
					+ ((msg.actual != "") ? (" | " + msg.actual) : "") 
					+ "\n";
			return out;
		}
		
		public static function getWriter() : FriggaWriter {
			return new FriggaWriter();
		}
	}
}