# IMPORT REQUEST NODE MODULE

# GET LOGIN/PASSWORD FROM COMMAND LINE ARGUMENTS
# Ex: node app.js "mylogin" "mypassword"

# URL PATTERNS

# MAIN CLASS DECLARATION // TO EXPORTS

# GET PRIVATE SHEET ( need to be share with the user )

# GET PUBLIC SHEET ( access to all users no authentification required )

# CALLBACK QUERY WHO SET PARSER AND EXCUTE PARSE BODY
_callbackQuery = (e, r, body, parser) ->
  if not e and r.statusCode is 200
    parser_core.set_parser parser
    parser_core.parse body
  else
    console.log r.statusCode, e
  return

# DO QUERY WITH URL AND CALLBACK
_doQuery = (url, callback) ->
  request url, callback
  return

# GET CLIENT LOGIN FOR PRIVATE SHEETS
_client_login = (url, action, callback) ->
  
  # do client login request
  request.post client_login_url,
    form:
      accountType: "HOSTED_OR_GOOGLE"
      Email: login
      Passwd: password
      service: "wise"
      source: "gdoc_js"
  , (e, r, b) ->
    
    # get auth and set it to headers for request url sheet
    auth = b.match(/Auth=([a-z0-9_-]+)/i)
    auth = (if auth and auth[1] then auth[1] else null)
    
    # set headers with auth key
    options =
      url: url
      headers:
        Authorization: "GoogleLogin auth=" + auth
        "GData-Version": "3.0"

    
    # _doQuery
    action options, callback
    return

  return
request = require("request")
parser_core = require("./parser_core")
login = process.env.npm_config_login
password = process.env.npm_config_pass
private_url = "https://spreadsheets.google.com/feeds/list/%key%/%sheet%/private/values?alt=json"
public_url = "https://spreadsheets.google.com/feeds/list/%key%/%sheet%/public/values?alt=json"
client_login_url = "https://www.google.com/accounts/ClientLogin"
gdoc_js =
  get_private_sheet: (key, sheet, parser) ->
    url = private_url.replace("%key%", key).replace("%sheet%", sheet)
    _client_login url, _doQuery, (e, r, body) ->
      _callbackQuery e, r, body, parser
      return

    return

  get_public_sheet: (key, sheet, parser) ->
    url = public_url.replace("%key%", key).replace("%sheet%", sheet)
    _doQuery url, (e, r, body) ->
      _callbackQuery e, r, body, parser
      return

    return


# EXPORT TO MODULE
module.exports = gdoc_js