# Require doc_js module
gdoc_js = require './lib/gdoc_js'

# Parser to use
i18n_parser = require './parser/i18n'

# Spreedsheet key / sheet number
spreedsheet = "__PLACE SPREADSHEET KEY HERE__"
sheet = "1"

# Execute script parser
gdoc_js.get_private_sheet(spreedsheet, sheet, i18n_parser);