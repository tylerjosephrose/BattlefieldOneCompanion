using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class BattlefieldOneCompanionMenuDelegate extends Ui.MenuInputDelegate {

	var data;

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :Basic) {
            Sys.println("Basic");
            //playerData.parseAllData();
            playerData.parseType("BasicStats");
            playerData.parseType("DetailedStats");
            Ui.pushView(new BasicView(), new BasicDelegate(), Ui.SLIDE_UP);
        } else if (item == :Detailed) {
            Sys.println("Detailed");
        } else if (item == :Classes) {
            Sys.println("Classes");
        } else if (item == :Vehicles) {
            Sys.println("Vehicles");
        } else if (item == :Games) {
            Sys.println("Games");
        }
    }

}