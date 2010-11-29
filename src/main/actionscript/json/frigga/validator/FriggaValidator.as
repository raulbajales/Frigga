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
package json.frigga.validator
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import json.frigga.report.FriggaMessage;
	import json.frigga.report.FriggaWriter;
	import json.frigga.schema.FriggaPropertyDescriptor;
	import json.frigga.schema.FriggaSchema;

	public class FriggaValidator
	{
		private var schema : FriggaSchema;
		private var validTypes : Dictionary = new Dictionary();
		
		public function FriggaValidator(schema : FriggaSchema) {
			this.schema = schema;
			this.validTypes["Object"] = "object";
			this.validTypes["String"] = "string";
			this.validTypes["Number"] = "number";
			this.validTypes["Boolean"] = "boolean";
			this.validTypes["Array"] = "array";
		}
		
		public function traverse(obj : Object, writer : FriggaWriter, root : String = "") : void {
			if (obj == null)
				return;
			
			// Check properties in object for those not in schema and those with invalid type:
			for (var prop : String in obj) {
				var path : String = (root != "" ? (root + ".") : "") + prop; 
				var propValue : * = obj[prop];
			    var descriptor : FriggaPropertyDescriptor = this.schema.getPropDescriptorForPath(path);
				if (descriptor == null) 
					writer.writeMessage(FriggaMessage.PROPERTY_NOT_FOUND_IN_SCHEMA_ERROR, path);
				else {
				    var expectedType : String = descriptor.type.getHeader().type;	
					var actualType : String = buildTypeFor(propValue, expectedType);
				    if (expectedType != "any") {
						if (expectedType != actualType)
							writer.writeMessage(FriggaMessage.PROPERTY_TYPE_ERROR, path, actualType);
						else 
							validateConstraints(propValue, descriptor, writer, path);
					}
					if (propValue == null && descriptor.defaultValue != null)
						propValue = descriptor.defaultValue;
					if (actualType == "object")
						traverse(propValue, writer, path);
					if (actualType == "array") {
						for each (var item : * in propValue) {
							if (buildTypeFor(item) == "object")
								traverse(item, writer, path);
						}
					} 
				}
			}
			
			// Check if mandatory properties from schema are present in instance.
			var subSchema : FriggaSchema = findSubSchemaFor(root);
			if (subSchema != null) {
				for each (var mandatoryPath : String in subSchema.getMandatory()) {
					if (!pathExists(obj, mandatoryPath))
						writer.writeMessage(FriggaMessage.PROPERTY_NOT_FOUND_IN_INSTANCE_ERROR, mandatoryPath);
				}
			}
		}
		
		private function buildTypeFor(obj : *, defaultTo : String = "any") : String {
			if (obj == null) 
				return defaultTo;
			var typeName : String = flash.utils.getQualifiedClassName(obj);
			if (["Array", "Object"].indexOf(typeName) != -1)
				return validTypes[typeName];
			if (typeName == "String") {
				if (["true", "false", "TRUE", "FALSE", "True", "False"].indexOf(obj as String) != -1)
					return "boolean";
				else if (!isNaN(obj)) 
					return "number";
				else
				    return "string";
			} else {
				if (!isNaN(obj)) 
					return "number";
			}
			return "object";
		}
		
		private function validateConstraints(prop : *, descriptor : FriggaPropertyDescriptor, writer : FriggaWriter, path : String) : void {
			switch (descriptor.type.getHeader().type) {
				case "array":
					var tmpArray : Array = prop as Array;
					if (tmpArray.length < descriptor.minItems)
						writer.writeMessage(FriggaMessage.PROPERTY_MIN_ITEMS_ERROR, path, tmpArray.length);
					if (tmpArray.length > descriptor.maxItems)
						writer.writeMessage(FriggaMessage.PROPERTY_MAX_ITEMS_ERROR, path, tmpArray.length);
					// TODO (rbajales): Add support for "uniqueItems"
					break;
				case "number":
					var tmpNumber : Number = prop as Number;
					if (descriptor.minimumCanEqual) {
						if (tmpNumber <= descriptor.minimum)
							writer.writeMessage(FriggaMessage.PROPERTY_OUT_OF_RANGE_ERROR, path, tmpNumber);
					} else 
						if (tmpNumber < descriptor.minimum)
							writer.writeMessage(FriggaMessage.PROPERTY_OUT_OF_RANGE_ERROR, path, tmpNumber);
					if (descriptor.maximumCanEqual) {
						if (tmpNumber >= descriptor.maximum)
							writer.writeMessage(FriggaMessage.PROPERTY_OUT_OF_RANGE_ERROR, path, tmpNumber);
					} else 
						if (tmpNumber > descriptor.maximum)
							writer.writeMessage(FriggaMessage.PROPERTY_OUT_OF_RANGE_ERROR, path, tmpNumber);
					break;
				case "string":
					var tmpString : String = prop as String;
					if (descriptor.enum.length > 0 && descriptor.enum.indexOf(tmpString) == -1) {
						writer.writeMessage(FriggaMessage.PROPERTY_NOT_IN_ENUM_ERROR, path, tmpString);
					}
					if (tmpString.length < descriptor.minLength) 
						writer.writeMessage(FriggaMessage.PROPERTY_LENGTH_ERROR, path, tmpString);
					if (tmpString.length > descriptor.maxLength) 
						writer.writeMessage(FriggaMessage.PROPERTY_LENGTH_ERROR, path, tmpString);
					if (descriptor.pattern != "" && !RegExp(descriptor.pattern).test(tmpString))
						writer.writeMessage(FriggaMessage.PROPERTY_REGEX_ERROR, path, tmpString);
					break;
			}
		}
		
		private function pathExists(obj : Object, path : String) : Boolean {
			if (path.indexOf(".") == -1)
				return obj[path] != null;
			var root : String = path.substr(0, path.indexOf("."));
			var rest : String = path.substr(path.indexOf(".") + 1, path.length - root.length - 1);
			return pathExists(obj[root], rest);
		}
		
		private function findSubSchemaFor(root : String) : FriggaSchema {
			if (root == "")
				return this.schema;
			else if (this.schema.getPropDescriptorForPath(root) != null)
			    return this.schema.getPropDescriptorForPath(root).type
			else return null;
		}
	}
}
