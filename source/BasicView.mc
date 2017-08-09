using Toybox.WatchUi as Ui;

class BasicView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
    	dc.drawText(
    	    dc.getWidth() / 2,                      // gets the width of the device and divides by 2
    	    //dc.getHeight() / 2,                     // gets the height of the device and divides by 2
    	    dc.getFontDescent(dc.FONT_LARGE),
    	    dc.FONT_LARGE,                          // sets the font size
    	    "Hello World",                          // the String to display
    	    Graphics.TEXT_JUSTIFY_CENTER            // sets the justification for the text
        );
	}

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}

class BasicDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
        Ui.pushView(new Rez.Menus.MainMenu(), new BattlefieldOneCompanionMenuDelegate(), Ui.SLIDE_UP);
    }

    /*function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new BattlefieldOneCompanionMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }*/

}