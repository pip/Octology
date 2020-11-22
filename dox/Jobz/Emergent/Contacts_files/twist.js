
var COOKIE_PREFIX = "TWikiTwistyContrib";
var COOKIE_EXPIRES = 31; // days

// hide straight away instead of waiting for onload
// http://www.quirksmode.org/blog/archives/2005/06/three_javascrip_1.html#link4
// SMELL should this be a <link> to another stylesheet? (probably not worth it)
document.write("<style type='text/css'>");
document.write(".twistyMakeHidden {display:none;}");
document.write("<\/style>");

// Asssume core javascript code is loaded via main template
	
// Add function initTwist to the head of the functions that are called
// at onload
addLoadEvent(initTwist, true);

function twist(id) {
    var toggleElem = document.getElementById(id+'toggle');
    if (!toggleElem) return;
    var state;
    if (toggleElem.twisted) {
        twistHide(id, toggleElem);
        state = 0; // hidden
    } else {
        twistShow(id, toggleElem);
        state = 1; // shown
    }
    // Use class name 'twistyRememberSetting' to see if a cookie can be set
    // This is not illegal, see: http://www.w3.org/TR/REC-html40/struct/global.html#h-7.5.2
    // 'For general purpose processing by user agents'
    if (hasClass(toggleElem, "twistyRememberSetting")) {
        writeCookie(COOKIE_PREFIX + id, state, COOKIE_EXPIRES);
    }
}
	
function twistShow(id, toggleElem) {
    var showControl = document.getElementById(id+'show');
    var hideControl = document.getElementById(id+'hide');
    addClass(showControl, 'twistyHidden');	
    removeClass(hideControl, 'twistyHidden');
    removeClass(toggleElem, 'twistyHidden');
    toggleElem.twisted = 1;
};
	
function twistHide(id, toggleElem) {
    var showControl = document.getElementById(id+'show');
    var hideControl = document.getElementById(id+'hide');
    removeClass(showControl, 'twistyHidden');
    addClass(hideControl, 'twistyHidden');
    addClass(toggleElem, 'twistyHidden');
    toggleElem.twisted = 0;
};

// Replace all elements with css class "twistyMakeHidden" with "twistyHidden"
// so these elements will become hidden
// The Twisty content will most probably have a "twistyMakeHidden" class
// Remove all classnames "twistyMakeVisible" (set to display:none)
// so these elements become visible
// Twisty toggle links will most probably have a "twistyMakeVisible" class
// Initialise all twisty triggers
var initialiseTwistyClasses = function(e) {
    if (hasClass(e, "twistyMakeHidden")) {
        replaceClass(e, "twistyMakeHidden", "twistyHidden");
    }
   	if (hasClass(e, "twistyMakeVisible")) {
        replaceClass(e, "twistyMakeVisible", "twistyVisible");
    }
    if (hasClass(e, "twistyMakeTransparent")) {
        replaceClass(e, "twistyMakeTransparent", "twistyHidden");
    }
    if (hasClass(e, "twistyMakeOpaque")) {
        replaceClass(e, "twistyMakeOpaque", "twistyVisible");
    }
    if (hasClass(e, "twistyTransparent")) {
        replaceClass(e, "twistyTransparent", "twistyHidden");
    }
};
//twistyTransparent twistyMakeOpaque
// twistyHidden twistyMakeVisible

// The twistyTriggers are the links or buttons that command the toggling.
// This script assumes that the clickable element is either a link, a
// button, a span or a div. On finding such an element, we add an
// onClick handler to it, and show or hide the associated twisty block.
function initialiseTwistyTriggers(e) {
    initialiseTwistyClasses(e);
    if (hasClass(e, "twistyTrigger")) {
        e.onclick = function() {
            twist(this.parentNode.id.slice(0,-4));
            return false;
        };
        var twistId = e.parentNode.id.slice(0,-4);
        var toggleElem = document.getElementById(twistId + 'toggle');
		if (!toggleElem) return;
        var cookie  = readCookie(COOKIE_PREFIX + twistId);
        if (cookie == "1")
			twistShow(twistId, toggleElem);
        else if (cookie == "0")
          twistHide(twistId, toggleElem);
    }
};

// Twisty should degrade gracefully when javascript is off.
// Then the hidden contents should be visible and the toggle links invisible.
// To do this, the content is hidden with javascript, while the links are
// displayed with javascript.
// Hiding and showing is done by adding and removing style classes to the
// elements.
function initTwist() {
	// Twisty can work with spans and with divs
	applyToAllElements( initialiseTwistyClasses, "span" );
	applyToAllElements( initialiseTwistyClasses, "div" );
	applyToAllElements( initialiseTwistyTriggers, "a" );
	applyToAllElements( initialiseTwistyTriggers, "button" );
}

