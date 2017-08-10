/*
This file is to store all the data as well as to make and refresh the API calls
*/

using Toybox.Communications as Comm;

var playerData;

class PlayerData extends Toybox.Lang.Object {

    function initialize() {
        Toybox.Lang.Object.initialize();
    }
    
    var basicData;
    var detailedData;

    function onReceiveBasic(responseCode, data) {
        System.println("Receive :");
        if (responseCode == 200){
            System.println("Request Successful");                  // print success
            System.println("Response: " + responseCode);
            System.println(data);
            //parseResponse(data);
            basicData = data;
        }
        else {
            System.println("Response: " + responseCode);            // print response code
            System.println(data);
        }
    }
    
    function onReceiveDetailed(responseCode, data) {
        System.println("Receive :");
        if (responseCode == 200){
            System.println("Request Successful");                  // print success
            System.println("Response: " + responseCode);
            System.println(data);
            //parseResponse(data);
            detailedData = data;
        }
        else {
            System.println("Response: " + responseCode);            // print response code
            System.println(data);
        }
    }
    
    function GetData(specType) {
        var platform = "3";
        var username = "tylerjosephrose";
        var url = "https://battlefieldtracker.com/bf1/api/Stats/" + specType + "?platform=" + platform + "&displayName=" + username;
        makeHttpCall(url, specType);
    }

    function makeHttpCall(url, type) {
        var param = { "platform" => "3", "displayName" => "tylerjosephrose" };

        var headers = {"TRN-API-KEY" => "6015d133-c1a7-4c7b-83ab-1573751fcb57"};

        var options = {
            :method => Comm.HTTP_REQUEST_METHOD_GET,
            :headers => headers,
            :responseType => Comm.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };
        
        var responseCallback;
        
        if(type.equals("BasicStats")) {
            responseCallback = method(:onReceiveBasic);
        } else {
            responseCallback = method(:onReceiveDetailed);
        }

        Comm.makeWebRequest(url, null, options, responseCallback);
    }
    
    function parseType(type) {
        var data;
        if (type.equals("BasicStats")) {
            data = basicData;
        } else {
            data = detailedData;
        }
        var dataString = data.toString();
        // remove outside brackets
        dataString = dataString.substring(1, dataString.length() - 1);
        // remove everything before "result=>"
        var index = dataString.find("result=>");
        dataString = dataString.substring(index + 9, dataString.length() - 1);
        if(type.equals("BasicStats")) {
            var dataArray = tokenizeStringBasic(",", dataString);
            var dataMap = arrayToMap("=>", dataArray);
            var keyArray = dataMap.keys();
            /*for(var i = 0; i < keyArray.size(); i += 1) {
                //System.println(keyArray[i] + " => " + dataMap.get(keyArray[i]));
            }*/
            basicToStructure(dataMap);
        } else {
            var dataArray = tokenizeStringDetailed(",", dataString);
            var dataMap = arrayToMap("=>", dataArray);
            var keyArray = dataMap.keys();
            /*for(var i = 0; i < keyArray.size(); i += 1) {
                System.println(keyArray[i] + " => " + dataMap.get(keyArray[i]));
            }*/
            detailedToStructure(dataMap);
        }
        printAllData();
    }
    
    function parseAllData() {
        System.println(basicData);
        System.println(detailedData);
        var basicDataString = basicData.toString();
        var detailedDataString = detailedData.toString();
        // remove outside brackets
        basicDataString = basicDataString.substring(1, basicDataString.length() - 1);
        detailedDataString = detailedDataString.substring(1, detailedDataString.length() - 1);
        // remove everything before "result=>"
        var basicIndex = basicDataString.find("result=>");
        var detailedIndex = detailedDataString.find("result=>");
        basicDataString = basicDataString.substring(basicIndex + 9, basicDataString.length() - 1);
        detailedDataString = detailedDataString.substring(detailedIndex + 9, detailedDataString.length() - 1);
        
        var basicDataArray = tokenizeStringBasic(",", basicDataString);
        for(var i = 0; i < basicDataArray.size(); i += 1) {
            System.println(basicDataArray[i]);
        }
        var basicDataMap = arrayToMap("=>", basicDataArray);
        var keyArray1 = basicDataMap.keys();
        /*for(var i = 0; i < keyArray1.size(); i += 1) {
            System.println(keyArray1[i] + " => " + basicDataMap.get(keyArray1[i]));
        }*/
        basicToStructure(basicDataMap);
        
        var detailedDataArray = tokenizeStringDetailed(",", detailedDataString);
        var detailedDataMap = arrayToMap("=>", detailedDataArray);
        var keyArray2 = detailedDataMap.keys();
        /*for(var i = 0; i < keyArray.size(); i += 1) {
            System.println(keyArray[i] + " => " + dataMap.get(keyArray[i]));
        }*/
        detailedToStructure(detailedDataMap);
        basicData = null;
        detailedData = null;
        printAllData();
    }
    
    function arrayToMap(delimiter, array) {
        var stringMap = {};
        for(var i = 0; i < array.size(); i += 1) {
            var index = array[i].find(delimiter);
            var key = array[i].substring(0, index);
            if (!(key instanceof Toybox.Lang.String)) {
                continue;
            }
            var value = array[i].substring(index + delimiter.length(), array[i].length());
            stringMap.put(key, value);
        }
        return stringMap;
    }
    
    function tokenizeStringBasic(delimiter, string) {
        var stringArray = [];
        while(string.length() > 0) {
            var tempString;
            var index = string.find(delimiter);
            if (index != null) {
                tempString = string.substring(0, index);
                var bracket = tempString.find("{");
                if (bracket == null) {
                    //System.println(tempString);
                    stringArray.add(tempString);
                    string = string.substring(index + 2, string.length());
                    //System.println(string);
                } else {
                    var closeIndex = string.find("}");
                    tempString = string.substring(0, closeIndex + 1);
                    stringArray.add(tempString);
                    string = string.substring(closeIndex + 3, string.length());
                }
            } else {
                stringArray.add(string);
                string = "";
            }
            //System.println("tokenize " + string);
        }
        return stringArray;
    }
    
    function tokenizeStringDetailed(delimiter, string) {
        var stringArray = [];
        while(string.length() > 0) {
            var tempString;
            var index = string.find(delimiter);
            if (index != null) {
                tempString = string.substring(0, index);
                var bracket = tempString.find("[");
                if (bracket == null) {
                    var bracket2 = tempString.find("{");
                    if (bracket2 == null) {
                        //System.println(tempString);
                        stringArray.add(tempString);
                        string = string.substring(index + 2, string.length());
                        //System.println(string);
                    } else {
                        var closeIndex = string.find("}");
                        tempString = string.substring(0, closeIndex + 1);
                        stringArray.add(tempString);
                        string = string.substring(closeIndex + 3, string.length());
                    }
                } else {
                    var closeIndex = string.find("]");
                    tempString = string.substring(0, closeIndex + 1);
                    stringArray.add(tempString);
                    string = string.substring(closeIndex + 3, string.length());
                }
            } else {
                stringArray.add(string);
                string = "";
            }
            //System.println(stringArray.size());
        }
        return stringArray;
    }
    
    function detailedSpecStringToMap(newLineString, wholeString) {
        var stringArray = [];
        while(wholeString.length() > 0) {
            var index = wholeString.find(newLineString);
            if (index != null) {
                stringArray.add(wholeString.substring(1, index - 1));
                wholeString = wholeString.substring(index + 2, wholeString.length());
            } else {
                stringArray.add(wholeString.substring(1, wholeString.length() - 1));
                wholeString = "";
            }
        }
        
        var arrayMap = [];
        for(var i = 0; i < stringArray.size(); i += 1) {
            if (stringArray[i] == 0) {
                continue;
            }
            var gameArray = tokenizeStringBasic(",", stringArray[i]);
            arrayMap.add(arrayToMap("=>", gameArray));
        }
        return arrayMap;
    }
    
    function detailedToStructure(dataMap) {
        classDatas = {};
        vehicleDatas = {};
        gameDatas = {};
        
        revives = dataMap.get("revives");
        longestHeadShot = dataMap.get("longestHeadShot");
        killAssists = dataMap.get("killAssists");
        accuracyRation = dataMap.get("accuracyRation");
        headShots = dataMap.get("headShots");
        favoriteClass = dataMap.get("favoriteClass");
        flagsCaptured = dataMap.get("flagsCaptured");
        suppressionAssist = dataMap.get("suppressionAssist");
        roundsPlayed = dataMap.get("roundsPlayed");
        kdr = dataMap.get("kdr");
        heals = dataMap.get("heals");
        repairs = dataMap.get("repairs");
        flagsDefended = dataMap.get("flagsDefended");
        highestKillStreak = dataMap.get("highestKillStreak");
        squadScore = dataMap.get("squadScore");
        
        processGameData(dataMap.get("gameModeStats"));
        processClassData(dataMap.get("kitStats"));
        processVehicleData(dataMap.get("vehicleStats"));
    }
    
    function basicToStructure(dataMap) {
        losses = dataMap.get("losses");
        wins = dataMap.get("wins");
        spm = dataMap.get("spm");
        skill = dataMap.get("skill");
        deaths = dataMap.get("deaths");
        kills = dataMap.get("kills");
        kpm = dataMap.get("kpm");
        timePlayed = dataMap.get("timePlayed");
        
        var rankString = dataMap.get("rank");
        var indexStart = rankString.find("number=>") + 8;
        var indexEnd = rankString.find(",");
        rank = rankString.substring(indexStart, indexEnd);
        
        var expString = dataMap.get("rankProgress");
        indexStart = expString.find("current=>") + 9;
        indexEnd = expString.find(".");
        currentRankExperience = expString.substring(indexStart, indexEnd);
        expString = expString.substring(indexEnd + 2, expString.length());
        indexStart = expString.find("total=>") + 7;
        indexEnd = expString.find(".");
        totalRankExperience = expString.substring(indexStart, indexEnd);
    }
    
    function processGameData(gameData) {
        // remove outside brackets
        gameData = gameData.substring(1, gameData.length() - 1);
        var dataArrayMap = detailedSpecStringToMap(", {prettyName", gameData);
        
        // now we have an array of each game mode in a map. We now have enough to make some real data!
        // lets convert this to a map of maps to store as gameDatas
        for(var i = 0; i < dataArrayMap.size(); i += 1) {
            var name = dataArrayMap[i].get("prettyName");
            dataArrayMap[i].remove("prettyName");
            gameDatas.put(name, dataArrayMap[i]);
        }
    }
    
    function processClassData(classData) {
        // remove outside brackets
        classData = classData.substring(1, classData.length() - 1);
        var dataArrayMap = detailedSpecStringToMap(", {prettyName", classData);
        
        for(var i = 0; i < dataArrayMap.size(); i += 1) {
            var name = dataArrayMap[i].get("prettyName");
            dataArrayMap[i].remove("prettyName");
            classDatas.put(name, dataArrayMap[i]);
        }
    }
    
    function processVehicleData(vehicleData) {
        // remove outside brackets
        vehicleData = vehicleData.substring(1, vehicleData.length() - 1);
        var dataArrayMap = detailedSpecStringToMap(", {vehiclesDestroyed", vehicleData);
        
        for(var i = 0; i < dataArrayMap.size(); i += 1) {
            var name = dataArrayMap[i].get("prettyName");
            dataArrayMap[i].remove("prettyName");
            vehicleDatas.put(name, dataArrayMap[i]);
        }
    }
    
    function printMap(map) {
        var keyArray = map.keys();
        for(var i = 0; i < keyArray.size(); i += 1) {
            System.println(keyArray[i] + " => " + map.get(keyArray[i]));
        }
    }
    
    function printAllData() {
        System.println("rank: " + rank);
        System.println("currentRankExperience: " + currentRankExperience);
        System.println("totalRankExperience: " + totalRankExperience);
        System.println("losses: " + losses);
        System.println("wins: " + wins);
        System.println("spm: " + spm);
        System.println("skill: " + skill);
        System.println("deaths: " + deaths);
        System.println("kills: " + kills);
        System.println("kpm: " + kpm);
        System.println("timePlayed: " + timePlayed);
        
        System.println("revives: " + revives);
        System.println("longestHeadShot: " + longestHeadShot);
        System.println("killAssists: " + killAssists);
        System.println("accuracyRatio: " + accuracyRatio);
        System.println("headShots: " + headShots);
        System.println("favoriteClass: " + favoriteClass);
        System.println("flagsCaptured: " + flagsCaptured);
        System.println("suppressionAssist: " + suppressionAssist);
        System.println("roundsPlayed: " + roundsPlayed);
        System.println("kdr: " + kdr);
        System.println("heals: " + heals);
        System.println("repairs: " + repairs);
        System.println("flagsDefended: " + flagsDefended);
        System.println("highestKillStreak: " + highestKillStreak);
        System.println("squadScore: " + squadScore);
    }
    
    var classDatas;
    var vehicleDatas;
    var gameDatas;
    
    // Basic Data to be processed before displaying
    var rank;
    var currentRankExperience;
    var totalRankExperience;
    
    // Basic Data to display
    var losses;
    var wins;
    var spm;
    var skill;
    var deaths;
    var kills;
    var kpm;
    var timePlayed;
    
    // Detailed Data to display
    var revives;
    var longestHeadShot;
    var killAssists;
    var accuracyRation;
    var headShots;
    var favoriteClass;
    var flagsCaptured;
    var suppressionAssist;
    var roundsPlayed;
    var kdr;
    var heals;
    var repairs;
    var flagsDefended;
    var highestKillStreak;
    var squadScore;
}
