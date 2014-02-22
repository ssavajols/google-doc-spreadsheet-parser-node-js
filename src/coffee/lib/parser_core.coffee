
# SAMPLE PARSER

# XML WRAPPER FOR GENERATED FILES

# WRITE FILES INTO JSON/XML FORMAT
_writeFile = (filename, content) ->
  if filename.match(/(.*)\.xml/)
    content = wrapper_xml_file.start + EOL + content.join(EOL) + EOL + wrapper_xml_file.end
  else if filename.match(/(.*)\.php/)
    content = wrapper_php_file.start + EOL + content.join(EOL) + EOL + wrapper_php_file.end
  else
    content = JSON.stringify(content)
  fs.writeFile filename, content
  return
fs = require("fs")
parser =
  json: {}
  set_parser: (parser) ->
    @parser = parser
    return

  parser: ->

  parse: (json) ->
    from_parser = @parser(JSON.parse(json).feed.entry)
    if Array.isArray(from_parser)
      index = 0
      len = from_parser.length

      while index < len
        _writeFile from_parser[index].filename, from_parser[index].rows
        index++
    else
      _writeFile from_parser.filename, from_parser.rows
    return

EOL = "\r\n"
wrapper_xml_file =
  start: "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + EOL + "<root>"
  end: "</root>"

wrapper_php_file =
  start: "<?php "
  end: "?>"

module.exports = parser