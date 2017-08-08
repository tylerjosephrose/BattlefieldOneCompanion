using Toybox.WatchUi as Ui;

class BattlefieldOneCompanionDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
        Ui.pushView(new Rez.Menus.MainMenu(), new BattlefieldOneCompanionMenuDelegate(), Ui.SLIDE_UP);
    }

    /*function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new BattlefieldOneCompanionMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }*/

}