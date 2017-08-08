/*
This file is to store all the data as well as to make and refresh the API calls
*/

using Toybox.Communications as Comm;

class PlayerData extends Toybox.Lang.Object {

	function initialize() {
		Toybox.Lang.Object.initialize();
	}

    function onReceive(responseCode, data) {
       if (responseCode == 200){
           System.println("Request Successful");                  // print success
           System.println("Response: " + responseCode);
           System.println(data);
           parseResponse(data);
       }
       else {
           System.println("Response: " + responseCode);            // print response code
           System.println(data);
       }

   }

   function GetData(specType) {
        // TODO: make API call
        var platform = "3";
        var username = "tylerjosephrose";
        var url = "https://battlefieldtracker.com/bf1/api/Stats/" + specType + "?platform=" + platform + "&displayName=" + username;
        makeHttpCall(url);
    }

    function RefreshData(specType) {
        // TODO: make API call
        var platform = 3;
        var username = tylerjosephrose;
        var url = "https://battlefieldtracker.com/bf1/api/Stats/" + specType + "?platform=" + platform + "&displayName=" + username;
        response = makeHttpCall(url);
        System.println(response);
    }

    function makeHttpCall(url) {
        var param = { "platform" => "3", "displayName" => "tylerjosephrose" };

        var headers = {"TRN-API-KEY" => "6015d133-c1a7-4c7b-83ab-1573751fcb57"};

        var options = {
            :method => Comm.HTTP_REQUEST_METHOD_GET,
            :headers => headers,
            :responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_URL_ENCODED
        };
        
        var responseCallback = method(:onReceive);

        Comm.makeWebRequest(url, null, options, responseCallback);
    }
    
    // Here data is just a string of everything returned so we will parse it into useful information
    function parseResponse(data) {
    	var dataString = data.toString();
    	// remove outside brackets
    	dataString = dataString.substring(1, dataString.length() - 1);
    	var dataArray = tokenizeString(",", dataString);
    	var dataMap = arrayToMap("=>", dataArray);
    	var keyArray = dataMap.keys();
    	for(var i = 0; i < keyArray.size(); i += 1) {
    		System.println(keyArray[i] + " => " + dataMap.get(keyArray[i]));
    	}
    }
    
    function arrayToMap(delimiter, array) {
    	var stringMap = {};
    	for(var i = 0; i < array.size(); i += 1) {
    		var index = array[i].find(delimiter);
    		var key = array[i].substring(0, index);
    		var value = array[i].substring(index + delimiter.length(), array[i].length());
    		stringMap.put(key, value);
    	}
    	return stringMap;
    }
    
    function tokenizeString(delimiter, string) {
    	var stringArray = new[0];
    	while(string.length() > 0) {
    		var tempString;
    		var index = string.find(delimiter);
    		if (index != null) {
    			tempString = string.substring(0, index);
    			//System.println(tempString);
    			stringArray.add(tempString);
    			string = string.substring(index + 2, string.length());
    			//System.println(string);
    		} else {
    			stringArray.add(string);
    			string = "";
    		}
    		//System.println(stringArray.size());
    	}
    	return stringArray;
    }
    

    var ClassDatas;
    var VehicleDatas;
    var GameDatas;
}

class ClassData {

}

class VehicleData {

}

class GameData {

}