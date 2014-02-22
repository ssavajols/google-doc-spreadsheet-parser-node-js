var fs = require('fs');

// SAMPLE PARSER
var parser = {
	json: {},
	set_parser: function(parser) {
		this.parser = parser;
	},
	parser: function() {},
	parse: function(json) {
		from_parser = this.parser(JSON.parse(json).feed.entry);

		if (Array.isArray(from_parser)) {

			for (var index = 0, len = from_parser.length; index < len; index++) {
				_writeFile(from_parser[index].filename, from_parser[index].rows);
			}

		} else {

			_writeFile(from_parser.filename, from_parser.rows);

		}
	}
};

// XML WRAPPER FOR GENERATED FILES
var EOL = "\r\n";
var wrapper_xml_file = {
	start: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+EOL+"<root>",
	end:"</root>"
};
var wrapper_php_file = {
	start: "<?php ",
	end:"?>"
};

// WRITE FILES INTO JSON/XML FORMAT
function _writeFile(filename, content){

	if( filename.match(/(.*)\.xml/) ){
		content = wrapper_xml_file.start+EOL+content.join(EOL)+EOL+wrapper_xml_file.end;
	}else if( filename.match(/(.*)\.php/) ){
		content = wrapper_php_file.start+EOL+content.join(EOL)+EOL+wrapper_php_file.end;
	}else{
		content = JSON.stringify(content);
	}
	fs.writeFile(filename, content);
}

module.exports = parser;