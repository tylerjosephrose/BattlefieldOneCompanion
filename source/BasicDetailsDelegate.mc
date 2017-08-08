using Toybox.WatchUi as Ui;

class BasicDetailsDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
        Ui.pushView(new Rez.Menus.MainMenu(), new BattlefieldOneCompanionMenuDelegate(), Ui.SLIDE_UP);
    }
    
    function onKey() {
    	
    }
    
    function onBack() {
    	return app.playGameView.keyPressed(KEY_ESC);
    }

}