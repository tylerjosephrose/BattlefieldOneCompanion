using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class BattlefieldOneCompanionMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :Basic) {
            Sys.println("Basic");
            var data = new PlayerData();
            data.GetData("BasicStats");
        } else if (item == :Detailed) {
            Sys.println("Detailed");
            PlayerData.GetData("DetailedStats");
        } else if (item == :Classes) {
            Sys.println("Classes");
        } else if (item == :Vehicles) {
            Sys.println("Vehicles");
        } else if (item == :Games) {
            Sys.println("Games");
        }
    }

}