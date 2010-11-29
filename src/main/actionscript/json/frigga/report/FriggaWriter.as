package json.frigga.report
{
	public class FriggaWriter
	{
		private var messages : Vector.<FriggaMessage> = new Vector.<FriggaMessage>();

		public function writeMessage(message : String, property : String = "", actual : * = "") : FriggaWriter {
			if (message != null && message != "") 
			    this.messages.push(new FriggaMessage(message, property, actual));
			return this;
		}
		
		public function getOutput() : FriggaReport {
		    return new FriggaReport(this.messages);	
		}
	}
}