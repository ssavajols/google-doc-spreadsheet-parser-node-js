# google-doc-spreadsheet-parser-node-js


## Introduction ##

Parse google doc spreadshit with node.js. Output in JSON, XML or PHP data's from google doc.

Can parse public or private spreadsheet.

For private spreadsheet, authentification (google account) required from user who can access to the document. 


----------

**JAVASCRIPT Native and COFFEE SCRIPT versions are available.**

----------


## Getting Started ##

Node.js is require

Execute install.bat to install node modules or the following command line :

    npm install

Edit app.coffee :

    	
	# Parser to use
	i18n_parser = require './parser/i18n'

    # Spreedsheet key / sheet number
    spreedsheet = "__PLACE SPREADSHEET KEY HERE__"
    sheet = "1"
    

Execute import.bat to start parser or the following command line :


    npm --login=%login% --pass=%password% run-script import
    

## Create custom parser ##

To create custom parser, you need to edit or create new parser file in parser folder. Sample parser is already exist in the parser directory.

### Sample parser i18n with single generated json file :

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
       


### Sample parser i18n with multiple generated json files :

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
	  [
	  	  {
			  filename: "./i18n-fr.json"
     		  rows: rows
		  },
		  {
			  filename: "./i18n-en.json"
      		  rows: rows
		  },
	  ]
      
       

