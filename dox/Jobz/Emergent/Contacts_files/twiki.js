// Generally useful JavaScript used by TWiki

var POPUP_WINDOW_WIDTH = 500;
var POPUP_WINDOW_HEIGHT = 480;

var TWIKI_PREF_COOKIE_NAME = "TWIKIPREF";
var COOKIE_PREF_SEPARATOR = "|"; // separates key-value pairs
var COOKIE_PREF_VALUE_SEPARATOR = "="; // separates key from value
var COOKIE_EXPIRY_TIME = 365 * 24 * 60 * 60 * 1000; // one year from now

// Constants for the browser type
var ns4 = (document.layers) ? true : false;
var ie4 = (document.all) ? true : false;
var dom = (document.getElementById) ? true : false;


// Chain a new load handler onto the existing handler chain
// http://simon.incutio.com/archive/2004/05/26/addLoadEvent
// if prepend is true, adds the function to the head of the handler list
// otherwise it will be added to the end (executed last)
function addLoadEvent(func, prepend) {
	var oldonload = window.onload;
	if (typeof window.onload != 'function') {
		window.onload = function() {
			func();
		};
	} else {
		var prependFunc = function() {
			func(); oldonload();
		};
		var appendFunc = function() {
			oldonload(); func();
		};
		window.onload = prepend ? prependFunc : appendFunc;
	}
}

// Stub
function initForm() {
}

// Launch a fixed-size help window
function launchTheWindow(inPath, inWeb, inTopic, inSkin, inTemplate) {
	var template = "";
	var skin = "";
	if (inSkin != undefined && inSkin.length > 0) {
		skin = "?skin=" + inSkin;
	}
	if (inTemplate != undefined && inTemplate.length > 0) {
		template = "?template=" + inTemplate;
	}
	var win = open(inPath + inWeb + "/" + inTopic + skin + template, inTopic, "titlebar=0,width=" + POPUP_WINDOW_WIDTH + ",height=" + POPUP_WINDOW_HEIGHT + ",resizable,scrollbars");
	if (win) win.focus();
	return false;
}

/** 
Writes html inside container with id inId.
*/
function insertHtml (inHtml, inId) {
	var elem = document.getElementById(inId);
	if (elem) {
		elem.innerHTML = inHtml;
	}
}

// Remove the given class from an element, if it is there
function removeClass(element, classname) {
	var classes = getClassList(element);
	if (!classes) return;
	var index = indexOf(classname,classes);
	if (index >= 0) {
		classes.splice(index,1);
		setClassList(element, classes);
	}
}

// Add the given class to the element, unless it is already there
function addClass(element, classname) {
	var classes = getClassList(element);
	if (!classes) return;
	if (indexOf(classname, classes) < 0) {
		classes[classes.length] = classname;
		setClassList(element,classes);
	}
}

// Replace the given class with a different class on the element.
// The new class is added even if the old class is not present.
function replaceClass(element, oldclass, newclass) {
	removeClass(element, oldclass);
	addClass(element, newclass);
}

// Get an array of the classes on the object.
function getClassList(element) {
	if (element.className && element.className != "") {
		return element.className.split(' ');
	}
	return [];
}

// Set the classes on an element from an array of class names
// Cache the list in the 'classes' attribute on the element
function setClassList(element, classlist) {
	element.className = classlist.join(' ');
}

// Determine the first index of a string in an array.
// Return -1 if the string is not found.
function indexOf(element, array) {
	if (!array || array.length == undefined) return -1;
	var i = array.length;
	while (i--)	{
		if (array[i] == element) return i;
	}
	return -1;
}

// Applies the given function to all elements in the document of
// the given tag type
function applyToAllElements(fn, type) {
    var c = document.getElementsByTagName(type);
    for (var j = 0; j < c.length; j++) {
        fn(c[j]);
    }
}

// Determine if the element has the given class string somewhere in it's
// className attribute.
function hasClass(node, className) {
    if (node.className) {
    	var classes = getClassList(node);
    	if (classes) return (indexOf(className, classes) >= 0);
    	return false;
    }
}

/**
Add a cookie. If 'days' is set to a non-zero number of days, sets an expiry on the cookie.
@deprecated Use setPref.
*/
function writeCookie(name,value,days) {
	var expires = "";
	if (days) {
		var date = new Date();
		date.setTime(date.getTime()+(days*24*60*60*1000));
		expires = "; expires="+date.toGMTString();
	}
	// cumulative
	document.cookie = name + "=" + value + expires + "; path=/";
}

/**
Reads the named cookie and returns the value.
@deprecated Use getPref.
*/
function readCookie(name) { 
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	if (ca.length == 0) {
		ca = document.cookie.split(';');
	}
	for (var i=0;i < ca.length;++i) {
		var c = ca[i];
		while (c.charAt(0)==' ')
            c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0)
            return c.substring(nameEQ.length,c.length);
	}
	return null;
}

/**
Writes a TWiki preference value. If the TWiki preference of given name already exists, a new value is written. If the preference name is new, a new preference is created.
Characters '|' and '=' are reserved as separators.
@param inPrefName (String): name of the preference to write, for instance 'SHOWATTACHMENTS'
@param inPrefValue (String): value to write, for instance '1'
@param inExpiryDate (Number): (optional) expiry date of cookie; if not set uses COOKIE_EXPIRY_TIME
*/
function setPref(inPrefName, inPrefValue, inExpiryDate) {
	var prefName = _getSafeString(inPrefName);
	var prefValue = (isNaN(inPrefValue)) ? _getSafeString(inPrefValue) : inPrefValue;
	var cookieString = _getPrefCookie();
	var prefs = cookieString.split(COOKIE_PREF_SEPARATOR);
	var index = _getKeyValueLoc(prefs, prefName);
	if (index != -1) {
		// updating this entry is done by removing the existing entry from the array and then pushing the new key-value onto it
		prefs.splice(index, 1);
	}
	// else not found, so don't remove an existing entry
	var keyvalueString = prefName + COOKIE_PREF_VALUE_SEPARATOR + prefValue;
	prefs.push(keyvalueString);
	_writePrefValues(prefs, inExpiryDate);
}

/**
Reads the value of a preference.
Characters '|' and '=' are reserved as separators.
@param inPrefName (String): name of the preference to read, for instance 'SHOWATTACHMENTS'
@return The value of the preference; an empty string when no value is found.
*/
function getPref(inPrefName) {
	var prefName = _getSafeString(inPrefName);
	return getPrefValueFromPrefList(prefName, getPrefList());
}

/**
Reads the value of a preference from an array of key-value pairs. Use in conjunction with getPrefList() when you want to store the key-value pairs for successive look-ups.
@param inPrefName (String): name of the preference to read, for instance 'SHOWATTACHMENTS'
@param inPrefList (Array): list of key-value pairs, retrieved with getPrefList()
@return The value of the preference; an empty string when no value is found.
*/
function getPrefValueFromPrefList (inPrefName, inPrefList) {
	var keyvalue = _getKeyValue(inPrefList, inPrefName);
	if (keyvalue != null) return keyvalue[1];
	return '';
}

/**
@return The array of key-value pairs.
*/
function getPrefList () {
	var cookieString = _getPrefCookie();
	if (!cookieString) return null;
	return cookieString.split(COOKIE_PREF_SEPARATOR);
}

/**
Finds a key-value pair in an array.
@param inKeyValues: (Array) the array to iterate
@param inKey: (String) the key to find in the array
@return The first occurrence of a key-value pair, where key == inKey; null if none is found.
*/
function _getKeyValue (inKeyValues, inKey) {
	var i = inKeyValues.length;
	while (i--) {
		var keyvalue = inKeyValues[i].split(COOKIE_PREF_VALUE_SEPARATOR);
		if (keyvalue[0] == inKey) return keyvalue;	
	}
	return null;
}

/**
Finds the location of a key-value pair in an array.
@param inKeyValues: (Array) the array to iterate
@param inKey: (String) the key to find in the array
@return The location of the first occurrence of a key-value tuple, where key == inKey; -1 if none is found.
*/
function _getKeyValueLoc (inKeyValues, inKey) {
	var i = inKeyValues.length;
	while (i--) {
		var keyvalue = inKeyValues[i].split(COOKIE_PREF_VALUE_SEPARATOR);
		if (keyvalue[0] == inKey) return i;	
	}
	return -1;
}

/**
Writes a cookie with the stringified array values of inValues.
@param inValues: (Array) an array with key-value tuples
@param inExpiryDate: (Number) (optional) expiry date of cookie; if not set uses COOKIE_EXPIRY_TIME
*/
function _writePrefValues (inValues, inExpiryDate) {
	var cookieString = (inValues != null) ? inValues.join(COOKIE_PREF_SEPARATOR) : '';
	var expdate = (inExpiryDate != null) ? inExpiryDate : new Date ();
	FixCookieDate (expdate); // Correct for Mac date bug - call only once for given Date object!
	expdate.setTime (expdate.getTime() + COOKIE_EXPIRY_TIME);
	SetCookie(TWIKI_PREF_COOKIE_NAME, cookieString, expdate);
}

/**
Gets the TWiki pref cookie; creates a new cookie if it does not exist.
@return The TWiki pref cookie.
*/
function _getPrefCookie () {
	var cookieString = GetCookie(TWIKI_PREF_COOKIE_NAME);
	if (cookieString == undefined) {
		// Cookie does not exist yet. Create a new one by writing without values.
		_writePrefValues();
		cookieString = GetCookie(TWIKI_PREF_COOKIE_NAME);
	}
	return cookieString;
}

/**
Strips reserved characters '|' and '=' from the input string.
@return The stripped string.
*/
function _getSafeString (inString) {
	var regex = new RegExp(/[|=]/);
	return inString.replace(regex, "");
}

//
//  Cookie Functions -- "Night of the Living Cookie" Version (25-Jul-96)
//
//  Written by:  Bill Dortch, hIdaho Design <bdortch@hidaho.com>
//  The following functions are released to the public domain.
//

//
// "Internal" function to return the decoded value of a cookie
//
function getCookieVal (offset) {
  var endstr = document.cookie.indexOf (";", offset);
  if (endstr == -1)
    endstr = document.cookie.length;
  return unescape(document.cookie.substring(offset, endstr));
}
//
//  Function to correct for 2.x Mac date bug.  Call this function to
//  fix a date object prior to passing it to SetCookie.
//  IMPORTANT:  This function should only be called *once* for
//  any given date object!  See example at the end of this document.
//
function FixCookieDate (date) {
  var base = new Date(0);
  var skew = base.getTime(); // dawn of (Unix) time - should be 0
  if (skew > 0)  // Except on the Mac - ahead of its time
    date.setTime (date.getTime() - skew);
}
//
//  Function to return the value of the cookie specified by "name".
//    name - String object containing the cookie name.
//    returns - String object containing the cookie value, or null if
//      the cookie does not exist.
//
function GetCookie (name) {
  var arg = name + "=";
  var alen = arg.length;
  var clen = document.cookie.length;
  var i = 0;
  while (i < clen) {
    var j = i + alen;
    if (document.cookie.substring(i, j) == arg)
      return getCookieVal (j);
    i = document.cookie.indexOf(" ", i) + 1;
    if (i == 0) break; 
  }
  return null;
}
//
//  Function to create or update a cookie.
//    name - String object containing the cookie name.
//    value - String object containing the cookie value.  May contain
//      any valid string characters.
//    [expires] - Date object containing the expiration data of the cookie.  If
//      omitted or null, expires the cookie at the end of the current session.
//    [path] - String object indicating the path for which the cookie is valid.
//      If omitted or null, uses the path of the calling document.
//    [domain] - String object indicating the domain for which the cookie is
//      valid.  If omitted or null, uses the domain of the calling document.
//    [secure] - Boolean (true/false) value indicating whether cookie transmission
//      requires a secure channel (HTTPS).  
//
//  The first two parameters are required.  The others, if supplied, must
//  be passed in the order listed above.  To omit an unused optional field,
//  use null as a place holder.  For example, to call SetCookie using name,
//  value and path, you would code:
//
//      SetCookie ("myCookieName", "myCookieValue", null, "/");
//
//  Note that trailing omitted parameters do not require a placeholder.
//
//  To set a secure cookie for path "/myPath", that expires after the
//  current session, you might code:
//
//      SetCookie (myCookieVar, cookieValueVar, null, "/myPath", null, true);
//
function SetCookie (name,value,expires,path,domain,secure) {
  document.cookie = name + "=" + escape (value) +
    ((expires) ? "; expires=" + expires.toGMTString() : "") +
    ((path) ? "; path=" + path : "") +
    ((domain) ? "; domain=" + domain : "") +
    ((secure) ? "; secure" : "");
}

//  Function to delete a cookie. (Sets expiration date to start of epoch)
//    name -   String object containing the cookie name
//    path -   String object containing the path of the cookie to delete. This MUST
//             be the same as the path used to create the cookie, or null/omitted if
//             no path was specified when creating the cookie.
//    domain - String object containing the domain of the cookie to delete.  This MUST
//             be the same as the domain used to create the cookie, or null/omitted if
//             no domain was specified when creating the cookie.
//
function DeleteCookie (name,path,domain) {
  if (GetCookie(name)) {
    document.cookie = name + "=" +
      ((path) ? "; path=" + path : "") +
      ((domain) ? "; domain=" + domain : "") +
      "; expires=Thu, 01-Jan-70 00:00:01 GMT";
  }
}

