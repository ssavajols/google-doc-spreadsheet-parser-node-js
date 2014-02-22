module.exports = (entries) ->
  rows = [] # MUST BE ARRAY TO JOIN ALL ENTRIES
  
  # PARSE ENTRIES
  index = 0
  len = entries.length

  while index < len
    key = entries[index].gsx$key.$t
    value = entries[index].gsx$value.$t
    rows.push "<" + key + ">" + value + "</" + key + ">"
    index++
  
  # RETURN OBJECT WITH FILENAME AND ROWS
  # OR RETURN ARRAY WIDTH OBJECTS CONTAINNING
  # FILENAME AND ROWS
  # Ex: 
  #  [
  #		{
  #			filename: './test2.xml',
  #			rows: rows
  #		},
  #		{
  #			filename: './test2.xml',
  #			rows: rows
  #		}
  #	]
  filename: "./test.xml"
  rows: rows