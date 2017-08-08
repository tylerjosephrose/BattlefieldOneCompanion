using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class BattlefieldOneCompanionMenuDelegate extends Ui.MenuInputDelegate {

	var data;

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
    	if (data == null) {
    		data = new PlayerData();
    	}
        if (item == :Basic) {
            Sys.println("Basic");
            data.GetData("BasicStats");
        } else if (item == :Detailed) {
            Sys.println("Detailed");
            data.GetData("DetailedStats");
        } else if (item == :Classes) {
            Sys.println("Classes");
        } else if (item == :Vehicles) {
            Sys.println("Vehicles");
        } else if (item == :Games) {
            Sys.println("Games");
        }
    }

}