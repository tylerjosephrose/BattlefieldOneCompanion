/*
This file is to store all the data as well as to make and refresh the API calls
*/

using Toybox.Communications as Comm;

class PlayerData {

    function onReceieve(responseCode, data) {
       if (responseCode == 200){
           System.println("Request Successful");                  // print success
           System.println("Response: " + responseCode);
           //System.println(data);
           return data;
       }
       else {
           System.println("Response: " + responseCode);            // print response code
           //System.println(data);
           return "No data";
       }

   }

   function GetData(specType) {
        // TODO: make API call
        var platform = "3";
        var username = "tylerjosephrose";
        var url = "https://battlefieldtracker.com/bf1/api/Stats/" + specType + "?platform=" + platform + "&displayName=" + username;
        response = PlayerData.makeHttpCall(url);
        System.println(response);
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
            :responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

        return Comm.makeWebRequest(url, null, options, method(:onReceieve));
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