// IMPORT REQUEST NODE MODULE
var request = require('request');
var parser_core = require('./parser_core');

// GET LOGIN/PASSWORD FROM COMMAND LINE ARGUMENTS
// Ex: node app.js "mylogin" "mypassword"
var login = process.argv[2];
var password = process.argv[3];

// URL PATTERNS
var private_url = "https://spreadsheets.google.com/feeds/list/%key%/%sheet%/private/values?alt=json";
var public_url = "https://spreadsheets.google.com/feeds/list/%key%/%sheet%/public/values?alt=json";
var client_login_url = "https://www.google.com/accounts/ClientLogin";

// MAIN CLASS DECLARATION // TO EXPORTS
var gdoc_js = {
	// GET PRIVATE SHEET ( need to be share with the user )
	get_private_sheet: function(key, sheet, parser) {
		var url = private_url.replace('%key%', key).replace('%sheet%', sheet);
		_client_login(url, _doQuery, function(e,r,body){ _callbackQuery(e,r,body,parser);});
	},
	// GET PUBLIC SHEET ( access to all users no authentification required )
	get_public_sheet: function(key, sheet, parser) {
		var url = public_url.replace('%key%', key).replace('%sheet%', sheet);
		_doQuery(url, function(e,r,body){ _callbackQuery(e,r,body,parser);});
	}
};

// CALLBACK QUERY WHO SET PARSER AND EXCUTE PARSE BODY
function _callbackQuery(e, r, body, parser){
		if( !e && r.statusCode === 200){
			parser_core.set_parser(parser);
			parser_core.parse(body);
		}else{
			console.log(r.statusCode, e);
		}
}

// DO QUERY WITH URL AND CALLBACK
function _doQuery(url, callback) {
		request(url, callback);
}

// GET CLIENT LOGIN FOR PRIVATE SHEETS
function _client_login(url, action, callback) {
	// do client login request
	request.post(client_login_url, {
		form: {
			accountType: "HOSTED_OR_GOOGLE",
			Email: login,
			Passwd: password,
			service: "wise",
			source: "gdoc_js"
		}
	}, function(e,r,b){
		// get auth and set it to headers for request url sheet
		var auth = b.match(/Auth=([a-z0-9_-]+)/i);
		auth = auth && auth[1] ? auth[1] : null;

		// set headers with auth key
		var options = {
			url: url,
			headers: {
            "Authorization": "GoogleLogin auth=" + auth,
            "GData-Version": "3.0"
			}
		};

		// _doQuery
		action(options, callback);
	});

}

// EXPORT TO MODULE
module.exports = gdoc_js;