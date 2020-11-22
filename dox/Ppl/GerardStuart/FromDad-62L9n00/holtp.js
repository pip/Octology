// holtp-05.js
// This is the HOLd toolTiP.JavaScript file.

// Goes at bottom of BANER.HTM  (does not use Section 3 universal messages)
//               and X1MAI.HTM  (  does   use Section 3 universal messages)

// It sets up the holdtip boxes.    
//   The files that call this script will have an individual 
//   additional script of "Section 3" messages in each of them.  
//   They will begin their numbering at 11.

// *****  If you ever alter this script, please make the same changes
//        to Script #2 (Hold-tooltip) in STDFT.JS

/////  Section 1 of 7  -  copyright  /////////////////////////////////

// This code is from Dynamic Web Coding www.dyn-web.com 
// Copyright 2002 by Sharon Paine Permission granted to use this code as long as this entire notice is included.
// Courtesy of SimplytheBest.net - http://simplythebest.net/scripts/

/////  Section 2 of 7  -  vars  //////////////////////////////////////

var dom = (document.getElementById) ? true : false;
var ns5 = ((navigator.userAgent.indexOf("Gecko")>-1) && dom) ? true: false;
var ie5 = ((navigator.userAgent.indexOf("MSIE")>-1) && dom) ? true : false;
var ns4 = (document.layers && !dom) ? true : false;
var ie4 = (document.all && !dom) ? true : false;
var nodyn = (!ns5 && !ns4 && !ie4 && !ie5) ? true : false;
var origWidth, origHeight;
var tipFollowMouse      = true; 
var tipWidth            = 160;  // 160 was Sharon's original pixel width
var curTipWidth         = tipWidth // in case no tipWidth set in array 
var offX                = 12;   // how far from mouse to show tip
var offY                = 12; 
var tipFontFamily       = "Verdana, arial, helvetica, sans-serif";
var tipFontSize         = "8pt";
var tipFontColor        = "#000000"; // black
	     // For possible background color
	     //             DDECFF = a pale blue
	     //             A0A0A0 = a too-dark grey
	     //             FFFFDD = very pale yellow  (acceptable, but)
	     //             FFFFCC = pale yellow  (excellent!)
	     //             EEFFEE = pale green   (great!)
	     //   Maybe use the very pale yellow as the standard for the
	     //     footnotes (without graphics), but use the (darker)
	     //     pale yellow as a background for picture captions.
	     //   I think that'll work.  --  We'll see.
	     //   0'11-28-04 (ver -06) changed default bgColor
	     //     from very pale yellow to pale green
var tipBgColor          = "#EEFFEE";  // pale green
var origBgColor         = tipBgColor; // in case no bgColor set in array
	     // For possible border color
	     //             0000FF = blue  (no, this is a link indicator)
	     //             00CC00 = pale green  (too light)
	     //             008000 = green  (excellent!)
var tipBorderColor      = "#008000";
var origBorderColor     = tipBorderColor; // if no BorderColor set in array
var tipBorderWidth      = 3;
var tipBorderStyle      = "solid";
var tipPadding          = 1;
var t1,t2;              // for setTimeouts
var tipOn = false;      // check if over tooltip link
var tooltip, tipcss;
var mouseX, mouseY;
var startStr =   '<table width="' + curTipWidth +'"><tr><td align="center" width="100%"><img src="';
var startStr13 = '<table width="';
var startStr23 = '<tr><td align="center" width="100%"><img src="';
var startStr33 = '" border="0"></td></tr>';
var midStr = '<tr><td valign="top">';
var endStr = '</td></tr></table>';
var messages = new Array();

/////  Section 3 of 7  -  messages array data  ///////////////////////

//       There are 8 of them (#0-7)
//         7 styles:  xin, maj, lnk, geo, def, acr, pic
//                     1    0    1    6    0    0    0

//BOY
messages[0] = new Array("", // geo
'<center>Home of the Boyertown<br>Museum of Historic Vehicles<br>&#149;&#149;&#149;<br>35 miles NW of Philadelphia</center>',
"197","black","lime"); // med width

//RTC
messages[1] = new Array("", // lnk
'<center>&nbsp;Returns to CONTENTS Table&nbsp;<br>for this page<center>',
"178","DDECFF","black","blue"); // med width

//PEN1 (part 1 of mess#3)
messages[2] = new Array("", // geo
"<center>Part 1 of 2</center><br>&nbsp;Pennsylvania is a medium-sized, heavily<br>&nbsp;&nbsp;&nbsp;&nbsp;populated, state in the northeastern<br>&nbsp;&nbsp;&nbsp;&nbsp;region of the United States of America.<br><br>&nbsp;Among its major industries are agriculture,<br>&nbsp;&nbsp;&nbsp;&nbsp;tourism, production of steel, machinery,<br>&nbsp;&nbsp;&nbsp;&nbsp;chemicals, computer components, cars,<br>&nbsp;&nbsp;&nbsp;&nbsp;crayons, and Hershey's chocolate.<br><br>&nbsp;It is neighbored by 6 other similar states:<br>&nbsp;&nbsp;&nbsp;&nbsp;New York, New Jersey, Delaware,<br>&nbsp;&nbsp;&nbsp;&nbsp;Maryland, West Virginia, and Ohio.<br><br>&nbsp;Pennsylvania's name means &quot;Penn's<br>&nbsp;&nbsp;&nbsp;&nbsp;woods&quot;, as the 45,333 square miles of<br>&nbsp;&nbsp;&nbsp;&nbsp;heavily forested land was granted to<br>&nbsp;&nbsp;&nbsp;&nbsp;William Penn (1644-1718) by King<br>&nbsp;&nbsp;&nbsp;&nbsp;Charles II of England, in 1681.<br><br><center>(move mouse right for Part 2)</center>",
"260"); // wide

//PEN2 (part 2 of mess#2)
messages[3] = new Array("", // geo
"<center>(move mouse left for Part 1)<br><br>This is Part 2 of 2</center><br>&nbsp;No other state in America holds so many<br>&nbsp;&nbsp;&nbsp;&nbsp;historic sites as Pennsylvania &nbsp;&ndash;&nbsp; plus, it<br>&nbsp;&nbsp;&nbsp;&nbsp;has 260 universities and colleges, and is<br>&nbsp;&nbsp;&nbsp;&nbsp;the birthplace of Perry Como, Jimmy<br>&nbsp;&nbsp;&nbsp;&nbsp;Stewart, Gene Kelly, Mister Rogers, the<br>&nbsp;&nbsp;&nbsp;&nbsp;Dorsey brothers, and Punxsutawney Phil.<br><br>&nbsp;The capital of Pennsylvania is Harrisburg,<br>&nbsp;&nbsp;&nbsp;&nbsp;a town of about 48,000, situated along<br>&nbsp;&nbsp;&nbsp;&nbsp;the Susquehanna River&nbsp;<br><br>&nbsp;&#149;&nbsp;&nbsp;157 miles west of New York City&nbsp;<br>&nbsp;&#149;&nbsp;&nbsp;95 miles north of Washington, DC&nbsp;<br>&nbsp;&#149;&nbsp;&nbsp;164 miles east of Pittsburgh&nbsp;<br>&nbsp;&#149;&nbsp;&nbsp;94 miles WNW of Philadelphia&nbsp;<br>&nbsp;&#149;&nbsp;&nbsp;66 miles west of the Boyertown Museum&nbsp;<br><br><center>(move mouse left for Part 1)</center>",
"260"); // wide

//BER
messages[4] = new Array("", // geo
"<center>Berks County, founded in 1752, is the 9th most populous of the 67 counties in the state of Pennsylvania.&nbsp;&nbsp; The 2000 census put the population of the 864 square miles of Berks County at 373,638 &nbsp;&ndash;&nbsp; up 11% from 1990.<br>&#149;&#149;&#149;<br>Of the 8 counties in Pennsylvania with a greater population, three of them border Berks to the south and east:&nbsp; Lancaster, Chester, and Montgomery Counties.<br>Other bordering counties are<br>Lebanon, Schuylkill, & Lehigh.<br>&#149;&#149;&#149;<br>The Berks County seat is Reading (pronounced &quot;REDDING&quot;), a city of about 81,000 people, probably best known as the home of the Reading Railroad, which, in the 1870's, was the largest corporation in the world, and since 1933, has been immortalized on the &quot;Monopoly&quot; board.<br>&#149;&#149;&#149;<br>Reading, Pennsylvania, is located<br>48 miles WNW of Philadelphia, and<br>15 miles west of the Boyertown Museum.</center>",
"270"); // max width

//REA
messages[5] = new Array("", // geo
'<center>Reading&nbsp;&nbsp; (pronounced "REDDING")<br>is a city of about 81,000 people,<br>probably best known as the home of<br>the Reading Railroad, which, in the 1870&#39;s, was the largest corporation in the world,<br>and since 1933, has been immortalized<br>on the &quot;Monopoly&quot; board.<br>&#149;&#149;&#149;<br>Reading, Pennsylvania, was named in 1748, by Thomas & Richard Penn (sons of Pennsylvania founder, William Penn) after their ancestral home of Reading, England, which was founded in the eighth century, 40 miles due west of London, and today has a population of about 144,000.<br>Reading, England&#39;s, most famous current resident is actress Jacqueline Bisset.<br>A past resident was author Oscar Wilde.<br>Actress Kate Winslet was born there on Sunday, October 5th, 1975.<br>&#149;&#149;&#149;<br>Reading, Pennsylvania, is located<br>48 miles WNW of Philadelphia, and<br>15 miles west of the Boyertown Museum.</center>',
"255"); // wide

//PHI
messages[6] = new Array("", // geo
"<center>&quot;Philly&quot; is the nickname of the Pennsylvania town of Philadelphia, a Greek word which means, &quot;brotherly love.&quot;<br>&#149;&#149;&#149;<br>The community was named by William Penn, in 1682, after the Philadelphia in the Lydia region of Asia Minor, which was mentioned twice in the Bible, in the beginning of the book of Revelation.&nbsp;&nbsp; The village of Alasehir, Turkey, stands on that site now.<br>&#149;&#149;&#149;<br>Philadelphia PA, the USA's first capital, is now its 5th largest city (behind only Houston, Chicago, Los Angeles, and New York).<br>&#149;&#149;&#149;<br>Philadelphia, Pennsylvania is located<br>in the northeastern region of the<br>United States of America<br>in the southeastern corner of the<br>state of Pennsylvania<br>78 miles SW of New York City<br>126 miles NE of Washington DC<br>258 miles east of Pittsburgh<br>35 miles SE of the Boyertown Museum</center>",
"270"); // max width

//KEN
messages[7] = new Array("", // xin
"<center>Executive Director of the Boyertown<br>Museum of Historic Vehicles, which<br>has sponsored and produced the<br>annual Duryea Day, ever since<br>the Labor Day Weekend of 1966</center>",
"235"); // med width

messages[8] = new Array();
messages[9] = new Array();
messages[10] = new Array();

/*   These (#s 0-10) are just the universal messages.  An individual
       additional script of "Section 3" messages, in each file which
       calls this script, is further required, beginning with #11.  */

/////  Section 4 of 7  -  3 if statements  ///////////////////////////

if (document.images) {
	var theImgs = new Array();
	for (var i=0; i<messages.length; i++) {
	theImgs[i] = new Image();
		theImgs[i].src = messages[i][0];
  }
}

if (ns4) {
	origWidth = window.innerWidth; origHeight = window.innerHeight;
	window.onresize = function() { if (window.innerWidth != origWidth || window.innerHeight != origHeight) history.go(0); }
}

if (nodyn) { event = "nope" }
	  
/////  Section 5 of 7  -  5 functions  ///////////////////////////////

function doTooltip(evt,num) {

	if (!tooltip) return;
	if (t1) clearTimeout(t1);       if (t2) clearTimeout(t2);
	tipOn = true;
	
	// set tipwidth if included in messages array
	
	if (messages[num][2])   var curTipWidth = messages[num][2];
	else curTipWidth = tipWidth;

	// set colors if included in messages array
	
	if (messages[num][3])   var curBgColor = messages[num][3];
	else curBgColor = tipBgColor;
	
	if (messages[num][4])   var curFontColor = messages[num][4];
	else curFontColor = tipFontColor;
	
	if (messages[num][5])   var curBorderColor = messages[num][5];
	else curBorderColor = tipBorderColor;

	if (ns4) {
		var tip = '<table bgcolor="' + tipBorderColor + '" width="' + curTipWidth + '" cellspacing="0" cellpadding="' + tipBorderWidth + '" border="0"><tr><td><table bgcolor="' + curBgColor + '" width="100%" cellspacing="0" cellpadding="' + tipPadding + '" border="0"><tr><td>' + startStr + messages[num][0] + midStr + '<span style="font-family:' + tipFontFamily + '; font-size:' + tipFontSize + '; color:' + curFontColor + ';">' + messages[num][1] + '</span>' + endStr + '</td></tr></table></td></tr></table>';
		tooltip.write(tip);
		tooltip.close();
	} else if (ie4||ie5||ns5) {
		if (!messages[num][0]) var tip = startStr13 + curTipWidth +'">' +                                              midStr + '<span style="font-family:' + tipFontFamily + '; font-size:' + tipFontSize + '; color:' + curFontColor + ';">' + messages[num][1] + '</span>' + endStr;
		else                   var tip = startStr13 + curTipWidth +'">' + startStr23 + messages[num][0] + startStr33 + midStr + '<span style="font-family:' + tipFontFamily + '; font-size:' + tipFontSize + '; color:' + curFontColor + ';">' + messages[num][1] + '</span>' + endStr;
		tipcss.backgroundColor = curBgColor;
		tipcss.borderColor = curBorderColor;
		tooltip.innerHTML = tip;
	}

	if (!tipFollowMouse) positionTip(evt);
	else t1=setTimeout("tipcss.visibility='visible'",100);
}

function initTip() {
	if (nodyn) return;
	tooltip = (ns4)? document.tipDiv.document: (ie4)? document.all['tipDiv']: (ie5||ns5)? document.getElementById('tipDiv'): null;
	tipcss = (ns4)? document.tipDiv: tooltip.style;
	if (ie4||ie5||ns5) {    // ns4 would lose all this on rewrites
		tipcss.width = curTipWidth+"px";
		tipcss.fontFamily = tipFontFamily;
		tipcss.fontSize = tipFontSize;
		tipcss.color = tipFontColor;
		tipcss.backgroundColor = tipBgColor;
		tipcss.borderColor = tipBorderColor;
		tipcss.borderWidth = tipBorderWidth+"px";
		tipcss.padding = tipPadding+"px";
		tipcss.borderStyle = tipBorderStyle;
	}

// THE FOLLOWING "IF" STATEMENT IN THIS FUNCTION (initTip)
//   CONFLICTS WITH THE "IF" STATEMENT IN THE (MoveHandlerIE)
//   FUNCTION IN THE "BOUNCE01.JS" JAVASCRIPT, CAUSING
//   THE BOUNCE SCRIPT NOT TO RUN PROPERLY. 
//   THE 7 BALLS APPEAR, BUT DO NOT FOLLOW THE MOUSE.

	if (tooltip&&tipFollowMouse) {
		if (ns4) document.captureEvents(Event.MOUSEMOVE);
		document.onmousemove = trackMouse;
	}
}

function trackMouse(evt) {
	mouseX = (ns4||ns5)? evt.pageX: window.event.clientX + document.body.scrollLeft;  // script fails if this is NOT "Left"
	mouseY = (ns4||ns5)? evt.pageY: window.event.clientY + document.body.scrollTop;
	if (tipOn) positionTip(evt);
}

function positionTip(evt) {
	if (!tipFollowMouse) {
		mouseX = (ns4||ns5)? evt.pageX: window.event.clientX + document.body.scrollLeft; // Left/Right -- seems makes no difference
		mouseY = (ns4||ns5)? evt.pageY: window.event.clientY + document.body.scrollTop;
	}

	// tooltip width and height
	var tpWd = (ns4)? tooltip.width: (ie4||ie5)? tooltip.clientWidth: tooltip.offsetWidth;
	var tpHt = (ns4)? tooltip.height: (ie4||ie5)? tooltip.clientHeight: tooltip.offsetHeight;

	// document area in view (subtract scrollbar width for ns)  
	
	var winWd = (ns4||ns5)? window.innerWidth-20+window.pageXOffset: document.body.clientWidth+document.body.scrollLeft; // Left is better
	var winHt = (ns4||ns5)? window.innerHeight-20+window.pageYOffset: document.body.clientHeight+document.body.scrollTop;

	// check mouse position against tip and window dimensions

	// and position the tooltip 
	if ((mouseX+offX+tpWd)>winWd) 
		tipcss.left = (ns4)? mouseX-(tpWd+offX): mouseX-(tpWd+offX)+"px";
	else tipcss.left = (ns4)? mouseX+offX: mouseX+offX+"px";
	if ((mouseY+offY+tpHt)>winHt) 
		tipcss.top = (ns4)? winHt-(tpHt+offY): winHt-(tpHt+offY)+"px";
	else tipcss.top = (ns4)? mouseY+offY: mouseY+offY+"px";
	if (!tipFollowMouse) t1=setTimeout("tipcss.visibility='visible'",100);
}

function hideTip() {
	if (!tooltip) return;
	t2=setTimeout("tipcss.visibility='hidden'",100);
	tipOn = false;
}

/////  Section 6 of 7  -  miscellaneous  /////////////////////////////

window.onload = initTip;

/////  Section 7 of 7  -  write one line  ////////////////////////////

document.write('<div id="tipDiv" style="position:absolute; visibility:hidden; z-index:100"></div>');

/////  End of all 7 sections of HoldTip Script  //////////////////////
