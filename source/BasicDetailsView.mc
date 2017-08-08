using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;

class PlayGameView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    	//PlayGameLayout = Rez.Layouts.PlayGameLayout(dc);
    	//setLayout(PlayGameLayout);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        /*dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        
        var HoleLabel = View.findDrawableById("HoleLabel");
        var DistanceLabel = View.findDrawableById("DistanceLabel");
        var ThrowsLabel = View.findDrawableById("ThrowsLabel");
        var ParLabel = View.findDrawableById("ParLabel");
        Sys.println(HoleLabel);
        HoleLabel.setText("Hole  " + hole);
        DistanceLabel.setText(distance[hole - 1] + "  feet");
        ThrowsLabel.setText("Throws: " + throws[hole - 1]);
        ParLabel.setText("Par: " + par[hole - 1]);
        
        for (var i = 0; i < PlayGameLayout.size(); i+=1) {
        	PlayGameLayout[i].draw(dc);
        }*/
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function keyPressed(keyEvent) {
    	/*var handled = false;
    	// Up was pressed
    	if (keyEvent == Ui.KEY_UP) {
    		throws[hole - 1] += 1;
    		var stringToSet = "Hole" + hole;
    		Rez.Strings.hole = stringToSet;
    		handled = true;
    	}
    	
    	// Down was pressed
    	if (keyEvent == Ui.KEY_DOWN) {
			if (throws[hole - 1] > 0) {
    			throws[hole - 1] -= 1;
    		}
    		handled = true;
    	}
    	
    	// Enter was pressed
    	if (keyEvent == Ui.KEY_ENTER) {
    		if (hole < throws.size()) {
    			hole += 1;
    		}
    		handled = true;
    	}
    	
    	// Back was pressed
    	if (keyEvent == Ui.KEY_ESC) {
    		if (hole > 1) {
    			hole -= 1;
    		}
    		handled = true;
    	}
    	
    	if (handled) {
    		requestUpdate();
    	}
    	return handled;*/
    }

}
