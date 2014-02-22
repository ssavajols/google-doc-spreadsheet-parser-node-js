module.exports = function(entries){
	var rows = {}; // MUST BE OBJECT TO JSON STRINGIFY
	
	// PARSE ENTRIES
	for(var index=0, len=entries.length; index<len; index++){
		var key = entries[index].gsx$key.$t;
		var value = entries[index].gsx$value.$t;

		rows[key] = value;
	}

	// RETURN OBJECT WITH FILENAME AND ROWS
	// OR RETURN ARRAY WIDTH OBJECTS CONTAINNING
	// FILENAME AND ROWS
	// Ex: 
	//  [
	//		{
	//			filename: './test2.json',
	//			rows: rows
	//		},
	//		{
	//			filename: './test2.json',
	//			rows: rows
	//		}
	//	]
	return {
		filename: './test2.json',
		rows: rows
	};
};