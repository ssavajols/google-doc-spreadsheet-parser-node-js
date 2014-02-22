module.exports = (entries)->
  # MUST BE OBJECT TO JSON STRINGIFY
  rows = {}

  # PARSE ENTRIES
  index = 0
  len = entries.length

  while index < len
    key = entries[index].gsx$key.$t
    value = entries[index].gsx$value.$t
    rows[key] = value
    index++
    
  # return
  filename: "./test.json"
  rows: rows    
  