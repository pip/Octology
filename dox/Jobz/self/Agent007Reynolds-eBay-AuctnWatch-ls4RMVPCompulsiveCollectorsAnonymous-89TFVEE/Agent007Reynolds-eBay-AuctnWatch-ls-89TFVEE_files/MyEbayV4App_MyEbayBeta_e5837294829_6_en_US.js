vjo.needs("vjo.dsf.Element");
vjo.needs("vjo.dsf.client.Browser");
vjo.type("vjo.dsf.document.Element").inherits("vjo.dsf.Element").props({toggleHideShowRow:function(_1,_2){
var e=this.get(_1),s,d,u="undefined";
var p=vjo.dsf.client.Browser.bFirefox?"table-row":"block";
if(e){
s=e.style;
d=s.display;
if(typeof (_2)===u){
_2=(d===""||d===p)?false:true;
}
e.bIsShown=_2;
s.display=(_2)?p:"none";
}
}});

vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.darwin.core.minmaxpanel.MinMaxPanel").props({displayContent:function(_1,_2,_3,_4,_5){
var _6=_2.srcElement||_2.target;
if(_6.tagName.toLowerCase()=="a"){
return;
}
var e=_1+"_mid";
var _8=vjo.dsf.document.Element.get(_1+"_s");
var _9=vjo.dsf.document.Element.get(_1+"_head");
var _a=vjo.dsf.document.Element.get(_1);
var _b=vjo.dsf.document.Element.get(_1+"_head_con");
vjo.dsf.document.Element.toggleHideShow(e);
e=vjo.dsf.document.Element.get(_1+"_mid");
if(e.style.display===""||e.style.display==="none"){
if(!_5){
_8.className="mmp-rcp-s mmp-rcp-bgcolor";
}
_a.className="mmp-rcp mmp-rcp-col";
_b.title=_3;
}else{
if(!_5){
_8.className="mmp-rcp-s mmp-rcp-mid-bgcolor";
}
_a.className="mmp-rcp mmp-rcp-exp";
_b.title=_4;
}
},onMouseOver:function(_c,_d,_e,_f){
var e=vjo.dsf.document.Element.get(_c+"_head");
var e_n=vjo.dsf.document.Element.get(_c+"_n");
var e_s=vjo.dsf.document.Element.get(_c+"_s");
var _13=vjo.dsf.document.Element.get(_c+"_mid");
var _14=vjo.dsf.document.Element.get(_c+"_head_con");
if(!_f){
e.className="mmp-rcp-head mmp-rcp-bgcolor";
e_n.className="mmp-rcp-n mmp-rcp-bgcolor";
if(_13.style.display==="none"){
e_s.className="mmp-rcp-s mmp-rcp-bgcolor";
}else{
e_s.className="mmp-rcp-s mmp-rcp-mid-bgcolor";
}
}
this.setHeadTitleAttr(_c,_d,_e);
},onMouseOut:function(_15){
var e=vjo.dsf.document.Element.get(_15+"_head");
var e_n=vjo.dsf.document.Element.get(_15+"_n");
var e_s=vjo.dsf.document.Element.get(_15+"_s");
var _19=vjo.dsf.document.Element.get(_15+"_mid");
e.className="mmp-rcp-head";
e_n.className="mmp-rcp-n";
if(_19.style.display==="none"){
e_s.className="mmp-rcp-s";
}else{
e_s.className="mmp-rcp-s mmp-rcp-mid-bgcolor";
}
},setHeadTitleAttr:function(_1a,_1b,_1c){
var _1d=vjo.dsf.document.Element.get(_1a+"_mid");
var _1e=vjo.dsf.document.Element.get(_1a+"_head_con");
if(_1d.style.display==="none"){
_1e.title=_1b;
}else{
_1e.title=_1c;
}
},editSavedSearch:function(){
},delSavedSearch:function(){
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.darwin.core.minmaxpanel.MinMaxPanel");
vjo.type("vjo.darwin.core.minmaxpanel.MinMaxPanelJsEventBinder").props({bindEventsInJS:function(_1,_2,_3,_4,_5,_6){
if(_5){
var e=vjo.dsf.document.Element.get(_1+"_mid");
e.style.display="none";
}
var _8=_1+"_head";
vjo.dsf.EventDispatcher.addEventListener(_8,"click",function(_9){
return vjo.darwin.core.minmaxpanel.MinMaxPanel.displayContent(_1,_9,_3,_4,_6);
});
vjo.dsf.EventDispatcher.add(_8,"mouseover",function(_a){
return vjo.darwin.core.minmaxpanel.MinMaxPanel.onMouseOver(_1,_3,_4,_6);
});
if(!_6){
vjo.dsf.EventDispatcher.add(_8,"mouseout",function(_b){
return vjo.darwin.core.minmaxpanel.MinMaxPanel.onMouseOut(_1);
});
}
}});

vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.darwin.core.utilitybar.UtilityBar").props({bindEventsInJS:function(_1,_2,_3){
vjo.dsf.EventDispatcher.add(_1,"mouseover",function(_4){
return vjo.darwin.core.utilitybar.UtilityBar.onHover(_1,_2,true,_3);
});
vjo.dsf.EventDispatcher.add(_1,"mouseout",function(_5){
return vjo.darwin.core.utilitybar.UtilityBar.onHover(_1,_2,false,_3);
});
},onHover:function(_6,_7,_8,_9){
var _a=vjo.dsf.document.Element.get(_6);
if(_8){
_a.className=_7+" "+_9[0];
}else{
_a.className=_7+" "+_9[1];
}
}});

vjo.needs("vjo.dsf.Enc");
vjo.type("vjo.darwin.sharedpres.flash.FlashHelper").props({AddFlash:function(_1){
var so=new SWFObject(_1.url,"flash_"+_1.containerName,_1.width,_1.height,_1.minVersion,_1.bgcolor,false);
so.addParam("allowscriptaccess",_1.allowscriptaccess);
so.addParam("allownetworking",_1.allownetworking);
so.addParam("wmode",_1.wmode);
so.addVariable("ebayConfig",vjo.dsf.Enc.encodeURIComponent(_1.ebayConfig||""));
so.addVariable("ebayData",vjo.dsf.Enc.encodeURIComponent(_1.ebayData||""));
so.addVariable("ebayContent",vjo.dsf.Enc.encodeURIComponent(_1.ebayContent||""));
var _3=document.title;
if(!so.write(_1.containerName)){
var o=document.getElementById(_1.containerName);
if(o){
o.innerHTML=_1.noFlashMsg||"";
}
}
document.title=_3;
}});

// @JsDoNotOptimize
// @JsDoNotLintValidate
// @Package vjo.darwin.sharedpres.flash

//**
//* SWFObject v1.4: Flash Player detection and embed - http://blog.deconcept.com/swfobject/
//*
//* SWFObject is (c) 2006 Geoff Stearns and is released under the MIT License:
//* http://www.opensource.org/licenses/mit-license.php
//*
//* **SWFObject is the SWF embed script formarly known as FlashObject. The name was changed for
//*   legal reasons.
///
if(typeof deconcept=="undefined"){var deconcept=new Object();}
if(typeof deconcept.util=="undefined"){deconcept.util=new Object();}
if(typeof deconcept.SWFObjectUtil=="undefined"){deconcept.SWFObjectUtil=new Object();}
deconcept.SWFObject=function(_1,id,w,h,_5,c,_7,_8,_9,_a,_b){
if(!document.createElement||!document.getElementById){return;}
this.DETECT_KEY=_b?_b:"detectflash";
this.skipDetect=deconcept.util.getRequestParameter(this.DETECT_KEY);
this.params=new Object();
this.variables=new Object();
this.attributes=new Array();
if(_1){this.setAttribute("swf",_1);}
if(id){this.setAttribute("id",id);}
if(w){this.setAttribute("width",w);}
if(h){this.setAttribute("height",h);}
if(_5){this.setAttribute("version",new deconcept.PlayerVersion(_5.toString().split(".")));}
this.installedVer=deconcept.SWFObjectUtil.getPlayerVersion(this.getAttribute("version"),_7);
if(c){this.addParam("bgcolor",c);}
var q=_8?_8:"high";
this.addParam("quality",q);
this.setAttribute("useExpressInstall",_7);
this.setAttribute("doExpressInstall",false);
var _d=(_9)?_9:window.location;
this.setAttribute("xiRedirectUrl",_d);
this.setAttribute("redirectUrl","");
if(_a){this.setAttribute("redirectUrl",_a);}};
deconcept.SWFObject.prototype={setAttribute:function(_e,_f){
this.attributes[_e]=_f;
},getAttribute:function(_10){
return this.attributes[_10];
},addParam:function(_11,_12){
this.params[_11]=_12;
},getParams:function(){
return this.params;
},addVariable:function(_13,_14){
this.variables[_13]=_14;
},getVariable:function(_15){
return this.variables[_15];
},getVariables:function(){
return this.variables;
},getVariablePairs:function(){
var _16=new Array();
var key;
var _18=this.getVariables();
for(key in _18){
_16.push(key+"="+_18[key]);}
return _16;
},getSWFHTML:function(){
var _19="";
var wmodestr = this.getParams()["wmode"];
if (wmodestr == null){
	wmodestr = "transparent";
}
if(navigator.plugins&&navigator.mimeTypes&&navigator.mimeTypes.length){
if(this.getAttribute("doExpressInstall")){this.addVariable("MMplayerType","PlugIn");}
_19="<param name=\"wmode\" value=\""+wmodestr+"\"/> <embed wmode=\""+wmodestr+"\" type=\"application/x-shockwave-flash\" src=\""+this.getAttribute("swf")+"\" width=\""+this.getAttribute("width")+"\" height=\""+this.getAttribute("height")+"\"";
_19+=" id=\""+this.getAttribute("id")+"\" name=\""+this.getAttribute("id")+"\" ";
var _1a=this.getParams();
for(var key in _1a){_19+=[key]+"=\""+_1a[key]+"\" ";}
var _1c=this.getVariablePairs().join("&");
if(_1c.length>0){_19+="flashvars=\""+_1c+"\"";}
_19+="/>";
}else{
if(this.getAttribute("doExpressInstall")){this.addVariable("MMplayerType","ActiveX");}
_19="<object id=\""+this.getAttribute("id")+"\" classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\""+this.getAttribute("width")+"\" height=\""+this.getAttribute("height")+"\">";
_19+="<param name=\"movie\" value=\""+this.getAttribute("swf")+"\" />";
var _1d=this.getParams();
for(var key in _1d){_19+="<param name=\""+key+"\" value=\""+_1d[key]+"\" />";}
var _1f=this.getVariablePairs().join("&");
if(_1f.length>0){_19+="<param name=\"flashvars\" value=\""+_1f+"\" />";}
_19+="</object>";}
return _19;
},write:function(_20){
if(this.getAttribute("useExpressInstall")){
var _21=new deconcept.PlayerVersion([6,0,65]);
if(this.installedVer.versionIsValid(_21)&&!this.installedVer.versionIsValid(this.getAttribute("version"))){
this.setAttribute("doExpressInstall",true);
this.addVariable("MMredirectURL",encodeURIComponent(this.getAttribute("xiRedirectUrl")));
document.title=document.title.slice(0,47)+" - Flash Player Installation";
this.addVariable("MMdoctitle",document.title);}}
if(this.skipDetect||this.getAttribute("doExpressInstall")||this.installedVer.versionIsValid(this.getAttribute("version"))){
var n=(typeof _20=="string")?document.getElementById(_20):_20;
n.innerHTML=this.getSWFHTML();
return true;
}else{
if(this.getAttribute("redirectUrl")!=""){document.location.replace(this.getAttribute("redirectUrl"));}}
return false;}};
deconcept.SWFObjectUtil.getPlayerVersion=function(_23,_24){
var _25=new deconcept.PlayerVersion([0,0,0]);
if(navigator.plugins&&navigator.mimeTypes.length){
var x=navigator.plugins["Shockwave Flash"];
if(x&&x.description){_25=new deconcept.PlayerVersion(x.description.replace(/([a-z]|[A-Z]|\s)+/,"").replace(/(\s+r|\s+b[0-9]+)/,".").split("."));}
}else{try{
var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash");
for(var i=3;axo!=null;i++){
axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash."+i);
_25=new deconcept.PlayerVersion([i,0,0]);}}
catch(e){}
if(_23&&_25.major>_23.major){return _25;}
if(!_23||((_23.minor!=0||_23.rev!=0)&&_25.major==_23.major)||_25.major!=6||_24){
try{_25=new deconcept.PlayerVersion(axo.GetVariable("$version").split(" ")[1].split(","));}
catch(e){}}}
return _25;};
deconcept.PlayerVersion=function(_29){
this.major=parseInt(_29[0])!=null?parseInt(_29[0]):0;
this.minor=parseInt(_29[1])||0;
this.rev=parseInt(_29[2])||0;};
deconcept.PlayerVersion.prototype.versionIsValid=function(fv){
if(this.major<fv.major){return false;}
if(this.major>fv.major){return true;}
if(this.minor<fv.minor){return false;}
if(this.minor>fv.minor){return true;}
if(this.rev<fv.rev){return false;}return true;};
deconcept.util={getRequestParameter:function(_2b){
var q=document.location.search||document.location.hash;
if(q){
var _2d=q.indexOf(_2b+"=");
var _2e=(q.indexOf("&",_2d)>-1)?q.indexOf("&",_2d):q.length;
if(q.length>1&&_2d>-1){
return q.substring(q.indexOf("=",_2d)+1,_2e);
}}return "";}};
if(Array.prototype.push==null){
Array.prototype.push=function(_2f){
this[this.length]=_2f;
return this.length;};}
var getQueryParamValue=deconcept.util.getRequestParameter;
var FlashObject=deconcept.SWFObject; // for backwards compatibility
var SWFObject=deconcept.SWFObject;



vjo.type("vjo.dsf.window.utils.VjWindow").props({open:function(_1,_2,_3,_4,_5,_6,_7){
if(_5){
var _8=(window.screen.width-_6)/2;
var _9=(window.screen.height-_7)/2;
_3+=",left="+_8+",top="+_9;
}
return window.open(_1,_2,_3,_4);
},location:function(_a){
document.location.href=_a;
},alert:function(_b){
window.alert(_b);
},confirm:function(_c){
return window.confirm(_c);
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.window.utils.VjWindow");
vjo.type("vjo.darwin.core.memberbadge.MemberBadge").props({openLink:function(_1){
if(_1){
var _2=_1;
var _3=window.screen.width;
vjo.dsf.window.utils.VjWindow.open(_1,"","width=440,height=500,resizable=yes,top=0,left="+(_3-450)+",location=no,menubar=no,scrollbars=no,status=no",false,false);
return false;
}
}});

vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.dsf.document.Text").props({autoClear:function(_1){
var o=vjo.dsf.document.Element.get(_1);
if(o){
if(o.defaultValue==o.value){
o.value="";
}
}
}});

vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.type("vjo.darwin.tracking.rover.Rover").props({roverTrack:function(){
var _1=new Date().getTime();
var _2=vjo.darwin.tracking.rover.Rover.getClientOffset(_1);
var _3=vjo.dsf.cookie.VjCookieJar.readCookieObj("npii","tpim");
if(_3==null||_3.value==""){
return;
}
var _4=parseInt(_3.maxage,16)*1000;
if(_4>0){
var _5=_4-_1+_2;
var _6=15552000000;
if((_5>_6||_5<0)&&typeof (RoverSyncDropped)=="undefined"&&typeof (RoverNsCapable)=="undefined"){
vjo.darwin.tracking.rover.Rover.dropRoverSyncImage();
}
}
},dropRoverSyncImage:function(){
if(typeof (RoverDomainBaseUrl)!=="undefined"&&RoverDomainBaseUrl.length>0){
var im=document.createElement("img");
im.width="1";
im.height="1";
im.src=RoverDomainBaseUrl+"/roversync/?rtpim=1&mpt="+new Date().getTime();
document.body.appendChild(im);
}
},getClientOffset:function(_8){
var _9;
var _a=vjo.dsf.cookie.VjCookieJar.readCookie("ebay","cos");
if(_a!==null&&_a.length>0){
_9=parseInt(_a,16)*1000;
}else{
if(typeof (svrGMT)!=="undefined"){
_9=_8-svrGMT;
var _b=Math.round(_9/1000);
if(!isNaN(_b)){
vjo.dsf.cookie.VjCookieJar.writeCookielet("ebay","cos",_b.toString(16));
}
}
}
if(isNaN(_9)){
_9=1800000;
}
return _9;
}});

vjo.type("vjo.dsf.document.Positioning").props({getScrollLeftTop:function(){
var d=document,rv=[0,0],db=d.body,de=d.documentElement;
if(db){
rv[0]+=db.scrollLeft;
rv[1]+=db.scrollTop;
}
if(de){
rv[0]+=de.scrollLeft;
rv[1]+=de.scrollTop;
}
return rv;
},getOffsetLeft:function(_2){
var e=_2,l=0;
while(e){
l+=e.offsetLeft;
e=e.offsetParent;
}
return l;
},getOffsetTop:function(_4){
var e=_4,t=0;
while(e){
t+=e.offsetTop;
e=e.offsetParent;
}
return t;
},getClientWidth:function(){
var s=self,d=document,de=d.documentElement,w;
if(s.innerWidth){
w=s.innerWidth;
}else{
if(de&&de.clientWidth){
w=de.clientWidth;
}else{
w=d.body.clientWidth;
}
}
return w;
},getClientHeight:function(){
var s=self,d=document,de=d.documentElement,h;
if(s.innerHeight){
h=s.innerHeight;
}else{
if(de&&de.clientHeight){
h=de.clientHeight;
}else{
h=d.body.clientHeight;
}
}
return h;
},getEventLeftTop:function(_8){
var u="undefined",evt=window.event||_8,xOff=(typeof (screenLeft)!=u)?screenLeft:screenX,yOff=(typeof (screenTop)!=u)?screenTop:(screenY+(outerHeight-innerHeight)-25);
return [evt.screenX-xOff,evt.screenY-yOff];
}});

vjo.needs("vjo.dsf.client.Browser");
vjo.type("vjo.dsf.document.Shim").props({add:function(_1,_2,_3){
var f,p="px",w,h,s;
if(this.check()){
w=_1.offsetWidth;
h=_1.offsetHeight;
w+=_2?_2:0;
h+=_3?_3:0;
f=document.createElement("IFRAME");
s=f.style;
s.width=w+p;
s.height=h+p;
s.filter="chroma(color='white')";
f.frameBorder=0;
s.position="absolute";
s.left="0"+p;
s.top="0"+p;
s.zIndex="-1";
s.filter="Alpha(Opacity=\"0\")";
if(document.location.protocol=="https:"){
f.src="https://securepics.ebaystatic.com/aw/pics/s.gif";
}
_1.appendChild(f);
return f;
}
},remove:function(_5,_6){
if(this.check()){
if(_6&&_6.parentNode){
_6.parentNode.removeChild(_6);
}
}
},check:function(){
var B=vjo.dsf.client.Browser;
return (B.bIE||B.bFirefox);
}});

vjo.type("vjo.dsf.utils.Object").props({hitch:function(_1,_2){
var _3;
if(typeof _2=="string"){
_3=_1[_2];
}else{
_3=_2;
}
return function(){
return _3.apply(_1,arguments);
};
},extend:function(_4,_5){
function inheritance(){
}
inheritance.prototype=_5.prototype;
_4.prototype=new inheritance();
_4.prototype.constructor=_4;
_4.baseConstructor=_5;
_4.superClass=_5.prototype;
}});

vjo.needs("vjo.dsf.client.Browser");
vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.document.Positioning");
vjo.needs("vjo.dsf.document.Shim");
vjo.needs("vjo.dsf.utils.Object");
vjo.type("vjo.darwin.core.menu.Menu").protos({constructs:function(_1,_2,_3,_4,_5,_6,_7){
this.sElementId=_1;
this.sLayerId=_2;
this.iOffsetWidth=_3;
this.iOffsetHeight=_4;
this.iTimer=_5;
this.bRelContainer=_6;
this.sLayerTimer="";
this.bLeftAlign=_7;
},showLayer:function(){
var P=vjo.dsf.document.Positioning,E=vjo.dsf.document.Element;
this.clearCloseLayerTimer();
var _9=null;
var _a=E.get(this.sLayerId);
var _b=E.get(this.sElementId);
var _c=this.bRelContainer?0:P.getOffsetLeft(_b);
var _d=_c+this.iOffsetWidth;
if(!this.bLeftAlign){
_d-=(_a.offsetWidth-_b.offsetWidth);
}
var _e=this.bRelContainer?0:P.getOffsetTop(_b);
var _f=_e+(_b.offsetHeight)+this.iOffsetHeight;
var B=vjo.dsf.client.Browser;
if(B.bIE&&B.iVer==7){
_f-=20;
}
_a.style.left=(_d)+"px";
_a.style.top=(_f)+"px";
E.toggleVisibility(this.sLayerId,true);
this.iframeShim=vjo.dsf.document.Shim.add(_a);
},closeLayer:function(){
vjo.dsf.document.Element.toggleVisibility(this.sLayerId,false);
var _11=document.getElementById(this.sLayerId);
if(this.iframeShim){
vjo.dsf.document.Shim.remove(_11,this.iframeShim);
}
},startCloseLayerTimer:function(){
this.sLayerTimer=setTimeout(vjo.dsf.utils.Object.hitch(this,"closeLayer"),this.iTimer);
},clearCloseLayerTimer:function(){
clearTimeout(this.sLayerTimer);
}});

vjo.type("vjo.darwin.core.pulldownmenu.PulldownMenuItemMsg").inherits("vjo.dsf.Message").protos({constructs:function(_1,_2){
this.base.call(this,_1);
this.sItemTitle="";
this.sItemValue="";
this.bCloseWhenClicked=false;
},setItemTitle:function(_3){
this.sItemTitle=_3;
},getItemTitle:function(){
return this.sItemTitle;
},setItemValue:function(_4){
this.sItemValue=_4;
},getItemValue:function(){
return this.sItemValue;
},setCloseWhenClicked:function(_5){
this.bCloseWhenClicked=_5;
},isCloseWhenClicked:function(){
return this.bCloseWhenClicked;
}});

vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.darwin.core.pulldownmenu.PulldownMenuItemMsg");
vjo.type("vjo.darwin.core.pulldownmenu.PulldownMenuItemEvtHandler").props({handleOnClickEvent:function(_1,_2,_3,_4){
var _5=new vjo.darwin.core.pulldownmenu.PulldownMenuItemMsg(_1);
_5.setItemTitle(_2);
_5.setItemValue(_3);
_5.setCloseWhenClicked(_4);
return _5;
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.ServiceEngine");
vjo.type("vjo.darwin.core.pulldownmenu.PulldownMenu").protos({E:vjo.dsf.document.Element,constructs:function(_1){
var t=this,m=_1;
t.sOpenServiceName=m.openServiceName;
t.sCloseServiceName=m.closeServiceName;
t.sPostOpenServiceName=m.postOpenServiceName;
t.sPostCloseServiceName=m.postCloseServiceName;
t.sOlpId=m.olpId;
t.sOlpJsId=m.olpJsId;
t.sCntId=m.cntId;
t.sCntPhId=m.cntPhId;
t.bRightAlign=m.rightAlign;
t.sScrollbarHeight=m.scrollbarHeight;
t.bForgive=t.bOpenUp=t.bOpened=t.bToggle=false;
t.iOpDlay=m.openDelay;
t.iClsDlay=m.closeDelay;
t.nClz=m.normalClz;
t.hClz=m.hiddenClz;
t.anchorId="";
},toggle:function(_3,_4){
var t=this,oOlp=t.E.get(t.sOlpId);
if(oOlp.style.visibility=="visible"){
t.bToggle=false;
t.bForgive=false;
t.disappear(_3);
}else{
t.bToggle=true;
t.appear(_3,_4);
}
var _6=_3.nativeEvent?_3.nativeEvent:window.event;
if(_6.stopPropagation){
_6.stopPropagation();
}else{
_6.cancelBubble=true;
}
},appear:function(_7,_8){
var t=this;
if(t.openTimer){
window.clearTimeout(t.openTimer);
}
if(t.closeTimer){
window.clearTimeout(t.closeTimer);
}
t.anchorId=_8;
t.openTimer=(t.iOpDlay<=0)?t.openOlpPanel():window.setTimeout(vjo.dsf.utils.Object.hitch(t,"openOlpPanel"),t.iOpDlay);
},openOlpPanel:function(){
var t=this,SE=vjo.dsf.ServiceEngine,openMsg=new vjo.dsf.Message(t.sOpenServiceName);
openMsg.fSetNotchLocation=t.setNotchLocation;
openMsg.oSetNotchLocationOverrider=t;
openMsg.sAnchorId=t.anchorId;
t.anchorId="";
if(t.bOpened){
openMsg.bResetPosition=true;
}
SE.handleRequest(openMsg);
t.appendCnt();
var _b=new vjo.dsf.Message(t.sPostOpenServiceName);
_b.clientContext={up:t.bOpenUp};
SE.handleRequest(_b);
t.bOpened=true;
t.bForgive=true;
return false;
},disappear:function(_c){
var t=this;
if(t.closeTimer){
window.clearTimeout(t.closeTimer);
}
if(t.openTimer){
window.clearTimeout(t.openTimer);
}
t.closeTimer=(t.iClsDlay<=0)?t.closeOlpPanel():window.setTimeout(vjo.dsf.utils.Object.hitch(t,"closeOlpPanel"),t.iClsDlay);
},closeOlpPanel:function(){
var t=this,oOlp=t.E.get(t.sOlpId);
t.bOpened=false;
if(t.openTimer){
window.clearTimeout(t.openTimer);
t.openTimer=null;
}
if(oOlp.style.visibility=="visible"){
if(!t.bForgive){
var _f=new vjo.darwin.core.overlaypanel.VjOverlayPanelMessage(t.sCloseServiceName);
_f.bCheckState=true;
vjo.dsf.ServiceEngine.handleRequest(_f);
}else{
t.bForgive=false;
}
}
},forgive:function(_10){
this.bForgive=true;
},notifyOnClose:function(_11){
vjo.dsf.ServiceEngine.handleRequest(new vjo.dsf.Message(this.sPostCloseServiceName));
return false;
},setNotchLocation:function(_12,_13,_14,_15){
var WU=vjo.dsf.window.utils.VjWindowUtils,B=vjo.dsf.client.Browser,lh=window.location.href,width=_14.offsetWidth,height=_14.offsetHeight,olpS=_14.style,screenWidth=WU.getBrowserWindowWidth(),screenHeight=WU.getBrowserWindowHeight(),aScollLocation=WU.getScrollXY(),xLoc=_15.x-aScollLocation[0],yLoc=_15.y-aScollLocation[1],anch=vjo.dsf.document.Element.get(_13.sAnchorName),anchHeight=20,anchorWidth=0,shadowWidth=12,topOffset=0,leftOffset=0,px="px";
if(anch){
anchHeight=anch.offsetHeight;
anchorWidth=anch.offsetWidth;
}
if(B.bIE&&lh.has("feedback")){
topOffset-=anch.offsetTop;
leftOffset-=anch.offsetLeft;
}
if(B.bIE&&lh.has("catalog")){
topOffset-=36;
leftOffset-=10;
}
if(B.bIE&&lh.has("my")&&!_12.iPdmLeft){
var nd=anch.parentNode,pa="";
_12.iPdmLeft=0;
while(nd.nodeName!="BODY"){
if(nd.nodeName=="TD"){
pa=nd.currentStyle.paddingLeft;
pa=pa.substr(0,pa.lastIndexOf(px));
_12.iPdmLeft+=parseInt(pa);
}
nd=nd.parentNode;
}
}
leftOffset=_12.iPdmLeft?(leftOffset-_12.iPdmLeft):leftOffset;
if(!_12.bRightAlign&&((xLoc+width)<screenWidth||width>screenWidth)){
olpS.left=_15.x+leftOffset+px;
if((yLoc+anchHeight+height)<screenHeight||height>screenHeight){
olpS.top=_15.y+anchHeight+topOffset+px;
_12.bOpenUp=false;
}else{
if(yLoc>height){
olpS.top=_15.y-height-shadowWidth+topOffset+px;
_12.bOpenUp=true;
}else{
olpS.top=_15.y+anchHeight+topOffset+px;
_12.bOpenUp=false;
}
}
}else{
olpS.left=_15.x-width+anchorWidth+leftOffset+px;
if((yLoc+anchHeight+height)<screenHeight||height>screenHeight){
olpS.top=_15.y+anchHeight+topOffset+px;
_12.bOpenUp=false;
}else{
if(yLoc>height){
olpS.top=_15.y-height-shadowWidth+topOffset+px;
_12.bOpenUp=true;
}else{
olpS.top=_15.y+anchHeight+topOffset+px;
_12.bOpenUp=false;
}
}
}
},hide:function(e){
e.className=this.hClz;
},appendCnt:function(){
var t=this,ph=t.E.get(t.sCntPhId),cnt=t.E.get(t.sCntId);
if(ph&&cnt&&cnt.parentNode){
while(ph.firstChild){
var n=ph.firstChild;
t.hide(n);
ph.removeChild(n);
document.body.appendChild(n);
}
var _1b=cnt.style,w=cnt.offsetWidth;
_1b.fontSize="1em";
w=cnt.offsetWidth;
t.showCnt(cnt);
cnt.parentNode.removeChild(cnt);
ph.appendChild(cnt);
t.adjust(w);
}
},showCnt:function(e){
e.className=this.nClz;
},adjust:function(_1d){
var t=this,addWidth=10;
if(t.sScrollbarHeight&&parseInt(t.sScrollbarHeight)>0){
addWidth=30;
}
if(!t.oOlpS){
var _1f=t.E.get(t.sOlpId);
t.oOlpS=_1f?_1f.style:false;
}
if(!t.oOlpJsRef){
t.oOlpJsRef=vjo.Registry.get(t.sOlpJsId);
}
if(t.oOlpS&&t.oOlpJsRef){
t.oOlpS.width=(_1d+addWidth)+"px";
t.oOlpJsRef.render();
}
},closePanel:function(_20){
if(_20.isCloseWhenClicked()){
this.bForgive=false;
this.disappear();
}
return;
},onMouseoutClose:function(_21){
this.bForgive=false;
this.disappear(_21);
}});

vjo.needs("vjo.dsf.Message");
vjo.type("vjo.darwin.core.overlaypanel.VjOverlayPanelCloseSvcHandler").protos({constructs:function(_1){
this.sOverlayPanelJsCompId=_1;
},invoke:function(_2){
var _3=vjo.Registry.get(this.sOverlayPanelJsCompId);
_3.onClosePanel(_2.getCheckState?_2.getCheckState():false);
return _2;
}});

vjo.needs("vjo.dsf.EventDispatcher");
vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.dsf.ServiceEngine");
vjo.type("vjo.dsf.utils.Handlers").props({ED:vjo.dsf.EventDispatcher,SE:vjo.dsf.ServiceEngine,attachEvt:function(_1,_2,_3,_4){
return this.ED.addEventListener(_1,_2,_3,_4);
},detachEvt:function(_5,_6,_7){
return this.ED.removeEventListener(_5,_6,_7);
},newMsg:function(_8){
return new vjo.dsf.Message(_8);
},handle:function(_9){
this.SE.handleRequest(_9);
},createHdl:function(_a,_b,_c){
var _d=_a,hdl={};
hdl[_c]=function(){
_b.apply(_d,arguments);
};
return hdl;
},attachSvc:function(_e,_f,_10){
var t=this,hdl=t.createHdl(_10,_f,"invoke");
if(t.SE&&hdl){
t.SE.registerSvcHdl(_e,hdl);
}
},attachSvcReqt:function(_12,_13,_14){
var t=this,hdl=t.createHdl(_14,_13,"handleRequest");
if(t.SE&&hdl){
t.SE.registerSvcReqtHdl(_12,hdl);
}
},attachSvcResp:function(_16,_17,_18){
var t=this,hdl=t.createHdl(_18,_17,"handleResponse");
if(t.SE&&hdl){
t.SE.registerSvcRespHdl(_16,hdl);
}
},resetSvc:function(_1a){
this.SE.inProcHdl.svcHdls[_1a]=[];
},resetSvcReqt:function(_1b){
this.SE.svcReqtHdls[_1b]=[];
},resetSvcResp:function(_1c){
this.SE.svcRespHdls[_1c]=[];
}});

vjo.needs("vjo.dsf.utils.Object");
vjo.type("vjo.dsf.utils.Timer").protos({timer:null,isRunning:false,interval:null,onTick:function(){
},onStart:null,onStop:null,constructs:function(_1){
this.interval=_1;
},setInterval:function(ms){
var t=this;
if(t.isRunning){
window.clearInterval(timer);
}
t.interval=ms;
if(t.isRunning){
t.setInt();
}
},start:function(){
var t=this;
if(typeof t.onStart=="function"){
t.onStart();
}
t.isRunning=true;
t.setInt();
},stop:function(){
var t=this;
if(typeof t.onStop=="function"){
t.onStop();
}
t.isRunning=false;
window.clearInterval(t.timer);
},setInt:function(){
var t=this;
t.timer=window.setInterval(vjo.dsf.utils.Object.hitch(t,"onTick"),t.interval);
}});

vjo.type("vjo.dsf.window.utils.VjWindowUtils").props({getBrowserWindowHeight:function(){
var s=self;
var d=document;
var de=d.documentElement;
if(s.innerHeight){
return s.innerHeight;
}else{
if(de&&de.clientHeight){
return de.clientHeight;
}
}
return d.body.clientHeight;
},getBrowserWindowWidth:function(){
var s=self;
var d=document;
var de=d.documentElement;
if(s.innerWidth){
return s.innerWidth;
}else{
if(de&&de.clientWidth){
return de.clientWidth;
}
}
return d.body.clientWidth;
},getScrollXY:function(){
var _7=0,scrOfY=0;
if(typeof (window.pageYOffset)=="number"){
scrOfY=window.pageYOffset;
_7=window.pageXOffset;
}else{
if(document.body&&(document.body.scrollLeft||document.body.scrollTop)){
scrOfY=document.body.scrollTop;
_7=document.body.scrollLeft;
}else{
if(document.documentElement&&(document.documentElement.scrollLeft||document.documentElement.scrollTop)){
scrOfY=document.documentElement.scrollTop;
_7=document.documentElement.scrollLeft;
}
}
}
return [_7,scrOfY];
},toPixels:function(_8){
return _8+"px";
},scrollTop:function(){
if(window.pageYOffset!=null){
return window.pageYOffset;
}
if(document.documentElement){
return Math.max(document.documentElement.scrollTop,document.body.scrollTop);
}else{
return document.body.scrollTop;
}
},scrollLeft:function(){
if(window.pageXOffset!=null){
return window.pageXOffset;
}
if(document.documentElement){
return Math.max(document.documentElement.scrollLeft,document.body.scrollLeft);
}else{
return document.body.scrollLeft;
}
},scrollWidth:function(){
if(document.documentElement){
return document.documentElement.scrollWidth;
}else{
return Math.max(document.body.scrollWidth,document.body.offsetWidth);
}
},scrollHeight:function(){
if(document.documentElement){
return document.documentElement.scrollHeight;
}else{
return Math.max(document.body.scrollHeight,document.body.offsetHeight);
}
},clientTop:function(){
if(document.documentElement){
return document.documentElement.clientTop;
}else{
return document.body.clientTop;
}
},clientLeft:function(){
if(document.documentElement){
return document.documentElement.clientLeft;
}else{
return document.body.clientLeft;
}
},clientWidth:function(){
var _9=document.documentElement;
if(_9&&window.innerWidth){
return Math.min(_9.clientWidth,window.innerWidth);
}else{
if(_9){
return _9.clientWidth;
}else{
if(window.innerWidth){
return window.innerWidth;
}else{
if(document.body.clientWidth){
return document.body.clientWidth;
}else{
return document.body.offsetWidth;
}
}
}
}
},clientHeight:function(){
var _a=document.documentElement;
if(_a&&window.innerHeight){
return Math.min(_a.clientHeight,window.innerHeight);
}else{
if(_a){
return _a.clientHeight;
}else{
if(window.innerHeight){
return window.innerHeight;
}else{
if(document.body.clientHeight){
return document.body.clientHeight;
}else{
return document.body.offsetHeight;
}
}
}
}
},browserTop:function(){
return (window.innerHeight)?window.screenY+(window.outerHeight-window.innerHeight):window.screenTop;
},browserLeft:function(){
return (window.innerWidth)?window.screenX+(window.outerWidth-window.innerWidth):window.screenLeft;
},eventTop:function(_b){
if(_b.pageY!=null){
return _b.pageY;
}
if(document.documentElement){
return _b.clientY+Math.max(document.documentElement.scrollTop,document.body.scrollTop);
}else{
return _b.clientY+document.body.scrollTop;
}
},eventLeft:function(_c){
if(_c.pageX!=null){
return _c.pageX;
}
if(document.documentElement){
return _c.clientX+Math.max(document.documentElement.scrollLeft,document.body.scrollLeft);
}else{
return _c.clientX+document.body.scrollLeft;
}
},offsetTop:function(_d){
var _e=(document.documentElement&&document.documentElement.clientTop)?document.documentElement.clientTop:0;
for(var _f=0;(_d!=null);_d=_d.offsetParent){
_f+=_d.offsetTop;
}
return _f+_e;
},offsetLeft:function(_10){
var _11=(document.documentElement&&document.documentElement.clientLeft)?document.documentElement.clientLeft:0;
for(var _12=0;(_10!=null);_10=_10.offsetParent){
_12+=_10.offsetLeft;
}
return _12+_11;
},openWindow:function(url,_14,_15){
var _16=new Array();
var _17=vjo.dsf.window.utils.VjWindowUtils;
_15.top=_17.browserTop()+Math.round((_17.clientHeight()-_15.height)/2)+25;
_15.left=_17.browserLeft()+Math.round((_17.clientWidth()-_15.width)/2);
for(var key in _15){
_16.push(key.concat("=",_15[key]));
}
return window.open(url,_14,_16.join(","),true);
}});

vjo.needs("vjo.dsf.utils.Timer");
vjo.needs("vjo.dsf.utils.Handlers");
vjo.type("vjo.darwin.core.overlaypanel.VjOverlayPanelController").singleton().protos({H:vjo.dsf.utils.Handlers,constructs:function(){
var t=this,H=t.H;
t.aOlps=[];
t.sIsActivated=false;
H.attachEvt(window,"resize",t.initResize,t);
var _2=function(){
t.initCloseOnMouseOut();
};
window.setTimeout(_2,500);
t.openAtZIndex=5000;
},registerOverlayPanel:function(_3){
var t=this;
t.aOlps[t.aOlps.length]=_3;
},initCloseOnMouseOut:function(){
var t=this;
t.oCloseTimer=new vjo.dsf.utils.Timer(100);
var _6=t.oCloseTimer;
_6.onTick=function(){
var i=0,arr=t.aOlps,len=arr.length;
while(i<len){
var _8=arr[i];
if(_8.bCloseOnMouseOut){
_8.tryCloseOnMouseOut();
}
i++;
}
};
_6.start();
},zIndex:function(){
var o=this.openAtZIndex;
o+=1;
return o;
},requireResize:function(){
this.sIsActivated=true;
},forceResize:function(_a){
var t=this,i=0;
for(;i<t.aOlps.length;i++){
var tO=t.aOlps[i];
if(_a&&tO.sOverlayDivId==_a){
tO.onResize();
break;
}else{
tO.onResize();
}
}
},initResize:function(){
var t=this,H=t.H;
H.detachEvt(window,"resize",t.initResize);
H.attachEvt(window,"resize",t.requireResize,t);
t.requireResize();
t.oResizeTimer=new vjo.dsf.utils.Timer();
var _e=t.oResizeTimer;
_e.interval=500;
_e.onTick=function(){
var bA=t.sIsActivated;
if(bA){
for(var i=0;i<t.aOlps.length;i++){
var tO=t.aOlps[i];
if(tO.bAdjustSize&&tO.bPanelOpen){
tO.onResize();
}
}
bA=false;
}
};
_e.start();
},resizeOlps:function(){
var i=0,t=this;
for(;i<t.aOlps.length;i++){
var tO=t.aOlps[i];
if(tO.bPanelOpen){
tO.onResize();
}
}
}}).inits(function(){
vjo.darwin.core.overlaypanel.VjOverlayPanelController=new vjo.darwin.core.overlaypanel.VjOverlayPanelController();
});

vjo.needs("vjo.dsf.Message");
vjo.type("vjo.darwin.core.overlaypanel.VjOverlayPanelOpenSvcHandler").protos({constructs:function(_1){
this.sOverlayPanelJsCompId=_1;
},invoke:function(_2){
var _3=vjo.Registry.get(this.sOverlayPanelJsCompId),mO=_2.bOver,LS=_2.leftOffset,TS=_2.topOffset,mL=_2.left,mT=_2.top,pAC=_3.aAnchorCoor;
_3.fSetNotchLocation=_2.fSetNotchLocation;
_3.oSetNotchLocationOverrider=_2.oSetNotchLocationOverrider;
var _4=true;
if(typeof (mO)!="undefined"){
_4=mO;
}
_3.bCloseOnMouseOut=_4;
_3.setAnchorName(_2.sAnchorId);
_3.iTmpLftOfset=LS?LS:0;
_3.iTmpTopOfset=TS?TS:0;
pAC=(mL&&mT)?{x:mL,y:mT}:false;
if(_2.bResetPosition){
_3.bPanelOpen=false;
}
_3.onOpenOverlayPanel(pAC||false);
_2.returnData=false;
return _2;
}});

vjo.needs("vjo.dsf.client.Browser");
vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.document.Positioning");
vjo.needs("vjo.dsf.document.Shim");
vjo.needs("vjo.dsf.utils.Handlers");
vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.dsf.utils.Object");
vjo.needs("vjo.dsf.utils.Timer");
vjo.needs("vjo.dsf.window.utils.VjWindowUtils");
vjo.needs("vjo.darwin.core.overlaypanel.VjOverlayPanelController");
vjo.needs("vjo.darwin.core.overlaypanel.VjOverlayPanelOpenSvcHandler");
vjo.needs("vjo.darwin.core.overlaypanel.VjOverlayPanelCloseSvcHandler");
vjo.type("vjo.darwin.core.overlaypanel.VjOverlayPanel").inherits("vjo.dsf.utils.Timer").protos({H:vjo.dsf.utils.Handlers,B:vjo.dsf.client.Browser,PC:vjo.darwin.core.overlaypanel.VjOverlayPanelController,E:vjo.dsf.document.Element,S:vjo.dsf.document.Shim,O:vjo.dsf.utils.Object,M:vjo.dsf.Message,P:vjo.dsf.document.Positioning,W:vjo.dsf.window.utils.VjWindowUtils,constructs:function(_1){
var t=this,E=t.E;
t.sOverlayDivId=_1.overlayCompId;
var _3=t.sOverlayDivId;
t.sOlpId=_1.cmpWrapperId;
t.oOlp=E.get(_3);
t.oCntnt=E.get(_3+"olpcontent");
t.oShdw=E.get(_3+"olpshadow");
t.oArr=E.get(_3+"olparrow");
t.pVt=_1.pointerVertical;
t.sArrowVTL=_1.arrowVTL;
t.sArrowVTR=_1.arrowVTR;
t.sArrowVBL=_1.arrowVBL;
t.sArrowVBR=_1.arrowVBR;
t.sArrowTL=_1.arrowTL;
t.sArrowTR=_1.arrowTR;
t.sArrowBR=_1.arrowBR;
t.sArrowBL=_1.arrowBL;
t.iLastLeft=t.iLastTop=t.mouseState=-1;
t.initDx=t.initDy=t.top=t.left=t.iTmpLftOfset=t.iTmpTopOfset=0;
t.bShownInCenter=_1.isShownInCenter;
t.iCnstLftOfset=_1.leftOffset;
t.iCnstTopOfset=_1.topOffset;
t.aAnchorCoor=false;
t.sHAlgn=_1.horizontalAlign||false;
t.sVAlgn=_1.verticalAlign||false;
t.iShdwOfset=_1.shadowOffset;
t.iOpDlay=_1.openDelay;
t.iClsDlay=_1.closeDelay;
t.bCloseOnMouseOut=_1.isCloseOnMouseOut;
t.bHasMask=_1.hasMask;
t.sOpMaskServId=_1.openMaskServiceName;
t.sClsMaskServId=_1.closeMaskServiceName;
t.sPostOpServId=_1.postOpenedServiceName;
t.sPostClsServId=_1.postClosedServiceName;
t.bAdjustSize=_1.adjustSize;
t.fSetNotchLocation=t.oSetNotchLocationOverrider=t.closeByButton=t.bPanelOpen=t.bCheckState=false;
t.sOpenServiceName="OPEN_OVERLAY_PANEL"+_3;
t.sCloseServiceName="CLOSE_OVERLAY_PANEL"+_3;
t.bSelfRegistry=_1.selfRegistry;
t.bPromote2Body=_1.promote2Body;
t.oWHeader=E.get(_3+"olpctnhd");
t.oCntn=E.get(_3+"_cnt_n");
t.oCntntBox=E.get(_3+"olpctnbox");
t.oCloseBtn=E.get(_3+"closebtn");
t.oCloseLink=E.get(_3+"closelink");
t.sJsId=_1.cmpJsId;
t.bHeaderDraggable=_1.headerDraggable;
t.bDraggable=_1.draggable;
t.bHasCloseBtn=_1.hasCloseBtn;
t.bHasCloseLink=_1.hasCloseText;
t.icmpWidth=_1.cmpWidth;
t.sCmpOpacity=_1.cmpOpacity;
t.PC.registerOverlayPanel(t);
if(!t.oIFrame&&t.oOlp){
t.oIFrame=t.S.add(t.oOlp);
}
if(t.bSelfRegistry){
t.init();
}
},init:function(){
var t=this,body=(t.B.bIE)?document.body:window,H=t.H,open=new vjo.darwin.core.overlaypanel.VjOverlayPanelOpenSvcHandler(t.sJsId),close=new vjo.darwin.core.overlaypanel.VjOverlayPanelCloseSvcHandler(t.sJsId);
H.attachSvcReqt(t.sOpenServiceName,open.invoke,open);
H.attachSvcReqt(t.sCloseServiceName,close.invoke,close);
if((t.bDraggable&&!t.bHeaderDraggable)&&t.oWHeader){
H.attachEvt(t.oWHeader,"mousedown",t.startDrag,t);
}
if(t.oOlp&&t.oOlp.firstChild){
var sO=t.oOlp.firstChild;
sO.setAttribute("style",t.sCmpOpacity);
}
if(t.bDraggable&&t.oWHeader&&t.oWHeader.firstChild){
var ss=t.oWHeader.firstChild;
t.setStyle(ss,"cursor","move");
}
if(t.bHeaderDraggable&&t.oCntn){
H.attachEvt(t.oCntn,"mousedown",t.startDrag,t);
t.setStyle(t.oCntn,"cursor","move");
}
if(t.bCloseOnMouseOut&&t.oCntntBox){
H.attachEvt(t.oCntntBox,"mouseover",t.panelMouseOver,t);
H.attachEvt(t.oCntntBox,"mouseout",t.panelMouseOut,t);
}
if(t.bHasCloseBtn&&t.oCloseBtn){
H.attachEvt(t.oCloseBtn,"click",t.onClosePanel,t);
}
if(t.bHasCloseLink&&t.oCloseLink){
H.attachEvt(t.oCloseLink,"click",t.onClosePanel,t);
H.attachEvt(t.oCloseLink,"mouseover",t.closeLinkMouseOver,t);
H.attachEvt(t.oCloseLink,"mouseout",t.closeLinkMouseOut,t);
}
if(t.bPromote2Body){
H.attachEvt(body,"load",t.promote2body,t);
}
if(t.icmpWidth!==0&&t.oOlp){
t.setStyle(t.oOlp,"width",(t.icmpWidth+"PX"));
}
},setStyle:function(_7,_8,_9){
_7.style[_8]=_9;
},closeLinkMouseOut:function(){
this.oCloseLink.style.textDecoration="none";
},closeLinkMouseOver:function(){
this.oCloseLink.style.textDecoration="underline";
},promote2body:function(_a){
var t=this;
if(_a){
t.E.promoteToBody(t.sOlpId);
}
},onResize:function(){
var t=this;
if(t.bPanelOpen){
if(!t.bDragged){
t.bPanelOpen=false;
}
t.openOverlayPanel();
}
},onOpenOverlayPanel:function(_d){
var t=this;
t.aAnchorCoor=_d?_d:false;
t.openTimer=(t.iOpDlay<=0)?t.openOverlayPanel():window.setTimeout(t.O.hitch(t,"openOverlayPanel"),t.iOpDlay);
},openOverlayPanel:function(){
var t=this,openedInfo=false;
if(t.openTimer){
window.clearTimeout(t.openTimer);
t.openTimer=null;
}
if(!t.bPanelOpen){
t.bPanelOpen=true;
openedInfo=t.render();
if(t.bHasMask){
t.openMask();
}
var _10=new t.M(t.sPostOpServId);
if(openedInfo){
_10.clientContext={x:openedInfo[0],y:openedInfo[1],w:openedInfo[2],h:openedInfo[3]};
t.H.handle(_10);
}
}
},openMask:function(){
var t=this,maskMsg=new t.M(t.sOpMaskServId),cnt=t.oCntnt;
try{
var _12=cnt?cnt.getElementsByTagName("form")[0]:{name:""};
maskMsg.clientContext={formName:_12.name||_12.id};
}
catch(e){
}
t.H.handle(maskMsg);
},align:function(_13,_14,pad,_16){
return _13+((_14=="right"||_14=="bottom")?pad:0)+((_14=="middle")?(pad/2):0)+_16;
},getLeftOffset:function(){
var t=this;
return t.iCnstLftOfset+t.iTmpLftOfset;
},getTopOffset:function(){
var t=this;
return t.iCnstTopOfset+t.iTmpTopOfset;
},render:function(){
var t=this,E=t.E,B=t.B,P=t.P,W=t.W,anc=E.get(t.sAnchorName),coordinates={x:0,y:0},openedInfo=false,AC=t.aAnchorCoor,LS=t.getLeftOffset(),TS=t.getTopOffset(),SS=t.iShdwOfset;
if(!t.bShownInCenter){
if(AC){
coordinates.x=AC.x+LS;
coordinates.y=AC.y+TS;
}else{
coordinates.x=(B.bIE&&B.fVer<7)?P.getOffsetLeft(anc)+1:P.getOffsetLeft(anc);
coordinates.y=P.getOffsetTop(anc);
coordinates.x=t.align(coordinates.x,t.sHAlgn,anc?anc.offsetWidth:0,LS);
coordinates.y=t.align(coordinates.y,t.sVAlgn,anc?anc.offsetHeight:0,TS);
}
}
var olp=t.oOlp,olpS=olp.style;
if(olpS){
olpS.visibility="visible";
olpS.zIndex=t.PC.zIndex();
if(olpS.zIndex===0){
t.promote2body();
}
}
openedInfo=t.fSetNotchLocation?t.fSetNotchLocation(t.oSetNotchLocationOverrider,t,olp,coordinates):t.setNotchLocation(olp,coordinates);
t.oShdw.style.height=W.toPixels(t.oCntnt.offsetHeight+2);
if(t.oIFrame){
var s=t.oIFrame.style;
s.width=W.toPixels(olp.offsetWidth+SS);
s.height=W.toPixels(olp.offsetHeight+SS+2);
}else{
t.oIFrame=t.S.add(olp,SS,SS+2);
}
return openedInfo;
},setAnchorName:function(_1c){
this.sAnchorName=_1c;
},setBubbleDivId:function(_1d){
this.sOverlayDivId=_1d;
},onClosePanel:function(_1e){
var t=this,CD=t.iClsDlay;
t.bCheckState=_1e;
t.closeTimer=(CD<=0)?t.closePanel():window.setTimeout(t.O.hitch(t,"closePanel"),CD);
},closePanel:function(){
var t=this,cT=t.closeTimer;
if(cT){
window.clearTimeout(cT);
cT=null;
}
if(t.bCheckState&&t.mouseState==1){
t.bCheckState=false;
return;
}
t.hidePanel();
if(t.mouseState==1){
t.closeByButton=true;
}
t.bDragged=false;
},setNotchLocation:function(olp,_22){
var t=this,W=t.W,olpS=olp.style,iX=_22.x,iY=_22.y,iW=olp.offsetWidth,iH=olp.offsetHeight,iScreenW=W.getBrowserWindowWidth(),iScreenH=W.getBrowserWindowHeight(),aScollLoc=W.getScrollXY(),iScrollX=aScollLoc[0],iScrollY=aScollLoc[1],arr=t.oArr;
if(!t.bShownInCenter){
if(t.pVt){
var _24=iX-iScrollX,yLoc=iY-iScrollY,finalX=0,finalY=0,arrH=21,sAuto="auto",iAdj=5,bTop=true,bLeft=false,B=t.B,iGuard=1;
if(!B.bIE){
iAdj+=16;
}
if((yLoc-iH-arrH)<0){
finalY=iY+arrH+iGuard;
bTop=false;
}else{
finalY=iY-iH-arrH-iGuard;
}
if(iX-iW/2<0){
finalX=0;
}else{
if(iX+iW/2+iAdj>iScreenW){
finalX=iScreenW-iW-iAdj;
bLeft=true;
}else{
finalX=iX-(iW/2);
}
}
if(arr){
arr.style.left=W.toPixels(iX-finalX-(bLeft?arr.offsetWidth+iGuard:-iGuard));
}
if(bTop){
t.setArrDivStyle(arr,bLeft?t.sArrowVBL:t.sArrowVBR,sAuto,W.toPixels(-arrH));
}else{
t.setArrDivStyle(arr,bLeft?t.sArrowVTL:t.sArrowVTR,W.toPixels(-arrH),sAuto);
}
}else{
var _24=iX-iScrollX,yLoc=iY-iScrollY,arrH=arr?21:0,arrW=arr?21:0,arrS=arr?14:0,finalX=0,finalY=0,finalW=iW+arrW,finalH=iH,sAuto="auto",iAdj=0,bLeft=false;
if((_24+iW+arrW)<iScreenW||iW>iScreenW||(t.sHAlgn&&t.sHAlgn!="middle")){
finalX=iX+arrW;
bLeft=true;
}else{
if((_24-iW-arrW)<0){
finalX=(iScreenW/2-iW/2)+iScrollX+t.getLeftOffset();
}else{
finalX=iX-iW-arrW;
}
}
if((yLoc+iH)<iScreenH){
finalY=iY-arrS;
t.setArrDivStyle(arr,bLeft?t.sArrowTL:t.sArrowTR,W.toPixels(arrS),sAuto);
}else{
if((yLoc+arrS)>iH){
finalY=iY-iH+arrS;
finalY-=t.getTopOffset()*2;
t.setArrDivStyle(arr,bLeft?t.sArrowBL:t.sArrowBR,sAuto,W.toPixels(arrS));
}else{
if(yLoc<(iScreenH/2)&&(iH<iScreenH)){
iAdj=(iY+iH)-(iScrollY+iScreenH);
finalY=iY-iAdj-arrS;
t.setArrDivStyle(arr,bLeft?t.sArrowTL:t.sArrowTR,W.toPixels(arrS+iAdj),sAuto);
}else{
iAdj=iScrollY-(iY-iH+arrS);
finalY=iScrollY;
t.setArrDivStyle(arr,bLeft?t.sArrowBL:t.sArrowBR,W.toPixels(yLoc-arrS),sAuto);
}
}
}
}
}else{
finalX=(iScreenW/2-iW/2)+iScrollX+t.getLeftOffset();
finalY=iScreenH/2-iH/2;
finalY=finalY>0?finalY:0;
finalY=finalY+iScrollY+t.getTopOffset();
}
olpS.left=W.toPixels(finalX);
olpS.top=W.toPixels(finalY);
return [finalX,finalY,finalW,finalH];
},setArrDivStyle:function(_25,_26,_27,_28){
if(_25){
_25.className=_26;
_25.style.top=_27;
_25.style.bottom=_28;
}
},startDrag:function(_29){
var t=this,P=t.P,W=t.W,olp=t.oOlp,SR=t.bSelfRegistry,H=t.H,db=document.body;
if(!t.bMonitorDrag){
t.bMonitorDrag=true;
t.bDragged=true;
var _2b=_29.nativeEvent;
if(SR){
_2b=_29.nativeEvent||_29;
}
var _2c=W.eventTop(_2b),mouseX=W.eventLeft(_2b);
t.initDx=P.getOffsetLeft(olp)-mouseX;
t.initDy=P.getOffsetTop(olp)-_2c;
t.top=t.iLastTop=_2c;
t.left=t.iLastLeft=mouseX;
t.fOnMouseMoveHdl=H.attachEvt(db,"mousemove",t.onMouseMove,t);
t.fOnMouseUpHdl=H.attachEvt(db,"mouseup",t.onMouseUp,t);
if(olp){
olp.onselectstart=olp.onmousedown=function(){
return false;
};
}
t.interval=50;
t.onTick=function(){
t.monitorMouseDrag();
};
t.start();
}
if(SR){
var _2d=_2b.target||_2b.srcElement;
H.attachEvt(_2d,"mouseup",t.stopDrag,t);
}
},onMouseMove:function(_2e){
var t=this,W=t.W;
if(t.bMonitorDrag){
var _30=window.event?window.event:_2e;
var _31=W.eventTop(_30),leftValue=W.eventLeft(_30);
if(_31>=0&&leftValue>=0){
t.top=_31;
t.left=leftValue;
}
}
},onMouseUp:function(_32){
var t=this,H=t.H,db=document.body;
if(t.bMonitorDrag){
H.detachEvt(db,"mousemove",t.fOnMouseMoveHdl);
H.detachEvt(db,"mouseup",t.fOnMouseUpHdl);
t.stopDrag();
}
},monitorMouseDrag:function(){
if(this.bMonitorDrag){
var t=this,P=t.P,W=t.W;
if((t.left!=t.iLastLeft)||(t.top!=t.iLastTop)){
var dx=t.left-t.iLastLeft,dy=t.top-t.iLastTop;
t.iLastLeft=t.left;
t.iLastTop=t.top;
var olp=t.oOlp,olpS=olp.style,x=P.getOffsetLeft(olp),y=P.getOffsetTop(olp);
olpS.left=W.toPixels(x+dx);
olpS.top=W.toPixels(y+dy);
}
}
},stopDrag:function(){
var t=this;
t.bMonitorDrag=false;
var olp=t.oOlp;
if(olp){
olp.onselectstart=olp.onmousedown=null;
}
t.stop();
},panelMouseOver:function(){
this.mouseState=1;
},panelMouseOut:function(){
this.mouseState=0;
},tryCloseOnMouseOut:function(){
var t=this;
if(t.mouseState===0){
t.mouseState=-1;
if(!t.closeByButton){
t.hidePanel();
}else{
t.closeByButton=false;
t.mouseState=-1;
}
}
},hidePanel:function(){
var t=this,H=t.H,M=t.M,olp=t.oOlp,olpS=olp.style;
olpS.visibility="hidden";
olpS.left="-1600px";
t.bPanelOpen=false;
t.iTmpLftOfset=t.iTmpTopOfset=0;
if(t.bHasMask){
H.handle(new M(t.sClsMaskServId));
}
if(t.sPostClsServId){
H.handle(new M(t.sPostClsServId));
}
if(t.oIFrame){
if(!t.fCleanUp){
t.fCleanUp=function(){
t.S.remove(t.oOlp,t.oIFrame);
t.oIFrame=null;
};
H.attachEvt(window,"unload",t.fCleanUp,t);
}
}
},setContentTitle:function(_3b){
var t=this,tcnt=t.oTitlCntnr;
if(!tcnt){
tcnt=t.E.get(t.sOverlayDivId+"olpcontenttitle");
}
if(tcnt){
tcnt.innerHTML=_3b;
}
}});

vjo.needs("vjo.dsf.Message");
vjo.type("vjo.darwin.core.overlaypanel.VjOverlayPanelMessage").inherits("vjo.dsf.Message").protos({constructs:function(_1,_2){
var t=this;
t.base.call(t,_1);
t.request=t.response={};
t.sAnchorId=t.sBubbleId="";
t.bCheckState=false;
},setBubbleId:function(_4){
this.sBubbleId=_4;
},getBubbleId:function(){
return this.sBubbleId;
},setAnchorId:function(_5){
this.sAnchorId=_5;
},getAnchorId:function(){
return this.sAnchorId;
},getCheckState:function(){
return this.bCheckState;
}});

vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.darwin.core.overlaypanel.VjOverlayPanelMessage");
vjo.needs("vjo.dsf.window.utils.VjWindowUtils");
vjo.type("vjo.darwin.core.overlaypanel.VjOverlayPanelEvtHandlers").props({M:vjo.darwin.core.overlaypanel.VjOverlayPanelMessage,handleOpenEvent:function(_1,_2){
var _3=new this.M(_1);
_3.setAnchorId(_2);
return _3;
},handleOpenEventXY:function(_4,x,y){
var _7=new this.M(_4);
_7.left=x;
_7.top=y;
_7.resetPosition=false;
return _7;
},handleOpenEventByLoc:function(_8,_9){
var e=_9.nativeEvent,W=vjo.dsf.window.utils.VjWindowUtils,x=W.eventLeft(e),y=W.eventTop(e);
return this.handleOpenEventXY(_8,x,y);
},handleCloseEvent:function(_b){
var _c=new this.M(_b);
return _c;
},handleCloseEventWithCheck:function(_d,_e){
var _f=new this.M(_d);
_f.bCheckState=_e;
return _f;
}});

vjo.type("vjo.darwin.app.common.mask.MaskHandlers").props({openService:function(_1,_2){
var _3=vjo.Registry.get(_1);
if(_3){
_3.show(_2.clientContext);
}
},closeService:function(_4,_5){
var _6=vjo.Registry.get(_4);
if(_6){
_6.hide();
}
}});

vjo.needs("vjo.dsf.window.utils.VjWindowUtils");
vjo.needs("vjo.dsf.EventDispatcher");
vjo.needs("vjo.dsf.utils.Timer");
vjo.needs("vjo.darwin.app.common.mask.MaskHandlers");
vjo.type("vjo.darwin.app.common.mask.Mask").protos({constructs:function(_1,_2){
var t=this;
t.eElem=document.getElementById(_1);
t.iOpacity=(_2)?parseFloat(_2):0;
t.showing=false;
t.zIndex=100;
t.sIsActivated=false;
t.oTimer=false;
t.ED=vjo.dsf.EventDispatcher;
},show:function(_4){
var t=this;
if(t.showing){
return;
}else{
t.showing=true;
}
t.formName=(_4)?_4.formName:"";
t.zIndex=(_4&&_4.overlayPanelIndex)?_4.overlayPanelIndex:t.zIndex;
t.render();
t.disableSelects();
t.startResizeListener();
},render:function(){
var t=this;
t.VjWindowUtils=vjo.dsf.window.utils.VjWindowUtils;
var _7=t.VjWindowUtils.scrollWidth();
var _8=t.VjWindowUtils.scrollHeight();
t.setStyle("display","block");
t.setStyle("width",t.VjWindowUtils.toPixels(_7));
t.setStyle("height",t.VjWindowUtils.toPixels(_8));
t.setStyle("opacity",t.iOpacity);
t.setStyle("filter","alpha(opacity="+parseInt(100*t.iOpacity)+")");
t.setStyle("background","#cccccc");
t.setStyle("zIndex",t.zIndex);
},hide:function(){
var t=this;
if(!t.showing){
return;
}else{
t.showing=false;
}
t.setStyle("display","none");
t.setStyle("width",t.VjWindowUtils.toPixels(0));
t.setStyle("height",t.VjWindowUtils.toPixels(0));
t.enableSelects();
t.stopResizeListener();
},disableSelects:function(){
this.disabledSelects=new Array();
var _a=document.body.getElementsByTagName("select");
for(var _b=0;(_b<_a.length);_b++){
var _c=_a[_b];
if(_c.disabled){
continue;
}
var _d=(_c.form)?_c.form.name:null;
if(_d==this.formName){
continue;
}
_c.disabled=true;
this.disabledSelects.push(_c);
}
},enableSelects:function(){
var _e=this.disabledSelects;
for(var _f=0;(_f<_e.length);_f++){
_e[_f].disabled=false;
}
},setStyle:function(_10,_11){
var e=this.eElem;
if(!e||!e.style){
return;
}
e.style[_10]=_11;
},requireResize:function(){
this.sIsActivated=true;
},startResizeListener:function(){
var t=this;
t.ED.addEventListener(window,"resize",t.requireResize,t);
if(!t.oTimer){
t.oTimer=new vjo.dsf.utils.Timer();
t.oTimer.interval=500;
t.oTimer.onTick=function(){
if(t.sIsActivated){
t.render();
t.sIsActivated=false;
}
};
}
t.oTimer.start();
},stopResizeListener:function(){
var t=this;
t.ED.removeEventListener(window,"resize",t.requireResize,t);
if(t.oTimer){
t.oTimer.stop();
}
}});

vjo.type("vjo.darwin.app.myebay.ReminderComponent").protos({constructs:function(){
this.CheckboxSubRequests=[];
},ToggleDescription:function(_1,_2,_3,_4){
with(this){
vjo.darwin.app.myebay.RequestManager.toggleImage(_2,_3,_4);
vjo.darwin.app.myebay.RequestManager.toggleShow(_1);
return false;
}
},submitOnCheck:function(_5,_6,_7){
this.CheckboxSubRequests[_6]=_7;
setTimeout("vjo.Registry.get('reminder_component').confirmStillChecked('"+_6+"')",_5);
},confirmStillChecked:function(_8){
oRequestManager.makeRequest(this.CheckboxSubRequests[_8]);
}}).inits(function(){
vjo.Registry.put("reminder_component",new vjo.darwin.app.myebay.ReminderComponent());
});

vjo.type("vjo.darwin.app.myebay.AboveFoldActivator").protos({constructs:function(id,_2,_3){
this.id=id;
this.action=_2;
this.interval=_3;
setTimeout("vjo.Registry.get(\""+this.id+"\").checkAboveFold()",this.interval);
},checkAboveFold:function(){
var _4=vjo.dsf.document.Positioning.getScrollLeftTop();
var _5=document.getElementById(this.id);
var _6=window.innerHeight?window.innerHeight:document.documentElement.clientHeight;
var _7=_4[1]+_6;
var _8=vjo.dsf.document.Positioning.getOffsetTop(_5);
if(_8<=_7){
eval(this.action);
}else{
setTimeout("vjo.Registry.get(\""+this.id+"\").checkAboveFold()",this.interval);
}
}});

vjo.type("vjo.dsf.document.Form").props({get:function(_1){
var f=document.forms[_1];
return f?f:null;
},getElem:function(_3,_4){
var f=this.get(_3),e;
if(f){
e=f.elements[_4];
}
return e?e:null;
},submit:function(_6){
var f=this.get(_6);
if(f){
f.submit();
}
},setAction:function(_8,_9){
this.setAttr(_8,"action",_9);
},getAction:function(_a){
return this.getAttr(_a,"action");
},setTarget:function(_b,_c){
this.setAttr(_b,"target",_c);
},getTarget:function(_d){
return this.getAttr(_d,"target");
},setAttr:function(_e,_f,_10){
var f=this.get(_e);
if(f){
eval("f."+_f.toLowerCase()+"=psAttrValue;");
}
},getAttr:function(_12,_13){
var f=this.get(_12),v=null;
if(f){
v=eval("f."+_13.toLowerCase());
}
return v;
}});

vjo.needs("vjo.dsf.utils.Object");
vjo.needs("vjo.dsf.client.Browser");
vjo.type("vjo.darwin.component.common.actbutton.ActionButtonImgPreloader").singleton().protos({constructs:function(){
this.aLoaded=[];
this.bPageLoaded=false;
var _1=vjo.dsf.utils.Object.hitch(this,"preloadAll");
vjo.dsf.EventDispatcher.add("body","load",_1);
this.fixIE6ImgCaching();
},preload:function(_2){
if(!_2||!_2.length){
return;
}
var i=0;
for(;i<_2.length;i++){
if(!this.aLoaded[_2[i]]){
if(!this.bPageLoaded){
this.aLoaded[_2[i]]=true;
}else{
this.checkAndPreload(_2[i]);
this.aLoaded[_2[i]]=true;
}
}
}
},preloadAll:function(){
this.bPageLoaded=true;
for(var _4 in this.aLoaded){
this.checkAndPreload(_4);
}
},checkAndPreload:function(_5){
if(typeof (_5)=="string"&&_5.match(/http.+/)){
var _6=new Image();
_6.src=_5;
}
},fixIE6ImgCaching:function(){
var br=vjo.dsf.client.Browser;
if(br.bIE&&br.iVer<7){
var _8=function(){
try{
document.execCommand("BackgroundImageCache",false,true);
}
catch(err){
}
};
vjo.dsf.EventDispatcher.add("body","load",_8);
}
}}).inits(function(){
vjo.darwin.component.common.actbutton.ActionButtonImgPreloader=new vjo.darwin.component.common.actbutton.ActionButtonImgPreloader();
});

vjo.needs("vjo.dsf.utils.Object");
vjo.needs("vjo.dsf.utils.Handlers");
vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.document.Form");
vjo.needs("vjo.darwin.component.common.actbutton.ActionButtonImgPreloader");
vjo.type("vjo.darwin.component.common.actbutton.ActionButton").protos({constructs:function(_1,_2,_3,_4,_5,_6,_7,_8,_9,_a){
var t=this;
t.E=vjo.dsf.document.Element;
t.H=vjo.dsf.utils.Handlers;
t.sCompId=_1+"Anc";
t.sAncId=_1+"Lnk";
t.sSubId=_1+"Sub";
t.sNoScriptId=_1+"NoScript";
t.sFormName=_2;
t.bAnonymousForm=_3;
t.sUrl=_4;
t.iState=_5;
t.bShowClicked=_6;
t.aStateClzes=_7;
t.bForceSubmit=_9;
t.fMouseMoveEvtHandler="undefined";
if(t.bShowClicked){
vjo.darwin.component.common.actbutton.ActionButtonImgPreloader.preload(_8);
}
t.initMe(_a);
},initMe:function(_c){
var t=this,ancBtn=t.E.get(t.sCompId),noScript=t.E.get(t.sNoScriptId);
if(noScript&&noScript.style){
noScript.style.display="none";
}
if(ancBtn){
t.switchClz();
}
if(_c){
var _e=t.E.get(t.sAncId);
if(t.bShowClicked){
t.H.attachEvt(_e,"mousedown",t.onClick,t);
t.H.attachEvt(_e,"mouseup",t.clicked,t);
t.H.attachEvt(_e,"keypress",t.onEnter,t);
}else{
t.H.attachEvt(_e,"click",t.clicked,t);
}
}
},enable:function(_f){
this.iState=0;
this.switchClz();
return false;
},monitorMouseOut:function(_10){
var t=this;
if(2!=t.iState){
var _12={x:t.eventLeft(_10),y:t.eventTop(_10)};
var _13=t.getAnchorPosition(t.sAncId);
var _14={x:_13.x+t.E.get(t.sAncId).offsetWidth,y:_13.y+t.E.get(t.sAncId).offsetHeight};
if(_12.x<_13.x||_12.x>_14.x||_12.y<_13.y||_12.y>_14.y){
t.iState=0;
t.switchClz();
t.H.detachEvt(document.body,"mousemove",t.fMouseMoveEvtHandler);
}
return false;
}
},isLeftClick:function(_15){
if(window.event){
if(window.event.button>1){
return false;
}
}else{
if(_15.nativeEvent){
if(_15.nativeEvent.button>=1){
return false;
}
}
}
return true;
},getAnchorPosition:function(_16){
var _17=false;
var _18={};
var x=0,y=0;
var _1a=false,use_css=false,use_layers=false;
if(document.getElementById){
_1a=true;
}else{
if(document.all){
use_css=true;
}else{
if(document.layers){
use_layers=true;
}
}
}
if(_1a&&document.all){
x=this.getPageOffsetLeft(document.all[_16]);
y=this.getPageOffsetTop(document.all[_16]);
}else{
if(_1a){
var o=document.getElementById(_16);
x=this.getPageOffsetLeft(o);
y=this.getPageOffsetTop(o);
}else{
if(use_css){
x=this.getPageOffsetLeft(document.all[_16]);
y=this.getPageOffsetTop(document.all[_16]);
}else{
if(use_layers){
var _1c=0;
for(var i=0;i<document.anchors.length;i++){
if(document.anchors[i].name==_16){
_1c=1;
break;
}
}
if(_1c===0){
_18.x=0;
_18.y=0;
return _18;
}
x=document.anchors[i].x;
y=document.anchors[i].y;
}else{
_18.x=0;
_18.y=0;
return _18;
}
}
}
}
_18.x=x;
_18.y=y;
return _18;
},getPageOffsetLeft:function(el){
var ol=el.offsetLeft;
while((el=el.offsetParent)!==null){
ol+=el.offsetLeft;
}
return ol;
},getPageOffsetTop:function(el){
var ot=el.offsetTop;
while((el=el.offsetParent)!==null){
ot+=el.offsetTop;
}
return ot;
},eventTop:function(_22){
if(_22.pageY!=null){
return _22.pageY;
}else{
if(document.documentElement&&document.documentElement.scrollTop){
return _22.clientY+Math.max(document.documentElement.scrollTop,document.body.scrollTop);
}else{
return _22.clientY+document.body.scrollTop;
}
}
},eventLeft:function(_23){
if(_23.pageX!=null){
return _23.pageX;
}else{
if(document.documentElement&&document.documentElement.scrollLeft){
return _23.clientX+Math.max(document.documentElement.scrollLeft,document.body.scrollLeft);
}else{
return _23.clientX+document.body.scrollLeft;
}
}
},onEnter:function(_24){
if(2!=this.iState){
if(_24.nativeEvent){
if(_24.nativeEvent.keyCode==13){
this.onClick(_24);
return this.clicked(_24);
}
}
}
},onClick:function(_25){
var t=this;
if(!t.isLeftClick(_25)){
return false;
}
if(2!=t.iState){
t.iState=1;
if(t.bShowClicked){
t.switchClz();
t.fMouseMoveEvtHandler=t.H.attachEvt(document.body,"mousemove",t.monitorMouseOut,t);
}
}
return false;
},clicked:function(_27){
var t=this;
if(!t.isLeftClick(_27)){
return false;
}
if(2!=t.iState&&t.bForceSubmit){
t.iState=0;
t.switchClz();
if(t.bShowClicked){
t.H.detachEvt(document.body,"mousemove",t.fMouseMoveEvtHandler);
}
if(t.bAnonymousForm){
var _29=t.E.get(t.sSubId);
if(_29){
_29.click();
}
}else{
if(t.sFormName!="undefined"){
var _2a=t.E.get(t.sFormName);
if(typeof (window.external)!="undefined"&&typeof (window.external)!="unknown"&&window.external!=null&&typeof (window.external.AutoCompleteSaveForm)!="undefined"&&typeof (window.external.AutoCompleteSaveForm)!="unknown"){
window.external.AutoCompleteSaveForm(_2a);
}
vjo.dsf.document.Form.submit(t.sFormName);
}else{
if(t.sUrl){
window.location=t.sUrl;
}
}
}
}
return false;
},disable:function(_2b){
if(2!=this.iState){
this.iState=2;
this.switchClz();
}
return false;
},switchClz:function(){
var dom=vjo.dsf.document.Element;
var _2d=dom.get(this.sCompId);
if(_2d){
_2d.className=this.aStateClzes[this.iState];
this.displayCursor(dom.get(this.sAncId),"btnPointerCur");
if(this.iState==0){
_2d.style.opacity="";
_2d.style.filter="";
_2d.style.zoom="1";
if(this.sFormName){
}else{
var anc=dom.get(this.sAncId);
anc.href=this.sUrl;
}
}else{
if(this.iState==2){
_2d.style.opacity=".5";
_2d.style.filter="alpha(opacity=50)";
_2d.style.zoom="1";
this.displayCursor(dom.get(this.sAncId),"btnDefCur");
var btn=vjo.dsf.Element.get(this.sAncId);
if(btn.tagName=="BUTTON"){
btn.style.cursor="default";
}
if(this.sFormName){
}else{
var anc=dom.get(this.sAncId);
anc.href="#";
}
}
}
}
},displayCursor:function(anc,_31){
if(anc!==null){
anc.className=_31;
}
}});

vjo.needs("vjo.dsf.typeextensions.string.Comparison");
vjo.type("vjo.dsf.utils.Html").props({encode:function(_1){
var v=new String(_1);
if(v.hasAny("<",">")){
var re=new RegExp("<","gi");
v=v.replace(re,"&lt;");
re=new RegExp(">","gi");
v=v.replace(re,"&gt;");
}
return v;
},strip:function(_4){
var s=_4.replace(/(<([^>]+)>)/ig,"");
s=s.replace(/\r\n/g," ");
s=s.replace(/\n/g," ");
s=s.replace(/\r/g," ");
return s;
}});

vjo.needs("vjo.dsf.utils.Timer");
vjo.type("vjo.darwin.core.inlineedit.item.InlineEditItemController").singleton().protos({constructs:function(){
var t=this;
t.aItems=[];
t.initTimer();
},getJsRefId:function(_2){
return _2+"Js";
},getAjaxKeyId:function(_3){
return _3+"AK";
},getFrontId:function(_4){
return _4+"Frnt";
},getBodyId:function(_5){
return _5+"Bdy";
},getCmdId:function(_6){
return _6+"Cmd";
},getSaveId:function(_7){
return _7+"Sav";
},getModifyLinkId:function(_8){
return _8+"MdfyLk";
},getRemoveLinkId:function(_9){
return _9+"RmvLk";
},getSaveLinkId:function(_a){
return _a+"SavLk";
},getCancelLinkId:function(_b){
return _b+"CnclLk";
},getStateClzes:function(_c){
var _d="-",INLINE_EDIT_FOCUS="-focus",INLINE_EDIT_EDITING="-editing",INLINE_EDIT_EDITED="-edited",INLINE_EDIT_SAVING="-saving",INLINE_EDIT_REMOVED="-removed",aStateClzes=[_c+_d,_c+INLINE_EDIT_FOCUS,_c+INLINE_EDIT_EDITING,_c+INLINE_EDIT_EDITED,_c+INLINE_EDIT_SAVING,_c+INLINE_EDIT_FOCUS,_c+INLINE_EDIT_REMOVED];
return aStateClzes;
},stopEvt:function(_e){
_e=_e.nativeEvent;
if(_e.stopPropagation){
_e.stopPropagation();
}else{
_e.cancelBubble=true;
}
},registerInlineEditItem:function(_f){
this.aItems[this.aItems.length]=_f;
},initTimer:function(){
var t=this;
t.oTimer=new vjo.dsf.utils.Timer(250);
t.oTimer.onTick=function(){
var i=0,arr=t.aItems,len=arr.length;
while(i<len){
var it=arr[i++];
it.switchClz(it.iState);
}
};
t.oTimer.start();
}}).inits(function(){
vjo.darwin.core.inlineedit.item.InlineEditItemController=new vjo.darwin.core.inlineedit.item.InlineEditItemController();
});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.document.Form");
vjo.needs("vjo.dsf.utils.Object");
vjo.needs("vjo.dsf.utils.Handlers");
vjo.needs("vjo.dsf.utils.Html");
vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.darwin.core.inlineedit.item.InlineEditItemController");
vjo.type("vjo.darwin.core.inlineedit.item.InlineEditItem").protos({H:vjo.dsf.utils.Handlers,E:vjo.dsf.document.Element,F:vjo.dsf.document.Form,C:vjo.darwin.core.inlineedit.item.InlineEditItemController,constructs:function(_1){
var t=this,m=_1,C=t.C,sCmpId=m.cmpId;
t.sInlineEditItemCompId=sCmpId;
t.oItem=t.E.get(sCmpId);
t.bAlertWhenRemove=m.alertWhenRemove;
t.sRemoveAlertMessage=m.removeAlert;
t.isCancelNewlyAdd2Remove=m.isCancelNewlyAdd2Remove;
t.bClick2Edit=m.click2Edit;
t.aValElemIds=m.itemValueIds;
t.aInputElemIds=m.itemInputIds;
t.aInputElemMaxLengths=m.itemInputMaxLengths;
t.sSavSvcType=m.saveServiceType;
t.sSavSvc=m.saveService;
t.sRmvSvcType=m.removeServiceType;
t.sRmvSvc=m.removeService;
t.sErrSvc=m.errorService;
t.iErrNo=m.errorCode;
t.oSaveRequest=m.saveRequest;
t.oRemoveRequest=m.removeRequest;
t.sAutoSavSvcId=m.autoSaveServiceName;
t.sPostCancelNewlyAddedSvcId=m.postCancelNewlyAddedServiceName;
t.sJsRefId=C.getJsRefId(sCmpId);
t.sAjaxKeyId=C.getAjaxKeyId(sCmpId);
t.aTabIds=[C.getFrontId(sCmpId),C.getBodyId(sCmpId),C.getCmdId(sCmpId),C.getSaveId(sCmpId)];
t.aLinkIds=[C.getModifyLinkId(sCmpId),C.getRemoveLinkId(sCmpId),C.getSaveLinkId(sCmpId),C.getCancelLinkId(sCmpId)];
t.aStateClzes=C.getStateClzes(m.clzScopeName);
t.bPageLoaded=m.pageLoaded;
t.iState=0;
t.iLastState=-1;
if(t.bPageLoaded){
if(m.needsJsRegistry){
t.registerJs();
}
t.registerSvc();
}else{
t.bNeedsJsRegistry=m.needsJsRegistry;
var _3=function(){
if(t.bNeedsJsRegistry){
t.registerJs();
}
t.registerSvc();
};
window.setTimeout(_3,500);
}
C.registerInlineEditItem(t);
},registerSvc:function(){
var t=this;
if(t.sAutoSavSvcId){
t.H.attachSvc(t.sAutoSavSvcId,t.save,t);
}
t.H.attachSvcReqt("HISTORY_CHANGE",t.historyChange,t);
},historyChange:function(_5){
var t=this,E=t.E,state=_5.state[t.sJsRefId],l=state?state.length-1:-1;
while(l>=0){
var _7=state[l],valElem=E.get(t.aValElemIds[l]),inputElem=E.get(t.aInputElemIds[l]);
if(valElem&&inputElem){
if(isTxtArea){
valElem.innerHTML=_7.replace(/\n/g,"<br>");
inputElem.value=_7;
}else{
valElem.innerHTML=inputElem.value=_7;
}
}
l--;
}
},registerJs:function(){
var t=this,O=vjo.dsf.utils.Object,ED=vjo.dsf.EventDispatcher,mouseOverEvtHandler=function(){
},mouseOutEvtHandler=function(){
},clickEvtHandler=function(){
},keyPressEvtHandler=function(){
},modifyEvtHandler=function(){
},removeEvtHandler=function(){
},saveEvtHandler=function(){
},cancelEvtHandler=function(){
};
mouseOverEvtHandler.prototype.handle=O.hitch(t,"focus");
mouseOutEvtHandler.prototype.handle=O.hitch(t,"reset");
clickEvtHandler.prototype.handle=O.hitch(t,"editing");
keyPressEvtHandler.prototype.handle=O.hitch(t,"edited");
modifyEvtHandler.prototype.handle=O.hitch(t,"editing");
removeEvtHandler.prototype.handle=O.hitch(t,"remove");
saveEvtHandler.prototype.handle=O.hitch(t,"save");
cancelEvtHandler.prototype.handle=O.hitch(t,"cancel");
if(ED&&ED.add){
var i=0,tL=t.aTabIds.length,vL=t.aValElemIds.length,iL=t.aInputElemIds.length;
while(i<tL){
ED.add(t.aTabIds[i],"mouseover",new mouseOverEvtHandler());
ED.add(t.aTabIds[i],"mouseout",new mouseOutEvtHandler());
if(t.bClick2Edit){
ED.add(t.aTabIds[i],"click",new clickEvtHandler());
}
i++;
}
i=0;
while(i<iL){
ED.add(t.aInputElemIds[i],"keyup",new keyPressEvtHandler());
i++;
}
ED.add(t.aLinkIds[0],"click",new modifyEvtHandler());
ED.add(t.aLinkIds[1],"click",new removeEvtHandler());
ED.add(t.aLinkIds[2],"click",new saveEvtHandler());
ED.add(t.aLinkIds[3],"click",new cancelEvtHandler());
}
},switchClz:function(_a){
if(this.iLastState==_a){
return;
}
var t=this;
clzName=(_a===0)?"":(t.aStateClzes[0]+" ")+t.aStateClzes[_a];
if(t.oItem){
t.oItem.className=clzName;
}
t.iLastState=_a;
},reset:function(){
var t=this;
if(t.iState!=2&&t.iState!=3&&t.iState!=5&&t.iState!=6){
t.iState=0;
}
},focus:function(){
var t=this;
if(t.iState!=2&&t.iState!=3&&t.iState!=5&&t.iState!=6){
t.iState=1;
}
},editing:function(){
var t=this;
t.iState=3;
t.switchClz(t.iState);
},edited:function(_f){
this.iState=3;
if(_f.nativeEvent){
if(_f.nativeEvent.keyCode==13){
return this.save(_f);
}
}
},save:function(_10){
if(this.iState!=3){
return false;
}
var t=this,E=t.E,itemDiv=t.oItem,iter=0,len=t.aValElemIds.length,valElemArr=[],inputElemArr=[];
while(iter<len){
var _12=E.get(t.aValElemIds[iter]),inputElem=E.get(t.aInputElemIds[iter])||document.getElementsByName(t.aInputElemIds[iter])[0];
valElemArr[iter]=_12;
inputElemArr[iter]=inputElem;
if(_12&&inputElem){
var _13=t.filterBeforeSave(inputElem.value);
if(_13!=inputElem.value){
var _14=t.H.newMsg(t.sErrSvc);
_14.clientContext={"inlineEditItemJsCompId":t.sIsCmpIditItemJsCompId,"error_code":t.iErrNo,"errors":"user input error"};
t.H.handle(_14);
}
inputElem.value=_13;
_12.innerHTML=inputElem.value;
}
iter++;
}
t.iState=4;
if(_10){
t.C.stopEvt(_10);
}
if(t.sSavSvcType=="ajax"&&t.sSavSvc){
var msg=t.H.newMsg(t.sSavSvc);
msg.request=t.oSaveRequest;
var _16=E.get(t.sAjaxKeyId),historyManager=vjo.Registry.get("HistoryManager"),state=[];
msg.request.ajaxKey=_16?_16.value:null;
msg.request.newVals=[];
iter=0;
while(iter<len){
msg.request.newVals[iter]=state[iter]=inputElemArr[iter]?inputElemArr[iter].value:(valElemArr[iter]?valElemArr[iter].innerHTML:null);
iter++;
}
msg.request.inlineEditItemJsCompId=t.sJsRefId;
if(historyManager){
historyManager.pushHistory(t.sJsRefId,state,null);
}
msg.returnData=false;
return msg;
}else{
if(t.sSavSvcType=="form"&&t.sSavSvc){
t.F.submit(t.sSavSvc);
return false;
}else{
if((t.sSavSvcType=="link"||t.sSavSvcType=="link_qs")&&t.sSavSvc){
var _17=t.sSavSvc;
iter=0;
while(iter<len){
if(inputElemArr[iter]){
_17+="&"+inputElemArr[iter].id+"="+inputElemArr[iter].value;
}
iter++;
}
if(t.sSavSvcType=="link_qs"){
_17+="&saveKey="+E.get(t.sAjaxKeyId).value;
}
}else{
if(t.sSavSvcType=="js_func"&&t.sSavSvcType){
var _18=t.sSavSvc+"('"+t.sJsRefId+"')";
eval(_18);
}
}
}
}
return false;
},filterBeforeSave:function(_19){
return _19.replace(/(<([^>]+)>)/ig,"");
},remove:function(){
var t=this,E=t.E,removeReplacement="",l=t.aInputElemIds.length-1;
while(l>=0){
var _1b=(E.get(t.aInputElemIds[l])||document.getElementsByName(t.aInputElemIds[l])[0]);
removeReplacement+=_1b?(" "+_1b.value):"";
l--;
}
var _1c=t.sRemoveAlertMessage;
_1c=_1c.replace(/#holder/,removeReplacement);
t.iState=5;
if(t.bAlertWhenRemove){
var _1d=confirm(_1c)||false;
if(_1d===false){
t.iState=0;
return false;
}
}
if(t.sRmvSvcType=="ajax"&&t.sRmvSvc){
var msg=t.H.newMsg(t.sRmvSvc);
msg.request=t.oRemoveRequest;
var _1f=E.get(t.sAjaxKeyId);
msg.request.ajaxKey=_1f?_1f.value:null;
msg.request.inlineEditItemJsCompId=t.sJsRefId;
msg.returnData=false;
return msg;
}else{
if(t.sRmvSvcType=="form"&&t.sRmvSvc){
t.F.submit(t.sRmvSvc);
}else{
if((t.sRmvSvcType=="link"||t.sRmvSvcType=="link_qs")&&t.sRmvSvc){
var _20=t.sRmvSvc;
if(t.sRmvSvcType=="link_qs"){
_20+="&removeKey="+E.get(t.sAjaxKeyId).value;
}
window.location=_20;
}else{
if(t.sRmvSvcType=="js_func"&&t.sRmvSvc){
var _21=t.sRmvSvc+"('"+t.sJsRefId+"')";
try{
eval(_21);
}
catch(e){
}
}
}
}
}
return false;
},removed:function(){
this.iState=6;
this.switchClz(this.iState);
},cancel:function(_22){
var t=this;
t.iState=0;
if(t.isCancelNewlyAdd2Remove){
if(t.sPostCancelNewlyAddedSvcId){
var _24=t.H.newMsg(t.sSuccessService);
_24.clientContext={"inlineEditItemJsCompId":t.sJsRefId};
t.H.handle(_24);
}
t.removed();
}else{
var _25=t.oItem,l=t.aValElemIds.length-1;
while(l>=0){
var _26=t.E.get(t.aValElemIds[l]),inputElem=t.E.get(t.aInputElemIds[l])||document.getElementsByName(t.aInputElemIds[l])[0];
if(_26&&inputElem){
inputElem.value=_26.innerHTML;
}
l--;
}
}
if(_22){
t.C.stopEvt(_22);
}
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.utils.Object");
vjo.needs("vjo.dsf.EventDispatcher");
vjo.type("vjo.darwin.core.inlineedit.save.InlineEditSave").protos({constructs:function(_1,_2,_3){
this.sSuccessService=_1;
this.sErrorService=_2;
this.iErrorCode=_3;
},handleResponse:function(_4){
var _5=_4.response.data.status;
var _6=_4.response.errors;
if(_6.length>0){
return false;
}
_6=_4.response.data.errors;
if(_5!=0||(_6&&_6.length>0)){
var _7=new vjo.dsf.Message(this.sErrorService);
_7.clientContext={"error_code":this.iErrorCode,"errors":_6,"info":_4.response.data.info};
if(_4.response.data&&_4.response.data.inlineEditItemJsCompId){
var _8=_4.response.data.inlineEditItemJsCompId;
var _9=vjo.Registry.get(_8);
if(_9){
_9.cancel();
}
_7.clientContext.inlineEditItemJsCompId=_8;
}
if(vjo.dsf.ServiceEngine){
vjo.dsf.ServiceEngine.handleRequest(_7);
}
}else{
var _8=_4.response.data.inlineEditItemJsCompId;
var _9=vjo.Registry.get(_8);
_9.isCancelNewlyAdd2Remove=false;
_9.reset();
if(this.sSuccessService){
var _a=new vjo.dsf.Message(this.sSuccessService);
_a.clientContext={"inlineEditItemJsCompId":_8,"info":_4.response.data.info};
if(vjo.dsf.ServiceEngine){
vjo.dsf.ServiceEngine.handleRequest(_a);
}
}
}
}});

vjo.needs("vjo.dsf.document.Shim");
vjo.needs("vjo.dsf.client.Browser");
vjo.needs("vjo.dsf.ServiceEngine");
vjo.type("vjo.darwin.app.myebay.RequestManager").protos({constructs:function(_1){
if(_1){
this.requestTimeout=_1.requestTimeout;
this.samplingInterval=_1.samplingInterval;
this.numOutstandingRequests=0;
this.incomingRequests=[];
this.requestDelay=_1.requestDelay;
this.startTime=null;
this.timerId=null;
this.mouseOverId=null;
this.mouseOverRequests=null;
this.mouseOverSSPageName=null;
this.isRegd=false;
this.changed=false;
this.errorLayerJsCompId=_1.errorLayerJsCompId;
if(!window.oRequestManager){
window.oRequestManager=this;
window.oRequestManager.registerMe();
}
this.oRoot=vjo.darwin.app.myebay.RequestManager;
}
},registerMe:function(){
if(!window.oRequestManager.isRegd){
vjo.dsf.ServiceEngine.registerTrspReqtHdl("MY_EBAY_REMOTE",window.oRequestManager.handleAjaxRequests);
window.oRequestManager.isRegd=true;
}
},handleAjaxRequests:function(_2){
if(_2.isXSS){
vjo.darwin.app.myebay.RequestManager.makeScriptRequest(_2.url,_2.callback);
}else{
var oX=vjo.darwin.app.myebay.RequestManager.currentHttpReqObj=vjo.dsf.Service.getXmlHttpReq();
if(_2.requestType=="AJAX_GET"){
oX.open("GET",_2.url);
}else{
if(_2.requestType=="AJAX_POST"){
oX.open("POST",_2.url);
oX.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
oX.setRequestHeader("Content-Length",_2.params.length);
}
}
oX.onreadystatechange=function(){
_2.processHandler(oX);
};
if(vjo.dsf.client.Browser.bFirefox){
oX.onerror=function(){
if(document.domain.indexOf(".dev.")>0){
alert("ONERROR: Error getting information!");
}
};
}
oX.send(_2.params);
}
},makeRequestWithSSPagename:function(_4,_5){
with(window.oRequestManager){
mouseOverSSPageName=_5;
makeRequest(_4);
}
},makeRequestWithForm:function(_6,_7,_8,_9){
var oF=document.forms[_7];
if(oF){
oF.method=_9;
oF.action=_8;
this.makeRequest(_6);
}
},makeRequest:function(_b){
with(window.oRequestManager){
if(!_b){
_b=window.aMouseReq;
}
if(timerId==null||(timerId!=null&&_b[0].callType=="FilmStripCall")){
startTime=new Date();
timerId=setTimeout("oRequestManager.checkTimeout()",samplingInterval);
var l=_b.length;
window.bOnload=false;
numOutstandingRequests=l;
var _d;
for(var i=0;i<l;i++){
_d=_b[i];
var _f="&"+_d.additionalParams;
var msg=this.oRoot.getMyEbayMessage(_d.requestType);
if(_d.requestType=="AJAX_GET"){
if(!window.bNoScroll){
scroll(0,0);
}
var _11=this.oRoot.addRandomParam(_d.url);
msg.url=_11+_f;
}else{
if(_d.requestType=="AJAX_POST"){
if(!window.bNoScroll){
scroll(0,0);
}
var oF=document.forms[_d.formName];
var url=oF.action;
var _14=this.oRoot.getFormValues(oF)+_f;
msg.url=this.oRoot.addRandomParam(url);
msg.params=_14;
}else{
var _15=_d.callback?_d.callback:"oRequestManager.processResponse";
msg.url=_d.url+(_d.url.indexOf("?")>0?"&":"?")+_f;
msg.callback=_15;
}
}
msg.requestType=_d.requestType;
vjo.dsf.ServiceEngine.handleRequest(msg);
}
}
}
return false;
},makeMouseOverRequest:function(_16,id,_18,_19){
var evt=_16;
if(_16.nativeEvent){
evt=_16.nativeEvent;
}
var sT=vjo.darwin.app.myebay.SellerLayer.closeTimer;
if(sT){
window.clearTimeout(sT);
vjo.darwin.app.myebay.SellerLayer.closeTimer=null;
}
var _1c=document.getElementById(id);
if(this.oRoot.isMouseEnter(evt,_1c)){
with(window.oRequestManager){
if(!mouseOverId){
mouseOverRequests=_19;
mouseOverSSPageName=_18;
var _1d=this.requestDelay;
if(vjo.dsf.client.Browser.bSafari){
_1d=15;
}
mouseOverId=setTimeout("oRequestManager.checkMouseOver();",_1d);
}
}
}
},checkMouseOver:function(){
with(window.oRequestManager){
if(mouseOverId){
window.oRequestManager.makeRequest(mouseOverRequests);
mouseOverId=null;
mouseOverRequests=null;
}
}
},processResponse:function(_1e){
var _1f;
if(_1e.readyState==4){
var sts=-1;
try{
sts=_1e.status;
}
catch(e1){
vjo.darwin.app.myebay.RequestManager.showContentWrapper();
var _21=(document.domain.indexOf(".qa.")>0||document.domain.indexOf(".dev.")>0);
if(_21){
}
return;
}
if(sts==200){
with(oRequestManager){
if(timerId!=null){
incomingRequests[incomingRequests.length]=_1e;
numOutstandingRequests--;
if(numOutstandingRequests==0){
var len=incomingRequests.length;
for(var i=0;i<len;i++){
var _1e=incomingRequests[i].responseText;
vjo.darwin.app.myebay.RequestManager.renderResponse(_1e);
if(typeof (_1e)=="string"){
if(_1e!=""){
_1f=eval("("+_1e+")");
}
}else{
_1f=_1e;
}
}
}
incomingRequests=[];
}
oRequestManager.cancelRequest();
}
}
}
},checkTimeout:function(){
with(window.oRequestManager){
if(startTime){
var now=new Date();
var _25=now.getTime()-startTime.getTime();
if(_25>=requestTimeout){
clearInterval(timerId);
timerId=null;
oRequestManager.cancelRequest();
}else{
setTimeout("oRequestManager.checkTimeout()",samplingInterval);
}
}
}
},cancelRequest:function(){
with(window.oRequestManager){
if(timerId){
clearInterval(timerId);
timerId=null;
}
if(vjo.darwin.app.myebay.RequestManager.currentHttpReqObj){
var _26=vjo.darwin.app.myebay.RequestManager.currentHttpReqObj;
if(_26.readyState!=4){
_26.abort();
}else{
vjo.darwin.app.myebay.RequestManager.currentHttpReqObj=null;
}
}
mouseOverId=null;
}
},makeNoWindowScroll:function(_27){
with(window.oRequestManager){
window.bNoScroll=true;
}
}}).props({currentHttpReqObj:null,registryId:"myebaynextgen_requestmgr",getMyEbayMessage:function(_28){
var m=new vjo.dsf.Message("MY_EBAY_BETA");
m.trspType="MY_EBAY_REMOTE";
m.url="unknown";
m.requestType=_28||"AJAX_GET";
m.params="";
m.callback=null;
m.processHandler=oRequestManager.processResponse;
m.isXSS=(_28!="AJAX_GET"&&_28!="AJAX_POST");
return m;
},makeScriptRequest:function(url,_2b){
if(url){
var _2c=document.createElement("script");
_2c.type="text/javascript";
var _2d=vjo.darwin.app.myebay.RequestManager.addRandomParam(url)+"&callback="+_2b;
_2c.src=_2d;
document.getElementsByTagName("head")[0].appendChild(_2c);
}
return false;
},makeAjaxGetRequest:function(url){
if(url&&vjo.darwin.app.myebay.RequestManager.currentHttpReqObj==null&&oRequestManager){
window.bOnload=false;
var _2f=vjo.darwin.app.myebay.RequestManager.addRandomParam(url);
var msg=vjo.darwin.app.myebay.RequestManager.getMyEbayMessage("AJAX_GET");
msg.url=_2f;
msg.processHandler=vjo.darwin.app.myebay.RequestManager.ajaxHandler;
vjo.dsf.ServiceEngine.handleRequest(msg);
}
return false;
},returnTop:function(_31){
this.makeAjaxGetRequest(_31);
},makeAjaxPostRequest:function(_32,_33){
if(vjo.darwin.app.myebay.RequestManager.currentHttpReqObj==null){
var oF=document.forms[_32];
var url=oF.action;
var _36=vjo.darwin.app.myebay.RequestManager.getFormValues(oF,_33);
var msg=this.getMyEbayMessage("AJAX_POST");
msg.url=this.addRandomParam(url);
msg.params=_36;
msg.processHandler=this.ajaxHandler;
vjo.dsf.ServiceEngine.handleRequest(msg);
}
return false;
},ajaxHandler:function(_38){
if(_38.readyState==4){
var _39=(document.domain.indexOf(".qa.")>0||document.domain.indexOf(".dev.")>0);
try{
if(_38.status==200){
vjo.darwin.app.myebay.RequestManager.renderResponse((_38.responseText)?_38.responseText:"");
}else{
vjo.darwin.app.myebay.RequestManager.showContentWrapper();
if(_39){
alert("Error getting data.");
}
}
}
catch(e){
vjo.darwin.app.myebay.RequestManager.showContentWrapper();
if(_39){
alert("Error getting data.\n"+e.toString());
}
}
}
},getFormValues:function(_3a,_3b){
var _3c="";
for(var i=0;i<_3a.elements.length;i++){
var _3e=_3a.elements[i];
switch(_3e.type){
case "radio":
var nm=_3a.elements[i].name;
if(_3c.indexOf(nm+"=")==-1){
var tmp=_3a.elements[nm];
var val="";
if(tmp.length>1){
for(var i=0;i<tmp.length;i++){
if(tmp[i].checked){
val=tmp[i].value;
break;
}
}
}else{
val=tmp.value;
}
_3c+=nm+"="+encodeURIComponent(val)+"&";
}
break;
case "checkbox":
if(_3e.checked){
if(_3e.name){
_3c+=_3e.name+"="+encodeURIComponent(_3e.value)+"&";
}
}
break;
case "text":
case "textarea":
case "hidden":
if(_3e.name){
_3c+=_3e.name+"="+encodeURIComponent(_3e.value)+"&";
}
break;
case "password":
case "select-one":
if(_3e.name){
_3c+=_3e.name+"="+encodeURIComponent(_3e.value)+"&";
}
break;
case "button":
case "submit":
if(_3e.name==_3b){
_3c+=_3e.name+"="+encodeURIComponent(_3e.value)+"&";
}
break;
}
}
return _3c;
},appendFormParams:function(_42,_43,pId){
var str="";
var _46=vjo.dsf.document.Element.get(_42);
for(i=0;i<_46.elements.length;i++){
if(_46.elements[i].type==_43&&_46.elements[i].checked){
var sId=pId?pId:_46.elements[i].name;
str+="&"+sId+"="+(_46.elements[i].value).split("_")[0];
}
}
return str;
},appendLineIds:function(_48,_49,pId,_4b,_4c){
var _4d=vjo.dsf.document.Element.get(_48);
if(!this.appendFormParams(_48,_49,pId)){
alert(_4c);
_4d.onsubmit=function(){
return false;
};
}else{
_4d.onsubmit=function(){
return true;
};
}
_4d.action=_4b+this.appendFormParams(_48,_49,pId);
},showhideContainer:function(_4e){
var _4f=vjo.dsf.document.Element.get("LeftArea");
var _50=vjo.dsf.document.Element.get("ContainerArea");
if(_4e){
if(_4f){
_4f.style.position="relative";
}
if(_50){
_50.style.display="none";
_50.style.visibility="hidden";
}
}else{
if(_4f){
_4f.style.position="absolute";
}
if(_50){
_50.style.display="";
_50.style.visibility="visible";
}
}
},renderResponse:function(_51){
var id;
var _53;
if(window.sSavedSearchId){
var sId=window.sSavedSearchId;
window.sSavedSearchId="";
vjo.darwin.app.myebay.RequestManager.currentHttpReqObj=null;
return vjo.darwin.app.myebay.RequestManager.show(sId,false,false);
}
var _55="Stats: \n";
var _56=false;
if(_51){
if(typeof (_51)=="string"){
var d=(new Date()).getTime();
_53=eval("("+_51+")");
_55+="\nTime taken for JS eval(responseObj): "+((new Date()).getTime()-d)+" ms";
}else{
_53=_51;
}
if(_53){
var _58=_53.serviceResponses;
for(id in _58){
_55+="\n========"+id+"========= ";
var div=document.getElementById(id);
if(div){
var _5a=_58[id];
var d=(new Date()).getTime();
div.innerHTML="";
vjo.darwin.app.myebay.RequestManager.bindCss(div,_5a.cssMeta);
var _5b=document.createElement("div");
_5b.innerHTML=_5a.htmlString;
div.appendChild(_5b);
_55+="\nTime taken for render HTML: "+((new Date()).getTime()-d)+" ms";
d=(new Date()).getTime();
vjo.darwin.app.myebay.RequestManager.bindJs(_5a.jsMeta,_5a.eventIdMap);
_55+="\nTime taken for eval AJAX JS: "+((new Date()).getTime()-d)+" ms";
if(_5a.openServiceId&&_5a.targetDiv){
vjo.darwin.app.myebay.RequestManager.openOverlayLayer(_5a.openServiceId,_5a.targetDiv,(id=="overLayItemLayerIFrame"));
}else{
vjo.darwin.app.myebay.RequestManager.showDivOverlay(id);
}
if(id.has("ShortcutUserRowDiv")){
vjo.darwin.app.myebay.RequestManager.show(id,false,false);
}
this.bResp;
if(!window.bOnload){
window.bOnload=true;
}
}
}
var _5c=_53.pageName;
var _5d=_53.ssPageName;
MyEbayNextGenSiteCatalystSetVarPagename(_5c,_5d);
}
}
vjo.darwin.app.myebay.RequestManager.showContentWrapper();
oRequestManager.cancelRequest();
if(_56){
alert(_55);
}
},bindCss:function(div,_5f,_60){
if(_5f){
var _61=document.createElement("style");
_61.type="text/css";
_61.rel="stylesheet";
_61.media="screen";
if(_61.styleSheet){
_61.styleSheet.cssText=_5f;
}else{
var t=document.createTextNode(_5f);
_61.appendChild(t);
}
if(_60){
document.getElementsByTagName("head")[0].appendChild(_61);
}else{
div.appendChild(_61);
}
}
},bindJs:function(_63,_64){
if(_63){
if(_64){
var map=_64;
for(var i in map){
var _67=map[i];
for(var j=0;j<_67.length;j++){
vjo.dsf.EventDispatcher.detachHandlers(i,_67[j]);
}
}
}
eval(_63);
}
},addRandomParam:function(url){
var i=parseInt(Math.random()*10000);
url+=(url.indexOf("?")>0?"&":"?")+"rand="+i;
return url;
},isMouseEnter:function(_6b,_6c){
if(_6b.type!="mouseover"){
return false;
}
var _6d=_6b.relatedTarget?_6b.relatedTarget:_6b.fromElement;
while(_6d&&_6d!=_6c){
_6d=_6d.parentNode;
}
return _6d!=_6c;
},show:function(_6e,_6f,_70,_71){
var e=document.getElementById(_6e);
if(e){
var s=e.style;
if(s){
s.visibility=(_6f)?"visible":"hidden";
if(!_70){
s.display=(_6f)?"":"none";
}
}
}
},showDivOverlay:function(id){
var _75=vjo.Registry.get(id);
if(_75&&_75.show){
_75.show();
}else{
vjo.darwin.app.myebay.RequestManager.show(id,true,false,false);
}
},toggleShow:function(_76){
var e=document.getElementById(_76);
if(e){
var s=e.style;
if(s){
vjo.darwin.app.myebay.RequestManager.show(_76,(s.visibility!="visible"),false,false);
}
}
},toggleImage:function(_79,_7a,_7b){
var e=document.getElementById(_79);
if(e){
e.src=(e.src==_7a)?_7b:_7a;
}
},parseSSPageName:function(url){
var _7e="";
var _7f=url.substr(url.indexOf("?")+1);
var ps=_7f.split("&"),psLen=ps.length;
for(var i=0;i<psLen;i++){
var p=ps[i].split("=");
if(p[0]=="ssPageName"){
_7e=p[1];
break;
}
}
return _7e;
},setCustomPosition:function(_83,_84,_85,_86){
var _b=vjo.dsf.client.Browser;
if(_b.bIE&&_b.iVer==6){
_86.x-=223;
}
if(vjo.darwin.app.myebay.SellerLayer){
if(vjo.darwin.app.myebay.SellerLayer.compId==_85.id){
var lyr=document.getElementById(_84.sAnchorName);
if(lyr){
_86.x+=lyr.offsetWidth;
}
}
}
this.setNotchLocation(_85,_86);
var _89=38;
if(vjo.darwin.app.myebay.SellerLayer){
if(vjo.darwin.app.myebay.SellerLayer.compId==_85.id){
_89=12;
}
}
if(_84.sAnchorName.indexOf("qv")==0){
_89=-38;
}
var _8a=vjo.dsf.document.Element.get(_84.sOverlayDivId+"olparrow");
if(_85.offsetTop<=0){
_8a.style.top=(_8a.offsetTop+_89)+"px";
}else{
var tt=_85.offsetTop+_89;
if(tt<0){
_8a.style.top=(_8a.offsetTop+tt)+"px";
tt=0;
}
_85.style.top=tt+"px";
}
},openOverlayLayer:function(_8c,_8d,_8e){
var _8f=vjo.darwin.core.overlaypanel.VjOverlayPanelEvtHandlers.handleOpenEvent(_8c,_8d);
_8f.bResetPosition=true;
if(_8e){
_8f.oSetNotchLocationOverrider=vjo.darwin.app.myebay.RequestManager;
_8f.fSetNotchLocation=vjo.darwin.app.myebay.RequestManager.setCustomPosition;
}
vjo.dsf.ServiceEngine.handleRequest(_8f);
},closeOverlayLayer:function(_90){
var _91=vjo.darwin.core.overlaypanel.VjOverlayPanelEvtHandlers.handleCloseEvent(_90);
_91.bCheckState=true;
vjo.dsf.ServiceEngine.handleRequest(_91);
},showContentWrapper:function(){
if(typeof (S_CONTAINERS_WRAPPER_DIV)!="undefined"&&S_CONTAINERS_WRAPPER_DIV&&S_CONTAINERS_WRAPPER_DIV.length>0){
var lyr=document.getElementById(S_CONTAINERS_WRAPPER_DIV);
if(lyr){
lyr.style.visibility="";
}
}
},centerMe:function(_93){
var e=document.getElementById(_93);
if(!e){
return;
}
e.style.position="absolute";
e.style.display="block";
e.style.zindex="10000";
e.style.visibility="";
var x=0,y=0;
var sT=0,sL=0;
if(document.documentElement){
var de=document.documentElement;
if(navigator.userAgent.indexOf("Safari")>-1&&document.body){
de=document.body;
}
sT=de.scrollTop;
sL=de.scrollLeft;
if(self.innerHeight){
x=self.innerWidth;
y=self.innerHeight;
}else{
x=de.clientWidth;
y=de.clientHeight;
}
}else{
if(document.body){
var de=document.body;
x=de.clientWidth;
y=de.clientHeight;
}
}
var t=parseInt((y-e.offsetHeight)/2)+sT;
var l=parseInt((x-e.offsetWidth)/2)+sL;
e.style.left=l+"px";
e.style.top=t+"px";
}}).inits(function(){
});

vjo.needs("vjo.darwin.app.myebay.RequestManager");
vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.darwin.app.myebay.SavedSearchesFlash").protos({constructs:function(){
this.getResolution();
},replaceDivs:function(_1,_2){
var _3=vjo.dsf.document.Element.get(_1);
if(_3&&vjo.dsf.client.Browser.bIE){
_3.innerHTML=_2;
}
return false;
},getResolution:function(){
var _4=vjo.dsf.document.Element.get("myebay_nextgen_saved_child_tab");
var _5=_4?_4.childNodes.length:0;
for(i=0;i<_5;i++){
if(_4.childNodes[i].tagName=="A"){
if(!_4.childNodes[i].href.has("&screenResolution=")){
_4.childNodes[i].href+="&screenResolution="+screen.height+"*"+screen.width;
}
}
}
},SavedSearchesFlash:function(_6,_7,_8){
var _9=vjo.dsf.document.Element.get(_6);
var _a=_9.elements[_7];
if(_9){
vjo.dsf.document.Element.get(_8).value=_a.value;
var _b;
window.bSearchesShown=true;
_b=vjo.darwin.app.myebay.ItemDisplay.submitForm();
window.bSearchesShown=false;
window.iNoOfItems=0;
_b+="&Container=ALL";
vjo.darwin.app.myebay.RequestManager.makeAjaxGetRequest(_b);
}
},hideSearch:function(_c,_d,_e,_f){
if(!window.iNoOfItems){
window.iNoOfItems=0;
}
if(!confirm(_e)){
return false;
}
window.sSavedSearchId=_c;
window.iNoOfItems++;
if(window.iNoOfItems==vjo.dsf.document.Element.get("ItemsInPageHidden").value){
vjo.dsf.document.Element.get("utilitybarid").style.display="none";
}
vjo.darwin.app.myebay.RequestManager.returnTop(_d);
var _10=vjo.dsf.document.Element.get(_f);
if(_10){
_10.className="";
}
return false;
},makeNoteScriptRequest:function(url,_12){
if(url){
var _13=document.createElement("script");
_13.type="text/javascript";
var _14=Math.round(Math.random()*100000);
var _15=this.addRandomParam(url)+"&_sajscallback="+_12+"&_sajsuniqueid="+_14;
_13.src=_15;
document.getElementsByTagName("head")[0].appendChild(_13);
}
return false;
},addRandomParam:function(url){
url+=(url.indexOf("?")>0?"&":"?")+"rand="+Math.random();
return url;
},renderResponse:function(_17){
this.bResp=true;
var _18;
var _19=vjo.darwin.app.myebay.SavedSearchesFlash.id;
var div=vjo.dsf.document.Element.get(_19);
if(_17&&_17.length>0){
_18=_17[0].data?_17[0].data.map:false;
if(_18){
if(div){
vjo.darwin.app.myebay.RequestManager.bindCss(div,_18.Style,true);
var _1b=eval("json.ME18_body");
if(vjo.dsf.document.Element.get(this.dbDownDiv)){
vjo.dsf.document.Element.get(this.dbDownDiv).style.display="none";
}
div.innerHTML=_1b;
vjo.darwin.app.myebay.RequestManager.bindJs(_18.Script);
vjo.darwin.app.myebay.RequestManager.showDivOverlay(_19);
}
}else{
if(_17[0].errors[0]=="NO_RESULT"){
div.innerHTML=vjo.darwin.app.myebay.SavedSearchesFlash.errorDiv;
vjo.dsf.document.Element.get(vjo.darwin.app.myebay.SavedSearchesFlash.sortdivId).style.display="none";
vjo.darwin.app.myebay.RequestManager.bindJs(_18.Script);
vjo.darwin.app.myebay.RequestManager.showDivOverlay(_19);
}
}
}
},openEmailOverlay:function(_1c,_1d,_1e,_1f,_20,_21,_22,_23,_24,_25,_26,_27,_28){
if(vjo.dsf.client.Browser.bIE){
vjo.Registry.get(_1c).leftOffset=-100;
}
vjo.dsf.ServiceEngine.handleRequest(vjo.darwin.core.overlaypanel.VjOverlayPanelEvtHandlers.handleOpenEvent(_1d,_1e));
window.sOverlayPanelId=_1c;
window.sSaveSearchUrl=_20;
window.sEmailSelectId=_1f;
window.subscribeLinkId=_21;
window.subscribeLinkText=_22;
window.daysDivId=_23;
window.sEditId=_1e;
window.sEmailHeaderId=_25;
window.sEmailMeChkId=_26;
window.sNotSubscribedContent=_27;
window.sNotSubscribedId=_28;
window.sBlankTxt="";
if(vjo.dsf.document.Element.get(window.sEditId).sVal){
vjo.dsf.document.Element.get(window.sEmailSelectId).selectedIndex=vjo.dsf.document.Element.get(window.sEditId).sVal;
}else{
vjo.dsf.document.Element.get(window.sEmailSelectId).value=_24;
}
},addEmailSetting:function(_29){
window.errorDiv=_29;
if(vjo.dsf.document.Element.get(window.sEmailMeChkId)&&vjo.dsf.document.Element.get(window.sEmailMeChkId).checked){
var _2a=window.sSaveSearchUrl+"&Emailme=1"+"&EmailDuration="+vjo.dsf.document.Element.get(window.sEmailSelectId).value;
}else{
var _2a=window.sSaveSearchUrl+"&Emailme=0"+"&EmailDuration="+vjo.dsf.document.Element.get(window.sEmailSelectId).value;
}
vjo.dsf.document.Element.get(window.sEditId).sVal=vjo.dsf.document.Element.get(window.sEmailSelectId).value;
if(window.subscribeLinkId&&vjo.dsf.document.Element.get(window.subscribeLinkId).innerHTML!=(window.subscribeLinkText)){
_2a+="&ssPageName=STRK:MEFSRCHX:SUBSCRIBE";
}else{
_2a+="&ssPageName=STRK:MEFSRCHX:EMAILPREF";
}
if(window.testmaps&&window.landingSelectedVal){
var _2b=window.testmaps[window.landingSelectedVal];
_2b[1]=vjo.dsf.document.Element.get(window.sEmailSelectId).value+" days left";
_2b[2]=vjo.dsf.document.Element.get(window.sEmailSelectId).value;
_2a=_2a+"&LineID="+_2b[3];
}
this.makeNoteScriptRequest(_2a,"vjo.Registry.get('SavedSearchesFlash').processESResponse");
return false;
},processESResponse:function(_2c){
var _2d;
if(_2c){
_2d=_2c;
if(_2d){
var _2e=_2d.success;
}
if(_2e){
if(_2d.emailcontent&&vjo.dsf.document.Element.get(window.daysDivId)){
vjo.dsf.document.Element.get(window.daysDivId).firstChild.data=_2d.emailcontent;
}
if(_2d.lastSentDate&&vjo.dsf.document.Element.get(window.sEmailHeaderId)){
if(vjo.dsf.document.Element.get(window.sEmailHeaderId).firstChild.nextSibling){
vjo.dsf.document.Element.get(window.sEmailHeaderId).firstChild.nextSibling.data=_2d.lastSentDate;
}
}
var _2f=vjo.dsf.document.Element.get(window.sEditId);
if(vjo.dsf.document.Element.get(window.sEmailMeChkId)&&!(vjo.dsf.document.Element.get(window.sEmailMeChkId).checked)){
if(_2f){
_2f.innerHTML=window.subscribeLinkText;
}
var _30=window.sNotSubscribedContent.replace("|","");
vjo.dsf.document.Element.get(window.daysDivId).firstChild.data=_30.replace("&nbsp;","");
if(vjo.dsf.document.Element.get(window.sNotSubscribedId)){
vjo.dsf.document.Element.get(window.sNotSubscribedId).innerHTML=window.sNotSubscribedContent;
}
}else{
if(_2f){
_2f.innerHTML="Edit";
}
if(vjo.dsf.document.Element.get(window.sNotSubscribedId)){
vjo.dsf.document.Element.get(window.sNotSubscribedId).innerHTML=window.sBlankTxt;
}
}
var _2f=vjo.dsf.document.Element.get(window.subscribeLinkId);
if(_2f){
_2f.innerHTML=window.subscribeLinkText;
}
}else{
if(window.errorDiv){
vjo.dsf.document.Element.get(window.errorDiv).style.display="block";
}
}
}
this.closeOverlay();
},cancelNotes:function(_31){
vjo.dsf.document.Element.get(_31).style.display="none";
},processSaveResponse:function(_32){
var _33;
if(_32){
_33=_32;
if(_33){
var _34=_33.success;
}
if(_34){
inlineEditItemJsComp.reset();
}
}
},showSearchOnLoad:function(){
var _35=null;
if(vjo.dsf.document.Element.get("SSarrow323id1")){
_35=vjo.dsf.document.Element.get("SSarrow323id1");
}else{
if(vjo.dsf.document.Element.get("SSarrow325id1")){
_35=vjo.dsf.document.Element.get("SSarrow325id1");
}
}
if(vjo.dsf.document.Element.get("SSRarrow324id1")){
_35=vjo.dsf.document.Element.get("SSRarrow324id1");
}
if(vjo.dsf.document.Element.get("MyNeighborhoodsImg0")){
_35=vjo.dsf.document.Element.get("MyNeighborhoodsImg0");
}
if(_35){
_35.onclick();
}
return false;
},unjoinNeighborhood:function(_36,_37){
if(confirm(_37)){
vjo.darwin.app.myebay.RequestManager.makeAjaxGetRequest(_36);
}
},showRtmOverlayCallback:function(_38,_39,msg,id){
var _3c=msg.vjRTMObject.aContent;
for(var idx=0;(idx<_3c.length);idx++){
if(_3c[idx].id==id&&_3c[idx].content){
this.showRtmOverlay(_38,_39,msg,id);
}
}
},saveEmailFrequency:function(_3e,url){
var url=url+"&EmailFrequency="+vjo.dsf.document.Element.get(_3e).value;
this.closeOverlay();
vjo.darwin.app.myebay.RequestManager.makeAjaxGetRequest(url);
},closeOverlay:function(){
if(vjo.Registry.get(window.sOverlayPanelId)){
return vjo.Registry.get(window.sOverlayPanelId).onClosePanel();
}
},showRtmOverlay:function(_40,_41,msg,id){
if(msg.status==1){
if(vjo.Registry.get(_41)){
vjo.Registry.get(_41).onOpenOverlayPanel();
var _44=vjo.dsf.document.Element.get("rtm_html_"+id);
if(_44){
_44.style.display="block";
}
}
if(vjo.dsf.document.Element.get("tr_rtm_html_"+id)){
vjo.dsf.document.Element.get("tr_rtm_html_"+id).style.display="";
}
}
}}).inits(function(){
vjo.Registry.put("SavedSearchesFlash",new vjo.darwin.app.myebay.SavedSearchesFlash());
}).props({ShowFlashSearchDivs:function(_45,_46,_47,_48,_49,id,_4b,_4c){
var _4d=window.testmaps?window.testmaps:_45;
window.testmaps=_4d;
var _4e=vjo.dsf.document.Element.get("name_"+id+"_"+_47+"Bdy");
var _4f=vjo.dsf.document.Element.get(""+id+"_Note");
var _50=vjo.dsf.document.Element.get("SearchDropDownId");
var _51=vjo.dsf.document.Element.get("emailSort");
var _52=_4d[_50.childNodes[_50.selectedIndex].value];
var _53=document.createElement("td");
_53.style.paddingLeft="12px";
_53.style.paddingTop="12px";
var _54=vjo.dsf.document.Element.get("GotoSearchesLnk");
var _55=_48[_50.childNodes[_50.selectedIndex].value];
var _56=_49[_50.childNodes[_50.selectedIndex].value];
var _57=vjo.dsf.document.Element.get("landingPageFlash");
_53.colSpan=2;
_57.removeChild(_57.firstChild);
_53.id=_55;
_57.appendChild(_53);
for(i=0;i<_51.childNodes.length;i++){
if(_51.childNodes[i].value==_52[2]){
_51.selectedIndex=i;
if(vjo.dsf.document.Element.get("EditLinkSSeditEmail323id1")){
var _58=vjo.dsf.document.Element.get("EditLinkSSeditEmail323id1");
}else{
var _58=vjo.dsf.document.Element.get("SubscribeLinkSSeditEmail323id1");
}
if(_58){
_58.sVal=i;
}
break;
}
}
var _59=(_52[1]==_4c)?_4b:_52[1];
vjo.dsf.document.Element.get("SSemail323id1").firstChild.data=_59;
window.landingSelectedVal=_50.childNodes[_50.selectedIndex].value;
if(_52[0]){
if(_4e){
_4e.firstChild.firstChild.innerHTML=_52[0];
}
if(_4f){
_4f.value=_52[0];
}
if(vjo.dsf.document.Element.get("newNotes_"+id+"")){
vjo.dsf.document.Element.get("newNotes_"+id+"").style.display="none";
}
if(vjo.dsf.document.Element.get("addNotes_"+id+"")){
vjo.dsf.document.Element.get("addNotes_"+id+"").style.display="block";
}
}else{
if(_4e){
_4e.firstChild.firstChild.innerHTML="";
}
if(_4f){
_4f.value="";
}
if(vjo.dsf.document.Element.get("newNotes_"+id+"")){
vjo.dsf.document.Element.get("newNotes_"+id+"").style.display="block";
}
if(vjo.dsf.document.Element.get("addNotes_"+id+"")){
vjo.dsf.document.Element.get("addNotes_"+id+"").style.display="none";
}
}
var _5a=vjo.dsf.document.Element.get("selectCriteria");
if(_5a){
_5a.innerHTML="";
}
if(_52[4]){
if(_5a){
_5a.innerHTML=_52[4];
}
}
if(_56){
_54.href=_56;
}
var _5b=_46[_50.childNodes[_50.selectedIndex].value];
if(_5b){
vjo.darwin.sharedpres.flash.FlashHelper.AddFlash(_5b);
}
},attachMap:function(_5c){
window.testmaps=_5c;
var _5d=vjo.dsf.document.Element.get("SearchDropDownId");
window.landingSelectedVal=_5d.childNodes[_5d.selectedIndex].value;
}});

vjo.type("vjo.darwin.app.myebay.SavedStuffNote").props({clickSave:function(_1){
var _2=_1;
inlineEditItemJsComp=vjo.Registry.get(_2);
var _3=sBaseUrl+"&SubmitAction.SaveNote=x";
if(inlineEditItemJsComp!=undefined){
var _4=inlineEditItemJsComp.aInputElemIds[0];
var _5=inlineEditItemJsComp.sAjaxKeyId;
window.iLineId=_5.split("_")[1];
var _6=document.getElementById(_4).value;
if(window.testmaps&&window.landingSelectedVal){
var _7=window.testmaps[window.landingSelectedVal];
_7[0]=_6;
window.iLineId=_7[3];
}
_3=_3+"&LineID="+window.iLineId+"&Note="+_6;
}
this.makeNoteScriptRequest(_3,"vjo.darwin.app.myebay.SavedStuffNote.processSaveResponse");
},clickRemove:function(_8){
var _9=_8;
inlineEditItemJsComp=vjo.Registry.get(_9);
var _a=sBaseUrl+"&SubmitAction.DeleteNote=x";
if(inlineEditItemJsComp!=undefined){
var _b=inlineEditItemJsComp.aInputElemIds[0];
var _c=inlineEditItemJsComp.sAjaxKeyId;
window.iLineId=_c.split("_")[1];
var _d=document.getElementById(_b).value;
if(window.testmaps&&window.landingSelectedVal){
var _e=window.testmaps[window.landingSelectedVal];
_e[0]=null;
window.iLineId=_e[3];
}
_a=_a+"&LineID="+window.iLineId+"&Note="+_d;
}
this.makeNoteScriptRequest(_a,"vjo.darwin.app.myebay.SavedStuffNote.processRemoveResponse");
},makeNoteScriptRequest:function(_f,_10){
if(_f){
var _11=document.createElement("script");
_11.type="text/javascript";
var _12=vjo.darwin.app.myebay.MyEbayUserNotes.addRandomParam(_f)+"&callback="+_10;
_11.src=_12;
document.getElementsByTagName("head")[0].appendChild(_11);
}
return false;
},addRandomParam:function(url){
var i=parseInt(Math.random()*10000);
url+=(url.indexOf("?")>0?"&":"?")+"rand="+i;
return url;
},makeAjaxRequest:function(url,_16){
if(url){
var _17=getAjaxReq(_16);
var _18=vjo.darwin.app.myebay.MyEbayUserNotes.addRandomParam(url);
_17.open("GET",_18,true);
_17.send(null);
}
return false;
},processSaveResponse:function(_19){
var _1a;
if(_19){
_1a=_19;
if(_1a){
var _1b=_1a.success;
}
if(_1b){
inlineEditItemJsComp.reset();
}
}
},setBaseUrl:function(url){
if(typeof (sBaseUrl)!="undefined"){
sBaseUrl=url;
}
},processRemoveResponse:function(_1d){
var _1e;
if(_1d){
_1e=_1d;
if(_1e){
var _1f=_1e.success;
}
if(_1f){
if(window.testmaps){
document.getElementById("newNotes_addnoteId").style.display="block";
document.getElementById("addNotes_addnoteId").style.display="none";
}else{
document.getElementById("newNotes_"+window.iLineId).style.display="block";
document.getElementById("addNotes_"+window.iLineId).style.display="none";
}
}
}
}}).protos({constructs:function(){
}});

vjo.needs("vjo.darwin.app.myebay.RequestManager");
vjo.type("vjo.darwin.app.myebay.ItemDisplay").props({bOrder:false,bAdd:true,showEditable:function(_1,_2,_3,_4,_5){
var _6=true;
var _7=_1.target?_1.target:_1.srcElement;
for(i=0;i<_7.form.elements.length;i++){
if((elem=_7.form.elements[i])&&(elem.type=="checkbox")&&(elem.id==_2)&&elem.checked){
if(vjo.darwin.app.myebay.ItemDisplay.bAdd){
if(elem.bOrder){
if(window.aMaskRow&&window.aMaskRow.length){
var _8=window.aMaskRow.length;
for(j=0;j<_8;j++){
if(window.aMaskRow[j]){
window.aMaskRow[j].style.display="none";
window.aMaskRow[j]="";
}
}
vjo.darwin.app.myebay.ItemDisplay.addOrderNotes(elem,_4,_5);
return;
}
}else{
_6=false;
if(vjo.dsf.document.Element.get(elem.parentNode.id+"_mask")){
vjo.dsf.document.Element.get(elem.parentNode.id+"_mask").style.display="none";
}
vjo.darwin.app.myebay.ItemDisplay.seperatorClass(elem);
if(document.getElementById(_4+elem.value)){
document.getElementById(_4+elem.value).style.display="";
document.getElementById(_4+elem.value).parentNode.parentNode.className="";
if(document.getElementById("name."+_4.split(".")[1]+elem.value)){
document.getElementById("name."+_4.split(".")[1]+elem.value).style.display="";
}
vjo.Registry.get(_5+elem.value+"Js").editing();
}else{
vjo.darwin.app.myebay.ItemDisplay.addOrderNotes(elem,_4,_5);
}
}
}else{
_6=false;
vjo.darwin.app.myebay.ItemDisplay.seperatorClass(elem);
if(vjo.dsf.document.Element.get(elem.parentNode.id+"_mask")){
vjo.dsf.document.Element.get(elem.parentNode.id+"_mask").style.display="none";
}
aItemVal=elem.value.split(",");
for(k=0;k<aItemVal.length;k++){
iVal="";
if(document.getElementById(_4+aItemVal[k])){
iVal=_4+aItemVal[k];
iVal2=_5+aItemVal[k];
}else{
iVal=aItemVal[k].has("Transactions")?aItemVal[k]:"Transactions."+aItemVal[k];
if(!document.getElementById(_4+iVal)){
iVal="Transactions"+iVal.split("Transactions")[1];
}
if(iVal.has("Order.")){
var _9=iVal.split("Transactions")[1];
iVal="Transactions"+_9;
}
}
if(document.getElementById(iVal)){
document.getElementById(iVal).style.display="";
document.getElementById(iVal).parentNode.parentNode.className="";
}
if(vjo.Registry.get(iVal2+"Js")){
vjo.Registry.get(iVal2+"Js").editing();
}
}
}
}
}
if(_6){
alert(_3);
}
return false;
},showEditableNote:function(_a,_b,_c){
var _d=true;
if(document.getElementById(_a+_c)){
document.getElementById(_a+_c).style.display="";
var _e=document.getElementById(_a+_c).parentNode.parentNode;
if(_e){
_e.className="";
if(_e.previousSibling.childNodes){
for(i=0;i<_e.previousSibling.childNodes.length;i++){
var _f=_e.previousSibling.childNodes[i].className;
var _10=_f.replace(/dtbl-rowSeptr/,"");
_e.previousSibling.childNodes[i].className=_10;
}
}
}
document.getElementById(_a+_c).parentNode.parentNode.className="";
if(document.getElementById("name."+_a.split(".")[1]+_c)){
document.getElementById("name."+_a.split(".")[1]+_c).style.display="";
}
vjo.Registry.get(_b+_c+"Js").editing();
}else{
vjo.darwin.app.myebay.ItemDisplay.addOrderNotes(_c,_a,_b,_d);
}
return false;
},showEbayNote:function(){
vjo.dsf.ServiceEngine.handleRequest(new vjo.dsf.Message("MYEBAY_PANEL_MOVED"));
},addOrderNotes:function(_11,_12,_13,_14){
if(!(_14)){
aItemVal=_11.value.split(",");
var _15=_11.id;
}else{
aItemVal=_11.split(",");
}
for(i=0;i<aItemVal.length;i++){
iVal="";
if(document.getElementById(aItemVal[i])){
iVal=aItemVal[i];
}else{
iVal=aItemVal[i].has("Transactions")?aItemVal[i]:"Transactions."+aItemVal[i];
if(!document.getElementById(_12+iVal)){
iVal="Transactions"+iVal.split("Transactions")[1];
}
}
if(!(_14)){
for(j=0;j<_11.form.elements.length;j++){
if((elem=_11.form.elements[j])&&(elem.type=="checkbox")&&(elem.value==iVal)){
vjo.darwin.app.myebay.ItemDisplay.seperatorClass(elem);
document.getElementById(_12+iVal).style.display="";
document.getElementById(_12+iVal).parentNode.parentNode.className="";
vjo.Registry.get(_13+elem.value+"Js").editing();
}
}
}else{
document.getElementById(_12+iVal).style.display="";
document.getElementById(_12+iVal).parentNode.parentNode.className="";
vjo.Registry.get(_13+iVal+"Js").editing();
}
}
},seperatorClass:function(_16){
var _17=_16;
if(_17.parentNode.parentNode.nextSibling.className&&_17.parentNode.parentNode.nextSibling.className=="my_itl-enR"){
_17.bEnotes=true;
}else{
_17.bEnotes=false;
}
var _18=_17.bEnotes?_17.parentNode.parentNode.nextSibling.childNodes.length:_17.parentNode.parentNode.childNodes.length;
for(l=0;l<_18;l++){
var _19=_17.bEnotes?_17.parentNode.parentNode.nextSibling.childNodes[l].className:_17.parentNode.parentNode.childNodes[l].className;
var _1a=_19.replace(/dtbl-rowSeptr/,"");
if(_17.bEnotes){
_17.parentNode.parentNode.nextSibling.childNodes[l].className=_1a;
}else{
_17.parentNode.parentNode.childNodes[l].className=_1a;
}
}
},orderClicked:function(_1b,_1c,_1d,_1e,_1f,_20){
var _21=_1b.target?_1b.target:_1b.srcElement;
var _22=_21.value.split(",");
var b=_21.checked?true:false;
_21.bOrder=b?true:false;
for(i=0;i<_22.length;i++){
iVal="";
if(document.getElementById(_22[i])){
iVal=_22[i];
}else{
iVal=_22[i].has("Transactions")?_22[i]:"Transactions."+_22[i];
if(iVal.has("Order.")){
var str=iVal.split("Transactions")[1];
iVal="Transactions"+str;
}
}
for(j=0;j<_21.form.elements.length;j++){
if((elem=_21.form.elements[j])&&(elem.type=="checkbox")&&(elem.id==_1c)&&elem.value==iVal){
elem.checked=b;
elem.bOdr=true;
this.grayoutItem(elem,_1d,b,true);
break;
}
}
}
this.checkboxClicked(_1b,_1e,_1f,_1d,_20,_1c);
},checkAll:function(_25,_26,_27){
var _28=_25.target?_25.target:_25.srcElement;
var _29=_28.form;
var b=_28.checked?true:false;
vjo.darwin.app.myebay.ItemDisplay.bAdd=b?false:true;
for(i=0;i<_29.elements.length;i++){
if((elem=_29.elements[i])&&(elem.type=="checkbox")&&(elem.id==_26)){
elem.checked=b;
if(vjo.dsf.document.Element.get(elem.parentNode.id+"_mask")){
vjo.dsf.document.Element.get(elem.parentNode.id+"_mask").style.display="none";
}
}
}
if(_29.elements[_27]){
_29.elements[_27].checked=b;
}
},checkboxClicked:function(_2b,_2c,_2d,_2e,_2f,_30){
var _31=_2b.target?_2b.target:_2b.srcElement;
var b=_31.checked?true:false;
if(!_31.getAttribute("orderval")){
this.grayoutItem(_31,_2e);
}
var _33=[_2c,_2d];
var _34=_31.form;
var _35=[];
var _36=_34.elements[_30];
for(i=0;i<_33.length;i++){
_35[i]=_34.elements[_33[i]];
if(_35[i]){
if(_35[i].checked){
_35[i].checked=false;
}else{
if(this.allCheckboxesAreChecked(_36)){
_35[i].checked=true;
}
}
}
}
},allCheckboxesAreChecked:function(_37){
if(_37.length){
var _38=true;
for(var i=0;i<_37.length;i++){
if(!_37[i].checked){
return false;
}
}
return true;
}
return _37.checked;
},grayoutItem:function(_3a,_3b,_3c,_3d){
var _3e=_3a.parentNode;
_3e.bEnotes=(_3e.parentNode.nextSibling&&_3e.parentNode.nextSibling.className=="my_itl-enR");
if(!window.aMaskRow){
window.aMaskRow=[];
}
var _3f=document.getElementById(_3e.id+"_mask");
if(!_3f){
var tmp=this.findPos(_3e.parentNode.parentNode.parentNode);
if(_3a.bOdr){
var _41=this.maskRow(_3e.parentNode.offsetHeight,(_3e.parentNode.offsetWidth-30),tmp[0]+28,1,-7,-12,_3b);
}else{
var _41=this.maskRow(_3e.parentNode.offsetHeight,(_3e.parentNode.offsetWidth-30),tmp[0]+28,1,-7,-26,_3b);
}
_41.id=_3e.id+"_mask";
_3e.appendChild(_41);
}
_3f=document.getElementById(_3e.id+"_mask");
if(_3e.parentNode.nextSibling){
_3f.style.height=(_3e.parentNode.offsetHeight+(_3e.parentNode.nextSibling.offsetHeight-6))+"px";
}
if(_3e.bEnotes&&_3e.parentNode.nextSibling.nextSibling){
_3f.style.height=(_3e.parentNode.offsetHeight+(_3e.parentNode.nextSibling.offsetHeight-6)+(_3e.parentNode.nextSibling.nextSibling.offsetHeight))+"px";
}
if(_3d){
if(_3c){
_3f.style.display="";
window.aMaskRow.push(_3f);
}else{
_3f.style.display="none";
window.aMaskRow.pop(_3f);
}
}else{
_3f.style.display=_3a.checked?"":"none";
if(_3a.checked){
window.aMaskRow.push(_3f);
}else{
window.aMaskRow.pop(_3f);
}
}
},findPos:function(obj){
var _43=curtop=0;
if(obj.offsetParent){
do{
_43+=obj.offsetLeft;
curtop+=obj.offsetTop;
}while(obj=obj.offsetParent);
}
return [_43,curtop];
},maskRow:function(_44,_45,_46,_47,_48,_49,_4a){
var t=document.createElement("DIV");
t.style.height=_44+"px";
t.style.width=_45+"px";
t.style.filter="Alpha(Opacity=10)";
if(!(vjo.dsf.client.Browser.bIE||vjo.dsf.client.Browser.bFirefox||vjo.dsf.client.Browser.bSafari)){
t.style.left="22px";
}else{
t.style.left=_46+"px";
}
t.style.zIndex=_47;
if(vjo.dsf.client.Browser.bIE){
t.style.marginTop=_48+"px";
}else{
t.style.marginTop=_49+"px";
}
t.className=_4a;
return t;
},submitForm:function(){
var _4c="",url="";
if(document.getElementById("sort")){
var val=document.getElementById("sort").value;
}
var _4e="SubmitAction.SortAscend";
var _4f="SubmitAction.SortDescend";
var _50="Column";
var url=document.URL;
index=url.split("?");
index[1]="";
if(document.getElementById("CurrentPage")){
url=index[0]+"?MyeBayBeta&CurrentPage="+document.getElementById("CurrentPage").value;
}
if(val){
if(val=="1"||val=="4"||val=="7"||val=="8"||val=="10"||val=="12"){
this.clearValues();
document.getElementById("ascending").value=_4e+"=x";
_4c+="&"+document.getElementById("ascending").value;
}else{
if(val=="2"||val=="3"||val=="5"||val=="6"||val=="9"||val=="11"){
this.clearValues();
document.getElementById("descending").value=_4f+"=x";
_4c+="&"+document.getElementById("descending").value;
}
}
if(val=="1"||val=="2"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=EndTime";
_4c+="&"+document.getElementById("sortColumn").value;
}else{
if(val=="4"||val=="5"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=CurrentPrice";
_4c+="&"+document.getElementById("sortColumn").value;
}else{
if(val=="6"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=EndDate";
_4c+="&"+document.getElementById("sortColumn").value;
}else{
if(val=="7"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=StartDate";
_4c+="&"+document.getElementById("sortColumn").value;
}else{
if(val=="8"||val=="9"||val=="3"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=StartTime";
_4c+="&"+document.getElementById("sortColumn").value;
}else{
if(val=="10"||val=="11"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=SalePrice";
_4c+="&"+document.getElementById("sortColumn").value;
}else{
if(val=="12"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=SaleDate";
_4c+="&"+document.getElementById("sortColumn").value;
}
}
}
}
}
}
}
if(val=="13"||val=="15"){
this.clearValues();
document.getElementById("ascending").value=_4e+"=x";
_4c+="&"+document.getElementById("ascending").value;
}else{
if(val=="14"||val=="16"){
this.clearValues();
document.getElementById("descending").value=_4f+"=x";
_4c+="&"+document.getElementById("descending").value;
}
}
if(val=="15"||val=="16"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=SearchName";
_4c+="&"+document.getElementById("sortColumn").value;
}else{
if(val=="13"||val=="14"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=EmailAddedDate";
_4c+="&"+document.getElementById("sortColumn").value;
}
}
if(val=="13"||val=="17"){
this.clearValues();
document.getElementById("ascending").value=_4e+"=x";
_4c+="&"+document.getElementById("ascending").value;
}else{
if(val=="14"||val=="18"){
this.clearValues();
document.getElementById("descending").value=_4f+"=x";
_4c+="&"+document.getElementById("descending").value;
}
}
if(val=="17"||val=="18"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=Sellers";
_4c+="&"+document.getElementById("sortColumn").value;
}else{
if(val=="13"||val=="14"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=EmailAddedDate";
_4c+="&"+document.getElementById("sortColumn").value;
}
}
if(val=="19"||val=="21"||val=="23"||val=="25"){
this.clearValues();
document.getElementById("ascending").value=_4e+"=x";
_4c+="&"+document.getElementById("ascending").value;
}else{
if(val=="20"||val=="22"||val=="24"||val=="26"){
this.clearValues();
document.getElementById("descending").value=_4f+"=x";
_4c+="&"+document.getElementById("descending").value;
}
}
if(val=="19"||val=="20"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=NeighborhoodName";
_4c+="&"+document.getElementById("sortColumn").value;
}else{
if(val=="21"||val=="22"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=NeighborhoodDateJoined";
_4c+="&"+document.getElementById("sortColumn").value;
}else{
if(val=="23"||val=="24"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=NeighborhoodNumberOfMembers";
_4c+="&"+document.getElementById("sortColumn").value;
}else{
if(val=="25"||val=="26"){
document.getElementById("sortColumn").value="";
document.getElementById("sortColumn").value=_50+"=NeighborhoodNumberOfPost";
_4c+="&"+document.getElementById("sortColumn").value;
}
}
}
}
}
var _52="&View="+document.getElementById("view").value;
var _53=document.getElementById("view").value+".Filter";
fUrl="&"+_53+"="+document.getElementById(_53).value;
if(document.getElementById("SearchDropDownId")){
_4c+="&maxRecordsPerContainer="+document.getElementById("SearchDropDownId").value;
}
_4c=url+_4c+_52+fUrl;
if((document.getElementById("CurrentPage").value=="MyeBayNextSellingDeletedItems")||(document.getElementById("CurrentPage").value=="MyeBayNextBuyingDeletedItems")){
_4c+=this.addParams();
}
window.location.replace(_4c);
},addParams:function(){
var str="";
var _55=["NewPeriod","NewFilter"];
for(i=0;i<_55.length;i++){
if(document.getElementById(_55[i])){
str+="&"+_55[i]+"="+document.getElementById(_55[i]).value;
}
}
var _56=document.getElementById("sort").value.split(":");
if(_56){
str+="&SortOrder="+_56[2]+"&Column="+_56[1];
}
str+="&SubmitAction.ChangeFilterSortPeriodAction=x";
return str;
},clearValues:function(){
document.getElementById("ascending").value="";
document.getElementById("descending").value="";
document.getElementById("sortColumn").value="";
},getFormSubmit:function(){
var _57="",curUrl="",hdnUrl="",resUrl="";
curUrl=document.URL;
index=curUrl.split("?");
index[1]="";
curUrl=index[0]+"?MyeBayBeta&CurrentPage="+document.getElementById("CurrentPage").value;
_57="&View="+document.getElementById("view").value+"&Container="+document.getElementById("view").value;
hdnUrl="&bidGroupId="+document.getElementById("bidGroupSelect").value;
resUrl=curUrl+_57+hdnUrl;
vjo.darwin.app.myebay.RequestManager.makeAjaxGetRequest(resUrl);
},postFormSubmit:function(){
document.getElementById("bidGroupId").value=document.getElementById("bidGroupSelect").value;
vjo.darwin.app.myebay.RequestManager.makeAjaxPostRequest("myform","bidGroupSelect");
},submitDelete:function(){
document.getElementById("SubmitAction.BulkEditMaxBid").value="";
},submitEdit:function(){
document.getElementById("SubmitAction.BulkDelete").value="";
},addNotes:function(_58,_59,_5a,_5b,_5c,_5d){
vjo.Registry.get(_5a+_58+"_"+_59+"Js").editing();
document.getElementById(_58+_5b).value="";
document.getElementById(_5c+_58).style.display="none";
document.getElementById(_5d+_58).style.display="block";
},undoRemove:function(_5e,_5f,_60,_61,_62,_63,_64){
var _65="",url="";
var val=document.getElementById(_5f).value;
var url=document.URL;
index=url.split("?");
index[1]="";
url=index[0]+"?MyeBayBeta&CurrentPage="+document.getElementById(_5e).value+"&Container=All"+"&View="+document.getElementById(_64).value;
var _68="&"+document.getElementById(_60).value+"=-1";
var _69="&"+document.getElementById(_61).value+"="+val;
var _6a="&"+document.getElementById(_62).value+"=true";
_65=url+_68+_69+_6a;
vjo.darwin.app.myebay.RequestManager.makeAjaxGetRequest(_65);
var _6b=document.getElementById(_63);
_6b.click();
},clickRemove:function(_6c){
var _6d=_6c;
inlineEditItemJsComp=vjo.Registry.get(_6d);
var _6e=sBaseUrl+"&SubmitAction.RemoveDynamicNote=x";
if(inlineEditItemJsComp!=undefined){
var _6f=inlineEditItemJsComp.aInputElemIds[0];
var _70=inlineEditItemJsComp.sAjaxKeyId;
window.iLineId=_70.split("_")[1];
var _71=document.getElementById(_6f).value;
_6e=_6e+"&LineID="+window.iLineId+"&Note="+_71;
}
vjo.darwin.app.myebay.MyEbayUserNotes.makeNoteScriptRequest(_6e,"vjo.darwin.app.myebay.ItemDisplay.processRemoveResponse");
},processRemoveResponse:function(_72){
var _73;
if(_72){
_73=_72;
if(_73){
var _74=_73.success;
}
if(_74){
document.getElementById("addNotes1_"+window.iLineId).style.display="block";
document.getElementById("newNotes1_"+window.iLineId).style.display="none";
}
}
}});

vjo.needs("vjo.dsf.utils.Timer");
vjo.needs("vjo.dsf.utils.Handlers");
vjo.type("vjo.darwin.core.inplaceedit.item.InplaceEditItemController").singleton().protos({H:vjo.dsf.utils.Handlers,constructs:function(){
var t=this;
t.aItems=[];
t.lItems=[];
t.H.attachEvt(window,"load",t.initTimer,t);
t.H.attachSvc("MYEBAY_PANEL_MOVED",t.panelMoved,t);
var _2=function(){
t.initItems();
};
window.setTimeout(_2,500);
},registerLazyItem:function(_3){
var t=this;
t.lItems[t.lItems.length]=_3;
},initItems:function(){
var t=this,i=0,arr=t.lItems,len=arr.length;
while(i<len){
arr[i].initMe();
i++;
}
},getJsRefId:function(_6){
return _6+"Js";
},getAjaxKeyId:function(_7){
return _7+"AK";
},getFrontId:function(_8){
return _8+"Frnt";
},getBodyId:function(_9){
return _9+"Bdy";
},getCmdId:function(_a){
return _a+"Cmd";
},getSaveId:function(_b){
return _b+"Sav";
},getModifyLinkId:function(_c){
return _c+"MdfyLk";
},getRemoveLinkId:function(_d){
return _d+"RmvLk";
},getSaveLinkId:function(_e){
return _e+"SavLk";
},getCancelLinkId:function(_f){
return _f+"CnclLk";
},getStateClzes:function(_10){
var _11="-",INPLACE_EDIT_FOCUS="-focus",INPLACE_EDIT_EDITING="-editing",INPLACE_EDIT_EDITED="-edited",INPLACE_EDIT_SAVING="-saving",INPLACE_EDIT_REMOVED="-removed",aStateClzes=[_10+_11,_10+INPLACE_EDIT_FOCUS,_10+INPLACE_EDIT_EDITING,_10+INPLACE_EDIT_EDITED,_10+INPLACE_EDIT_SAVING,_10+INPLACE_EDIT_FOCUS,_10+INPLACE_EDIT_REMOVED];
return aStateClzes;
},stopEvt:function(_12){
_12=_12.nativeEvent;
if(_12.stopPropagation){
_12.stopPropagation();
}else{
_12.cancelBubble=true;
}
},input2Value:function(_13,_14){
_14.innerHTML=_13.value.replace(/\n/g,"<br>");
},value2Input:function(_15,_16){
_16.value=_15.innerHTML.replace(/<br>/ig,"\n");
},registerInlineEditItem:function(_17){
this.aItems[this.aItems.length]=_17;
},panelMoved:function(){
var t=this,E=vjo.dsf.document.Element,aItems=t.aItems,i=0,L=aItems.length;
while(i<L){
var _19=aItems[i],iState=_19.iState;
if(iState==3){
var _1a=E.get(_19.sInputElemId);
if(_1a){
_1a.style.left="0";
_1a.style.position="fixed";
_1a.style.position="relative";
}
}else{
if(iState>=0){
var _1b=E.get(_19.sValElemId);
if(_1b){
_1b.style.left="0";
_1b.style.position="fixed";
_1b.style.position="relative";
}
}
}
i++;
}
},initTimer:function(){
var t=this;
t.oTimer=new vjo.dsf.utils.Timer(250);
t.oTimer.onTick=function(){
var i=0,arr=t.aItems,len=arr.length;
while(i<len){
var it=arr[i++];
it.switchClz(it.iState);
}
};
t.oTimer.start();
}}).inits(function(){
vjo.darwin.core.inplaceedit.item.InplaceEditItemController=new vjo.darwin.core.inplaceedit.item.InplaceEditItemController();
});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.document.Form");
vjo.needs("vjo.dsf.utils.Object");
vjo.needs("vjo.dsf.utils.Handlers");
vjo.needs("vjo.dsf.utils.Html");
vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.darwin.core.inplaceedit.item.InplaceEditItemController");
vjo.type("vjo.darwin.core.inplaceedit.item.InplaceEditItem").protos({H:vjo.dsf.utils.Handlers,E:vjo.dsf.document.Element,F:vjo.dsf.document.Form,C:vjo.darwin.core.inplaceedit.item.InplaceEditItemController,constructs:function(_1){
var t=this,m=_1,C=t.C,sCmpId=m.cmpId;
t.sInlineEditItemCompId=sCmpId;
t.oItem=t.E.get(sCmpId);
t.bAlertWhenRemove=m.alertWhenRemove;
t.sRemoveAlertMessage=m.removeAlert;
t.isCancelNewlyAdd2Remove=m.isCancelNewlyAdd2Remove;
t.bClick2Edit=m.click2Edit;
t.sValElemId=m.itemValueId;
t.aValElemIds=[t.sValElemId];
t.sInputElemId=m.itemInputId;
t.aInputElemIds=[t.sInputElemId];
t.iInputElemMaxLength=m.itemInputMaxLength;
t.sSavSvcType=m.saveServiceType;
t.sSavSvc=m.saveService;
t.sRmvSvcType=m.removeServiceType;
t.sRmvSvc=m.removeService;
t.sErrSvc=m.errorService;
t.iErrNo=m.errorCode;
t.oSaveRequest=m.saveRequest;
t.oRemoveRequest=m.removeRequest;
t.sAutoSavSvcId=m.autoSaveServiceName;
t.sPostCancelNewlyAddedSvcId=m.postCancelNewlyAddedServiceName;
t.sJsRefId=C.getJsRefId(sCmpId);
t.sAjaxKeyId=C.getAjaxKeyId(sCmpId);
t.aTabIds=[C.getFrontId(sCmpId),C.getBodyId(sCmpId),C.getCmdId(sCmpId),C.getSaveId(sCmpId)];
t.aLinkIds=[C.getModifyLinkId(sCmpId),C.getRemoveLinkId(sCmpId),C.getSaveLinkId(sCmpId),C.getCancelLinkId(sCmpId)];
t.aStateClzes=C.getStateClzes(m.clzScopeName);
t.bPageLoaded=m.pageLoaded;
t.iState=0;
t.iLastState=-1;
t.bNeedsJsRegistry=m.needsJsRegistry;
if(t.bPageLoaded){
t.initMe();
}else{
C.registerLazyItem(t);
}
C.registerInlineEditItem(t);
},initMe:function(){
var t=this;
if(t.bNeedsJsRegistry){
t.registerJs();
}
t.registerSvc();
},registerSvc:function(){
var t=this;
if(t.sAutoSavSvcId){
t.H.attachSvc(t.sAutoSavSvcId,t.save,t);
}
t.H.attachSvcReqt("HISTORY_CHANGE",t.historyChange,t);
},historyChange:function(_5){
var t=this,E=t.E,state=_5.state[t.sJsRefId];
var _7=state[l],valElem=E.get(t.sValElemId),inputElem=E.get(t.sInputElemId);
if(valElem&&inputElem){
inputElem.value=_7;
t.C.input2Value(inputElem,valElem);
}
},registerJs:function(){
var t=this,O=vjo.dsf.utils.Object,ED=vjo.dsf.EventDispatcher,mouseOverEvtHandler=function(){
},mouseOutEvtHandler=function(){
},clickEvtHandler=function(){
},keyPressEvtHandler=function(){
},modifyEvtHandler=function(){
},removeEvtHandler=function(){
},saveEvtHandler=function(){
},cancelEvtHandler=function(){
};
mouseOverEvtHandler.prototype.handle=O.hitch(t,"focus");
mouseOutEvtHandler.prototype.handle=O.hitch(t,"reset");
clickEvtHandler.prototype.handle=O.hitch(t,"editing");
keyPressEvtHandler.prototype.handle=O.hitch(t,"edited");
modifyEvtHandler.prototype.handle=O.hitch(t,"editing");
removeEvtHandler.prototype.handle=O.hitch(t,"remove");
saveEvtHandler.prototype.handle=O.hitch(t,"save");
cancelEvtHandler.prototype.handle=O.hitch(t,"cancel");
if(ED&&ED.add){
var i=0,tL=t.aTabIds.length;
while(i<tL){
ED.add(t.aTabIds[i],"mouseout",new mouseOutEvtHandler());
i++;
}
if(t.bClick2Edit){
ED.add(t.sValElemId,"click",new clickEvtHandler());
}
ED.add(t.aLinkIds[0],"click",new modifyEvtHandler());
ED.add(t.aLinkIds[1],"click",new removeEvtHandler());
ED.add(t.aLinkIds[2],"click",new saveEvtHandler());
ED.add(t.aLinkIds[3],"click",new cancelEvtHandler());
}
},switchClz:function(_a){
if(this.iLastState==_a){
return;
}
var t=this,aStateClzes=t.aStateClzes;
clzName=(_a===0)?"":aStateClzes[0];
clzName+=" ";
clzName+=aStateClzes[_a];
if(t.oItem){
t.oItem.className=clzName;
}
t.iLastState=_a;
},reset:function(){
var t=this;
if(t.iState!=2&&t.iState!=3&&t.iState!=5&&t.iState!=6){
t.iState=0;
}
},focus:function(){
var t=this;
if(t.iState!=2&&t.iState!=3&&t.iState!=5&&t.iState!=6){
t.iState=1;
}
},editing:function(){
var t=this,inputElem=t.E.get(t.sInputElemId);
t.iState=3;
t.switchClz(t.iState);
if(inputElem){
try{
inputElem.focus();
}
finally{
}
}
},edited:function(_f){
this.iState=3;
},save:function(_10){
if(this.iState!=3){
return false;
}
var t=this,E=t.E,itemDiv=t.oIte,valElem=E.get(t.sValElemId),inputElem=E.get(t.sInputElemId)||document.getElementsByName(t.sInputElemId)[0];
if(valElem&&inputElem){
var _12=t.filterBeforeSave(inputElem.value);
if(_12!=inputElem.value){
var _13=t.H.newMsg(t.sErrSvc);
_13.clientContext={"inlineEditItemJsCompId":t.sIsCmpIditItemJsCompId,"error_code":t.iErrNo,"errors":"user input error"};
t.H.handle(_13);
}
inputElem.value=_12;
t.C.input2Value(inputElem,valElem);
}
t.iState=4;
if(_10){
t.C.stopEvt(_10);
}
if(t.sSavSvcType=="ajax"&&t.sSavSvc){
var msg=t.H.newMsg(t.sSavSvc);
msg.request=t.oSaveRequest;
var _15=E.get(t.sAjaxKeyId),historyManager=vjo.Registry.get("HistoryManager"),state=[];
msg.request.ajaxKey=_15?_15.value:null;
msg.request.newVals=[];
msg.request.newVals[0]=state[0]=inputElem?inputElem.value:null;
msg.request.inlineEditItemJsCompId=t.sJsRefId;
if(historyManager){
historyManager.pushHistory(t.sJsRefId,state,null);
}
msg.returnData=false;
return msg;
}else{
if(t.sSavSvcType=="form"&&t.sSavSvc){
t.F.submit(t.sSavSvc);
return false;
}else{
if((t.sSavSvcType=="link"||t.sSavSvcType=="link_qs")&&t.sSavSvc){
var _16=t.sSavSvc+"&"+inputElem.id+"="+inputElem.value;
if(t.sSavSvcType=="link_qs"){
_16+="&saveKey="+E.get(t.sAjaxKeyId).value;
}
}else{
if(t.sSavSvcType=="js_func"&&t.sSavSvcType){
var _17=t.sSavSvc+"('"+t.sJsRefId+"')";
eval(_17);
}
}
}
}
return false;
},filterBeforeSave:function(_18){
return _18.replace(/(<([^>]+)>)/ig,"");
},remove:function(_19){
var t=this,E=t.E,removeReplacement="";
removeReplacement+=" "+(E.get(t.sInputElemId)||document.getElementsByName(t.sInputElemId)[0]).value;
var _1b=t.sRemoveAlertMessage;
_1b=_1b.replace(/#holder/,removeReplacement);
t.iState=5;
if(_19){
t.C.stopEvt(_19);
}
if(t.bAlertWhenRemove){
var _1c=confirm(_1b)||false;
if(_1c===false){
t.iState=0;
return false;
}
}
if(t.sRmvSvcType=="ajax"&&t.sRmvSvc){
var msg=t.H.newMsg(t.sRmvSvc);
msg.request=t.oRemoveRequest;
var _1e=E.get(t.sAjaxKeyId);
msg.request.ajaxKey=_1e?_1e.value:null;
msg.request.inlineEditItemJsCompId=t.sJsRefId;
msg.returnData=false;
return msg;
}else{
if(t.sRmvSvcType=="form"&&t.sRmvSvc){
t.F.submit(t.sRmvSvc);
}else{
if((t.sRmvSvcType=="link"||t.sRmvSvcType=="link_qs")&&t.sRmvSvc){
var _1f=t.sRmvSvc;
if(t.sRmvSvcType=="link_qs"){
_1f+="&removeKey="+E.get(t.sAjaxKeyId).value;
}
window.location=_1f;
}else{
if(t.sRmvSvcType=="js_func"&&t.sRmvSvc){
var _20=t.sRmvSvc+"('"+t.sJsRefId+"')";
try{
eval(_20);
}
catch(e){
}
}
}
}
}
return false;
},removed:function(){
this.iState=6;
},cancel:function(_21){
var t=this;
t.iState=0;
if(t.isCancelNewlyAdd2Remove){
if(t.sPostCancelNewlyAddedSvcId){
var _23=t.H.newMsg(t.sSuccessService);
_23.clientContext={"inlineEditItemJsCompId":t.sJsRefId};
t.H.handle(_23);
}
t.removed();
}else{
var _24=t.oItem,valElem=t.E.get(t.sValElemId),inputElem=t.E.get(t.sInputElemId)||document.getElementsByName(t.sInputElemId)[0];
if(valElem&&inputElem){
t.C.value2Input(valElem,inputElem);
}
}
if(_21){
t.C.stopEvt(_21);
}
}});

vjo.needs("vjo.dsf.typeextensions.string.Comparison");
String.prototype.replaceToken=function(_1,_2,_3){
var rv=_1;
while(rv.has(_2)){
rv=rv.replace(_2,_3);
}
return rv;
};
String.prototype.replaceTokensEx=function(_5){
var rv=this,re,tkn,a=arguments,l=a.length;
for(var i=1;i<l+1;i++){
rv=this.replaceToken(rv,_5.replace("n",(i)),a[i]);
}
return rv;
};
String.prototype.replaceTokens=function(){
var rv=this,re,tkn,a=arguments,l=a.length;
for(var i=0;i<l;i++){
rv=this.replaceToken(rv,"<#"+(i+1)+"#>",a[i]);
}
return rv;
};

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.utils.Timer");
vjo.needs("vjo.dsf.typeextensions.string.TokenReplacement");
vjo.needs("vjo.dsf.typeextensions.string.Comparison");
vjo.type("vjo.darwin.core.inplaceedit.item.charcounter.InplaceEditCharCounter").props({register:function(_1){
var t=this;
if(!t.sCompIdArr){
t.sCompIdArr=[];
}
t.sCompIdArr[t.sCompIdArr.length]=_1.compId;
if(!t.sTargetIdArr){
t.sTargetIdArr=[];
t.bStatusArr=[];
}
t.sTargetIdArr[t.sTargetIdArr.length]=_1.targetId;
if(!t.iMaxArr){
t.iMaxArr=[];
}
t.iMaxArr[t.iMaxArr.length]=_1.max;
if(!t.sMultipleCharsLeftArr){
t.sMultipleCharsLeftArr=[];
}
t.sMultipleCharsLeftArr[t.sMultipleCharsLeftArr.length]=_1.multipleCharsLeft;
if(!t.sSingleCharLeftArr){
t.sSingleCharLeftArr=[];
}
t.sSingleCharLeftArr[t.sSingleCharLeftArr.length]=_1.singleCharLeft;
if(!t.sNoCharLeftArr){
t.sNoCharLeftArr=[];
}
t.sNoCharLeftArr[t.sNoCharLeftArr.length]=_1.noCharLeft;
t.iRef=0;
},activate:function(_3){
var t=this,E=vjo.dsf.document.Element;
var i=0,L=t.sTargetIdArr.length;
while(i<L){
if(t.sTargetIdArr[i]==_3){
break;
}
i++;
}
if(i>=L){
return false;
}
t.iRef++;
t.oCurrComp=E.get(t.sCompIdArr[i]);
t.oCurrTarget=E.get(t.sTargetIdArr[i]);
t.iCurrMax=t.iMaxArr[i];
t.sCurrMulti=t.sMultipleCharsLeftArr[i];
t.sCurrSingle=t.sSingleCharLeftArr[i];
t.sCurrZero=t.sNoCharLeftArr[i];
if(!t.oTimer){
t.oTimer=new vjo.dsf.utils.Timer(250);
}
t.oTimer.onTick=function(){
t.check();
};
if(!t.oTimer.isRunning){
t.oTimer.start();
}
},deactivate:function(_6){
var t=this;
t.iRef--;
if(t.iRef<=0&&t.oTimer&&t.oTimer.isRunning){
t.oTimer.stop();
}
},check:function(){
var t=this,msgDiv=t.oCurrComp,target=t.oCurrTarget,inputVal=target?target.value:"",len=inputVal.length,left=t.iCurrMax-len,msgStr="";
if(!msgDiv||!target){
return;
}
if(left===0){
msgDiv.innerHTML=t.sCurrZero;
}else{
if(left==1){
msgStr=t.sCurrSingle;
msgDiv.innerHTML=msgStr.replace("##1##",left);
}else{
if(left>1){
msgStr=t.sCurrMulti;
msgDiv.innerHTML=msgStr.replace("##1##",left);
}else{
target.value=inputVal.substring(0,t.iCurrMax);
msgDiv.innerHTML=t.sCurrZero;
}
}
}
}});

vjo.type("vjo.darwin.core.inplaceedit.item.cell.InplaceEditItemCellController").singleton().protos({constructs:function(){
var t=this;
t.aCells=[];
var _2=function(){
t.initCells();
};
window.setTimeout(_2,500);
},registerCell:function(_3){
var t=this;
t.aCells[t.aCells.length]=_3;
},initCells:function(){
var t=this,i=0,arr=t.aCells,len=arr.length;
while(i<len){
arr[i].initMe();
i++;
}
}}).inits(function(){
vjo.darwin.core.inplaceedit.item.cell.InplaceEditItemCellController=new vjo.darwin.core.inplaceedit.item.cell.InplaceEditItemCellController();
});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.utils.Handlers");
vjo.needs("vjo.darwin.core.inplaceedit.item.charcounter.InplaceEditCharCounter");
vjo.needs("vjo.darwin.core.inplaceedit.item.cell.InplaceEditItemCellController");
vjo.type("vjo.darwin.core.inplaceedit.item.cell.InplaceEditItemCell").protos({E:vjo.dsf.document.Element,H:vjo.dsf.utils.Handlers,CC:vjo.darwin.core.inplaceedit.item.charcounter.InplaceEditCharCounter,constructs:function(_1){
var t=this,m=_1;
t.sInputId=m.inputElemId;
t.sValueId=m.valueElemId;
vjo.darwin.core.inplaceedit.item.cell.InplaceEditItemCellController.registerCell(t);
},initMe:function(){
var t=this,oClz=vjo.darwin.core.inplaceedit.item.cell.InplaceEditItemCell,oInput=t.E.get(t.sInputId),oValue=t.E.get(t.sValueId),oPseudo=t.oPseudo,iPad=8,iAdj=iPad*2;
var w=oClz.iWidth;
if(!w||w<0){
if(!oPseudo){
oPseudo=t.oPseudo=document.createElement("textarea");
}
oPseudo.rows=oInput.rows;
oPseudo.cols=oInput.cols;
oValue.parentNode.appendChild(oPseudo);
w=parseInt(oPseudo.offsetWidth)-iAdj;
oClz.iWidth=w;
oPseudo.parentNode.removeChild(oPseudo);
}
if(w>=0){
oValue.style.width=w+"px";
}
oValue.innerHTML=oClz.input2Value(oInput);
var _5=function(){
t.CC.activate(t.sInputId);
},blurHdl=function(){
t.CC.deactivate(t.sInputId);
};
t.H.attachEvt(oInput,"focus",_5,window);
t.H.attachEvt(oInput,"blur",blurHdl,window);
}}).props({iWidth:-1,input2Value:function(_6){
return _6.value.replace(/\n/g,"<br>");
},value2Input:function(_7){
return _7.innerHTML.replace(/<br>/ig,"\n");
}});

vjo.needs("vjo.darwin.app.myebay.RequestManager");
vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.darwin.app.myebay.SavedSellersComponent").protos({constructs:function(){
},ToggleDescription:function(_1,_2,_3,_4,_5,_6,_7,_8){
with(this){
vjo.darwin.app.myebay.SavedSellersComponent.id=_6;
vjo.darwin.app.myebay.SavedSellersComponent.sortDivId=_7;
if(_8){
vjo.darwin.app.myebay.SavedSellersComponent.pErrorStr=_8;
}
if(_5!=""&&vjo.dsf.document.Element.get(_1).style.display){
this.makeNoteScriptRequest(_5,"vjo.Registry.get('SavedSellersComponent').renderResponse");
}
vjo.darwin.app.myebay.RequestManager.toggleImage(_2,_3,_4);
vjo.darwin.app.myebay.RequestManager.toggleShow(_1);
return false;
}
},SortFilmStrip:function(_9,_a){
vjo.darwin.app.myebay.SavedSellersComponent.id=_a;
this.makeNoteScriptRequest(vjo.dsf.document.Element.get(_9).value,"vjo.Registry.get('SavedSellersComponent').renderResponse");
},makeNoteScriptRequest:function(_b,_c){
if(_b){
var _d=document.createElement("script");
_d.type="text/javascript";
var _e=this.addRandomParam(_b)+"&cb="+_c+"&callback="+_c;
_d.src=_e;
document.getElementsByTagName("head")[0].appendChild(_d);
}
return false;
},addRandomParam:function(_f){
_f+=(_f.indexOf("?")>0?"&":"?")+"rand="+Math.random();
return _f;
},renderResponse:function(_10){
var _11;
var _12=vjo.darwin.app.myebay.SavedSellersComponent.id;
var div=vjo.dsf.document.Element.get(_12);
if(_10&&_10.length>0){
_11=_10[0].data.map;
if(_11){
if(div){
vjo.darwin.app.myebay.RequestManager.bindCss(_11.Style);
var _14=eval("json.ME21_body");
div.innerHTML=_14;
vjo.darwin.app.myebay.RequestManager.bindJs(_11.Script);
vjo.darwin.app.myebay.RequestManager.showDivOverlay(_12);
}
}else{
if(_10[0].errors[0]=="NO_RESULT"){
div.innerHTML=vjo.darwin.app.myebay.SavedSellersComponent.pErrorStr;
}
vjo.dsf.document.Element.get(vjo.darwin.app.myebay.SavedSellersComponent.sortDivId).style.display="none";
}
}
},showSearchOnLoad:function(){
var _15=vjo.dsf.document.Element.get("SSarrow323id1")?vjo.dsf.document.Element.get("SSarrow323id1"):vjo.dsf.document.Element.get("SSRarrow324id1");
if(_15){
_15.onclick();
}
return false;
},saveEmailFrequency:function(_16,url){
var url=url+"&EmailFrequency="+vjo.dsf.document.Element.get(_16).value;
vjo.darwin.app.myebay.RequestManager.makeAjaxGetRequest(url);
}}).inits(function(){
vjo.Registry.put("SavedSellersComponent",new vjo.darwin.app.myebay.SavedSellersComponent());
});

vjo.type("vjo.darwin.app.myebay.filmstrip.FilmStrip").protos({constructs:function(_1){
var b=_1;
this.items=b.items;
this.basePicId=b.basePicId;
this.baseAnchorNameId=b.baseAnchorNameId;
this.baseItemContainerId=b.baseItemContainerId;
this.baseEndTimeId=b.baseEndTimeId;
this.basePriceEndtimeId=b.basePriceEndtimeId;
this.basePriceId=b.basePriceId;
this.itemsPerPage=b.itemsPerPage;
this.selectedItemIndex=b.selectedItemIndex;
this.currentPage=0;
this.itemPtr=(b.itemPtr)?b.itemPtr:-1;
this.selectedItemClass=b.selectedItemClass;
this.nonSelectedItemClass=b.nonSelectedItemClass;
this.nextButtonAnchorId=b.nextButtonAnchorId;
this.prevButtonAnchorId=b.prevButtonAnchorId;
this.nextButtonImgId=b.nextButtonImgId;
this.prevButtonImgId=b.prevButtonImgId;
this.nextButtonDisabledImg=b.nextButtonDisabledImg;
this.prevButtonDisabledImg=b.prevButtonDisabledImg;
this.nextButtonEnabledImg=b.nextButtonEnabledImg;
this.prevButtonEnabledImg=b.prevButtonEnabledImg;
this.displayedItems=[];
this.isPrevDisabled=b.isPrevDisabled||false;
this.isNextDisabled=b.isNextDisabled||false;
this.timerId=null;
this.playInterval=b.playInterval;
this.playButtonEnabledImg=b.playButtonEnabledImg;
this.playButtonDisabledImg=b.playButtonDisabledImg;
this.playButtonImgId=b.playButtonImgId;
this.stopButtonEnabledImg=b.stopButtonEnabledImg;
this.stopButtonDisabledImg=b.stopButtonDisabledImg;
this.stopButtonImgId=b.stopButtonImgId;
this.resizeImages=b.resizeImages||false;
this.Init();
},Init:function(){
with(this){
var i=0;
if(itemPtr!=-1){
itemPtr=itemPtr-itemsPerPage;
}
for(i;i<itemsPerPage;i++){
itemPtr++;
displayedItems[i]=items[itemPtr];
}
EnableDisableButtons(itemPtr);
if(resizeImages){
var _4=[];
for(var i=0;i<itemsPerPage;i++){
var _5=document.getElementById(basePicId+i);
if(_5){
_4[_4.length]=[_5.id,"80","80"];
}
}
if(_4.length>0){
vjo.darwin.app.myebay.EbayViewItemPopup.resizeImages(_4);
}
}
}
},ShowItem:function(_6,_7){
var o=document.getElementById(this.baseItemContainerId+_6);
var _9=_7?"":"hidden";
o.style.visibility=_9;
},DisplayItem:function(_a,_b){
this.displayedItems[_b]=_a;
var _c=document.getElementById(this.basePicId+_b);
_c.src=_a.picUrl;
_c.alt=_a.title;
_c.title=_a.title;
if(this.resizeImages){
var _d=[[_c.id,"80","80"]];
vjo.darwin.app.myebay.EbayViewItemPopup.resizeImages(_d);
}
var a=document.getElementById(this.baseAnchorNameId+_b);
if(a){
a.href=_a.viewItemUrl;
}
var _f=document.getElementById("iconcell"+_b);
if(_f){
if(_a.saleTypeIconUrl){
var _10=new Image();
_10.src=_a.saleTypeIconUrl;
_f.innerHTML="";
_f.appendChild(_10);
_f.style.visibility="";
}else{
iTconCell.innerHTML="-";
_f.style.visibility="hidden";
}
}
var _11=document.getElementById(this.basePriceId+_b);
if(_11){
if(_a.price){
_11.innerHTML=_a.price;
}else{
_11.innerHTML="";
}
}
var _12=document.getElementById(this.baseEndTimeId+_b);
if(_12){
if(_a.endTime){
_12.innerHTML=_a.endTime;
}else{
_12.innerHTML="";
}
}
if(_12){
if(_a.endingSoon){
vjo.darwin.app.myebay.filmstrip.FilmStrip.setClass(_12.id,"il_itemTimeCellSoon");
}else{
vjo.darwin.app.myebay.filmstrip.FilmStrip.setClass(_12.id,"il_itemTimeCell");
}
}
this.ShowItem(_b,true);
},FillItems:function(ptr){
with(this){
var i=0;
for(i;i<itemsPerPage;i++){
ptr++;
if(ptr<items.length){
var o=items[ptr];
DisplayItem(o,i);
}else{
ShowItem(i,false);
}
}
itemPtr=ptr;
EnableDisableButtons(ptr);
}
},DeselectPrevious:function(){
with(this){
vjo.darwin.app.myebay.filmstrip.FilmStrip.setClass(baseItemContainerId+selectedItemIndex,nonSelectedItemClass);
}
},DisplaySelectedItem:function(_16,_17){
with(this){
DeselectPrevious();
vjo.darwin.app.myebay.filmstrip.FilmStrip.setClass(baseItemContainerId+_17,selectedItemClass);
selectedItemIndex=_17;
var img=document.getElementById(items[_17].selectedItemPicId);
if(img){
img.src=_16.picUrl;
img.alt=_16.title;
}
vjo.darwin.app.myebay.filmstrip.FilmStrip.replaceInnerHtml(items[_17].selectedItemTitleId,_16.title);
vjo.darwin.app.myebay.filmstrip.FilmStrip.replaceInnerHtml(items[_17].selectedItemWatchesId,_16.watches);
vjo.darwin.app.myebay.filmstrip.FilmStrip.replaceInnerHtml(items[_17].selectedItemBidsId,_16.bids);
vjo.darwin.app.myebay.filmstrip.FilmStrip.replaceInnerHtml(items[_17].selectedItemPriceId,_16.price);
vjo.darwin.app.myebay.filmstrip.FilmStrip.replaceInnerHtml(items[_17].selectedItemShippingId,_16.shipping);
vjo.darwin.app.myebay.filmstrip.FilmStrip.replaceInnerHtml(items[_17].selectedItemEndTimeId,_16.endTime);
}
},DisplayNextItems:function(){
with(this){
if(!isNextDisabled){
FillItems(itemPtr);
}
}
return false;
},DisplayPrevItems:function(){
with(this){
if(!isPrevDisabled){
var ptr=(itemPtr-2*itemsPerPage)>0?(itemPtr-2*itemsPerPage):-1;
FillItems(ptr);
}
}
return false;
},EnableDisableButtons:function(ptr){
with(this){
if(isAtEnd()){
DisableNextButton();
}else{
EnableNextButton();
}
if(ptr<itemsPerPage){
DisablePrevButton();
}else{
EnablePrevButton();
}
}
},LoadItems:function(_1b){
this.items=_1b;
this.currentPage=0;
this.itemPtr=-1;
this.DisplayNextItems();
},DisableNextButton:function(){
this.isNextDisabled=true;
},DisablePrevButton:function(){
this.isPrevDisabled=true;
},EnableNextButton:function(){
this.isNextDisabled=false;
},EnablePrevButton:function(){
this.isPrevDisabled=false;
},SelectItemOnMouseOver:function(_1c){
this.DisplaySelectedItem(this.displayedItems[_1c],_1c);
},Play:function(_1d){
with(this){
vjo.darwin.app.myebay.filmstrip.FilmStrip.swapImg(playButtonImgId,playButtonDisabledImg);
vjo.darwin.app.myebay.filmstrip.FilmStrip.swapImg(stopButtonImgId,stopButtonEnabledImg);
if(!isAtEnd()){
itemPtr=itemPtr-itemsPerPage+1;
DisplayNextItems();
}
timerId=setInterval("vjo.Registry.get('"+_1d+"').PlayHelper();",this.playInterval);
}
},PlayHelper:function(){
with(this){
if(isAtEnd()){
Stop();
}else{
itemPtr=itemPtr-itemsPerPage+1;
DisplayNextItems();
}
}
},MouseOverNextButton:function(){
with(this){
if(!isNextDisabled){
vjo.darwin.app.myebay.filmstrip.FilmStrip.swapImg(nextButtonImgId,nextButtonEnabledImg);
}
}
},MouseOverPrevButton:function(){
with(this){
if(!isPrevDisabled){
vjo.darwin.app.myebay.filmstrip.FilmStrip.swapImg(prevButtonImgId,prevButtonEnabledImg);
}
}
},MouseOutNextButton:function(){
vjo.darwin.app.myebay.filmstrip.FilmStrip.swapImg(this.nextButtonImgId,this.nextButtonDisabledImg);
},MouseOutPrevButton:function(){
vjo.darwin.app.myebay.filmstrip.FilmStrip.swapImg(this.prevButtonImgId,this.prevButtonDisabledImg);
},isAtEnd:function(){
with(this){
return (itemPtr>=items.length-1);
}
}}).props({replaceInnerHtml:function(id,_1f){
var o=document.getElementById(id);
if(o){
o.innerHTML=_1f;
}
},setClass:function(id,_22){
var o=document.getElementById(id);
if(o){
o.className=_22;
}
},swapImg:function(id,src){
var i=document.getElementById(id);
if(i){
i.src=src;
}
}});

vjo.type("vjo.darwin.app.myebay.BiddingLayer").props({ajaxRequestOnCloseUrl:null,emptyImageURL:"",showModuleEnabled:false,layerId:"",iframeId:"",iframeUrlWithToken:"",ajaxUrl:"",itemIdTokenString:"",containerTokenString:"",containerToken:"",pageToken:"",init:function(_1,_2,_3,_4,_5,_6,_7,_8,_9){
this.layerId=_1;
this.iframeId=_2;
this.iframeUrlWithToken=_3;
this.ajaxUrl=_4;
this.emptyImageUrl=_5;
this.itemIdTokenString=_6;
this.containerToken=_7;
this.pageToken=_8;
this.ssPageNameToken=_9;
},getIframeUrl:function(_a,_b){
var s=this.iframeUrlWithToken.replace(this.itemIdTokenString,_a);
s=s.replace(this.ssPageNameToken,_b);
s+="&rd="+Math.random();
return s;
},getAjaxUrl:function(_d,_e){
var s=this.ajaxUrl.replace(this.pageToken,_d);
s=s.replace(this.containerToken,_e);
return s;
},closeIframeLayer:function(_10,_11){
vjo.darwin.app.myebay.BiddingLayer.showModuleEnabled=false;
vjo.darwin.app.myebay.BiddingLayer.openCloseIframeLayer(false,_10,_11,vjo.darwin.app.myebay.BiddingLayer.emptyImageURL,null,null);
return false;
},openCloseBidLayer:function(_12,_13,_14,_15,_16){
var ifU=this.getIframeUrl(_13,_16);
var ajU=this.getAjaxUrl(_15,_14);
return this.openCloseIframeLayer(_12,this.layerId,this.iframeId,ifU,ajU,this.emptyImageUrl);
},openCloseIframeLayer:function(_19,_1a,_1b,_1c,_1d,_1e){
var f=document.getElementById(_1b);
if(f){
f.src=_1c;
if(_19){
vjo.darwin.app.myebay.BiddingLayer.showModuleEnabled=true;
}else{
vjo.darwin.app.myebay.DivOverlay.hide(_1a);
}
if(!_19&&vjo.darwin.app.myebay.BiddingLayer.ajaxRequestOnCloseUrl){
var req={};
req.url=vjo.darwin.app.myebay.BiddingLayer.ajaxRequestOnCloseUrl;
req.requestType="AJAX_GET";
oRequestManager.makeRequest([req]);
}else{
vjo.darwin.app.myebay.BiddingLayer.ajaxRequestOnCloseUrl=_1d;
vjo.darwin.app.myebay.BiddingLayer.emptyImageURL=_1e;
}
}
return false;
}});

vjo.type("vjo.darwin.core.dropdownselector.Submit").satisfies("vjo.dsf.common.IJsHandler").protos({constructs:function(_1){
this.id=_1;
},handle:function(_2){
vjo.Registry.get(this.id).submit();
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.document.Form");
vjo.needs("vjo.darwin.core.dropdownselector.Submit");
vjo.type("vjo.darwin.core.dropdownselector.DropdownSelector").protos({constructs:function(_1,_2){
this.sDropdownId=_1;
this.sFormId=_2;
},submit:function(){
var f=vjo.dsf.document.Form.get(this.sFormId),d=vjo.dsf.document.Element.get(this.sDropdownId),si,v="",o;
if(f&&d){
si=d.selectedIndex;
if(si!=-1){
o=d.options[si];
}
if(o){
v=o.value;
}
if(v!=""){
f.submit();
}
}
}});

vjo.type("vjo.darwin.app.myebay.MyEbayUserNotes").props({baseUrl:"",setBaseUrl:function(_1){
this.baseUrl=_1;
},clickSave:function(_2){
var _3=_2;
this.inlineEditItemJsComp=vjo.Registry.get(_3);
var _4=this.baseUrl+"&SubmitAction.SaveDynamicNote=x";
if(this.inlineEditItemJsComp!=undefined){
var _5=this.inlineEditItemJsComp.aInputElemIds[0];
var _6=this.inlineEditItemJsComp.sAjaxKeyId;
window.containerId=_6.replace(/AK$/,"");
_6=_6.replace(/AK$/,"");
var _7=_6.split("_");
window.iLineId="";
for(i=1;i<_7.length;i++){
window.iLineId=window.iLineId+_7[i];
if(!(i==_7.length-1)){
window.iLineId=window.iLineId+"_";
}
}
var _8=document.getElementById(_5).value;
_4=_4+"&LineID="+window.iLineId+"&Note="+escape(_8);
}
this.makeNoteScriptRequest(_4,"vjo.darwin.app.myebay.MyEbayUserNotes.processSaveResponse");
},clickRemove:function(_9){
var _a=_9;
this.inlineEditItemJsComp=vjo.Registry.get(_a);
var _b=this.baseUrl+"&SubmitAction.RemoveDynamicNote=x";
if(this.inlineEditItemJsComp!=undefined){
var _c=this.inlineEditItemJsComp.aInputElemIds[0];
var _d=this.inlineEditItemJsComp.sAjaxKeyId;
window.containerId=_d.replace(/AK$/,"");
_d=_d.replace(/AK$/,"");
var _e=_d.split("_");
window.iLineId="";
for(i=1;i<_e.length;i++){
window.iLineId=window.iLineId+_e[i];
if(!(i==_e.length-1)){
window.iLineId=window.iLineId+"_";
}
}
var _f=document.getElementById(_c).value;
_b=_b+"&LineID="+window.iLineId+"&Note="+_f;
}
this.makeNoteScriptRequest(_b,"vjo.darwin.app.myebay.MyEbayUserNotes.processRemoveResponse");
},makeNoteScriptRequest:function(url,_11){
if(url){
var _12=document.createElement("script");
_12.type="text/javascript";
var _13=vjo.darwin.app.myebay.MyEbayUserNotes.addRandomParam(url)+"&callback="+_11;
_12.src=_13;
document.getElementsByTagName("head")[0].appendChild(_12);
}
return false;
},addRandomParam:function(url){
url+=(url.indexOf("?")>0?"&":"?")+"rand="+Math.random();
return url;
},makeAjaxRequest:function(url,_16){
if(url){
var _17=getAjaxReq(_16);
var _18=vjo.darwin.app.myebay.MyEbayUserNotes.addRandomParam(url);
_17.open("GET",_18,true);
_17.send(null);
}
return false;
},processSaveResponse:function(_19){
var _1a;
if(_19){
_1a=_19;
if(_1a){
var _1b=_1a.success;
}
if(_1b){
this.inlineEditItemJsComp.reset();
}
}
},processRemoveResponse:function(_1c){
var _1d;
if(_1c){
_1d=_1c;
if(_1d){
var _1e=_1d.success;
}
if(_1e){
if(document.getElementById("addNotes_"+window.iLineId)){
document.getElementById("addNotes_"+window.iLineId).style.display="block";
}
if(document.getElementById(window.containerId.split(".")[1].split("_")[0]+window.iLineId+"note")){
document.getElementById(window.containerId.split(".")[1].split("_")[0]+window.iLineId+"note").value="";
}
document.getElementById(window.containerId.split(".")[1].split("_")[0]+window.iLineId).innerHTML="";
document.getElementById(window.containerId).style.display="none";
}
}
}});

vjo.needs("vjo.darwin.app.myebay.RequestManager");
vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.darwin.app.myebay.SavedSearchesComponent").protos({constructs:function(){
},ToggleDescription:function(_1,_2,_3,_4,_5,_6,_7,_8,_9){
with(this){
vjo.darwin.app.myebay.SavedSearchesComponent.id=_5;
this.dbDownDiv=_6;
vjo.darwin.app.myebay.SavedSearchesComponent.sortdivId=_8;
this.bResp;
if(_9){
vjo.darwin.app.myebay.SavedSearchesComponent.errorDiv=_9;
}
if(vjo.dsf.document.Element.get(_6)){
vjo.dsf.document.Element.get(_6).style.display="block";
}
if(_7!=""&&vjo.dsf.document.Element.get(_1).style.display){
this.makeNoteScriptRequest(_7+"&_sasop=1","vjo.Registry.get('SavedSearchesComponent').renderResponse");
}
vjo.darwin.app.myebay.RequestManager.toggleImage(_2,_3,_4);
vjo.darwin.app.myebay.RequestManager.toggleShow(_1);
return false;
}
},SortFilmStrip:function(_a,_b,_c){
vjo.darwin.app.myebay.SavedSearchesComponent.id=_c;
pParam="&_sasop=";
sUrl=_a+pParam+vjo.dsf.document.Element.get(_b).value;
this.makeNoteScriptRequest(sUrl,"vjo.Registry.get('SavedSearchesComponent').renderResponse");
},makeNoteScriptRequest:function(_d,_e){
if(_d){
var _f=document.createElement("script");
_f.type="text/javascript";
var _10=Math.round(Math.random()*100000);
var _11=this.addRandomParam(_d)+"&_sajscallback="+_e+"&_sajsuniqueid="+_10;
_f.src=_11;
document.getElementsByTagName("head")[0].appendChild(_f);
}
return false;
},addRandomParam:function(url){
url+=(url.indexOf("?")>0?"&":"?")+"rand="+Math.random();
return url;
},renderResponse:function(_13){
this.bResp=true;
this.json;
var _14=vjo.darwin.app.myebay.SavedSearchesComponent.id;
var div=vjo.dsf.document.Element.get(_14);
if(_13&&_13.length>0){
this.json=_13[0].data?_13[0].data.map:false;
if(this.json){
if(div){
vjo.darwin.app.myebay.RequestManager.bindCss(div,this.json.Style,true);
var _16=eval("this.json.ME18_body");
if(vjo.dsf.document.Element.get(this.dbDownDiv)){
vjo.dsf.document.Element.get(this.dbDownDiv).style.display="none";
}
div.innerHTML=_16;
vjo.darwin.app.myebay.RequestManager.bindJs(this.json.Script);
vjo.darwin.app.myebay.RequestManager.showDivOverlay(_14);
}
}else{
if(_13[0].errors[0]=="NO_RESULT"){
div.innerHTML=vjo.darwin.app.myebay.SavedSearchesComponent.errorDiv;
vjo.dsf.document.Element.get(vjo.darwin.app.myebay.SavedSearchesComponent.sortdivId).style.display="none";
vjo.darwin.app.myebay.RequestManager.bindJs(this.json.Script);
vjo.darwin.app.myebay.RequestManager.showDivOverlay(_14);
}
}
}
},addNote:function(url,_18){
var url=url+"&Note="+vjo.dsf.document.Element.get(_18).value;
vjo.darwin.app.myebay.RequestManager.makeAjaxGetRequest(url);
},addEmailSetting:function(url,_1a,_1b,_1c,_1d,_1e,_1f){
this.daysDivId=_1b;
this.editDivId=_1c;
this.changeDivId=_1d;
this.errorDiv=_1e;
this.headerId=_1f;
var _20=url+"&Emailme=1"+"&EmailDuration="+vjo.dsf.document.Element.get(_1a).value;
this.makeNoteScriptRequest(_20,"vjo.Registry.get('SavedSearchesComponent').processEmailResponse");
return false;
},processEmailResponse:function(_21){
var _22;
if(_21){
_22=_21;
if(_22){
var _23=_22.success;
}
if(_23){
if(_22.emailcontent){
vjo.dsf.document.Element.get(this.daysDivId).innerHTML=_22.emailcontent;
}
vjo.dsf.document.Element.get(this.editDivId).style.display="inline";
vjo.dsf.document.Element.get(this.changeDivId).style.display="none";
vjo.dsf.document.Element.get(this.headerId).style.display="inline";
}else{
if(this.errorDiv){
vjo.dsf.document.Element.get(this.errorDiv).style.display="block";
}
}
}
},cancelNotes:function(_24){
vjo.dsf.document.Element.get(_24).style.display="none";
},processSaveResponse:function(_25){
var _26;
if(_25){
_26=_25;
if(_26){
var _27=_26.success;
}
if(_27){
inlineEditItemJsComp.reset();
}
}
},editEmail:function(_28,_29,_2a){
vjo.dsf.document.Element.get(_28).style.display="none";
vjo.dsf.document.Element.get(_29).style.display="inline";
vjo.dsf.document.Element.get(_2a).style.display="none";
},cancelEmail:function(_2b,_2c,_2d){
vjo.dsf.document.Element.get(_2b).style.display="inline";
vjo.dsf.document.Element.get(_2c).style.display="none";
vjo.dsf.document.Element.get(_2d).style.display="inline";
},showSearchOnLoad:function(){
var _2e=null;
if(vjo.dsf.document.Element.get("SSarrow323id1")){
_2e=vjo.dsf.document.Element.get("SSarrow323id1");
}else{
if(vjo.dsf.document.Element.get("SSarrow325id1")){
_2e=vjo.dsf.document.Element.get("SSarrow325id1");
}
}
if(vjo.dsf.document.Element.get("SSRarrow324id1")){
_2e=vjo.dsf.document.Element.get("SSRarrow324id1");
}
if(vjo.dsf.document.Element.get("MyNeighborhoodsImg0")){
_2e=vjo.dsf.document.Element.get("MyNeighborhoodsImg0");
}
if(_2e){
_2e.onclick();
}
return false;
},unjoinNeighborhood:function(_2f,_30){
if(confirm(_30)){
vjo.darwin.app.myebay.RequestManager.makeAjaxGetRequest(_2f);
}
},showRtmOverlayCallback:function(_31,_32,msg,id){
var _35=msg.vjRTMObject.aContent;
for(var idx=0;(idx<_35.length);idx++){
if(_35[idx].id==id&&_35[idx].content){
this.showRtmOverlay(_31,_32,msg,id);
}
}
},showRtmOverlay:function(_37,_38,msg,id){
if(msg.status==1){
if(vjo.Registry.get(_38)){
vjo.Registry.get(_38).onOpenOverlayPanel();
var _3b=vjo.dsf.document.Element.get("rtm_html_"+id);
if(_3b){
_3b.style.display="block";
}
}
if(vjo.dsf.document.Element.get("tr_rtm_html_"+id)){
vjo.dsf.document.Element.get("tr_rtm_html_"+id).style.display="";
}
}
}}).inits(function(){
vjo.Registry.put("SavedSearchesComponent",new vjo.darwin.app.myebay.SavedSearchesComponent());
});

vjo.type("vjo.darwin.app.myebay.Customization").props({containerContentOrder:null,hiddenOrderId:null,aDisabledCheckbox:[],aCheckedCheckbox:[],selectTab:function(_1){
for(i in aTabsDefs){
var _2=document.getElementById(aTabsDefs[i][0]);
if(i==_1){
_2.className="CustomizationComponent-navSelected";
if(_1!="tabMyEbay"){
_2.style.borderTop="solid 1px #a5a5a5";
}
}else{
_2.className="CustomizationComponent-navNormal";
_2.style.borderTop="none";
}
var _3=document.getElementById(aTabsDefs[i][1]);
if(_3){
if(_1=="tabMyEbay"){
_3.className="CustomizationComponent-selected";
}else{
_3.className=(i==_1)?"CustomizationComponent-selected":"CustomizationComponent-hidden";
}
}
}
var _4=document.getElementById("custoLeftNav");
if(_1=="tabMyEbay"){
_4.style.borderTop="solid 1px #a5a5a5";
}else{
_4.style.borderTop="none";
}
return false;
},swapContent:function(_5,_6){
var _7=document.getElementById(_5);
var _8=document.getElementById(_6);
if(_7&&_8){
var _9=_7.innerHTML;
var _a=_8.innerHTML;
_8.innerHTML=_9;
_7.innerHTML=_a;
}
},swapStyle:function(_b,_c){
var _d=document.getElementById(_b);
var _e=document.getElementById(_c);
if(_d&&_e){
var _f=_d.className;
_d.className=_e.className;
_e.className=_f;
}
},init:function(_10){
vjo.darwin.app.myebay.Customization.containerContentOrder=document.getElementById(_10).value.split(",");
vjo.darwin.app.myebay.Customization.hiddenOrderId=_10;
},swapArrayValues:function(_11,_12,_13){
var _14=_11[_13];
_11[_13]=_11[_12];
_11[_12]=_14;
},swapRows:function(_15,_16,_17,_18,_19){
vjo.darwin.app.myebay.Customization.swapContent(_17+_15,_17+_16);
vjo.darwin.app.myebay.Customization.swapContent(_18+_15,_18+_16);
vjo.darwin.app.myebay.Customization.swapStyle(_19+_15,_19+_16);
vjo.darwin.app.myebay.Customization.swapArrayValues(vjo.darwin.app.myebay.Customization.containerContentOrder,_15-1,_16-1);
vjo.darwin.app.myebay.Customization.serializeOrder(vjo.darwin.app.myebay.Customization.hiddenOrderId);
},moveUp:function(_1a,_1b,_1c,_1d,idx){
with(this){
if(containerContentOrder==null){
vjo.darwin.app.myebay.Customization.init(_1a,_1b,_1c,_1d);
}
if(idx>1){
var _1f=idx-1;
swapRows(idx,_1f,_1b,_1c,_1d);
}
}
return false;
},moveDown:function(_20,_21,_22,_23,idx){
with(this){
if(containerContentOrder==null){
vjo.darwin.app.myebay.Customization.init(_20,_21);
}
if(idx<containerContentOrder.length){
var _25=idx+1;
swapRows(idx,_25,_21,_22,_23);
}
}
return false;
},serializeOrder:function(_26){
var o=document.getElementById(_26);
if(o){
o.value=vjo.darwin.app.myebay.Customization.containerContentOrder.join(",");
}
},checkBoxOnClick:function(_28,_29,_2a){
var cb=document.getElementById(_28);
if(cb&&cb.checked){
var tr=document.getElementById(_29);
if(tr){
tr.className=_2a;
}
}
},alertOrder:function(_2d){
alert(document.getElementById(_2d).value);
},closeCustomizationLayer:function(_2e){
var _2f=vjo.darwin.core.overlaypanel.VjOverlayPanelEvtHandlers.handleCloseEvent(_2e);
vjo.dsf.ServiceEngine.handleRequest(_2f);
},presetClick:function(_30,_31,_32,_33,_34){
var _35=document.getElementById(_30);
var _36=document.getElementById(_31);
_36.disabled=false;
var _37=_35.elements;
for(i=0;i<_37.length;i++){
if(_37[i].type=="checkbox"){
_37[i].disabled=true;
if(_37[i].parentNode){
_37[i].parentNode.className=_33;
}
}
}
var _38=_32;
var _39,oSel;
for(var n=0;n<_38.length;n++){
_39=document.getElementById(_38[n]);
if(_39){
var _3b=_39.getAttribute("name");
oSel=document.getElementById(_3b+"_1");
oSel.disabled=true;
oSel.selectedIndex=0;
}
}
this.basicDetail(_30,_31);
},ownClick:function(_3c,_3d,_3e,_3f,_40){
var _41=document.getElementById(_3c);
var _42=document.getElementById(_3d);
_42.disabled=true;
var _43=_41.elements;
var l;
for(l=0;l<_43.length;l++){
if(_43[l].type=="checkbox"){
var _45=_43[l].getAttribute("cchecked");
var _46=_43[l].getAttribute("cdisabled");
if(_46){
_43[l].disabled=true;
if(_43[l].parentNode.parentNode){
_43[l].parentNode.parentNode.className=_3f;
}
}else{
_43[l].disabled=false;
if(_43[l].parentNode.parentNode){
_43[l].parentNode.parentNode.className=_40;
}
}
}
}
var _47=_3e;
var _48,oSel;
for(k=0;k<_47.length;k++){
_48=document.getElementById(_47[k]);
if(_48){
var _49=_48.getAttribute("name");
oSel=document.getElementById(_49+"_1");
oSel.disabled=false;
}
}
},basicDetail:function(_4a,_4b){
var _4c=document.getElementById(_4a);
var _4d=document.getElementById(_4b);
var idx=_4d.selectedIndex;
var _4f=_4c.elements;
var _50,sIsall;
for(j=0;j<_4f.length;j++){
if(_4f[j].type=="checkbox"){
_50=_4f[j].getAttribute("isJTB");
sIsall=_4f[j].getAttribute("isall");
if((idx===0)&&(_50=="true")){
_4f[j].checked=true;
}else{
if((idx==1)&&(sIsall=="true")){
_4f[j].checked=true;
}else{
_4f[j].checked=false;
}
}
}
}
},eventKeyclick:function(_51,_52,_53,_54,_55){
var _56=_51.keyCode?_51.keyCode:_51.charCode;
if(_56==_54||_56==_55){
this.basicDetail(_52,_53);
}
},restoreClick:function(_57,_58,_59,_5a,_5b,_5c,_5d,_5e,_5f,_60,_61){
var _62=document.getElementById(_57);
var _63=document.getElementById(_58);
var _64=document.getElementById(_5c);
var _65=document.getElementById(_5d);
var _66=document.getElementById(_5f);
var _67=document.getElementById(_60);
var _68=document.getElementById(_61);
var _69=_62.elements;
var _6a,sIsall;
_64.checked=true;
_63.disabled=false;
_63.selectedIndex=0;
if(_65){
_66.style.display="none";
_67.style.display="none";
_68.style.display="none";
_65.value=_5e;
}
for(j=0;j<_69.length;j++){
if(_69[j].type=="checkbox"){
_6a=_69[j].getAttribute("isJTB");
_69[j].disabled=true;
if(_69[j].parentNode.parentNode){
_69[j].parentNode.parentNode.className=_5a;
}
if(_6a=="true"){
_69[j].checked=true;
}else{
_69[j].checked=false;
}
}
}
var _6b=_59;
var _6c,oSel;
for(var n=0;n<_6b.length;n++){
_6c=document.getElementById(_6b[n]);
if(_6c){
var _6e=_6c.getAttribute("name");
oSel=document.getElementById(_6e+"_1");
oSel.disabled=true;
oSel.selectedIndex=0;
}
}
},onKeyEnter:function(_6f,_70,_71,_72,_73,_74,_75){
var _76=document.getElementById(_6f);
_76.onkeypress=function(e){
var _78;
if(!e){
var e=window.event;
}
if(e.keyCode){
_78=e.keyCode;
}else{
if(e.which){
_78=e.which;
}
}
if(_78==13){
if(!vjo.darwin.app.myebay.Customization.customApplyClick(_6f,_70,_71,_72,_73,_74,_75)){
if(window.event){
window.event.keyCode=0;
return false;
}else{
e.returnValue=false;
e.cancel=true;
e.preventDefault();
return false;
}
}
}
};
},customApplyClick:function(_79,_7a,_7b,_7c,_7d,_7e,_7f){
var _80=document.getElementById(_79);
var _81=document.getElementById(_7a);
var _82=document.getElementById(_7b);
var _83=document.getElementById(_7c);
var _84=document.getElementById(_7d);
if(_80){
var _85=_80.value.has("+");
if(((_80.value)>=_7e)&&((_80.value)<=_7f)&&(_80.value!="")&&!(_85)){
_81.submit();
}else{
_82.style.display="";
_83.style.display="";
_84.style.display="";
_81.action="";
return false;
}
}else{
_81.submit();
}
}}).inits(function(){
aTabsDefs={"myebay":["tabMyEbay","ctMyeBayToday"],"buy":["tabBuy","ctBuy"],"sell":["tabSell","ctSell"]};
});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.document.Form");
vjo.type("vjo.darwin.app.myebay.MyeBayNotificationPrefService").satisfies("vjo.dsf.common.IJsHandler").protos({constructs:function(_1,_2,_3,_4,_5,_6,_7){
this.sObjType="MyeBayNotificationPrefService";
this.sSvcId=_1;
this.sRequest=_2;
this.sFormName=_3;
this.sFlagDiv=_4;
this.bIsUnload=_6;
this.aFormList=_5;
this.sAlertMsg=_7;
},handle:function(_8){
var _9=new vjo.dsf.Message(this.sSvcId);
if(this.bIsUnload){
var _a=false;
var _b=this.aFormList;
var _c=_b.length;
for(var y=0;y<_c;y++){
var _e=vjo.dsf.document.Element.get(_b[y]);
if(_e){
var _f=_e.elements,iLen=_f.length;
for(g=0;g<iLen;g++){
if(_f[g].id==_b[y]+"_"+this.sFlagDiv){
if(_f[g].value==="true"){
_a=true;
break;
}
}
}
}
}
if(_a){
var _10=confirm(this.sAlertMsg);
if(_10===true){
_9.request=this.sRequest+this.appendAllParams();
_9.returnData=false;
}else{
return;
}
}
}else{
_9.request=this.sRequest+this.appendParams(this.sFormName);
_9.returnData=false;
}
return _9;
},appendAllParams:function(){
var _11=this.aFormList;
var _12=_11.length;
var _13="";
var _14=false;
for(var k=0;k<_12;k++){
var _16=vjo.dsf.document.Element.get(_11[k]);
if(_16==null||_16==""){
continue;
}
var _17=_16.elements,iLen=_17.length;
for(h=0;h<iLen;h++){
if(_17[h].id==_11[k]+"_"+this.sFlagDiv){
if(_17[h].value==="true"){
_14=true;
break;
}
}
}
if(_14){
_13+=(this.appendParams(_11[k]));
_14=false;
}
}
return _13;
},appendParams:function(_18){
oForm=vjo.dsf.document.Element.get(_18);
if(!oForm){
return "";
}
var _19=oForm.elements,iLen=_19.length,sParam="";
for(var j=0;j<iLen;j++){
if(((_19[j].type=="radio")||(_19[j].type=="checkbox"))&&!_19[j].checked){
continue;
}
sParam+=("|#%"+_19[j].name+"^:!"+_19[j].value);
if(_19[j].id==_18+"_"+this.sFlagDiv){
_19[j].value=false;
}
}
return sParam;
}});

vjo.type("vjo.darwin.app.myebay.CaptureChange").protos({constructs:function(_1,_2){
this.sFormId=_1;
this.sChangeFlag=_2;
},captureChange:function(){
var _3=document.getElementById(this.sFormId+"_"+this.sChangeFlag);
_3.value="true";
}});

vjo.needs("vjo.dsf.ServiceEngine");
vjo.needs("vjo.darwin.app.myebay.RequestManager");
vjo.type("vjo.darwin.app.myebay.SellerLayer").props({compId:"SellerLayer",contentTarget:"SellerLayerolppanel",closeTimer:null,setCompId:function(_1,_2){
this.compId=_1;
this.contentTarget=_1+_2;
},renderScriptResponse:function(_3){
var id=this.contentTarget||"SellerLayerolppanel";
var _5;
if(_3){
_5=_3;
if(_5){
var _6=document.getElementById(id);
if(_6){
var _7=_5.data;
if(_7){
vjo.darwin.app.myebay.RequestManager.bindCss(_6,_7.cssMeta);
_6.innerHTML=_7.htmlString;
vjo.darwin.app.myebay.RequestManager.bindJs(_7.jsMeta,_7.eventIdMap);
var _8=_7.overlayName;
var _9=_7.sellerSpan;
var _a=vjo.darwin.core.overlaypanel.VjOverlayPanelEvtHandlers.handleOpenEvent(_8,_9);
_a.bResetPosition=true;
_a.oSetNotchLocationOverrider=vjo.darwin.app.myebay.RequestManager;
_a.fSetNotchLocation=vjo.darwin.app.myebay.RequestManager.setCustomPosition;
vjo.dsf.ServiceEngine.handleRequest(_a);
MyEbayNextGenSiteCatalystSetVarPagename("MyeBay_MS_MeetSellerX",oRequestManager.mouseOverSSPageName);
}
}
}
}
},closeSellerLayer:function(_b){
window.oRequestManager.timerId=null;
window.oRequestManager.mouseOverId=null;
vjo.darwin.app.myebay.SellerLayer.closeTimer=setTimeout("vjo.darwin.app.myebay.RequestManager.closeOverlayLayer(\""+_b+"\")",200);
}}).inits(function(){
});

vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.darwin.core.overlaypanel.VjOverlayPanelMessage");
vjo.type("vjo.darwin.core.overlaypanelgroup.VjOverlayPanelGroup").protos({constructs:function(_1,_2){
this.aPostOpenedServiceIds=_1;
this.aCloseServiceIds=_2;
},handleOverlayPanelOpened:function(_3){
var _4=_3.svcId,i;
if(_4){
for(i=0;i<this.aPostOpenedServiceIds.length;i++){
if(_4!=this.aPostOpenedServiceIds[i]){
var _5=new vjo.darwin.core.overlaypanel.VjOverlayPanelMessage(this.aCloseServiceIds[i]);
vjo.dsf.ServiceEngine.handleRequest(_5);
}
}
}
return false;
},handleCloseAll:function(_6){
for(i=0;i<this.aCloseServiceIds.length;i++){
var _7=new vjo.darwin.core.overlaypanel.VjOverlayPanelMessage(this.aCloseServiceIds[i]);
vjo.dsf.ServiceEngine.handleRequest(_7);
}
return false;
}});

vjo.needs("vjo.darwin.app.myebay.RequestManager");
vjo.needs("vjo.darwin.core.overlaypanel.VjOverlayPanel");
vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.Enc");
vjo.type("vjo.darwin.app.myebay2.component.sets.ValidateOverlay").props({openSetOverlay:function(_1,_2,_3,_4,_5,_6,_7,_8,_9){
this.pEdiv1=_7;
this.pEdiv2=_8;
this.pEClass=_9;
errDiv1=vjo.dsf.document.Element.get(this.pEdiv1);
errDiv1.className=this.pEClass;
errDiv2=vjo.dsf.document.Element.get(this.pEdiv2);
errDiv2.className=this.pEClass;
var _a=vjo.dsf.document.Element.get(_5);
_a.value=_6;
this.sActUrl=_4;
vjo.dsf.ServiceEngine.handleRequest(vjo.darwin.core.overlaypanel.VjOverlayPanelEvtHandlers.handleOpenEvent(_2,_3));
},buttonClick:function(_b,_c,_d,_e,_f,_10,_11,_12,_13,_14,_15,_16,_17,_18){
this.hideMsgDivs(_18);
this.pFormId=_e;
this.pSclass=_14;
this.pFclass=_15;
var _19="*:<>?";
var b=true;
var _1b=vjo.dsf.document.Element.get(_16);
if(_1b){
_1b.style.display="none";
}
var _1c=vjo.dsf.document.Element.get(_17);
if(_1c){
_1c.style.display="none";
}
var _1d=vjo.dsf.document.Element.get(_c);
var _1e=vjo.dsf.document.Element.get(_d);
var _1f=vjo.dsf.document.Element.get(_b);
var _20=vjo.dsf.document.Element.get(_e);
if(_12===""){
_12=this.sActUrl;
}
if(_1d.value.length!==0){
if(_1d.value===_10){
_1d.value="";
}
for(var i=0;i<_1d.value.length;i++){
if(_19.indexOf(_1d.value.charAt(i))!=-1){
_1e.style.display="";
b=false;
}
}
var _22=0;
var _23="";
var _24=_1d.value.split(",");
for(var _25=0;_25<_24.length;_25++){
if(_24[_25].length>_f){
_22+=1;
_23="&errorCount="+_22;
}
}
if(_1d.value.length>_f){
_1d.returnValue=false;
}else{
_1d.returnValue=true;
}
}
if(_20&&_20.elements&&_20.elements["tagId"]){
var _26=_20.elements["tagId"];
if(_26){
var _27="";
var _28=_26.length?_26.length:0;
for(var i=0;i<_28;i++){
if(_26[i].checked){
_27=_27+"&tagId="+_26[i].value;
}
}
if(!_28){
_27="&tagId="+_26.value;
}
}
}
if(vjo.dsf.document.Element.get("entityId")){
var _29=_20.elements["entityId"];
var _2a="";
var _2b=_29.length?_29.length:0;
for(var k=0;k<_2b;k++){
_2a=_2a+"&entityId="+_29[k].value;
}
if(!_2b){
_2a="&entityId="+_29.value;
}
}
if(vjo.dsf.document.Element.get("entityType")){
var _2d=_20.elements["entityType"];
var _2e="";
var _2f=_2d.length?_2d.length:0;
for(var l=0;l<_2f;l++){
_2e=_2e+"&entityType="+_2d[k].value;
}
if(!_2f){
_2e="&entityType="+_2d.value;
}
}
if(_27){
if(typeof _23!="undefined"){
var _31=_12+"&tagName="+vjo.dsf.Enc.encodeURI(_1d.value)+_27+_2a+_2e+_23;
}else{
var _31=_12+"&tagName="+vjo.dsf.Enc.encodeURI(_1d.value)+_27+_2a+_2e;
}
}else{
if(_2a&&_2e){
if(typeof _23!="undefined"){
var _31=_12+"&tagName="+vjo.dsf.Enc.encodeURI(_1d.value)+_2a+_2e+_23;
}else{
var _31=_12+"&tagName="+vjo.dsf.Enc.encodeURI(_1d.value)+_2a+_2e;
}
}else{
if(typeof _23!="undefined"){
var _31=_12+"&tagName="+vjo.dsf.Enc.encodeURI(_1d.value)+_23;
}else{
var _31=_12+"&tagName="+vjo.dsf.Enc.encodeURI(_1d.value);
}
}
}
this.makeScriptRequest(_31,"vjo.darwin.app.myebay2.component.sets.ValidateOverlay.processResponse");
this.closeId=_13;
return false;
},makeScriptRequest:function(url,_33){
if(url){
var _34=document.createElement("script");
_34.type="text/javascript";
var _35=url+"&cb="+_33;
_34.src=_35;
document.getElementsByTagName("head")[0].appendChild(_34);
}
return false;
},processResponse:function(_36){
var _37,errDiv1,errDiv2,sDiv;
if(_36){
_37=_36;
if(_37){
var _38=_37.success;
errDiv1=this.errDiv1=vjo.dsf.document.Element.get(_37.divId);
errDiv2=vjo.dsf.document.Element.get(_37.divIdGenericError);
}
if(_38){
this.closeOverlay();
if(_37.formSubmit){
if(_37.actUrl!==""){
formId=vjo.dsf.document.Element.get(_37.formId);
var _39=_37.actUrl+"&requestedSets="+_37.requestedSets+"&allowedSets="+_37.allowedSets+"&totalSetsCreated="+_37.totalSetsCreated;
if(this.pFormId==="createSetForm"){
var _3a=_39+"&createSuccess=0";
}else{
var _3a=_39+"&createSuccess=1";
}
formId.action=_3a;
formId.submit();
}
}else{
errDiv1.style.display="block";
errDiv1.innerHTML=_37.successMessage;
}
}else{
if(errDiv1&&_37.errorMessage){
errDiv1.innerHTML=_37.errorMessage;
errDiv1.className=this.pFclass;
}
if(errDiv2&&_37.genericErrorMessage){
errDiv2.innerHTML=_37.genericErrorMessage;
errDiv2.className=this.pFclass;
}
}
}
},closeOverlay:function(){
var _3b=vjo.darwin.core.overlaypanel.VjOverlayPanelEvtHandlers.handleCloseEvent(this.closeId);
vjo.dsf.ServiceEngine.handleRequest(_3b);
},textOnfocus:function(_3c,_3d){
var _3e=vjo.dsf.document.Element.get(_3c);
_3e.className="";
if(_3e.value===_3d){
_3e.value="";
}
},bulkCheck:function(_3f,_40,_41,_42){
var _43=_3f.target?_3f.target:_3f.srcElement;
var _44=_43.form;
var b=_43.checked?true:false;
for(i=0;i<_44.elements.length;i++){
if((elem=_44.elements[i])&&(elem.type=="checkbox")&&(elem.id==_40)){
elem.checked=b;
this.grayLayer(elem,_42);
}
}
vjo.dsf.document.Element.get(_41).checked=b;
},bulkAddtoset:function(_46,_47,_48,_49,_4a,_4b,_4c,_4d,_4e,_4f,_50,_51){
if(window.aMaskRow){
for(i=0;i<window.aMaskRow.length;i++){
(window.aMaskRow[i]).style.display="none";
}
}
this.hideMsgDivs(_51);
var _52=vjo.dsf.document.Element.get(_4f);
if(_52){
_52.style.display="none";
}
var _53=vjo.dsf.document.Element.get(_50);
var _54=_46.target?_46.target:_46.srcElement;
var _55="";
var _56;
var b=true;
var _58=vjo.dsf.document.Element.get(_47);
var _59=vjo.dsf.document.Element.get(_4a);
for(i=0;i<_54.form.elements.length;i++){
if((elem=_54.form.elements[i])&&(elem.type=="checkbox")&&(elem.id==_49)&&elem.checked){
b=false;
}
}
_58.action=_48;
this.showTitle(_4c,_4d);
vjo.darwin.app.myebay.RequestManager.makeAjaxPostRequest(_47);
_58.action=_4e;
if(b){
if(_59){
_59.style.display="block";
_59.className=_4b;
}
if(_53){
_53.style.display="none";
}
}else{
if(_59){
_59.style.display="none";
}
}
},placeTosetBtnClick:function(_5a,_5b,_5c,_5d,_5e,_5f,_60,_61,_62){
this.pFormId=_5b;
this.pSclass=_5f;
this.pFclass=_60;
var _63=vjo.dsf.document.Element.get(_5a);
_63.style.display="none";
var _64=vjo.dsf.document.Element.get(_61);
_64.style.display="none";
var _65=vjo.dsf.document.Element.get(_62);
_65.style.display="none";
var _66=vjo.dsf.document.Element.get(_5b);
if(_5d===""){
_5d=this.sActUrl;
}
if(vjo.dsf.document.Element.get("selectedPage")){
var _67=_66.elements["selectedPage"];
var _68="";
var _69=_67.length?_67.length:0;
for(var i=0;i<_69;i++){
if(_67[i].checked){
_68=_68+"&selectedPage="+_67[i].value;
}
}
if(!_69){
_68="&selectedPage="+_67.value;
}
if(vjo.dsf.document.Element.get("tagId")){
var _6b=_66.elements["tagId"];
var _6c="";
var _6d=_6b.length?_6b.length:0;
for(var k=0;k<_6d;k++){
_6c=_6c+"&tagId="+_6b[k].value;
}
if(!_6d){
_6c="&tagId="+_6b.value;
}
}
}
var _6f=_5d+_68+_6c;
this.makeScriptRequest(_6f,"vjo.darwin.app.myebay2.component.sets.ValidateOverlay.processResponse");
this.closeId=_5e;
return false;
},showTitle:function(_70,_71){
var _72=vjo.dsf.document.Element.get(_70);
_72.innerHTML=_71;
},addtosetOvl:function(_73,_74,_75){
var _76=vjo.dsf.document.Element.get(_73);
_76.innerHTML=_74;
vjo.darwin.app.myebay.RequestManager.makeAjaxGetRequest(_75);
},grayOutItem:function(_77,_78,_79){
var _7a=_77.target?_77.target:_77.srcElement;
this.grayLayer(_7a,_79);
},grayLayer:function(_7b,_7c){
var _7d=_7b.parentNode;
var _7e=document.getElementById(_7d.id+"_mask");
if(!_7e){
var _7f=this.maskRow((_7d.parentNode.offsetHeight+8),(_7d.parentNode.offsetWidth+624),285,1,-16,-20,-18,_7c);
_7f.id=_7d.id+"_mask";
_7d.parentNode.nextSibling.appendChild(_7f);
}
_7e=document.getElementById(_7d.id+"_mask");
_7e.style.display=_7b.checked?"":"none";
},maskRow:function(_80,_81,_82,_83,_84,_85,_86,_87){
var t=document.createElement("DIV");
t.style.height=_80+"px";
t.style.width=_81+"px";
t.style.filter="Alpha(Opacity=10)";
t.style.zIndex=_83;
if(vjo.dsf.client.Browser.bIE){
t.style.marginTop=_84+"px";
}
if(vjo.dsf.client.Browser.bFirefox){
t.style.marginTop=_85+"px";
}
if(vjo.dsf.client.Browser.bSafari){
t.style.marginTop=_86+"px";
}
t.className=_87;
return t;
},hideMsgDivs:function(_89){
var _8a=" ";
_8a=_89;
var _8b;
if(_8a){
for(k=0;k<_8a.length;k++){
_8b=vjo.dsf.document.Element.get(_8a[k]);
if(_8b){
_8b.style.display="none";
}
}
}
},redirectUrl:function(_8c,pId){
oObj=document.getElementById(pId);
if(oObj.tagName=="A"){
oObj.href=_8c;
}
if(oObj.tagName=="BUTTON"||oObj.tagName=="SPAN"){
parent.location=_8c;
}
}});

vjo.type("vjo.darwin.app.myebay.ImageItemDisplayComponent").protos({constructs:function(){
this.name="hello";
},renderItemPopup:function(){
this.m_winObj=window.open("http://www.ebay.com","popup","height=200, width=200, top=10, left=10");
vjo.darwin.app.myebay.EbayViewItemPopup.resizeImages([["ItemPhoto","80","80"],["largerImageLayer","300","300"],["imgLayer1","50","50"],["imgLayer2","50","50"],["imgLayer3","50","50"],["imgLayer4","50","50"]]);
},renderClose:function(){
if(this.m_winObj){
this.m_winObj.close();
}
}});

vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.darwin.app.myebay.ImageItemDisplay").props({gotoVI:function(_1,_2){
var _3=vjo.dsf.document.Element.get(_2+_1);
if(_3){
if(_3.href){
location.href=_3.href;
}else{
if(_3.length>0){
location.href=_3[0].href;
}
}
}
return false;
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.EventDispatcher");
vjo.needs("vjo.dsf.utils.Timer");
vjo.needs("vjo.dsf.client.Browser");
vjo.type("vjo.darwin.core.datatable.DataTable").protos({constructs:function(_1,_2,_3){
var t=this;
t.tbl=vjo.dsf.document.Element.get(_1);
t.scrollFooter=_2;
t.height=_3;
t.container=[];
t.onResizeHandler=null;
t.sIsActivated=false;
if(t.tbl){
var bs=t.tbl.tBodies[0].setAttribute("style","height:"+_3+"px !important; overflow:auto;overflow-x:hidden");
}
t.makeScrollableTable();
},getActualWidth:function(e){
if(!e.currentStyle){
e.currentStyle=e.style;
}
pr=parseInt(e.currentStyle.paddingLeft,10);
pl=parseInt(e.currentStyle.paddingRight,10);
pr=(isNaN(pr))?5:pr;
pl=(isNaN(pl))?5:pl;
return e.clientWidth-pr-pl;
},findRowWidth:function(r){
for(var i=0;i<r.length;i++){
var w=this.getActualWidth(r[i]);
w=(i===r.length-1)?w-16:w;
r[i].actualWidth=w;
}
},setRowWidth:function(r){
for(var i=0;i<r.length;i++){
r[i].style.width=r[i].actualWidth+"px";
r[i].innerHTML="<div style=\"width:"+r[i].actualWidth+"px;\">"+r[i].innerHTML+"</div>";
}
},fixTableWidth:function(_c){
var t=this;
for(var i=0;i<_c.tHead.rows.length;i++){
t.findRowWidth(_c.tHead.rows[i].cells);
}
t.findRowWidth(_c.tBodies[0].rows[0].cells);
if(_c.tFoot){
for(var j=0;j<_c.tFoot.rows.length;j++){
t.findRowWidth(_c.tFoot.rows[j].cells);
}
}
for(var k=0;k<_c.tHead.rows.length;k++){
t.setRowWidth(_c.tHead.rows[k].cells);
}
t.setRowWidth(_c.tBodies[0].rows[0].cells);
if(_c.tFoot){
for(var l=0;l<_c.tFoot.rows.length;l++){
t.setRowWidth(_c.tFoot.rows[l].cells);
}
}
},makeScrollableTable:function(){
var c,pNode,hdr,ftr,wrapper,rect,t=this,tbl=t.tbl,E=vjo.dsf.document.Element;
if(!tbl||vjo.dsf.client.Browser.bFirefox){
return;
}
pNode=tbl.parentNode;
t.fixTableWidth(tbl);
c=t.container.length;
t.container[c]=E.createElement("div");
cs=t.container[c].style;
cs.height="50";
cs.overflow="scroll";
cs.display="block";
cs.overflowX="hidden";
t.container[c].id=tbl.id+"Container";
pNode.insertBefore(t.container[c],tbl);
t.container[c].appendChild(tbl);
w=tbl.clientWidth+2*tbl.clientLeft;
t.container[c].style.width=w+"px";
t.container[c].style.backgroundColor="transparent";
hdr=tbl.cloneNode(false);
hdr.id+="Header";
if(tbl.tHead){
hdr.appendChild(tbl.tHead.cloneNode(true));
hdr.style.width=w+"px";
tbl.tHead.style.display="none";
}
if(tbl.tFoot){
ftr=tbl.cloneNode(false);
ftr.id+="Footer";
ftr.appendChild(tbl.tFoot.cloneNode(true));
ftr.style.borderTop="none";
tbl.tFoot.style.display="none";
ftr.style.width=w+"px";
}
wrapper=E.createElement("table");
wrapper.border="0";
wrapper.cellSpacing="0";
wrapper.cellPadding="0";
wrapper.id=tbl.id+"Wrapper";
wrapper.width=w+"px";
pNode.insertBefore(wrapper,t.container[c]);
if(tbl.tHead){
wrapper.insertRow(0).insertCell(0).appendChild(hdr);
}
wrapper.insertRow(1).insertCell(0).appendChild(t.container[c]);
if(tbl.tFoot){
wrapper.insertRow(2).insertCell(0).appendChild(ftr);
}
t.container[c].style.height=t.height+"px";
tbl.style.width=w+"px";
}}).props({hghLightSortColumn:function(_13,_14,_15,_16,_17,_18,_19,_1a,_1b){
var _1c=_13+"_srtHCol_"+_1a;
var hg=vjo.dsf.document.Element.get(_1c);
var _1e;
if(_15=="mouseOver"){
if(_16){
if(_17=="down"){
hg.className=_14+" "+_18[2];
}else{
if(_17=="up"){
hg.className=_14+" "+_18[4];
}else{
hg.className=_14+" "+_18[0];
}
}
}else{
hg.className=_14+" "+" "+_18[0];
}
}else{
if(_15=="mouseOut"){
if(_16){
if(_17=="up"){
hg.className=_14+" "+_18[3];
}else{
if(_17=="down"){
hg.className=_14+" "+_18[1];
}
}
}else{
hg.className=_14;
}
}
}
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.darwin.core.datatable.DataTable");
vjo.type("vjo.darwin.core.datatable.DataTableJsEventBinder").props({bindEventsInJS:function(_1,_2,_3,_4,_5,_6,_7,_8){
var _9=_1+"_srtHCol_"+_7;
var _a=vjo.dsf.document.Element.get(_9);
vjo.dsf.EventDispatcher.addEventListener(_a,"mouseover",function(_b){
return vjo.darwin.core.datatable.DataTable.hghLightSortColumn(_1,_2,"mouseOver",_3,_4,_5,_6,_7,_8);
});
vjo.dsf.EventDispatcher.addEventListener(_a,"mouseout",function(_c){
return vjo.darwin.core.datatable.DataTable.hghLightSortColumn(_1,_2,"mouseOut",_3,_4,_5,_6,_7,_8);
});
}});

vjo.type("vjo.darwin.app.myebay.ItemDisplayColumnHeader").props({navigateTo:function(_1){
window.location.href=_1;
}}).inits(function(){
});

vjo.type("vjo.darwin.core.menu.accordian.Util").protos({getDescendentById:function(_1,_2){
try{
var _3=_1.getElementsByTagName("*");
var _4;
for(var i=0;i<_3.length;i++){
if(_3[i].id==_2){
_4=_3[i];
break;
}
}
return _4;
}
catch(err){
return _1;
}
},getAncestorByNodeName:function(_6,_7){
if(_6&&_6.id!=this.id){
var _8=_6.parentNode;
if(_8.nodeName==_7){
return _8;
}else{
return (this.getAncestorByNodeName(_8,_7));
}
}
},getAncestorByClassName:function(_9,_a){
if(_9&&_9.id!=this.id){
var _b=_9.parentNode;
if(_b.className==_a){
return _b;
}else{
return (this.getAncestorByClassName(_b,_a));
}
}
},getDescendentByClassName:function(_c,_d){
if(_c){
var _e=_c.getElementsByTagName("*");
var _f;
for(var i=0;i<_e.length;i++){
if(_e[i].className==_d){
_f=_e[i];
break;
}
}
return _f;
}
}});

vjo.needs("vjo.darwin.core.menu.accordian.Util");
vjo.needs("vjo.dsf.EventDispatcher");
vjo.type("vjo.darwin.core.menu.accordian.AccordianMenuSection").protos({constructs:function(_1){
this.ED=vjo.dsf.EventDispatcher;
this.util=new vjo.darwin.core.menu.accordian.Util();
this.id=_1.id;
this.sectionDiv=_1;
this.divs=this.sectionDiv.getElementsByTagName("DIV");
this.menu=null;
this.css=new Object();
this.css.menu="accrdn-ms";
this.css.head="accrdn-msh";
this.css.headHigh="accrdn-msh-hi";
this.css.headPointer="accrdn-msh-ptr";
this.css.headBG="accrdn-msh-bg";
this.css.headBGHigh="accrdn-msh-bg-hi";
this.css.toggle="accrdn-ms-tgl";
this.css.toggleClosed="accrdn-ms-tgl-c";
this.css.toggleOpen="accrdn-ms-tgl-o";
this.css.toggleEmpty="accrdn-ms-tgl-e";
this.css.title="accrdn-ms-ttl";
this.css.item="accrdn-itm";
this.css.itemHigh="accrdn-itm-hi";
this.css.itemBold="accrdn-itm-bld";
this.css.itemLink="accrdn-itm-lnk";
this.css.itemLinkHi="accrdn-itm-lnk-hi";
this.css.itemNoBorder="accrdn-itm-nobdr";
this.css.list="accrdn-list";
this.css.info="accrdn-info";
this.css.headCurrent="accrdn-msh-cur";
this.css.headBGCurrent="accrdn-msh-bg-cur";
this.css.menuCurrent="accrdn-m-cur";
this.css.bodyVisible="accrdn-msb-v";
this.body;
this.toggle;
for(var i=0;i<this.divs.length;i++){
var _3=this.divs[i];
if(_3.id.indexOf("_body")!=-1){
this.body=_3;
}
if(_3.id.indexOf("_tgl")!=-1){
this.toggle=_3;
}
}
this.list=this.sectionDiv.getElementsByTagName("UL")[0];
this.items;
if(this.list){
this.items=this.list.getElementsByTagName("LI");
}
this.head=this.divs[0];
this.headDiv1=this.divs[1];
this.headDiv2=this.divs[2];
this.titleLink=this.util.getDescendentByClassName(this.head,this.css.title);
if(!this.isOpenDisabled()){
this.ED.addEventListener(this.sectionDiv,"mouseover",this.sectionMouseOver,this);
this.ED.addEventListener(this.sectionDiv,"mouseout",this.sectionMouseOut,this);
}
this.ED.addEventListener(this.sectionDiv,"click",this.sectionClick,this);
},sectionMouseOver:function(ev){
this.highItem(ev);
if(!this.isCurrentSection()){
this.highHeader(ev);
}
},sectionMouseOut:function(ev){
this.unhighItem(ev);
if(!this.isCurrentSection()){
this.unhighHeader(ev);
}
},sectionClick:function(ev){
if(!this.isOpenDisabled()){
if(this.isOpenControl(ev)){
if(this.isOpen()===false){
var _7=this.slideOpenSection();
_7();
}else{
if(this.id!=this.menu.currentSectionID){
var _8=this.closeSection();
_8();
}
}
}
}
return this.executeAction(ev);
},isOpenControl:function(ev){
var _a=this.ED.target(ev);
if(_a==this.headDiv1||_a==this.headDiv2||_a==this.toggle){
return true;
}else{
if(_a.className==this.css.title&&_a.nodeName=="SPAN"){
return true;
}else{
return false;
}
}
},slideOpenSection:function(){
var _b=this;
return function(){
if(_b.list){
_b.body.className=_b.css.bodyVisible;
_b.body.style.height="0px";
if(!_b.menu.intervals[_b.body.id]){
var _c=setInterval(_b.openInterval(),_b.menu.openTime);
_b.menu.intervals[_b.body.id]=_c;
}
}
};
},openSection:function(){
if(!this.isOpenDisabled()){
if(this.list){
this.body.className=this.css.bodyVisible;
this.body.style.height=this.list.offsetHeight+"px";
}
this.toggleIcon("open");
this.menu.setOpenSectionIds();
}
},isOpenDisabled:function(){
if(this.items&&this.items.length>0){
return false;
}else{
return true;
}
},openInterval:function(){
var _d=this;
return function(){
if(_d.body.offsetHeight<_d.list.offsetHeight){
var _e=_d.body.offsetHeight+_d.menu.openPixels;
if(_e>_d.list.offsetHeight){
_d.body.style.height=_d.list.offsetHeight+"px";
}else{
_d.body.style.height=_e+"px";
}
}
if(_d.body.offsetHeight===_d.list.offsetHeight){
_d.toggleIcon("open");
_d.menu.setOpenSectionIds();
_d.clearIntervalAndTimeout();
}
};
},toggleIcon:function(_f){
if(this.toggle&&_f=="open"){
this.toggle.className=this.css.toggle+" "+this.css.toggleOpen;
}else{
if(this.toggle){
this.toggle.className=this.css.toggle+" "+this.css.toggleClosed;
}
}
},highHeader:function(ev){
var _11=this.ED.target(ev);
var _12=this.util.getAncestorByClassName(_11,this.css.head);
if(_12){
this.head.className=this.css.head+" "+this.css.headHigh;
this.headDiv1.className=this.css.headBGHigh;
this.head.className+=" "+this.css.headPointer;
}
},unhighHeader:function(ev){
this.setSectionNormalStyle(this);
},highItem:function(ev){
var _15=this.ED.target(ev);
if(_15.nodeName!="UL"&&_15.nodeName!="LI"){
var _16=this.util.getAncestorByNodeName(_15,"LI");
if(_16){
var _17=_16.getElementsByTagName("DIV")[0];
if(_17){
_17.className+=" "+this.css.itemHigh;
if(_16){
var _18=(this.items[0].id==_16.id)?true:false;
if(!this.isCurrentSection()&&_18){
_17.className+=" "+this.css.itemNoBorder;
}
}
var _19=_17.getElementsByTagName("A")[0];
if(_19){
_19.className+=" "+this.css.itemLinkHi;
}
if(_16&&_16.id==this.menu.currentItemID){
_17.className+=" "+this.css.itemBold;
}
}
}
}
},unhighItem:function(ev){
var _1b=this.ED.target(ev);
var _1c=this.util.getAncestorByNodeName(_1b,"LI");
if(_1c){
this.setItemNormalStyle(_1c);
var _1d=_1c.getElementsByTagName("A")[0];
if(_1d){
_1d.className=this.css.itemLink;
}
if(_1c.id==this.menu.currentItemID){
itemDiv=_1c.getElementsByTagName("DIV")[0];
if(itemDiv){
itemDiv.className+=" "+this.css.itemBold;
}
}
}
},executeAction:function(ev){
var _1f=this.ED.target(ev);
var _20=this.util.getAncestorByNodeName(_1f,"LI");
if(!this.util.getAncestorByClassName(_1f,this.css.info)){
if(_20||(_1f.className==this.css.title&&_1f.nodeName=="A")){
this.setAsCurrent(_1f,_20);
this.applyCurrentStyleOnClick(_20);
}
}
if(this.menu.handler){
if(_20){
return this.menu.handler.onItemClick(_20.id,this.menu);
}else{
if(_1f.className==this.css.title){
return this.menu.handler.onItemClick(this.id,this.menu);
}
}
}else{
if(_1f.nodeName==="A"){
return true;
}else{
if(_20){
var _21=_20.getElementsByTagName("A")[0];
document.location.href=_21.href;
}
}
}
},setAsCurrent:function(_22,_23){
this.menu.currentSectionID=this.id;
if(this.isOpen()===false&!this.isOpenDisabled()){
this.openSection();
}
if(_23){
this.menu.currentItemID=_23.id;
}else{
if(_22.className==this.css.title){
this.menu.currentItemID=null;
}
}
},applyCurrentStyleOnClick:function(_24){
this.applyCurrentStyle(_24);
if(_24){
var _25=_24.getElementsByTagName("DIV")[0];
if(_25){
_25.className+=" "+this.css.itemHigh;
}
}
},applyCurrentStyle:function(_26){
this.head.className=this.css.head+" "+this.css.headCurrent;
this.headDiv1.className=this.css.headBG+" "+this.css.headBGCurrent;
this.sectionDiv.className=this.css.menu+" "+this.css.menuCurrent;
if(this.items){
for(var i=0;i<this.items.length;i++){
var itm=this.items[i];
this.setItemNormalStyle(itm);
}
}
if(_26){
var _29=_26.getElementsByTagName("DIV")[0];
_29.className+=" "+this.css.itemBold;
}
for(var j=0;j<this.menu.sections.length;j++){
var _2b=this.menu.sections[j];
if(this.id!=_2b.id){
this.setSectionNormalStyle(_2b);
}
}
},setSectionNormalStyle:function(_2c){
_2c.sectionDiv.className=this.css.menu;
_2c.head.className=this.css.head;
_2c.headDiv1.className=this.css.headBG;
if(_2c.items){
for(var i=0;i<_2c.items.length;i++){
var _2e=_2c.items[i];
var _2f=_2c.items[i].getElementsByTagName("A")[0];
if(_2f){
_2f.className=this.css.itemLink;
}
this.setItemNormalStyle(_2e);
}
if(_2c.items[0]){
_2c.items[0].className+=" "+this.css.itemNoBorder;
}
}
},setItemNormalStyle:function(_30){
if(_30){
_30.className=this.css.item;
var _31=_30.getElementsByTagName("DIV")[0];
if(_31){
_31.className=this.css.item;
}
}
},isCurrentSection:function(){
return this.menu.currentSectionID==this.id?true:false;
},close:function(){
if(this.isOkayToClose()){
var _32=setTimeout(this.closeSection(),this.menu.closeDelay);
this.menu.timeouts[this.body.id]=_32;
}
},isOkayToClose:function(){
if(this.isOpen()&&this.menu.currentSectionID!=this.id&&!this.menu.intervals[this.body.id]&&!this.menu.timeouts[this.body.id]){
return true;
}else{
return false;
}
},closeSection:function(){
var _33=this;
return function(){
var _34=setInterval(_33.closeInterval(),_33.menu.closeTime);
_33.menu.intervals[_33.body.id]=_34;
};
},closeInterval:function(){
var _35=this;
return function(){
if(_35.body.offsetHeight>0){
var h=_35.body.offsetHeight-_35.menu.closePixels;
_35.body.style.height=h>=0?(h+"px"):(0+"px");
}
if(_35.body.offsetHeight<=0){
_35.toggleIcon("close");
_35.menu.setOpenSectionIds();
_35.clearIntervalAndTimeout();
}
};
},clearIntervalAndTimeout:function(){
clearInterval(this.menu.intervals[this.body.id]);
this.menu.intervals[this.body.id]=null;
clearTimeout(this.menu.timeouts[this.body.id]);
this.menu.timeouts[this.body.id]=null;
},isOpen:function(){
if(this.list&&this.body){
if(this.list.offsetHeight==this.body.offsetHeight){
return true;
}else{
return false;
}
}else{
return false;
}
}});

vjo.needs("vjo.dsf.client.Browser");
vjo.needs("vjo.darwin.core.menu.accordian.AccordianMenuSection");
vjo.needs("vjo.darwin.core.menu.accordian.Util");
vjo.needs("vjo.dsf.EventDispatcher");
vjo.type("vjo.darwin.core.menu.accordian.AccordianMenu").protos({constructs:function(id,_2){
this.id=id;
this.menuDiv=document.getElementById(this.id);
this.sections=[];
this.openTime=1;
this.openPixels=15;
this.closeTime=this.openTime;
this.closePixels=this.openPixels;
this.openDelay=300;
this.closeDelay=this.openDelay;
this.currentSectionID=null;
this.currentItemID=null;
this.mouseover="mouseover";
this.click="click";
this.openEvent=this.click;
this.util=new vjo.darwin.core.menu.accordian.Util();
this.handler=_2;
this.openSectionIds=[];
this.intervals={};
this.timeouts={};
var _3=this.menuDiv.childNodes;
for(var i=0;i<_3.length;i++){
var _5=_3[i];
if(_5.nodeName==="DIV"){
this.addSection(_5);
}
}
this.ED=vjo.dsf.EventDispatcher;
},addSection:function(_6){
var _7=new vjo.darwin.core.menu.accordian.AccordianMenuSection(_6);
_7.menu=this;
this.sections.push(_7);
},closeAll:function(ev){
for(var i=0;i<this.sections.length;i++){
this.sections[i].close();
}
},setOpenSections:function(_a){
for(var i=0;i<_a.length;i++){
var _c=_a[i];
for(var j=0;j<this.sections.length;j++){
var _e=this.sections[j];
if(_c==_e.id){
_e.openSection();
}
}
}
},setCurrentSection:function(_f,_10){
for(var i=0;i<this.sections.length;i++){
var _12=this.sections[i];
if(_12.id===_f){
var _13=null;
if(_10!=null){
var _14=_12.sectionDiv.getElementsByTagName("LI");
for(var x=0;x<_14.length;x++){
if(_14[x].id===_10){
_13=_14[x];
break;
}
}
}
_12.setAsCurrent(_12,_13);
_12.applyCurrentStyle(_13);
}
}
},getOpenSectionIds:function(){
var ids=new Array();
for(var i=0;i<this.sections.length;i++){
if(this.sections[i].isOpen()){
ids.push(this.sections[i].id);
}
}
return ids;
},setOpenSectionIds:function(){
this.openSectionIds=new Array();
for(var i=0;i<this.sections.length;i++){
if(this.sections[i].isOpen()){
this.openSectionIds.push(this.sections[i].id);
}
}
},getCurrentSectionId:function(){
return this.currentSectionID;
},getCurrentItemId:function(){
return this.currentItemID;
}});

vjo.type("vjo.darwin.app.myebay.FilmstripLoader").protos({constructs:function(_1){
this.init(_1);
if(this.sPrimarySelectId){
this.setDefaultState(true);
}
},init:function(_2){
this.sDivId=_2.divId;
this.sPromoId=_2.promoId;
this.sPromoName=_2.promoName;
this.sOuterRequestParam=_2.outerRequestParam;
this.sSecondarySelectId=_2.secondarySelectId;
this.sSecondarySelectDivId=_2.secondarySelectDivId;
this.selectOptionMap=_2.selectOptionMap;
this.sDefaultSelectedValue=_2.defaultSelectedValue;
this.sPrimarySelectId=_2.primarySelectId;
this.sJsCompId=_2.jsCompId;
this.sDependentSelectId=_2.dependentSelectId;
this.sErrorDivId=_2.errorDivId;
},setDefaultState:function(_3){
var dd=document.getElementById(this.sPrimarySelectId);
if(dd){
if(this.sDependentSelectId){
var _5=document.getElementById(this.sDependentSelectId);
if(_5){
var _6=_5.options[_5.selectedIndex].value;
var _7=dd.options.length;
for(var i=0;i<_7;i++){
var _9=dd.options[i].value;
if(this.removeTrksid(_9)!=this.removeTrksid(_6)){
dd.selectedIndex=i;
if(_9.indexOf("http")<0){
this.populateSecondaryDiv(_9);
}else{
vjo.darwin.app.myebay.RequestManager.show(this.sSecondarySelectDivId,false,false,false);
}
break;
}
}
}else{
dd.selectedIndex=0;
}
}else{
if(_3){
dd.selectedIndex=0;
}
}
}
},removeTrksid:function(_a){
if(_a.indexOf("http")==0){
var _b=_a.indexOf("_trksid=5");
var _c=_a.indexOf("_trkparms",_b);
var _d=_a.substring(_b,_c);
var _e=_a.replace(_d,"");
return _e;
}else{
return _a;
}
},renderResponse:function(_f){
var id=(this.tempDivId)?this.tempDivId:this.sDivId;
var _11=(this.tempPromoId)?this.tempPromoId:this.sPromoId;
this.tempDivId=null;
this.tempPromoId=null;
var _12;
if(_f&&_f.length>0){
var div=document.getElementById(id);
if(_f[0].errors[0]=="NO_RESULT"){
var d=document.getElementById(this.sErrorDivId);
if(d){
div.innerHTML=d.innerHTML;
}
}else{
if(_f[0].data){
_12=_f[0].data.map;
}
if(_12){
if(div){
div.innerHTML="";
vjo.darwin.app.myebay.RequestManager.bindCss(div,_12.Style);
var _15=_12["ME"+_11+"_body"];
if(_15){
var _16=document.createElement("div");
_16.innerHTML=_15;
div.appendChild(_16);
}
vjo.darwin.app.myebay.RequestManager.bindJs(_12.Script);
}
}
}
}
oRequestManager.cancelRequest();
},loadOnSelect:function(_17,_18,_19,_1a){
if(_19){
this.init(_19);
}
var dd=document.getElementById(_17);
if(dd){
var val=dd.options[dd.selectedIndex].value;
if(val.indexOf("http")>-1){
this.makeRequest(val,_18);
if(_1a){
vjo.darwin.app.myebay.RequestManager.show(this.sSecondarySelectDivId,false,false,false);
}
}else{
this.populateSecondaryDiv(val);
if(_1a){
vjo.darwin.app.myebay.RequestManager.show(this.sSecondarySelectDivId,true,false,false);
}
var d=document.getElementById(this.sSecondarySelectId);
this.makeRequest(d.options[0].value,_18);
}
}
},populateSecondaryDiv:function(_1e){
var dd2=document.getElementById(this.sSecondarySelectId);
if(dd2){
dd2.options.length=0;
var _20=this.selectOptionMap[_1e],len=_20.length;
for(var i=0;i<len;i++){
var _22=_20[i];
var _23=new Option(_22.name,_22.url);
dd2.options[dd2.options.length]=_23;
}
}
},makeRequest:function(url,_25,_26,_27){
if(_25){
this.tempDivId=_25;
}
var _28=vjo.darwin.app.myebay.FilmstripLoader.getQueryStringParamVal(this.sOuterRequestParam,this.sPromoName,url);
if(_28){
this.tempPromoId=_28;
}
var req={};
req.url=url;
req.callType="FilmStripCall";
req.additionalParams="";
req.requestType="SCRIPT";
if(_26){
req.additionalParams="cb="+_26;
req.callback=_26;
}else{
req.additionalParams="cb=vjo.Registry.get('"+this.sJsCompId+"').renderResponse";
req.callback="vjo.Registry.get('"+this.sJsCompId+"').renderResponse";
}
if(_27){
_27[_27.length]=req;
}else{
_27=[req];
}
oRequestManager.makeRequest(_27);
}}).props({getQueryStringParamVal:function(_2a,_2b,url){
var _2d="";
var _2e=url.substr(url.indexOf("?")+1);
var ps=_2e.split("&"),psLen=ps.length;
for(var i=0;i<psLen;i++){
var p=ps[i].split("=");
if(p[0]==_2a){
var _32=decodeURIComponent(p[1]).split("&"),nvLen=_32.length;
for(var j=0;j<nvLen;j++){
var _34=_32[j].split("=");
if(_34[0]==_2b){
_2d=_34[1];
break;
}
}
}
}
if(_2d==null||_2d==""){
_2d="18";
}
return _2d;
}});

vjo.type("vjo.darwin.app.myebay.MyeBayLeftNav").satisfies("vjo.darwin.core.menu.accordian.IAccordianOnClickHandler").protos({constructs:function(_1,_2){
this.baseUrl=_1;
this.menu=_2;
vjo.dsf.EventDispatcher.addEventListener("leftnav_buy","click",function(){
setTimeout("vjo.darwin.app.myebay.MyeBayLeftNav.onItemClick1('leftnav_buy')",1000);
});
vjo.dsf.EventDispatcher.addEventListener("leftnav_sell","click",function(){
setTimeout("vjo.darwin.app.myebay.MyeBayLeftNav.onItemClick1('leftnav_sell')",1000);
});
vjo.dsf.EventDispatcher.addEventListener("leftnav_summary","click",function(){
setTimeout("vjo.darwin.app.myebay.MyeBayLeftNav.onItemClick1('leftnav_summary')",1000);
});
vjo.dsf.EventDispatcher.addEventListener("leftnav_organize","click",function(){
setTimeout("vjo.darwin.app.myebay.MyeBayLeftNav.onItemClick1('leftnav_organize')",1000);
});
},onItemClick:function(id,_4){
},makeNoteScriptRequest:function(_5,_6){
if(_5){
var _7=document.createElement("script");
_7.type="text/javascript";
var _8=this.addRandomParam(_5)+"&callback="+_6;
_7.src=_8;
document.getElementsByTagName("head")[0].appendChild(_7);
}
return false;
},addRandomParam:function(_9){
_9+=(_9.indexOf("?")>0?"&":"?")+"rand="+Math.random();
return _9;
}}).props({processOpenResponse:function(_a){
var _b;
if(_a){
_b=_a;
}
},onItemClick1:function(id){
var t=vjo.Registry.get("myebayleftnavjs");
var _e=t.menu.getOpenSectionIds();
var _f=t.menu.currentSectionID;
var _10=t.menu.currentItemID;
if(_10&&(_10.search(_f)!=-1)){
var _11=document.getElementById(_10).firstChild.firstChild.href+"&SubmitAction.MyeBayLeftNav=x";
}else{
var _11=t.baseUrl+"&SubmitAction.MyeBayLeftNav=x";
}
if(document.getElementById(id+"_body")){
if(document.getElementById(id+"_body").style.height=="0px"){
_11=_11+"&"+id+"=collapse";
}else{
_11=_11+"&"+id+"=open";
}
if(_e.length<=0){
_11=_11+"&id0=closeAll";
}else{
for(var i=0;i<_e.length;i++){
if((_11.search(_e[i]))==-1){
_11=_11+"&"+_e[i]+"=open";
}
}
}
t.makeNoteScriptRequest(_11,"vjo.darwin.app.myebay.MyeBayLeftNav.processOpenResponse");
}
}});

vjo.type("vjo.darwin.app.myebay.TrackingRender").props({ranAt:0}).inits(function(){
vjo.darwin.app.myebay.TrackingRender.ranAt=(new Date()).getTime();
if(vjo.darwin.app.myebay.TrackingHead){
vjo.darwin.app.myebay.TrackingHead.setRender();
vjo.darwin.app.myebay.TrackingHead.addCustomData("version","1.0");
}
});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.utils.Handlers");
vjo.needs("vjo.dsf.ServiceEngine");
vjo.type("vjo.darwin.core.dropdown.Dropdown").protos({E:vjo.dsf.document.Element,H:vjo.dsf.utils.Handlers,constructs:function(_1){
var t=this,m=_1;
t.sDpdId=m.dpdId;
t.sTitle=m.initTitle;
t.sValue=m.initValue;
t.bEnable=m.enable;
t.iWidth=m.width;
t.sPdmCntId=m.pdmCntId;
t.sPdmJsId=m.pdmJsId;
t.saStateClzes=m.stateClzes;
t.sDefImg=m.defImgPath;
t.sDisImg=m.disImgPath;
t.init();
},init:function(){
var t=this,w=0;
t.sFldId=t.sDpdId+"_fld";
t.sTxtId=t.sDpdId+"_txt";
t.sArrId=t.sDpdId+"_arr";
t.sPanelId=t.sDpdId+"_pnl";
t.sHiddenId=t.sDpdId+"_hdn";
t.sLenTesterId=t.sDpdId+"_tst";
var _4=t.E.get(t.sDpdId),fld=t.E.get(t.sFldId),tx=t.E.get(t.sTxtId),cnt=t.E.get(t.sPdmCntId),cntS=cnt.style;
t.oDpd=_4;
t.oTx=tx;
tx.style.width="";
if(fld&&cnt){
w=t.iWidth;
if(w<=0){
cntS.visibility="visible";
cntS.position=cntS.top=cntS.left="";
t.iWidth=cnt.offsetWidth+10;
cntS.position="absolute";
cntS.left="-1600px";
}else{
if(w<45&&w>0){
t.iWidth=45;
}
}
fld.style.width=t.iWidth+"px";
}
t.setTitle(t.sTitle);
t.setValue(t.sValue);
t.H.attachEvt(fld,"mouseover",t.onHover,t);
t.H.attachEvt(fld,"mouseout",t.showDefault,t);
t.H.attachEvt(fld,"mousedown",t.onActive,t);
t.H.attachEvt(fld,"mouseup",t.showDefault,t);
if(!t.bEnable){
t.disable();
}
_4.style.display="";
},isOverflow:function(_5,_6){
var t=this,w=t.oLenTester;
if(!w){
w=t.oLenTester=document.createElement("span");
var wS=w.style;
w.id=t.sLenTesterId+"_t";
wS.visibility="hidden";
wS.position="absolute";
wS.left="-1600px";
t.E.get(t.sLenTesterId).appendChild(w);
}
w.innerHTML=_6;
var _9=w.offsetWidth>_5;
return _9;
},setTitle:function(_a){
var t=this,f=t.oTx,w=t.iWidth-40,c="(...)",str="";
if(!t.isOverflow(w,_a)){
f.innerHTML=_a;
}else{
do{
var l=_a.length,cl=c.length,ind=_a.charCodeAt(l-1)>255?3:2;
if(l>1){
_a=_a.substr(0,(l-ind));
}else{
if(cl>0){
c=c.substr(0,(cl-2));
}else{
_a="&#160;";
break;
}
}
str=_a+c;
}while(str.length>0&&t.isOverflow(w,str));
f.innerHTML=str;
}
},setValue:function(_d){
var t=this,h=t.oHdn;
if(!h){
h=t.oHdn=t.E.get(t.sHiddenId);
}
h.value=_d;
},updateFld:function(_f,_10){
var t=this;
if(t.bEnable){
t.setTitle(_f);
t.setValue(_10);
}
},changeStyle:function(_12,_13){
var t=this,d=t.oDpd,a=t.oArr;
if(!a){
a=t.oArr=t.E.get(t.sArrId);
}
if(d&&a){
d.className=_12;
a.src=_13;
}
},showDefault:function(){
var t=this;
if(t.bEnable){
t.changeStyle(t.saStateClzes[0],t.sDefImg);
}
},onHover:function(){
var t=this;
if(t.bEnable){
t.changeStyle(t.saStateClzes[1],t.sDefImg);
}
},onActive:function(){
var t=this;
if(t.bEnable){
t.changeStyle(t.saStateClzes[2],t.sDefImg);
}
},disable:function(){
var t=this;
t.bEnable=false;
t.changeStyle(t.saStateClzes[3],t.sDisImg);
},enable:function(){
var t=this;
t.bEnable=true;
t.changeStyle(t.saStateClzes[0],t.sDisImg);
},toggle:function(_1a){
var t=this;
if(t.bEnable){
var h=t.oPdmJsRef;
if(!h){
h=t.oPdmJsRef=vjo.Registry.get(t.sPdmJsId);
}
if(h){
h.toggle(_1a,t.sFldId);
}
}
if(_1a.stopPropagation){
_1a.stopPropagation();
}else{
_1a.cancelBubble=true;
}
}});

vjo.needs("vjo.dsf.Message");
vjo.type("vjo.darwin.core.dropdown.DropdownItemClickSvcHandler").protos({constructs:function(_1){
this.sCmpFldJsId=_1;
},handleRequest:function(_2){
var t=this,fld=t.oFld;
if(!fld){
t.oFld=fld=vjo.Registry.get(t.sCmpFldJsId);
}
fld.updateFld(_2.getItemTitle(),_2.getItemValue());
return _2;
}});

vjo.type("vjo.darwin.domain.finding.autofill.AutoFillEncoder").protos({aCharList:[[new RegExp("[%]","g"),"_"],[new RegExp("[.]","g"),"_2e"],[new RegExp("[+]","g"),"_2b"],[new RegExp("[']","g"),"_27"]],pseudoDiv:null,constructs:function(){
this.pseudoDiv=document.createElement("div");
},encode:function(_1){
var _2=encodeURIComponent(_1),t=this;
for(var j=0;j<t.aCharList.length;j++){
var _4=t.aCharList[j];
_2=_2.replace(_4[0],_4[1]);
}
return _2;
},decodeCookie:function(_5){
var _6=_5||"";
_6=_6.replace(new RegExp("[+]","g")," ");
_6=decodeURIComponent(_6);
return _6;
},encodeHTML:function(_7){
var e=this.pseudoDiv;
if(typeof (e.textContent)!="undefined"){
e.textContent=_7;
}else{
e.innerText=_7;
}
return e.innerHTML;
}});

vjo.needs("vjo.darwin.domain.finding.autofill.AutoFillEncoder");
vjo.type("vjo.darwin.domain.finding.autofill.AutoFillCache").protos({oCache:{},oIndex:{},oReference:{},oLeaf:{},oEncoder:null,constructs:function(){
this.oEncoder=new vjo.darwin.domain.finding.autofill.AutoFillEncoder();
},add:function(_1){
try{
var t=this,kw=_1[0],kwList=_1[1],laList=_1[2],cacheItem=t.oCache[kw];
if(_1.length>=3){
t.addItem(kw,kw,"k",kwList);
}else{
try{
if(typeof (kwList[0])=="string"){
laList=null;
t.addItem(kw,kw,"k",kwList);
}else{
if(typeof (kwList[0])=="object"&&(kwList[0] instanceof Array)){
laList=_1[1];
}
}
}
catch(err){
laList=null;
}
}
if(laList!==null){
for(var i=0;i<laList.length;i++){
var _4=laList[i],lookAheadKw=kw+_4[0],lookAheadType=_4[1],lookAheadList=_4[2];
if(typeof (lookAheadList)=="undefined"||lookAheadList===null){
lookAheadType="fd";
lookAheadList=_4[0];
}
t.addItem(lookAheadKw,kw,lookAheadType,lookAheadList);
}
}else{
t.addItem(kw,kw,"null");
}
}
catch(e){
}
},addItem:function(_5,_6,_7,_8){
var t=this;
_5=_5.toLowerCase();
_6=_6.toLowerCase();
if(_7=="k"){
t.oCache[_5]={"type":"k","keyword":(typeof (_8)=="number")?(""+_8):_8,"shortPrefix":_6};
return t.oCache[_5];
}else{
if(_7=="f"){
t.oIndex[_5]={"type":"f","keyword":(typeof (_8)=="number")?(""+_8):_8,"shortPrefix":_6};
return t.oIndex[_5];
}else{
if(_7=="fd"){
t.oReference[_5]={"type":"fd","keyword":_8,"shortPrefix":_6};
return t.oReference[_5];
}else{
if(_7=="null"){
t.oLeaf[_5]={"type":"null","shortPrefix":_6};
return t.oLeaf[_5];
}
}
}
}
},get:function(_a,_b){
_a=_a.toLowerCase();
_b=_b.toLowerCase();
var t=this,cacheItem=t.oCache[_a],indexItem=t.oIndex[_a],referenceItem=t.oReference[_a];
if(typeof (cacheItem)!="undefined"&&typeof (cacheItem)!="function"){
return cacheItem;
}
if(typeof (indexItem)!="undefined"&&typeof (indexItem)!="function"){
return indexItem;
}
if(typeof (referenceItem)!="undefined"&&typeof (referenceItem)!="function"){
return referenceItem;
}
if(_b){
var _d=t.oLeaf[_b];
if(typeof (_d)!="undefined"&&typeof (_d)!="function"){
return _d;
}
var _e=[];
for(var _f in t.oIndex){
var _10=t.oIndex[_f];
if(_10.shortPrefix==_b){
_e.push(_f);
}
}
_e.sort();
if(_e.length===0){
return null;
}
var _11=_e.length-1;
for(i=0;i<_e.length;i++){
if(_a<_e[i]){
_11=i-1;
break;
}
}
if(_11<0){
_11=0;
}
return t.oIndex[_e[_11]];
}
return null;
}});

vjo.needs("vjo.dsf.XDomainRequest");
vjo.needs("vjo.Registry");
vjo.needs("vjo.dsf.utils.Object");
vjo.needs("vjo.dsf.utils.Handlers");
vjo.needs("vjo.dsf.utils.Timer");
vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.darwin.domain.finding.autofill.AutoFillCache");
vjo.needs("vjo.darwin.domain.finding.autofill.AutoFillEncoder");
vjo.type("vjo.darwin.domain.finding.autofill.AutoFillRequest").singleton().protos({aReqList:[],oCache:null,oConfig:{"baseURL":null,"dirDepth":null,"rootDir":null,"algorithm":null,"version":null,"siteId":null},oEncoder:null,sRespSvc:"autofill_response",iTimeout:1000,iProcessInterval:20,oProcessTimer:null,inProcess:false,bInit:false,vX:vjo.dsf.XDomainRequest,uN:"undefined",constructs:function(){
},init:function(_1){
var t=this;
if(t.bInit){
return;
}
var tO=t.oConfig;
tO.baseURL=_1.baseURL;
tO.dirDepth=_1.dirDepth;
tO.rootDir=_1.rootDir;
tO.algorithm=_1.algorithm;
tO.version=_1.version;
tO.siteId=_1.siteId;
t.oCache=new vjo.darwin.domain.finding.autofill.AutoFillCache();
t.oEncoder=new vjo.darwin.domain.finding.autofill.AutoFillEncoder();
t.oProcessTimer=new vjo.dsf.utils.Timer();
t.oProcessTimer.setInterval(t.iProcessInterval);
t.oProcessTimer.onTick=function(){
if(t.inProcess){
return;
}
t.inProcess=true;
try{
t.processQue();
t.cleanQue();
}
catch(e){
}
t.inProcess=false;
};
t.oProcessTimer.start();
t.bInit=true;
},processQue:function(){
var t=this,queLength=t.aReqList.length;
if(queLength===0){
return;
}
var _5=t.aReqList[0];
if(_5&&(_5.state=="wait")){
t.aReqList[0].state="process";
var _6=t.vX.bUseIframe;
try{
t.vX.bUseIframe=false;
var _7=t.vX.send(_5.url);
t.aReqList[0].scriptId=_7;
}
catch(e){
}
t.vX.bUseIframe=_6;
}
},cleanQue:function(){
var t=this,newList=[],i;
for(i=0;i<t.aReqList.length;i++){
var _9=t.aReqList[i];
if(_9.state=="wait"){
newList.push(_9);
}else{
if(_9.state=="process"){
var _a=new Date(),time=_a.getTime()-_9.timestamp;
if(time>=t.iTimeout){
t.removeScriptTag(_9.scriptId);
t.sendRespService(true,_9.requester,_9.prefix,null,null,_9.shortPrefix);
}else{
newList.push(_9);
}
}
}
}
t.aReqList=newList;
},removeScriptTag:function(_b){
var t=this;
if(_b&&_b.length>0){
var _d=vjo.dsf.document.Element.get(_b),scriptLoc=t.vX.getReqDiv();
if(scriptLoc&&_d){
scriptLoc.removeChild(_d);
}
}
},getRespSvc:function(){
return this.sRespSvc;
},getShortPrefix:function(_e){
var t=this,dirDepth=t.oConfig.dirDepth,shortPrefix=_e.substr(0,dirDepth+1);
return shortPrefix;
},buildPath:function(pKw,_11){
var t=this,pd=_11?10000:t.oConfig.dirDepth,pathStr=pKw.length>pd?pKw.substr(0,pd):pKw.substr(0,pKw.length-1),fileStr=pKw.length>pd?pKw.substr(pd,1):pKw.substr(pKw.length-1,1),encodedPathStr="";
var _13=pathStr.toLowerCase(),lowFileStr=fileStr.toLowerCase();
for(var i=0;i<_13.length;i++){
encodedPathStr+=t.encodeChar(_13.charAt(i))+"/";
}
return [encodedPathStr,t.encodeChar(lowFileStr),pathStr+fileStr];
},encodeChar:function(_15){
return this.oEncoder.encode(_15);
},buildURL:function(){
var t=this,tO=t.oConfig,url=tO.baseURL;
if(typeof (tO.version)==t.uN||tO.version===null){
return null;
}
if(url.lastIndexOf("/")<url.length-1){
url+="/";
}
url+=tO.rootDir+"/";
url+=tO.algorithm+"/";
url+=tO.siteId+"/";
url+=tO.version+"/";
return url;
},addRequest:function(_17,_18,_19,_1a){
var t=this,url=t.buildURL(),fileInfo=t.buildPath(_18,(_19=="fd"));
if(url===null){
return;
}
if(url.lastIndexOf("/")<url.length-1){
url+="/";
}
url+=fileInfo[0]+fileInfo[1];
if(_19=="f"&&typeof (_1a)!=t.uN&&_1a.length>0){
url+=_1a;
}
url+=".js";
var _1c=new Date();
t.aReqList.push({"requester":_17,"prefix":_18,"shortPrefix":t.getShortPrefix(_18),"url":url,"state":"wait","timestamp":_1c.getTime(),"type":_19});
},send:function(_1d,_1e){
var t=this;
if(!t.bInit){
return;
}
var _20=t.getShortPrefix(_1e),cacheResp=t.oCache.get(_1e,_20);
if(cacheResp===null){
t.addRequest(_1d,_1e,"k");
}else{
if(cacheResp.type=="f"||cacheResp.type=="fd"){
t.addRequest(_1d,_1e,cacheResp.type,cacheResp.keyword);
}else{
if(cacheResp.type=="null"){
t.sendRespService(true,_1d,_1e,[],[],_20);
}else{
t.sendRespService(false,_1d,_1e,cacheResp.keyword,[],_20);
}
}
}
},sendRespService:function(_21,_22,_23,_24,_25,_26){
var H=vjo.dsf.utils.Handlers,m=H.newMsg(this.sRespSvc);
if(_21){
m.clientContext={"timeout":true,"prefix":_23,"shortPrefix":_26,"requestId":_22};
}else{
m.clientContext={"timeout":false,"prefix":_23,"shortPrefix":_26,"requestId":_22,"kwList":_24,"laList":_25};
}
H.handle(m);
},handleResponse:function(_28){
var t=this,kw=_28[0],kwList=_28[1],laList=_28[2],i;
if(!t.bInit){
return;
}
t.oCache.add(_28);
var _2a=[];
for(i=0;i<t.aReqList.length;i++){
var _2b=t.aReqList[i];
if(_2b.state!="process"){
continue;
}
if(_2b.prefix.toLowerCase()==_2b.shortPrefix.toLowerCase()){
if(_2b.prefix.toLowerCase()==kw.toLowerCase()){
_2b.state="done";
t.removeScriptTag(_2b.scriptId);
t.sendRespService(false,_2b.requester,kw,kwList,laList,_2b.shortPrefix);
}
}else{
if(_2b.shortPrefix.toLowerCase()==kw.toLowerCase()){
var _2c=t.oCache.get(_2b.prefix,_2b.shortPrefix);
_2b.state="done";
t.removeScriptTag(_2b.scriptId);
if(_2b.type=="f"&&_2c.type!="k"){
t.sendRespService(true,_2b.requester,_2b.prefix,null,null,_2b.shortPrefix);
}else{
_2a.push(_2b);
}
}
}
}
for(i=0;i<_2a.length;i++){
var _2d=_2a[i];
t.send(_2d.requester,_2d.prefix);
}
}}).inits(function(){
vjo.darwin.domain.finding.autofill.AutoFillRequest=new vjo.darwin.domain.finding.autofill.AutoFillRequest();
});

vjo.needs("vjo.dsf.ServiceEngine");
vjo.needs("vjo.Registry");
vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.dsf.utils.Object");
vjo.needs("vjo.dsf.document.Shim");
vjo.needs("vjo.dsf.utils.Handlers");
vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.needs("vjo.darwin.domain.finding.autofill.AutoFillRequest");
vjo.needs("vjo.darwin.domain.finding.autofill.AutoFillEncoder");
vjo.type("vjo.darwin.domain.finding.autofill.AutoFill").props({_do:function(_1){
vjo.darwin.domain.finding.autofill.AutoFillRequest.handleResponse(_1);
}}).protos({oConfig:null,oKeyTimer:null,sCurKw:"",sLastKw:"",iCurSel:-1,aCurKwList:[],bInSugDiv:false,sInputId:null,oIframeShim:null,bHideSug:false,oRequest:null,sRequestId:"autofill",bLastQueryEmpty:false,oEncoder:null,constructs:function(_2,_3){
var t=this,vE=vjo.dsf.document.Element,vEvt=vjo.dsf.EventDispatcher,vO=vjo.dsf.utils.Object,vS=vjo.dsf.ServiceEngine;
t.sRequestId=_3;
t.oConfig=_2;
t.oEncoder=new vjo.darwin.domain.finding.autofill.AutoFillEncoder();
t.oRequest=vjo.darwin.domain.finding.autofill.AutoFillRequest;
vS.registerSvcHdl(t.oRequest.getRespSvc(),vO.hitch(t,"handleResp"));
vEvt.add(_2.getContainerId(),"mouseover",vO.hitch(t,"onMouseIn"));
vEvt.add(_2.getContainerId(),"mouseout",vO.hitch(t,"onMouseOut"));
vEvt.addEventListener(window,"resize",t.onWindowResize,t);
var _5=_2.getIdList(),i,id;
_5=_2.getHideLnkList();
for(i=0;i<_5.length;i++){
id=_5[i];
vEvt.add(id,"click",vO.hitch(t,"onHideClick"));
}
vS.registerSvcHdl(_2.getOutSvc(),function(_6){
var _7=_6.clientContext;
t.setInputId(_7.srcId);
switch(_7.type){
case "kw_keyup":
t.kw_keyup(_7);
break;
case "kw_blur":
t.kw_blur(_7);
break;
case "kw_keydown":
t.kw_keydown(_7);
break;
case "kw_mouseover":
t.kw_mouseover(_7);
break;
case "show_click":
t.show_click(_7);
break;
}
});
t.updTrk(t.oConfig.getTrkInput());
t.setAutoComplete(t.isHideSuggestion());
},handleResp:function(_8){
var vE=vjo.dsf.document.Element,t=this,context=_8.clientContext,i;
var _a=context.kwList||[],laList=context.laList||[];
if(t.sRequestId!=context.requestId||context.prefix.toLowerCase()!=t.getInputValue().toLowerCase()){
return;
}
var _b=t.getRecentSearch();
if(_b&&_b.length>0){
var _c=_b.toLowerCase(),index=_c.indexOf(t.sCurKw.toLowerCase()),bRecentMatch=false,sRecentPart=_c,preIndex=0;
while(index>=0){
if(t.isWordStart(_c,index+preIndex)){
bRecentMatch=true;
break;
}
preIndex=index+1;
sRecentPart=sRecentPart.substr(index+1);
index=sRecentPart.indexOf(t.sCurKw.toLowerCase());
}
if(bRecentMatch){
var _d=[];
_d.push(_b);
for(i=0;i<_a.length;i++){
if(_a[i].toLowerCase()!=_c){
_d.push(_a[i]);
}
}
if(_d.length>t.oConfig.getListSize()){
_d.pop();
}
_a=_d;
}
}
if(context.timeout&&(context.prefix==t.sCurKw)&&_a.length<1){
if(!t.bLastQueryEmpty){
t.showNoSugMessage(true);
t.showSugDiv(true,t.oConfig.getWidthMin().px);
}else{
t.showSugDiv(false);
}
t.bLastQueryEmpty=true;
return;
}
t.bLastQueryEmpty=false;
t.showNoSugMessage(false);
t.iCurSel=-1;
t.aCurKwList=[];
var _e=t.oConfig.getIdList(),listLength=_e.length;
if(listLength>t.oConfig.getListSize()){
listLength=t.oConfig.getListSize();
}
if(t.sInputId!==null){
var _f=vjo.dsf.document.Element.get(t.sInputId);
if(_f){
t.oConfig.updateWidthDef(_f);
}
}
var _10=t.getMaxKwLength(_a,listLength),clipLength=t.oConfig.getWidthMax()["char"],dispPx=_10*t.oConfig.getWidthUnit();
if(dispPx<t.oConfig.getWidthMin().px){
dispPx=t.oConfig.getWidthMin().px;
}else{
if(dispPx>t.oConfig.getWidthMax().px){
dispPx=t.oConfig.getWidthMax().px;
}
}
for(i=0;i<listLength;i++){
var en=_e[i],e=vE.get(en);
if(e===null){
continue;
}
e.className="unsel";
if(i<_a.length){
e.innerHTML=t.genKwHTML(_a[i],t.sCurKw,clipLength);
vE.toggleHideShow(en,true);
var trk=(_a[i]==_b)?t.oConfig.getTrkRS():t.oConfig.getTrkSuggest();
t.aCurKwList[i]={"divId":en,"sugKw":_a[i],"trk":trk};
}else{
vE.toggleHideShow(en,false);
}
}
t.showSugDiv(true,dispPx);
},getInputValue:function(){
var e=vjo.dsf.document.Element.get(this.sInputId);
return e?e.value:"";
},isHideSuggestion:function(){
if(vjo.Registry.get("autofilltest")){
return this.bHideSug;
}
var vC=vjo.dsf.cookie.VjCookieJar,pbf=vC.readCookie("dp1","pbf"),bit=vC.getBitFlag(pbf,29);
return bit==1;
},setHideSuggestion:function(_15){
if(vjo.Registry.get("autofilltest")){
this.bHideSug=_15;
}
var vC=vjo.dsf.cookie.VjCookieJar,pbf=vC.readCookie("dp1","pbf");
vC.writeCookielet("dp1","pbf",vC.setBitFlag(pbf,29,_15?1:0));
},getRecentSearch:function(){
var lss=this.oConfig.getLastSearch();
if(lss!==null&&lss.length>0){
lss=lss.substring(lss.indexOf(".")+1);
return lss;
}
return "";
},getMaxKwLength:function(_18,_19){
if(!_18){
return 0;
}
var max=0,length=_18.length;
if(length>_19){
length=_19;
}
for(var i=0;i<_18.length;i++){
if(_18[i].length>max){
max=_18[i].length;
}
}
return max;
},isWordStart:function(pKw,_1d){
if(_1d<=0||_1d>pKw.length-1){
return true;
}
var _1e=pKw.substr(_1d-1,1),wordDelimiter=new RegExp("[\\s \\.,]");
return _1e.search(wordDelimiter)>=0;
},genKwHTML:function(pKw,_20,_21){
var _22=_20.length,out=pKw,t=this;
var _23,startIndex=-1;
for(var i=0;i<pKw.length;i++){
_23=pKw.substr(i,_22);
if(_23.length!=_22){
break;
}
if(_23.toLowerCase()==_20.toLowerCase()&&t.isWordStart(pKw,i)){
startIndex=i;
break;
}
}
var _25=pKw.substring(0,startIndex),afterPart=pKw.substr(startIndex+_22),keepLength;
if(startIndex>=0){
if(pKw.length>_21){
if(_25.length>_21){
out=t.oEncoder.encodeHTML(out.substr(0,_21));
out+="...";
}else{
if((_25.length+_23.length)>_21){
keepLength=_21-_25.length;
_23="<span class='hl'>"+t.oEncoder.encodeHTML(_23.substr(0,keepLength))+"...</span>";
out=t.oEncoder.encodeHTML(_25)+_23;
}else{
keepLength=_21-_25.length-_23.length;
out=t.oEncoder.encodeHTML(_25)+"<span class='hl'>"+t.oEncoder.encodeHTML(_23)+"</span>"+t.oEncoder.encodeHTML(afterPart.substr(0,keepLength))+"...";
}
}
}else{
out=t.oEncoder.encodeHTML(_25)+"<span class='hl'>"+t.oEncoder.encodeHTML(_23)+"</span>"+t.oEncoder.encodeHTML(afterPart);
}
}else{
if(pKw.length>_21){
out=t.oEncoder.encodeHTML(out.substr(0,_21));
out+="...";
}
}
return out;
},startKeyTimer:function(_26){
var t=this;
t.stopKeyTimer();
var _28=function(){
var _29=t.getInputValue();
if(_26!=_29||_29.length<1){
return;
}
t.oRequest.send(t.sRequestId,_26);
};
t.oKeyTimer=window.setTimeout(_28,t.oConfig.getDelayTime());
},stopKeyTimer:function(){
var t=this;
if(t.oKeyTimer!==null){
window.clearTimeout(t.oKeyTimer);
t.oKeyTimer=null;
}
},getKwSelect:function(){
var t=this;
if(t.iCurSel<0){
return t.sCurKw;
}
return t.aCurKwList[t.iCurSel].sugKw;
},selectSug:function(_2c,_2d){
var t=this,kw=t.sCurKw;
if(t.iCurSel>=0){
t.unselectSug(t.aCurKwList[t.iCurSel].divId);
}
if(_2c!==null){
var e=vjo.dsf.document.Element.get(_2c);
for(var i=0;i<t.aCurKwList.length;i++){
if(t.aCurKwList[i].divId==_2c){
t.iCurSel=i;
kw=t.aCurKwList[i].sugKw;
break;
}
}
if(e){
e.className="sel";
}
}else{
t.iCurSel=-1;
}
t.updateInput(kw);
if(!_2d){
t.focusInput();
}
},unselectSug:function(_31){
var e=vjo.dsf.document.Element.get(_31);
if(e){
e.className="unsel";
}
},createTrackingImg:function(_33){
var _34=new Date(),r=_34.getTime(),imgUrl=_33;
if(imgUrl.indexOf("?")>0){
imgUrl+="&"+r;
}else{
imgUrl+="?"+r;
}
var img=new Image(),bodyLoc=document.getElementsByTagName("body")[0];
bodyLoc.appendChild(img);
img.setAttribute("src",imgUrl);
img.setAttribute("width","1");
img.setAttribute("height","1");
img.setAttribute("border","0");
},sendInSvc:function(_36){
var H=vjo.dsf.utils.Handlers,m=H.newMsg(this.oConfig.getInSvc());
m.clientContext=_36;
H.handle(m);
},isCtrlKey:function(_38){
var _39=[38,39,40,27];
for(var i=0;i<_39.length;i++){
if(_39[i]==_38){
return true;
}
}
return false;
},isIgnorKey:function(_3b){
var _3c=[16,17,18];
for(var i=0;i<_3c.length;i++){
if(_3b==_3c[i]){
return true;
}
}
return false;
},isSugShown:function(){
var _3e=vjo.dsf.document.Element.get(this.oConfig.getContainerId());
disp=_3e.currentStyle?_3e.currentStyle.display:window.getComputedStyle(_3e,null).getPropertyValue("display");
return (disp!="none");
},isNoSugMsgShow:function(){
var _3f=vjo.dsf.document.Element.get(this.oConfig.getNoSugDivId());
disp=_3f.currentStyle?_3f.currentStyle.display:window.getComputedStyle(_3f,null).getPropertyValue("display");
return (disp!="none");
},showNoSugMessage:function(_40){
var vE=vjo.dsf.document.Element,t=this;
vE.toggleHideShow(t.oConfig.getSugDivId(),!_40);
vE.toggleHideShow(t.oConfig.getNoSugDivId(),_40);
if(_40){
var _42=function(){
if(t.isNoSugMsgShow()){
t.showSugDiv(false);
}
};
window.setTimeout(_42,t.oConfig.getNoSugShowTime());
}
},showSugDiv:function(_43,_44){
var t=this;
if(t.isHideSuggestion()&&_43){
t.showIcon(true);
return;
}
var vS=vjo.dsf.document.Shim,oDiv=vjo.dsf.document.Element.get(t.oConfig.getContainerId());
vjo.dsf.document.Element.toggleHideShow(t.oConfig.getContainerId(),_43);
if(_43){
t.posLayer(_44);
if(t.oIframeShim){
vS.remove(oDiv,t.oIframeShim);
}
t.oIframeShim=vS.add(oDiv);
var _47=function(){
t.regOverEvent(true);
};
window.setTimeout(_47,100);
}else{
if(t.oIframeShim!==null){
vS.remove(oDiv,t.oIframeShim);
t.oIframeShim=null;
}
t.regOverEvent(false);
}
},regOverEvent:function(_48){
var t=this,idList=t.oConfig.getIdList(),i,id;
vEvt=vjo.dsf.EventDispatcher,vO=vjo.dsf.utils.Object;
for(i=0;i<idList.length;i++){
id=idList[i];
vEvt.unregister(id,"mouseover");
vEvt.unregister(id,"click");
}
if(_48){
for(i=0;i<idList.length;i++){
id=idList[i];
vEvt.add(id,"mouseover",vO.hitch(t,"onListMouseOver"));
vEvt.add(id,"click",vO.hitch(t,"onListClick"));
}
}
},posLayer:function(_4a){
var _4b=this.getAbsPos(this.sInputId);
if(_4b===null){
return false;
}
var e=vjo.dsf.document.Element.get(this.oConfig.getContainerId());
if(e===null){
return false;
}
e.style.left=_4b.left+"px";
e.style.top=_4b.top+_4b.height+"px";
if((typeof (_4a)!="undefined")&&(_4a!==null)){
e.style.width=parseInt(_4a,10)+"px";
}
return true;
},getAbsPos:function(_4d,_4e){
var obj=_4d;
if(!_4d){
return null;
}
if(typeof (_4d)=="string"){
obj=vjo.dsf.document.Element.get(_4d);
if(obj===null){
return null;
}
}
var top=obj.offsetTop,left=obj.offsetLeft,height=obj.offsetHeight,width=obj.offsetWidth;
var pos="",of="";
obj=obj.offsetParent;
while(obj!==null){
if(_4e){
pos=obj.currentStyle?obj.currentStyle.position:window.getComputedStyle(obj,null).getPropertyValue("position");
of=obj.currentStyle?obj.currentStyle.overflow:window.getComputedStyle(obj,null).getPropertyValue("overflow");
if(pos=="absolute"||pos=="relative"||(of!=="visible"&&of!=="")){
break;
}
}
top+=obj.offsetTop;
left+=obj.offsetLeft;
obj=obj.offsetParent;
}
return {"left":parseInt(left,10),"top":parseInt(top,10),"height":parseInt(height,10),"width":parseInt(width,10)};
},updateInput:function(pKw){
if(this.isSugShown()){
this.sLastKw=pKw;
var _53={"type":"kw_updvalue","value":pKw};
this.sendInSvc(_53);
}
},updTrk:function(_54){
var _55={"type":"search_updtrk","lnkStr":_54};
this.sendInSvc(_55);
},submitForm:function(){
var t=this;
if(t.iCurSel>=0){
var trk=t.aCurKwList[t.iCurSel].trk;
t.updTrk(trk);
}
var _58={"type":"search_submit"};
this.sendInSvc(_58);
},showIcon:function(_59){
var _5a={"type":"sug_icon_show","bShow":_59};
this.sendInSvc(_5a);
},focusInput:function(){
var _5b={"type":"kw_focus"};
this.sendInSvc(_5b);
},setAutoComplete:function(bOn){
var _5d={"type":"kw_autocomplete","bOn":bOn};
this.sendInSvc(_5d);
},setInputId:function(pId){
if(this.sInputId===null){
this.sInputId=pId;
}
var e=vjo.dsf.document.Element.get(pId);
if(e){
this.oConfig.updateWidthDef(e);
}
},show_click:function(_60){
var t=this;
t.showIcon(false);
t.setHideSuggestion(false);
t.bLastQueryEmpty=false;
t.oRequest.send(t.sRequestId,t.getInputValue());
var _62=function(){
t.createTrackingImg(t.oConfig.getTrkShow());
};
window.setTimeout(_62,500);
t.setAutoComplete(false);
},kw_blur:function(_63){
if(this.isSugShown()&&!this.isNoSugMsgShow()){
if(!this.bInSugDiv){
this.selectSug(null,true);
this.showSugDiv(false);
}else{
this.focusInput();
}
}
},kw_mouseover:function(_64){
if(this.isSugShown()&&!this.isNoSugMsgShow()){
this.selectSug(null);
}
},kw_keydown:function(_65){
var t=this,kc=_65.keyCode;
if(kc==13&&t.isSugShown()&&!t.isNoSugMsgShow()){
t.submitForm();
t.showSugDiv(false);
}
},kw_keyup:function(_67){
var t=this,vE=vjo.dsf.document.Element,kc=_67.keyCode,cv=_67.value;
if(t.isIgnorKey(kc)){
return;
}
if(t.isSugShown()&&!t.isNoSugMsgShow()){
if(t.isCtrlKey(kc)){
var e,nextId,divId;
switch(kc){
case 38:
nextId=t.iCurSel-1;
if(nextId<-1){
nextId=t.aCurKwList.length-1;
}
divId=nextId>=0?t.aCurKwList[nextId].divId:null;
t.selectSug(divId);
t.iCurSel=nextId;
break;
case 40:
nextId=t.iCurSel+1;
if(nextId>=t.aCurKwList.length){
nextId=-1;
}
divId=nextId>=0?t.aCurKwList[nextId].divId:null;
t.selectSug(divId);
break;
case 39:
if(cv.length!==0){
t.sCurKw=cv;
t.startKeyTimer(cv);
t.sLastKw=cv;
}
break;
case 27:
t.selectSug(null);
t.showSugDiv(false);
break;
}
}else{
if(cv.length!==0){
if(t.sLastKw!=cv){
t.sCurKw=cv;
t.startKeyTimer(cv);
t.sLastKw=cv;
}
}else{
t.showSugDiv(false);
t.showIcon(false);
t.sCurKw=cv;
t.sLastKw=cv;
t.bLastQueryEmpty=false;
}
}
}else{
if(cv.length!==0){
if(t.sLastKw!=cv){
t.sCurKw=cv;
t.startKeyTimer(cv);
t.sLastKw=cv;
}
}else{
t.sCurKw=cv;
if(t.isHideSuggestion()){
t.showIcon(false);
}
t.sLastKw=cv;
t.bLastQueryEmpty=false;
}
}
},onListMouseOver:function(_6a){
this.bInSugDiv=true;
var e=_6a.src;
this.selectSug(e.id);
},onListClick:function(_6c){
var e=_6c.src;
this.selectSug(e.id);
this.submitForm();
this.showSugDiv(false);
},onMouseIn:function(_6e){
this.bInSugDiv=true;
},onMouseOut:function(_6f){
this.bInSugDiv=false;
},onHideClick:function(_70){
var t=this;
t.setHideSuggestion(true);
t.selectSug(null);
t.showSugDiv(false);
t.setAutoComplete(true);
t.showIcon(true);
var _72=function(){
t.createTrackingImg(t.oConfig.getTrkHide());
};
window.setTimeout(_72,500);
return false;
},onWindowResize:function(_73){
var t=this;
if(t.isSugShown()){
t.showSugDiv(true);
}
}});

vjo.needs("vjo.darwin.domain.finding.autofill.AutoFillEncoder");
vjo.type("vjo.darwin.domain.finding.autofill.AutoFillConfig").protos({oModel:{"rootDir":"autofill","listSize":7,"delayTime":200,"dirDepth":3,"noSugShowTime":1500,"svcIn":"SVC_GH_IN","svcOut":"SVC_GH_OUT"},defaultAlgo:"1",algoMap:{"1":"f","2":"a"},widthDef:{"unit":9,"min":{"px":233,"char":26},"max":{"px":400,"char":40}},oEncoder:null,constructs:function(_1){
this.oEncoder=new vjo.darwin.domain.finding.autofill.AutoFillEncoder();
this.loadConfig(_1);
},loadConfig:function(_2){
var t=this,tM=t.oModel;
if(_2.version===null||_2.algorithm===null){
tM.version=_2.algoVerMap[t.defaultAlgo];
tM.algorithm=t.algoMap[t.defaultAlgo];
}else{
tM.version=_2.version;
tM.algorithm=t.algoMap[_2.algorithm];
}
tM.trkSuggest=_2.trkSuggest;
tM.trkRS=_2.trkRS;
tM.trkInput=_2.trkInput;
tM.trkShow=_2.trkShow;
tM.trkHide=_2.trkHide;
tM.containerId=_2.containerId;
tM.idList=_2.idList;
tM.sugDivId=_2.sugDivId;
tM.noSugDivId=_2.noSugDivId;
tM.hideLnkList=_2.hideLnkList;
tM.baseURL=_2.baseURL;
tM.siteId=_2.siteId;
tM.lastSearch=t.oEncoder.decodeCookie(_2.lastSearch);
tM.svcIn=_2.svcIn;
tM.svcOut=_2.svcOut;
},updateWidthDef:function(_4){
var t=this,inputWidth=parseInt(_4.offsetWidth,10);
t.widthDef.max={"px":inputWidth,"char":Math.floor(inputWidth/t.widthDef.unit)-1};
},getHideLnkList:function(){
return this.oModel.hideLnkList;
},getWidthUnit:function(){
return this.widthDef.unit;
},getWidthMin:function(){
return this.widthDef.min;
},getWidthMax:function(){
return this.widthDef.max;
},getRootDir:function(){
return this.oModel.rootDir;
},getListSize:function(){
return this.oModel.listSize;
},getDelayTime:function(){
return this.oModel.delayTime;
},getDirDepth:function(){
return this.oModel.dirDepth;
},getAlgorithm:function(){
return this.oModel.algorithm;
},getVersion:function(){
return this.oModel.version;
},getTrkSuggest:function(){
return this.oModel.trkSuggest;
},getTrkRS:function(){
return this.oModel.trkRS;
},getTrkInput:function(){
return this.oModel.trkInput;
},getTrkShow:function(){
return this.oModel.trkShow;
},getTrkHide:function(){
return this.oModel.trkHide;
},getContainerId:function(){
return this.oModel.containerId;
},getIdList:function(){
return this.oModel.idList;
},getKeyUpSvc:function(){
return this.oModel.keyUpSvc;
},getKeyDownSvc:function(){
return this.oModel.keyDownSvc;
},getInputOverSvc:function(){
return this.oModel.inputOverSvc;
},getUpdInputSvc:function(){
return this.oModel.updInputSvc;
},getFillContentSvc:function(){
return this.oModel.fillContentSvc;
},getInSvc:function(){
return this.oModel.svcIn;
},getOutSvc:function(){
return this.oModel.svcOut;
},getBaseURL:function(){
return this.oModel.baseURL;
},getSiteId:function(){
return this.oModel.siteId;
},getSugDivId:function(){
return this.oModel.sugDivId;
},getNoSugDivId:function(){
return this.oModel.noSugDivId;
},getNoSugShowTime:function(){
return this.oModel.noSugShowTime;
},getLastSearch:function(){
return this.oModel.lastSearch;
}});

vjo.needs("vjo.dsf.EventDispatcher");
vjo.needs("vjo.dsf.ServiceEngine");
vjo.needs("vjo.darwin.domain.finding.autofill.AutoFillConfig");
vjo.needs("vjo.darwin.domain.finding.autofill.AutoFill");
vjo.needs("vjo.darwin.domain.finding.autofill.AutoFillRequest");
vjo.type("vjo.darwin.domain.finding.autofill.AutoFillInit").protos({constructs:function(_1){
this.oModel=_1;
var t=this;
var _3=function(){
var _4=new vjo.darwin.domain.finding.autofill.AutoFillConfig(t.oModel),requestConfig={"baseURL":_4.getBaseURL(),"dirDepth":_4.getDirDepth(),"rootDir":_4.getRootDir(),"algorithm":_4.getAlgorithm(),"version":_4.getVersion(),"siteId":_4.getSiteId()};
vjo.darwin.domain.finding.autofill.AutoFillRequest.init(requestConfig);
new vjo.darwin.domain.finding.autofill.AutoFill(_4,t.oModel.requestId);
};
vjo.dsf.EventDispatcher.add("body","load",_3);
}});

vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.dsf.EventDispatcher");
vjo.needs("vjo.dsf.ServiceEngine");
vjo.needs("vjo.dsf.window.utils.VjWindowUtils");
vjo.type("vjo.darwin.core.ebayheader.autocomplete.AutoComplete").protos({constructs:function(_1,_2){
var t=this,E=vjo.dsf.document.Element;
t.sInputId=_1;
t.sFormId=_2;
t.sAcDivId=_1+"_acdiv";
t.acdivWidth=0;
t.sShowImg=false;
t.input=E.get(t.sInputId);
t.input.setAttribute("AUTOCOMPLETE","OFF");
t.acdiv=E.get(t.sAcDivId);
var _4=document.forms;
vjo.dsf.EventDispatcher.add(this.sInputId,"keyup",function(e){
var _6=e.nativeEvent.keyCode;
var _7=new vjo.dsf.Message("SVC_GH_OUT");
_7.clientContext={type:"kw_keyup",srcId:_1,value:t.input.value,keyCode:_6};
return _7;
});
vjo.dsf.EventDispatcher.add(this.sInputId,"keydown",function(e){
var _9=e.nativeEvent.keyCode;
var _a=new vjo.dsf.Message("SVC_GH_OUT");
_a.clientContext={type:"kw_keydown",srcId:_1,value:t.input.value,keyCode:_9};
return _a;
});
vjo.dsf.EventDispatcher.add(this.sInputId,"mouseover",function(e){
var _c=e.nativeEvent.keyCode;
var _d=new vjo.dsf.Message("SVC_GH_OUT");
_d.clientContext={type:"kw_mouseover",srcId:_1};
return _d;
});
vjo.dsf.EventDispatcher.add(this.sInputId,"blur",function(e){
var _f=e.nativeEvent.keyCode;
var _10=new vjo.dsf.Message("SVC_GH_OUT");
_10.clientContext={type:"kw_blur",srcId:_1};
return _10;
});
vjo.dsf.EventDispatcher.add(this.sAcDivId,"click",function(e){
var _12=new vjo.dsf.Message("SVC_GH_OUT");
_12.clientContext={type:"show_click"};
return _12;
});
vjo.dsf.ServiceEngine.registerSvcHdl("SVC_GH_IN",function(_13){
var _14=_13.clientContext.type;
if(_14=="kw_updvalue"){
var _15=document.getElementById(_1);
_15.value=_13.clientContext.value;
}else{
if(_14=="kw_autocomplete"){
if(_13.clientContext.bOn){
t.input.blur();
}
t.input.setAttribute("AUTOCOMPLETE",_13.clientContext.bOn?"ON":"OFF");
if(_13.clientContext.bOn){
t.input.blur();
t.input.focus();
}
}else{
if(_14=="search_updtrk"){
for(i=0;i<_4.length;i++){
if(_4[i].name==_2){
for(var j=0;j<_4[i].length;j++){
if(_4[i].elements[j].name=="_trksid"){
var _17=_4[i].elements[j].value;
var _18=_17.indexOf(".");
if(_18>0){
_17=_17.substring(0,_18+1);
}else{
if(_17.length>0){
_17=_17+".";
}
}
_17=_17+_13.clientContext.lnkStr;
_4[i].elements[j].value=_17;
return;
}
}
}
}
}else{
if(_14=="search_submit"){
for(i=0;i<_4.length;i++){
if(_4[i].name==_2){
_4[i].submit();
return;
}
}
}else{
if(_14=="sug_icon_show"){
if(_13.clientContext.bShow){
t.showImage();
}else{
t.hideImage();
}
}else{
if(_14=="kw_focus"){
t.input.focus();
t.input.value=t.input.value+"";
}
}
}
}
}
}
});
},showImage:function(){
var t=this;
if(t.sShowImg){
return;
}
var _1a=vjo.dsf.window.utils.VjWindowUtils;
if(t.acdivWidth===0){
t.acdiv.style.display="inline";
t.acdivWidth=t.acdiv.offsetWidth;
}
var _1b=t.acdivWidth+3;
t.input.style.width=(t.input.clientWidth-_1b)+"px";
t.input.style.borderRightWidth="0px";
t.acdiv.style.display="inline";
t.sShowImg=true;
},hideImage:function(){
var t=this;
if(!t.sShowImg){
return;
}
var _1d=t.acdiv.offsetWidth-5;
t.input.style.width=(t.input.clientWidth+_1d)+"px";
t.input.style.borderRightWidth="1px";
t.acdiv.style.display="none";
t.sShowImg=false;
}});

vjo.type("vjo.darwin.core.moduletab.ModuleTab").protos({constructs:function(_1){
var m=_1;
var t=this;
t.sHtmlName=m.htmlName;
t.sactiveRgt=m.activeRgt;
t.sactiveLft=m.activeLft;
t.shighlightLft=m.highlightLft;
t.shighlightRgt=m.highlightRgt;
t.sinactiveLft=m.inactiveLft;
t.sinactiveRgt=m.inactiveRgt;
t.shoverLft=m.hoverLft;
t.shoverRgt=m.hoverRgt;
t.stabcontentOuterOff=m.tabcontentOuterOff;
t.stabcontentOuterOn=m.tabcontentOuterOn;
t.sContentElementId=null;
t.sActiveBkgColor=m.activeBkgColor;
t.aTabs=[];
t.iCurrTab=m.activeTabId;
}});

vjo.needs("vjo.Registry");
vjo.type("vjo.darwin.core.moduletab.TabProperties").protos({_e:null,_r:null,constructs:function(_1){
_e=vjo.dsf.Element;
_r=vjo.Registry;
m=_1;
var t=this;
t.hN=m.htmlName;
t.iId=m.id;
t.sUrl=m.url;
t.bIsActive=m.active;
t.bIsHighlighted=m.highlighted;
var _n=_r.get(t.hN);
if(_n!==null){
var _4=_n.aTabs;
_4[_4.length]=t;
}
t.bindEventsInJS();
},bindEventsInJS:function(){
var t=this;
vjEd=vjo.dsf.EventDispatcher,_tProp=vjo.darwin.core.moduletab.TabProperties;
var _6=t.hN+"_tab_rgt_"+t.iId,tbL=t.hN+"_tab_lft_"+t.iId,tb=t.hN+"_"+t.iId;
if(t.sUrl===null){
t.sUrl="";
}
var _f=function(_8){
return _tProp.switchToTab(t.hN,t.iId,_8);
};
vjEd.add(tbL,"click",_f);
vjEd.add(_6,"click",_f);
vjEd.add(_6,"mouseover",function(_9){
return _tProp.hoverChange(t.hN,t.iId,true);
});
vjEd.add(_6,"mouseout",function(_a){
return _tProp.hoverChange(t.hN,t.iId,false);
});
}}).props({tLft:"_tab_lft_",tRgt:"_tab_rgt_",tCnt:"_content_",tCurrId:"CurrId",switchToTab:function(_b,_c,_d){
var t=this;
var _f=_r.get(_b),pArrTab=_f.aTabs,currId=_e.get(_b+t.tCurrId).value;
var _10;
var to;
for(i=0;i<pArrTab.length;i++){
if(currId==pArrTab[i].iId){
_10=i;
}
if(_c==pArrTab[i].iId){
to=i;
}
}
var tp=vjo.darwin.core.moduletab.TabProperties;
var _13=_b+t.tRgt+pArrTab[_10].iId,fTbL=_b+t.tLft+pArrTab[_10].iId;
var _14=_b+t.tRgt+pArrTab[to].iId,tTbL=_b+t.tLft+pArrTab[to].iId;
if(pArrTab){
if(pArrTab[to].bIsActive===true){
return;
}
if(pArrTab[to].iId==_c){
_e.get(_b+t.tCurrId).value=_c;
var rt=_e.get(_14);
if((pArrTab[to].bIsAjaxEnabled===false)&&(pArrTab[to].sUrl!==null)&&(pArrTab[to].sUrl.indexOf("http")===0)){
var src=_d.nativeEvent.target?_d.nativeEvent.target:_d.nativeEvent.srcElement;
if(src.tagName.toLowerCase()==="a"){
src.blur();
return;
}
document.location.href=pArrTab[to].sUrl;
return;
}
tp.setTabs(_c,pArrTab[_10],_b,_f);
tp.setTabs(_c,pArrTab[to],_b,_f);
}
}
},setClz:function(_17,_18){
var el;
el=_e.get(_17);
if(el){
el.className=_18;
}
},setBkgColor:function(_1a,_1b){
var el;
el=_e.get(_1a);
if(el){
el.style.backgroundColor=_1b;
}
},init:function(_1d){
var t=this;
var _1f=_r.get(_1d),pArrTab=_1f.aTabs,tp=vjo.darwin.core.moduletab.TabProperties;
var _20=_e.get(_1d+tp.tCurrId).value;
var to;
for(i=0;i<pArrTab.length;i++){
if(_20==pArrTab[i].iId){
to=i;
break;
}
}
if(pArrTab){
if(pArrTab[to].bIsActive===true){
return;
}
for(var i=0;i<pArrTab.length;i++){
tp.setTabs(_20,pArrTab[i],_1d,_1f);
}
}
},setTabs:function(_23,_24,_25,_26){
var t=vjo.darwin.core.moduletab.TabProperties;
var _28=_25+t.tRgt+_24.iId,fTbL=_25+t.tLft+_24.iId;
if(_23==_24.iId){
_24.bIsActive=true;
if(_26.sActiveBkgColor!==null){
t.setBkgColor(fTbL,_26.sActiveBkgColor);
t.setBkgColor(_28,_26.sActiveBkgColor);
}
t.setClz(fTbL,_26.sactiveLft);
t.setClz(_28,_26.sactiveRgt);
t.setClz(_25+t.tCnt+_24.iId,_26.stabcontentOuterOn);
}else{
_24.bIsActive=false;
t.setBkgColor(fTbL,"");
t.setBkgColor(_28,"");
if(_24.bIsHighlighted===true){
t.setClz(fTbL,_26.shighlightLft);
t.setClz(_28,_26.shighlightRgt);
}else{
t.setClz(fTbL,_26.sinactiveLft);
t.setClz(_28,_26.sinactiveRgt);
}
t.setClz(_25+t.tCnt+_24.iId,_26.stabcontentOuterOff);
}
},hoverChange:function(_29,_2a,_2b){
var _2c=_r.get(_29),tp=vjo.darwin.core.moduletab.TabProperties,pArrTab=_2c.aTabs;
for(var i=0;i<pArrTab.length;i++){
if(pArrTab[i].iId==_2a){
to=i;
break;
}
}
var _2e=_29+tp.tRgt+pArrTab[to].iId,tTbL=_29+tp.tLft+pArrTab[to].iId;
if(pArrTab){
if(pArrTab[to].bIsActive===true){
return;
}
if(pArrTab[to].bIsHighlighted===true){
if(_2b===true){
tp.setClz(tTbL,_2c.shighlightLft+" "+_2c.shoverLft);
tp.setClz(_2e,_2c.shighlightRgt+" "+_2c.shoverRgt);
}else{
tp.setClz(tTbL,_2c.shighlightLft);
tp.setClz(_2e,_2c.shighlightRgt);
}
}else{
if(_2b===true){
tp.setClz(tTbL,_2c.sinactiveLft+" "+_2c.shoverLft);
tp.setClz(_2e,_2c.sinactiveRgt+" "+_2c.shoverRgt);
}else{
tp.setClz(tTbL,_2c.sinactiveLft);
tp.setClz(_2e,_2c.sinactiveRgt);
}
}
}
}});

vjo.needs("vjo.Registry");
vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.darwin.core.pageleveltab.TabProperties").protos({vjElem:null,vjReg:null,mName:null,constructs:function(_1){
vjElem=vjo.dsf.document.Element;
vjReg=vjo.Registry;
var t=this;
var m=_1;
mName=m.htmlName;
t.sHtmlName=m.htmlName;
t.iId=m.id;
t.bIsAjaxEnabled=m.ajaxEnabled;
t.bIsAjaxDataCachable=m.dataCachable;
t.sUrl=m.ajaxUrl;
t.bIsActive=m.active;
t.bIsHighlighted=m.highlighted;
t.bIsContentPresent=true;
t.sContentElementId=null;
if(t.bIsAjaxEnabled===true){
t.bIsContentPresent=false;
}
if(vjReg.get(t.sHtmlName)!==null){
var _4=vjReg.get(t.sHtmlName).aTabs;
_4[_4.length]=t;
}
this.attachEventListner(m.htmlName);
},attachEventListner:function(_5){
var t=vjo.darwin.core.pageleveltab.TabProperties,fn=function(){
t.init(_5);
};
vjo.dsf.EventDispatcher.addEventListener(window,"load",fn);
}}).props({tLft:"_tab_lft_",tRgt:"_tab_rgt_",tCnt:"_content_",tCurrId:"CurrId",switchToTab:function(_7,_8){
var _9=vjReg.get(_7);
var _a=_9.aTabs;
var _b=vjElem.get(_7+this.tCurrId).value;
var _c=_b-1;
var to=_8-1;
if(_a){
if(_a[to].bIsActive===true){
return;
}
if(_a[to].iId==_8){
vjElem.get(_7+this.tCurrId).value=_8;
if(_b>0){
_a[_c].bIsActive=false;
if(_9.bIsHighlighted===true){
this.setClz(_7+this.tLft+_a[_c].iId,_9.shighlightLft);
this.setClz(_7+this.tRgt+_a[_c].iId,_9.shighlightRgt);
}else{
this.setClz(_7+this.tLft+_a[_c].iId,_9.sinactiveLft);
this.setClz(_7+this.tRgt+_a[_c].iId,_9.sinactiveRgt);
}
this.setClz(_7+this.tCnt+_a[_c].iId,_9.stabcontentOuterOff);
}
_a[to].bIsActive=true;
this.setClz(_7+this.tLft+_a[to].iId,_9.sactiveLft);
this.setClz(_7+this.tRgt+_a[to].iId,_9.sactiveRgt);
this.setClz(_7+this.tCnt+_a[to].iId,_9.stabcontentOuterOn);
}
}
return false;
},setClz:function(_e,_f){
var el;
el=vjElem.get(_e);
if(el){
el.className=_f;
}
},init:function(_11){
var _12=vjReg.get(_11);
var _13=_12.aTabs;
var _14=vjElem.get(_11+this.tCurrId).value;
var to=_14-1;
if(_13){
if(_13[to].bIsActive===true){
return;
}
for(var i=0;i<_13.length;i++){
if(_14==_13[i].iId){
_13[to].bIsActive=true;
this.setClz(_11+this.tLft+_13[i].iId,_12.sactiveLft);
this.setClz(_11+this.tRgt+_13[i].iId,_12.sactiveRgt);
this.setClz(_11+this.tCnt+_13[i].iId,_12.stabcontentOuterOn);
}else{
_13[i].bIsActive=false;
if(_13[i].bIsHighlighted===true){
this.setClz(_11+this.tLft+_13[i].iId,_12.shighlightLft);
this.setClz(_11+this.tRgt+_13[i].iId,_12.shighlightRgt);
}else{
this.setClz(_11+this.tLft+_13[i].iId,_12.sinactiveLft);
this.setClz(_11+this.tRgt+_13[i].iId,_12.sinactiveRgt);
}
this.setClz(_11+this.tCnt+_13[i].iId,_12.stabcontentOuterOff);
}
}
}
},hoverChange:function(_17,_18,_19){
var _1a=vjReg.get(_17);
var _1b=_1a.aTabs;
var to=_18-1;
if(_1b){
if(_1b[to].bIsActive===true){
return;
}
if(_1b[to].bIsHighlighted===true){
if(_19===true){
this.setClz(_17+this.tLft+_1b[to].iId,_1a.shighlightLft+" "+_1a.shoverLft);
this.setClz(_17+this.tRgt+_1b[to].iId,_1a.shighlightRgt+" "+_1a.shoverRgt);
}else{
this.setClz(_17+this.tLft+_1b[to].iId,_1a.shighlightLft);
this.setClz(_17+this.tRgt+_1b[to].iId,_1a.shighlightRgt);
}
}else{
if(_19===true){
this.setClz(_17+this.tLft+_1b[to].iId,_1a.sinactiveLft+" "+_1a.shoverLft);
this.setClz(_17+this.tRgt+_1b[to].iId,_1a.sinactiveRgt+" "+_1a.shoverRgt);
}else{
this.setClz(_17+this.tLft+_1b[to].iId,_1a.sinactiveLft);
this.setClz(_17+this.tRgt+_1b[to].iId,_1a.sinactiveRgt);
}
}
}
}});

vjo.needs("vjo.Registry");
vjo.needs("vjo.dsf.EventDispatcher");
vjo.type("vjo.darwin.core.pageleveltab.PageLevelTab").protos({constructs:function(_1){
var t=this;
var m=_1;
t.sHtmlName=m.htmlName;
t.sactiveRgt=m.activeRgt;
t.sactiveLft=m.activeLft;
t.shighlightLft=m.highlightLft;
t.shighlightRgt=m.highlightRgt;
t.sinactiveLft=m.inactiveLft;
t.sinactiveRgt=m.inactiveRgt;
t.shoverLft=m.hoverLft;
t.shoverRgt=m.hoverRgt;
t.stabcontentOuterOff=m.tabcontentOuterOff;
t.stabcontentOuterOn=m.tabcontentOuterOn;
t.sContentElementId=null;
t.aTabs=new Array();
t.iCurrTab=m.activeTabId;
}}).props({bindEventsInJS:function(_4,_5,_6,_7,_8,_9){
var _a=vjo.Registry;
var _b=vjo.dsf.EventDispatcher;
var _c=vjo.darwin.core.pageleveltab.TabProperties;
var _d="_tab_lft_";
var _e="_tab_rgt_";
if(_8==null){
_8="";
}
if(_7){
_a.put(_4+"_"+_5,new vjo.darwin.core.pageleveltab.PageLevelTabReqHandler(_6,_8,_4,_5));
_b.add(_4+_e+_5,"click",_a.get(_4+"_"+_5));
}else{
if((_8!==null)&&(_8.indexOf("http")!==0)&&(_8!=="#")&&(_8!=="javascript:;")&&(_8!=="javascript:void(0);")){
_b.add(_4+_e+_5,"click",function(_f){
return _c.switchToTab(_4,_5);
});
}
}
_b.add(_4+_e+_5,"mouseover",function(_10){
return _c.hoverChange(_4,_5,true);
});
_b.add(_4+_e+_5,"mouseout",function(_11){
return _c.hoverChange(_4,_5,false);
});
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.Registry");
vjo.needs("vjo.darwin.core.pageleveltab.TabProperties");
vjo.needs("vjo.darwin.core.pageleveltab.PageLevelTab");
vjo.type("vjo.darwin.core.pageleveltab.PageLevelTabReqHandler").satisfies("vjo.dsf.common.IJsHandler").protos({constructs:function(_1,_2,_3,_4){
var t=this;
t.sSvcId=_1;
t.sRequest=_2;
t.sTabName=_3;
t.sTabId=_4;
},handle:function(_6){
var _7=vjo.Registry.get(this.sTabName);
var _8=_7.aTabs;
var to=this.sTabId-1;
if(_8[to].bIsActive===true){
return null;
}
vjo.darwin.core.pageleveltab.TabProperties.switchToTab(this.sTabName,this.sTabId);
if(_8[to].bIsAjaxDataCachable===true&&_8[to].bIsContentPresent===true){
return null;
}else{
_8[to].sContentElementId=_8[to].sHtmlName+"_content_"+_8[to].iId;
var _a=vjo.dsf.document.Element.get(_8[to].sContentElementId);
if(_a){
_a.innerHTML="";
}
var _b=_8[to].sAjaxUrl;
_b="&modTabName="+this.sTabName+"&tabId="+_8[to].iId;
var _c=new vjo.dsf.Message(this.sSvcId);
_c.request=_b;
return _c;
}
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.Registry");
vjo.needs("vjo.darwin.core.pageleveltab.PageLevelTab");
vjo.type("vjo.darwin.core.pageleveltab.PageLevelTabResHandler").satisfies("vjo.dsf.common.IJsResHandler").protos({constructs:function(_1,_2){
var t=this;
t.sSvcId=_1;
t.sModTabName=_2;
},handleResponse:function(_4){
if(!_4.response||_4.response.errors.length>0){
return;
}
var _5=vjo.Registry.get(this.sModTabName);
var _6=_5.aTabs;
var _7=vjo.dsf.document.Element.get(this.sModTabName+"CurrId").value;
var to=_7-1;
var _9=vjo.dsf.document.Element.get(_6[to].sContentElementId);
_9.innerHTML="";
var _a=_4.response.data.content;
_9.innerHTML=_a;
if(_6[to].bIsAjaxDataCachable===true){
_6[to].bIsContentPresent=true;
}
}});

vjo.type("vjo.darwin.core.pulldowndialog.PulldownDialogController").singleton().protos({constructs:function(){
this.aOlps=[];
this.sIsActivated=false;
vjo.dsf.EventDispatcher.addEventListener(document.body,"click",function(){
vjo.darwin.core.pulldowndialog.PulldownDialogController.closeInactiveModalessDialog();
});
},registerModalessDialog:function(_1){
this.aOlps[this.aOlps.length]=_1;
},closeInactiveModalessDialog:function(_2){
for(var i=0;i<this.aOlps.length;i++){
if(_2){
if(_2!=this.aOlps[i]&&this.aOlps[i].bOpened){
this.aOlps[i].disappear();
}
}else{
if(this.aOlps[i].bOpened){
this.aOlps[i].disappear();
}
}
}
}}).inits(function(){
vjo.darwin.core.pulldowndialog.PulldownDialogController=new vjo.darwin.core.pulldowndialog.PulldownDialogController();
});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.ServiceEngine");
vjo.needs("vjo.dsf.utils.Timer");
vjo.needs("vjo.dsf.utils.Handlers");
vjo.needs("vjo.darwin.core.pulldowndialog.PulldownDialogController");
vjo.type("vjo.darwin.core.pulldowndialog.PulldownDialog").protos({constructs:function(_1){
var t=this,m=_1;
t.sOpenServiceName=m.openServiceName;
t.sCloseServiceName=m.closeServiceName;
t.sPostOpenServiceName=m.postOpenServiceName;
t.sPostCloseServiceName=m.postCloseServiceName;
t.sOverlayDivId=m.overlayPanelDivId;
t.bForgive=false;
t.bOpenUp=false;
t.bToggle=false;
t.bOpened=false;
t.oOlp=vjo.dsf.document.Element.get(t.sOverlayDivId);
t.H=vjo.dsf.utils.Handlers;
t.fForgiveHdl=t.H.attachEvt(t.oOlp,"click",t.forgive,t);
if(m.closeWhenClickBody){
t.H.attachSvcReqt(m.retireServiceName,t.retire,t);
}
t.H.attachSvcReqt(m.postCloseServiceName,t.notifyOnClose,t);
vjo.darwin.core.pulldowndialog.PulldownDialogController.registerModalessDialog(t);
},toggle:function(_3,_4){
var _5=vjo.dsf.document.Element.get(this.sOverlayDivId);
if(_5.style.visibility=="visible"){
this.disappear(_3);
this.bToggle=false;
}else{
this.appear(_3,_4);
this.bToggle=true;
}
return false;
},appear:function(_6,_7){
var _8=new vjo.dsf.Message(this.sOpenServiceName);
_8.fSetNotchLocation=this.setNotchLocation;
_8.oSetNotchLocationOverrider=this;
_8.sAnchorId=_7;
if(this.bOpened){
_8.bResetPosition=true;
}
vjo.dsf.ServiceEngine.handleRequest(_8);
var _9=new vjo.dsf.Message(this.sPostOpenServiceName);
_9.clientContext={up:this.bOpenUp};
vjo.dsf.ServiceEngine.handleRequest(_9);
this.bOpened=true;
vjo.darwin.core.pulldowndialog.PulldownDialogController.closeInactiveModalessDialog(this);
return false;
},forgive:function(_a){
this.bForgive=true;
},disappear:function(_b){
var _c=vjo.dsf.document.Element.get(this.sOverlayDivId);
if(_c.style.visibility=="visible"){
if(!this.bForgive){
vjo.dsf.ServiceEngine.handleRequest(new vjo.dsf.Message(this.sCloseServiceName));
this.bOpened=false;
}else{
this.bForgive=false;
}
}
},retire:function(_d){
var _e=vjo.dsf.document.Element.get(this.sOverlayDivId);
if(_e.style.visibility=="visible"){
this.bForgive=false;
return this.disappear();
}
},notifyOnClose:function(_f){
vjo.dsf.ServiceEngine.handleRequest(new vjo.dsf.Message(this.sPostCloseServiceName));
return false;
},setNotchLocation:function(_10,_11,_12,_13){
var _14=vjo.dsf.window.utils.VjWindowUtils;
var _15=_12.offsetWidth,height=_12.offsetHeight,screenWidth=_14.getBrowserWindowWidth(),screenHeight=_14.getBrowserWindowHeight(),aScollLocation=_14.getScrollXY(),px="px";
var _16=_13.x-aScollLocation[0],yLoc=_13.y-aScollLocation[1];
var _17=vjo.dsf.document.Element.get(_11.sAnchorName);
var _18=20,anchorWidth=0,shadowWidth=5;
if(_17){
_18=_17.offsetHeight;
anchorWidth=_17.offsetWidth;
}
if(_11.sHAlgn&&_11.sHAlgn=="right"){
var _19=_13.x-_15-shadowWidth;
if(_19<0){
_19=_13.x-anchorWidth;
}
_12.style.left=_19+px;
}else{
if((_16+_15)<screenWidth||_15>screenWidth){
_12.style.left=_13.x+px;
}else{
_12.style.left=_13.x-_15-shadowWidth+anchorWidth+px;
}
}
if((yLoc+_18+height)<screenHeight||height>screenHeight){
_12.style.top=_13.y+_18+px;
_10.bOpenUp=false;
}else{
if(yLoc>height){
_12.style.top=_13.y-height-shadowWidth+px;
_10.bOpenUp=true;
}else{
_12.style.top=_13.y+_18+px;
_10.bOpenUp=false;
}
}
}});

vjo.type("vjo.darwin.app.myebay.component.customization.CustomizationLayerV2").props({addEntry:function(_1){
if(!window.aUserEditedCheckboxList){
window.aUserEditedCheckboxList=[];
window.aUserEditedSelectList=[];
}
element=document.getElementById(_1);
if(element.type=="checkbox"){
if(typeof (window.aUserEditedCheckboxList[element.id])=="undefined"){
window.aUserEditedCheckboxList[element.id]=element.checked;
}
}else{
if(element.type=="select-one"){
if(!window.aUserEditedSelectList[element.id]){
window.aUserEditedSelectList[element.id]=element.options.selectedIndex;
}
}
}
},restoreDefaults:function(){
var _2;
for(temp in window.aUserEditedCheckboxList){
_2=document.getElementById(temp);
if(_2.type=="checkbox"){
_2.checked=!(window.aUserEditedCheckboxList[temp]);
}
}
for(temp1 in window.aUserEditedSelectList){
_2=document.getElementById(temp1);
if(_2&&_2.type=="select-one"){
_2.selectedIndex=window.aUserEditedSelectList[temp1];
}
}
window.aUserEditedSelectList=[];
window.aUserEditedCheckboxList=[];
},toggleDiv:function(_3,_4){
var _5=document.getElementById(_3);
var _6=document.getElementById(_4);
_5.style.display="";
_6.style.display="none";
},editMenuAction:function(_7,_8,_9,_a,_b){
var _c=document.getElementById(_7+_8);
var _d=document.getElementById(_a);
if((!vjo.dsf.client.Browser.bIE)&&(vjo.dsf.client.Browser.iVer!=3)){
if(_c){
if(_c.style.display==="block"||_c.style.display===""){
if(_7=="BUYING"){
_d.innerHTML=_9+"&nbsp;&nbsp;"+_b;
}else{
if(_7=="SELLING"){
_d.innerHTML=_9+"&nbsp;&nbsp;"+_b;
}else{
_d.innerHTML=_9+"&nbsp;&nbsp;"+_b;
}
}
}
}else{
if(_7=="BUYING"){
_d.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;"+_b;
}else{
if(_7=="SELLING"){
_d.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;"+_b;
}else{
_d.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;"+_b;
}
}
}
}else{
if(_c){
if(_c.style.display==="block"||_c.style.display===""){
if(_7==="BUYING"){
_d.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;"+_b;
}else{
if(_7==="SELLING"){
_d.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;"+_b;
}else{
_d.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;"+_b;
}
}
}
}else{
if(_7==="BUYING"){
_d.innerHTML=_9+"&nbsp;&nbsp;"+_b;
}else{
if(_7==="SELLING"){
_d.innerHTML=_9+"&nbsp;&nbsp;"+_b;
}else{
_d.innerHTML=_9+"&nbsp;&nbsp;"+_b;
}
}
}
}
},toggleView:function(_e,_f){
var _10=document.getElementById(_e);
_10.src=_f;
}});

vjo.type("vjo.darwin.app.myebay.Messages").props({deleteMessages:function(_1,_2,_3){
if(confirm(_2)){
var _4=vjo.dsf.document.Element.get(_3);
_4.action=_4.action+_1;
_4.submit();
}else{
return false;
}
}});

vjo.type("vjo.darwin.app.myebay.Itemdisplayslim").props({showOverlayContent:function(_1,_2,_3,_4){
var _5=document.getElementById(_1);
_5.innerHTML="";
var _6=document.getElementById(_2);
var _7=document.createElement("div");
_7.setAttribute("id","newID");
_7.innerHTML="";
_7.innerHTML=_6.innerHTML;
_5.appendChild(_7);
if(_3){
return vjo.dsf.ServiceEngine.handleRequest(vjo.darwin.core.overlaypanel.VjOverlayPanelEvtHandlers.handleOpenEvent(_4,_3));
}
},highlightImage:function(_8,_9){
var _a=document.getElementById(_8);
_a.className=_9;
},highlightMessage:function(_b,_c,_d,_e){
var _f=document.getElementById(_b);
var _10=document.getElementById(_e);
_f.bgColor=_c;
if(_d!==null&&_10!==null){
_10.src=_d;
_10.style.display="block";
}
return false;
},deHighLightMessage:function(_11,_12,_13){
var _14=document.getElementById(_11);
var _15=document.getElementById(_13);
_14.bgColor=_12;
if(_15!==null){
_15.style.display="none";
}
return false;
},headerDropDown:function(_16,_17){
var _18=document.getElementById(_16);
var _19=document.getElementById(_17);
var c=_18.selectedValue;
_19.innerHTML=_18.value;
},replaceImg:function(_1b,_1c){
var _1d=document.getElementById(_1b);
_1d.src=_1c;
}});

vjo.needs("vjo.dsf.typeextensions.string.TokenReplacement");
vjo.needs("vjo.dsf.typeextensions.string.Comparison");
vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.utils.Object");
vjo.type("vjo.darwin.core.cc.VjCharCounter").protos({constructs:function(_1,_2,_3,_4,_5){
this.maxChars=_2;
this.noCharLeft=_5[2];
this.singleCharLeft=_5[1];
this.multipleCharsLeft=_5[0];
this.id=_3;
this.divId=_4;
this.alreadyCleared=false;
this.updateDiv();
return this;
},checkMax:function(){
var _6=vjo.dsf.document.Element.get(this.id);
var _7=_6.value;
var _8=this.determineLength(_7);
var _9=this.maxChars;
var _a=_9-_8;
if(_8>_9){
var _b=_6.scrollTop;
var i=_9;
if(_6.tagName.toLowerCase().indexOf("textarea")!=-1){
i=i-this.getNoOfCRs(_7);
if(_7.substr(i)!="\r\n"){
i++;
_6.value=_7.substr(0,i-1);
}else{
_6.value=_7.substr(0,i);
}
}
_6.scrollTop=_b;
}
return _a;
},getNoOfCRs:function(v){
var _e=new RegExp("\r\n","g");
var _f=v.match(_e);
var l=0;
if(_f!==null){
var _11=_f.length;
if(_11>=1){
l=_11;
}
return l-1;
}
return l;
},checkLength:function(v){
var _13=0;
var _14=encodeURIComponent(v);
if(_14.indexOf("%")!=-1){
_13=_14.split("%").length-1;
if(_13==0){
_13++;
}
var tmp=_14.length-(_13*3);
_13=_13+tmp;
}else{
_13=_14.length;
}
return _13;
},determineLength:function(v){
if(typeof (v)=="string"){
var _17=new RegExp("\n","g");
var _18=v.match(_17);
var _19=new RegExp("\r\n","g");
var _1a=v.match(_19);
if(_18!=null&&_1a==null){
var l=1;
var _1c=_18.length;
if(_1c>=1){
l=_1c;
}
v=v.replace(_17,"");
l=l+this.checkLength(v);
return l;
}else{
if(_1a!=null){
var l=1;
var _1c=_1a.length;
if(_1c>=1){
l=_1c*2;
}
v=v.replace(_19,"");
l=l+this.checkLength(v);
return l;
}else{
return this.checkLength(v);
}
}
}
return 0;
},updateDiv:function(){
var _1d=vjo.dsf.document.Element.get(this.divId);
var _1e=this.checkMax();
var _1f="";
if(_1e<=0){
_1f=this.noCharLeft;
}else{
if(_1e==1){
_1f=this.singleCharLeft;
}else{
_1f=this.multipleCharsLeft;
}
}
_1d.innerHTML=(_1f.replaceTokensEx("##n##",_1e));
}});

vjo.needs("vjo.dsf.EventDispatcher");
vjo.needs("vjo.Registry");
vjo.needs("vjo.dsf.assembly.VjClientAssembler");
vjo.needs("vjo.dsf.assembly.VjClientAssemblerRequest");
vjo.type("vjo.darwin.app.myebay.UserNote").props({init:function(_1){
var t=this;
t.oMod=_1;
var m=t.oMod;
t.E=vjo.dsf.EventDispatcher;
t.R=vjo.Registry;
t.G=vjo.dsf.document.Element;
E=t.E;
E.add(m.cancelId,"click",t.can,t);
E.add(m.saveId,"click",t.sv,t);
E.add(m.deleteId,"click",t.del,t);
},sn:function(_4,_5,_6,_7,_8){
var t=this,m=t.oMod;
var ol=vjo.Registry.get(m.overLayCmpId);
var id=_6+_7;
var d=t.G.get(id);
t.d=d;
t.itId=_7;
t.or=_5;
t.ss=_4;
t.cntr=_8;
var _d=t.G.get(m.textId);
t.tx=_d.childNodes[0];
var _e=d.innerHTML.replace(/<br>/ig,"\n");
t.tx.value=_e;
if(ol){
if(!ol.bPanelOpen){
ol.openOverlayPanel();
t.tx.focus();
}
}
},can:function(){
this.closePanel();
return false;
},sv:function(){
var t=this;
t.save=true;
t.tx.value=t.tx.value.replace(/^\s*|\s*$/,"");
if(t.tx.value==""){
t.save=false;
}
var _10=t.creUrl(t.save,t);
t.doAjax(_10,t);
return false;
},isSeller:function(c){
return (c==346||c==324);
},isFav:function(c){
return (c==346||c==324||c==323||c==345);
},creUrl:function(d,t){
var _15=t.oMod.baseURL;
if(t.isFav(t.cntr)){
if(!d){
_15+=t.oMod.favDelCmd;
}else{
_15+=t.oMod.favSaveCmd;
}
}else{
if(!d){
_15+=t.oMod.delCmd;
}else{
_15+=t.oMod.saveCmd;
}
}
_15=_15+"&LineID="+t.itId+"&Note="+escape(t.tx.value)+"&ssPageName="+t.ss;
if(t.isSeller(t.cntr)){
_15=_15+"&isSellerNote=true";
}
_15=t.addRandomParam(_15);
return _15;
},procResp:function(_16){
if(_16){
var t=this;
if(_16.success){
if(t.save){
var txt=t.tx.value.replace(/\n/g,"<br>");
t.d.innerHTML=txt;
if(!t.isFav(t.cntr)){
t.d.style.display="block";
if(vjo.dsf.client.Browser.bIE){
t.d.parentNode.parentNode.style.display="block";
}else{
t.d.parentNode.parentNode.style.display="table-row";
}
if(!t.or){
for(i=0;i<t.d.parentNode.parentNode.previousSibling.childNodes.length;i++){
var _19=t.d.parentNode.parentNode.previousSibling.childNodes[i].className;
var ns=_19.replace(/dtbl-rowSeptr/,"");
t.d.parentNode.parentNode.previousSibling.childNodes[i].className=ns;
}
}
}else{
var _1b="nn2tr."+t.cntr+t.itId;
var _1c=t.G.get(_1b);
if(vjo.dsf.client.Browser.bIE){
_1c.style.display="block";
}else{
_1c.style.display="table-row";
}
}
}else{
t.d.innerHTML="";
if(!t.isFav(t.cntr)){
t.d.parentNode.parentNode.style.display="none";
if(!t.or){
for(i=0;i<t.d.parentNode.parentNode.previousSibling.childNodes.length;i++){
t.d.parentNode.parentNode.previousSibling.childNodes[i].className=t.d.parentNode.parentNode.previousSibling.childNodes[i].className+" dtbl-rowSeptr";
}
}
}else{
var _1d="nn2tr."+t.cntr+t.itId;
var _1e=t.G.get(_1d);
_1e.style.display="none";
}
}
}else{
alert(t.oMod.errorMsg);
}
t.closePanel();
}
},del:function(){
var t=this;
t.save=false;
var _20=t.creUrl(t.save,t);
t.doAjax(_20,t);
return false;
},doAjax:function(url,t){
var req=new vjo.dsf.assembly.VjClientAssemblerRequest(url,t.procResp,t,"callback");
vjo.dsf.assembly.VjClientAssembler.load(req);
},addRandomParam:function(url){
url+=(url.indexOf("?")>0?"&":"?")+"rand="+Math.random();
return url;
},closePanel:function(){
var t=this,m=t.oMod,ol=t.R.get(m.overLayCmpId);
if(ol){
if(ol.bPanelOpen){
ol.closePanel();
}
}
}});

vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.darwin.core.overlaypanel.autosize.AutoSizeContentWrapper").props({autoSizeOverlay:function(_1,_2,_3,_4,_5,_6){
var E=vjo.dsf.document.Element,oOlp=E.get(_1),oOlpN=E.get(_2),oOlpJsRef=vjo.Registry.get(_3),oCntnt=E.get(_4),max=oOlpN?oOlpN.offsetWidth:0;
max=this.getMax(oCntnt,max,true,(_5+_6));
if(oOlp&&oOlpJsRef&&max>oOlpN.offsetWidth){
this.adjust(oOlp,oOlpJsRef,max);
}
},adjust:function(_8,_9,_a){
_8.style.width=(_a+4)+"px";
_9.render();
},getMax:function(_b,_c,_d,_e){
var t=this,n=_b,m=_c;
m=t.pad(n.offsetWidth,_e)>m?t.pad(n.offsetWidth,_e):m;
if(n.childNodes.length<=0){
return m;
}
if(_d){
m=t.getChildMax(n,"img",m,_e);
}
m=t.getChildMax(n,"div",m,_e);
m=t.getChildMax(n,"table",m,_e);
return m;
},pad:function(val,_11){
return val+_11;
},getChildMax:function(_12,_13,max,_15){
var t=this,i=0,blocks=_12.getElementsByTagName(_13);
for(;i<blocks.length;++i){
max=(t.pad(blocks[i].offsetWidth,_15)>max)?t.pad(blocks[i].offsetWidth,_15):max;
}
return max;
}});

vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.needs("vjo.dsf.typeextensions.string.TokenReplacement");
vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.darwin.core.ebayheader.rebate.Rebate").props({Refresh:function(_1,_2,_3){
var D=vjo.dsf.document;
var E=D.Element;
var _6=E.get(_1);
if(_6){
if(this.IsShowMagicRebate(_6,_2)){
E.toggleHideShow(_1,true);
}else{
if(this.IsShowVibrantCoupon()){
var _7=_6.getElementsByTagName("span")[0];
if(_7){
_7.innerHTML=_3;
E.toggleHideShow(_1,true);
}
}
}
}
},IsShowVibrantCoupon:function(){
var _8=vjo.dsf.cookie.VjCookieJar.readCookie("ebay","sbf");
if(_8){
return vjo.dsf.cookie.VjCookieJar.getBitFlag(_8,29)==1;
}
},IsShowMagicRebate:function(_9,_a){
var _b=_9.getElementsByTagName("img")[0],rate=vjo.dsf.cookie.VjCookieJar.readCookie("npii","mri"),perc;
if(this.IsExpired()){
return false;
}
if(!rate){
return false;
}
perc=this.GetRate(rate);
if(perc){
perc=this.IsValidRate(perc);
}
if(perc!==null&&_b){
_b.src=_b.src.replaceToken(_b.src,_a,perc);
return true;
}else{
return false;
}
},IsExpired:function(){
var _c=new Date().getTime();
var _d=this.getClientOffset(_c);
var _e=vjo.dsf.cookie.VjCookieJar.readCookieObj("npii","mri");
if(_e!==null){
var _f=parseInt(_e.maxage,16)*1000;
if(_f>0){
var _10=_f-_c+_d;
if(_10<0){
return true;
}
}
}
return false;
},getClientOffset:function(_11){
var _12;
var _13=vjo.dsf.cookie.VjCookieJar.readCookie("ebay","cos");
if(_13!==null&&_13.length>0){
_12=parseInt(_13,16)*1000;
}else{
_12=3600000;
}
return _12;
},IsValidRate:function(_14){
var R=parseInt(_14,10);
return (R>0&&R<100)?R:null;
},GetRate:function(cv){
var ar=cv.split(":");
return ar.length>3?ar[2]:null;
}});

vjo.needs("vjo.dsf.Enc");
vjo.type("vjo.dsf.utils.UriBuilder").props({meta:function(_1,_2){
var _3=document.getElementsByTagName("meta");
for(var _4=0;(_4<_3.length);_4++){
if(_3[_4].getAttribute(_1)==_2){
return _3[_4];
}
}
return null;
}}).protos({constructs:function(_5,_6){
this.parse(_5,_6);
},parse:function(_7,_8){
this.uri=_7;
this.params=new Object();
var _9=this.uri.match("(([^:]*)://([^:/?]*)(:([0-9]+))?)?([^?#]*)([?]([^#]*))?(#(.*))?");
if(_9==null){
return;
}
this.protocol=this.match(_9,2);
this.host=this.match(_9,3);
this.port=this.match(_9,5);
this.href=this.match(_9,6);
this.query=this.match(_9,8);
if(_8){
this.decodeSeo();
}
if(this.href.match(/eBayISAPI.dll/i)){
this.parseIsapi(this.query);
}else{
this.parseQuery(this.query);
}
this.href=this.decodeUri(this.href);
this.hash=this.match(_9,10);
},match:function(_a,_b){
return ((_a.length>_b)&&_a[_b])?_a[_b]:"";
},parseQuery:function(_c){
this.decodeParams(_c);
},parseIsapi:function(_d){
var _e=(_d)?_d.split("&"):new Array();
this.isapi=_e.shift();
this.query=_e.join("&");
this.decodeParams(this.query);
},appendParam:function(_f,_10,_11){
_11=(_11)?_11:this.params;
if(_11[_f]==null){
_11[_f]=_10;
}else{
if(typeof (_11[_f])=="object"){
_11[_f].push(_10);
}else{
_11[_f]=new Array(_11[_f],_10);
}
}
},appendParams:function(_12){
for(var _13 in _12){
var _14=_12[_13];
if(typeof (_14)!="object"){
this.appendParam(_13,_14);
}else{
for(var idx=0;(idx<_14.length);idx++){
this.appendParam(_13,_14[idx]);
}
}
}
},decodeParams:function(_16){
var _17=(_16)?_16.split("&"):new Array();
for(var idx=0;(idx<_17.length);idx++){
var _19=_17[idx].split("="),name=this.decodeParam(_19[0]);
var _1a=(_19.length>1)?this.decodeParam(_19[1].replace(/\+/g,"%20")):"";
this.appendParam(name,_1a);
}
},encodeParams:function(_1b){
var _1c=new Array();
var _1b=(_1b)?_1b:this.params;
for(var _1d in _1b){
if(typeof (_1b[_1d])!="object"){
_1c.push(this.encodeParam(_1d).concat("=",this.encodeParam(_1b[_1d])));
}else{
for(var idx=0;(idx<_1b[_1d].length);idx++){
_1c.push(this.encodeParam(_1d).concat("=",this.encodeParam(_1b[_1d][idx])));
}
}
}
return _1c.join("&");
},decodeSeo:function(){
var _1f=this.href.match(/(.*)_W0QQ(.*)/);
if(_1f==null){
return;
}
this.href=_1f[1].replace(/Q([0-9a-fA-F][0-9a-fA-F])/g,"%$1");
var _20=_1f[2].split("QQ");
for(var idx=0;(idx<_20.length);idx++){
var _22=_20[idx].split("Z");
var _23=this.decodeParam(_22[0].replace(/Q([0-9a-fA-F][0-9a-fA-F])/g,"%$1"));
var _24=(_22.length>1)?this.decodeParam(_22[1].replace(/Q([0-9a-fA-F][0-9a-fA-F])/g,"%$1")):"";
this.appendParam(_23,_24);
}
},decodeForm:function(_25){
var _26=new Object();
var _27=_25.elements;
for(var idx=0;(idx<_27.length);idx++){
var _29=_27[idx];
if(_29.disabled){
continue;
}
var _2a=_29.type,name=_29.name;
value=_29.value;
if(_2a.match(/text|hidden|textarea|password|file/)){
this.appendParam(name,value,_26);
}else{
if(_2a.match(/radio|checkbox/)&&_29.checked){
this.appendParam(name,value,_26);
}else{
if(_2a.match(/select-one|select-multiple/)){
this.appendSelect(_29,_26);
}
}
}
}
return _26;
},appendSelect:function(_2b,_2c){
var _2d=_2b.options;
for(var idx=0;(idx<_2d.length);idx++){
if(_2d[idx].selected){
this.appendParam(_2b.name,_2d[idx].value,_2c);
}
}
},getUri:function(){
var uri=(this.protocol)?this.protocol.concat("://"):"";
if(this.host){
uri=uri.concat(this.host);
}
if(this.port){
uri=uri.concat(":",this.port);
}
if(this.href){
uri=uri.concat(this.encodeUri(this.href));
}
if(this.isapi){
uri=uri.concat("?",this.isapi);
}
var _30=this.encodeParams(this.params);
if(_30){
uri=uri.concat(this.isapi?"&":"?",_30);
}
if(this.hash){
uri=uri.concat("#",this.hash);
}
return this.uri=uri;
}}).inits(function(){
var _31=(navigator.userAgent.indexOf("MSIE")>=0);
var _32=vjo.dsf.utils.UriBuilder.meta(_31?"httpEquiv":"http-equiv","Content-Type");
var _33=(_32)?_32.getAttribute("content"):null;
this.prototype.encodeUri=(_33&&_33.match(/utf/gi))?vjo.dsf.Enc.encodeURI:window.escape;
this.prototype.decodeUri=(_33&&_33.match(/utf/gi))?vjo.dsf.Enc.decodeURI:window.unescape;
this.prototype.encodeParam=(_33&&_33.match(/utf/gi))?vjo.dsf.Enc.encodeURIComponent:window.escape;
this.prototype.decodeParam=(_33&&_33.match(/utf/gi))?vjo.dsf.Enc.decodeURIComponent:window.unescape;
});

vjo.needs("vjo.dsf.Enc");
vjo.needs("vjo.dsf.ServiceEngine");
vjo.needs("vjo.dsf.EventDispatcher");
vjo.needs("vjo.dsf.utils.UriBuilder");
vjo.type("vjo.dsf.utils.HistoryManager").protos({URIBuilder:vjo.dsf.utils.UriBuilder,EventDispatcher:vjo.dsf.EventDispatcher,constructs:function(_1){
var _2=this;
this.model=_1;
this.modules=new Object();
this.href=new this.URIBuilder(document.location.href);
if(navigator.userAgent.indexOf("MSIE")>-1){
this.iframe=document.getElementById(this.model.frameId);
if(!this.iframe.contentWindow.document.body.innerText){
this.pushFrame(this.href.hash);
}
this.EventDispatcher.addEventListener(this.iframe,"load",function(_3){
return _2.onFrameLoad(_3);
});
}
this.EventDispatcher.addEventListener(window,"load",function(_4){
return _2.onLoad(_4);
});
this.EventDispatcher.addEventListener(window,"unload",function(_5){
return _2.onUnload(_5);
});
},onLoad:function(_6){
var _7=this;
this.states=new Object();
this.onHistoryChange(this.href.hash);
this.ticker=window.setInterval(function(){
_7.onTicker();
},50);
},onUnload:function(_8){
this.iframe=null;
},onTicker:function(){
var _9=this.getHash();
if(_9!=this.href.hash){
this.onHistoryChange(_9);
}
},getHash:function(){
return document.location.hash.match("(#)?(.*)")[2];
},pushFrame:function(_a,_b){
this.href.hash=_a;
_b=((_b)?_b:document.title);
_b=((_b)?_b.replace(/"/g,"\\\""):this.href.getUri());
var _c="<scr"+"ipt type=\"text/javascript\">";
_c+="document.title = \""+_b+"\";";
_c+="document.write(\""+this.href.getUri()+"\");";
_c+="</scr"+"ipt>";
var _d=this.iframe.contentWindow.document;
_d.open();
_d.write(_c);
_d.close();
},onFrameLoad:function(_e){
var _f=new this.URIBuilder(this.iframe.contentWindow.document.body.innerText);
if(_f.hash!=this.href.hash){
this.onHistoryChange(document.location.hash=_f.hash);
}
},serialize:function(_10){
try{
return JSON.stringify(_10);
}
catch(except){
return "";
}
},deserialize:function(_11){
try{
return (_11)?eval("("+_11+")"):new Object();
}
catch(except){
return new Object();
}
},putState:function(key,_13){
this.states[key]=this.deserialize(this.serialize(_13));
},getState:function(key){
return this.states[key];
},pushHistory:function(_15,_16,_17){
this.modules[_15]=_16;
var _18=vjo.dsf.Enc.encodeURIComponent(this.serialize(this.modules));
if(_18==this.href.hash){
return;
}
window.location.hash=_18;
if(this.iframe){
this.pushFrame(_18,_17);
}
},onHistoryChange:function(_19){
this.href.hash=_19;
var _1a=new vjo.dsf.Message("HISTORY_CHANGE");
_1a.state=this.deserialize(vjo.dsf.Enc.decodeURIComponent(this.href.hash));
vjo.dsf.ServiceEngine.handleRequest(_1a);
}});

vjo.needs("vjo.dsf.client.Browser");
vjo.type("vjo.darwin.core.ebayheader.searchbox.SearchBox").props({Focus:function(_1){
var _2=vjo.dsf.document.Element.get(_1);
if(typeof (_2)!="undefined"&&_2){
_2.focus();
}
},IeOptionDisabler:function(_3){
if(vjo.dsf.client.Browser.bIE){
var sl=vjo.dsf.document.Element.get(_3);
if(sl){
var _5;
sl.onchange=function(){
_5=this.selectedIndex=(this.options[this.selectedIndex].disabled)?_5:this.selectedIndex;
};
sl.onfocus=function(){
_5=this.selectedIndex;
};
this.greydisabledoption(sl);
}
}
},greydisabledoption:function(e){
var i,op;
for(i=0;i<e.options.length;i++){
op=e.options[i];
if(op.disabled){
op.style.color="graytext";
}
}
}});

vjo.needs("vjo.dsf.utils.Object");
vjo.needs("vjo.dsf.Message");
vjo.type("vjo.darwin.core.roundedcornerpanel3.VjRoundedCornerPanel3Message").inherits("vjo.dsf.Message").protos({constructs:function(_1,_2){
this.base.call(this,_1);
this.request={};
this.sElemId=_2;
this.response={};
this.changeType="";
this.cssClz="";
this.secindx=0;
},setElemId:function(_3){
this.sElemId=_3;
},getElemId:function(){
return this.sElemId;
}});

vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.darwin.core.roundedcornerpanel3.VjRoundedCornerPanel3Message");
vjo.type("vjo.darwin.core.roundedcornerpanel3.VjRoundedCornerPanel3EvtHandlers").props({handleHeaderChange:function(_1,_2,_3){
var _4=new vjo.darwin.core.roundedcornerpanel3.VjRoundedCornerPanel3Message(_1,_2);
_4.changeType="HEADER_CHANGE";
_4.cssClz=_3;
return _4;
},handleFooterChange:function(_5,_6,_7){
var _8=new vjo.darwin.core.roundedcornerpanel3.VjRoundedCornerPanel3Message(_5,_6);
_8.changeType="FOOTER_CHANGE";
_8.cssClz=_7;
return _8;
},handleShowHideContent:function(_9,_a){
var _b=new vjo.darwin.core.roundedcornerpanel3.VjRoundedCornerPanel3Message(_9,_a);
_b.changeType="SHOW_HIDE_CONTENT";
return _b;
}});

vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.darwin.core.roundedcornerpanel3.VjRoundedCornerPanel3SvcHandler").protos({constructs:function(_1){
this.sRoundedCornerPanel3JsCompId=_1;
},invoke:function(_2){
var _e=vjo.dsf.document.Element;
if(_2.changeType==="HEADER_CHANGE"){
var _4=_e.get(_2.sElemId+"_t");
var _5=_e.get(_2.sElemId+"_h");
_5.className=_2.cssClz;
_4.className=_2.cssClz;
this.setBorderToAnchor(_2.sElemId,_2.cssClz);
}else{
if(_2.changeType==="FOOTER_CHANGE"){
var _6=_e.get(_2.sElemId+"_f");
var _7=_e.get(_2.sElemId+"_b");
var _8=_7.className;
_6.className=_2.cssClz;
if(_8.indexOf("c-sgf")>-1){
_7.className=_2.cssClz;
}else{
_7.className=_8+" "+_2.cssClz;
}
}else{
if(_2.changeType==="SHOW_HIDE_CONTENT"){
var _9=_e.get(_2.sElemId+"_c");
var _a=_e.get(_2.sElemId);
var _b=_e.get(_2.sElemId+"_t");
var _c=_e.get(_2.sElemId+"_h");
var _d=_a.className;
if(_9.style.display=="none"){
_9.style.display="";
if(_d.indexOf("c-sgfx")>-1){
_d=_d.replace("c-sgfx","");
}
}else{
_9.style.display="none";
_d+=" c-sgfx";
}
_a.className=_d;
}
}
}
},setBorderToAnchor:function(_e,_f){
var _e=vjo.dsf.document.Element;
var _11=_e.get(_e+"_c-gr");
var _12=_e.get(_e+"_c-bl");
var _13=_e.get(_e+"_c-rd");
var _14=_e.get(_e+"_c-yl");
var _15=_e.get(_e+"_c-gy");
if(_11!==null){
if(_f==="c-gr"){
_11.className="r3-gr-bdr";
}else{
_11.className="";
}
}
if(_12!==null){
if(_f==="c-bl"){
_12.className="r3-bl-bdr";
}else{
_12.className="";
}
}
if(_13!==null){
if(_f==="c-rd"){
_13.className="r3-rd-bdr";
}else{
_13.className="";
}
}
if(_14!==null){
if(_f==="c-yl"){
_14.className="r3-yl-bdr";
}else{
_14.className="";
}
}
if(_15!==null){
if(_f==="c-gy"){
_15.className="r3-gy-bdr";
}else{
_15.className="";
}
}
}});

vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.type("vjo.dsf.utils.Bit").props({CJ:vjo.dsf.cookie.VjCookieJar,getMulti:function(_1,_2,_3){
var r="",i,CJ=this.CJ;
for(i=0;i<_3;i++){
r=CJ.getBitFlag(_1,_2+i)+r;
}
return parseInt(r,2);
},setMulti:function(_5,_6,_7,_8){
var i=0,CJ=this.CJ,v,l,e;
v=_8.toString(2).substring(0,_7);
l=v.length;
if(l<_7){
e=_7-l;
for(j=0;j<e;j++){
v="0"+v;
}
l=l+e;
}
for(i=0;i<l;i++){
_5=CJ.setBitFlag(_5,_6+i,v.substring(l-i-1,l-i));
}
return _5;
}});

vjo.needs("vjo.dsf.EventDispatcher");
vjo.needs("vjo.dsf.assembly.VjClientAssembler");
vjo.needs("vjo.dsf.assembly.VjClientAssemblerRequest");
vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.needs("vjo.dsf.utils.Bit");
vjo.type("vjo.darwin.app.myebay.Resizer").props({init:function(dm,rs){
var t=this;
t.E=vjo.dsf.EventDispatcher;
t.G=vjo.dsf.document.Element;
t.res=screen.width;
t.pgW=dm.pgW;
t.caW=dm.caW;
t.dm=dm;
if(rs==0||rs!=t.res){
rs=screen.width;
var _4=rs+"x"+screen.height;
cook=dm.szEnum[_4];
if(cook==undefined){
cook="2";
}
t.wc(cook,dm);
}
t.setwths(rs);
t.diff=t.PgMinWth-t.ItemMinWth;
t.oPg=t.G.get(dm.pgID);
t.oCa=t.G.get(dm.caID);
t.curWth=0;
this.resizeHandler();
t.E.addEventListener(window,"resize",t.resizeHandler,t);
},setwths:function(rs){
t=this;
if(t.dm.szMap[rs]!=undefined){
t.PgMinWth=t.dm.szMap[rs].pgMin;
t.ItemMinWth=t.dm.szMap[rs].caMin;
}else{
t.PgMinWth=t.dm.szMap[1024].pgMin;
t.ItemMinWth=t.dm.szMap[1024].caMin;
}
},wc:function(_6,dm){
t=this;
var CJ,pbf,BIT,nVal;
CJ=vjo.dsf.cookie.VjCookieJar;
BIT=vjo.dsf.utils.Bit;
pbf=CJ.readCookie(dm.cookieName,dm.cookieletName);
nVal=parseInt(_6,10);
pbf=BIT.setMulti(pbf,dm.cookieBitPosition,dm.cookieNumBits,nVal);
CJ.writeCookielet(dm.cookieName,dm.cookieletName,pbf);
},resizeHandler:function(){
var t=this;
t.res=screen.width;
t.setwths(t.res);
dbcW=t.getCWidth();
if(dbcW!=t.curWth){
t.curWth=dbcW;
var _a=dbcW-t.res;
t.curWth=t.PgMinWth+_a;
if(t.curWth<t.pgW){
t.curWth=t.pgW;
}
t.setWidth(t.oPg,t.curWth);
t.setWidth(t.oCa,t.curWth-t.diff);
}
},setWidth:function(_b,w){
_b.style.width=w+"px";
},getCWidth:function(){
var w=0;
var _e="";
if(typeof (window.innerWidth)=="number"){
w=window.innerWidth;
}else{
if(document.documentElement&&(document.documentElement.clientWidth||document.documentElement.clientHeight)){
w=document.documentElement.clientWidth;
w+=20;
}else{
if(document.body&&(document.body.clientWidth||document.body.clientHeight)){
w=document.body.clientWidth;
}
}
}
return w;
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.ServiceEngine");
vjo.needs("vjo.dsf.document.Positioning");
vjo.needs("vjo.dsf.EventDispatcher");
vjo.type("vjo.darwin.core.bubble2.Bubble2").protos({constructs:function(_1){
this.sOpenServiceName=_1.openServiceName;
this.sCloseServiceName=_1.closeServiceName;
this.sOverlayPanelId=_1.overlayPanelDivId;
this.sOverlayPanelJsId=_1.overlayPanelJsId;
},openBubble2:function(_2,_3,_4){
var _5=new vjo.dsf.Message(this.sOpenServiceName);
_5.fSetNotchLocation=this.setNotchLocation;
_5.oSetNotchLocationOverrider=this;
_5.sAnchorId=_3;
_5.bOver=_4||false;
vjo.dsf.ServiceEngine.handleRequest(_5);
},closeBubble2:function(){
var _6=new vjo.darwin.core.overlaypanel.VjOverlayPanelMessage(this.sCloseServiceName);
_6.bCheckState=true;
vjo.dsf.ServiceEngine.handleRequest(_6);
return false;
},setNotchLocation:function(_7,_8,_9,_a){
var _b=vjo.dsf.window.utils.VjWindowUtils;
var _c=_9.offsetWidth;
var _d=_9.offsetHeight;
var _e=_b.getBrowserWindowWidth();
var _f=_b.getBrowserWindowHeight();
var _10=_b.getScrollXY();
var px="px";
var _12=vjo.dsf.document.Element.get(this.sOverlayDivId+"olparrow");
var _13=_a.x-_10[0];
var _14=_a.y-_10[1];
var _15=vjo.dsf.document.Element.get(this.sAnchorName);
var _16=_15.getElementsByTagName("img")[0];
var _17=vjo.dsf.document.Positioning.getOffsetLeft(_16);
_17-=_7.computeMarginAndBorder(_16,"left");
var _18=vjo.dsf.document.Positioning.getOffsetTop(_16);
var ox=_16.clientWidth/2;
var oy=_16.clientHeight/2;
var _1b=20;
if(_15){
_1b=_15.offsetHeight;
}
var _1c=0,arrowWidth=0,arrowSpace=0;
if(_12){
_1c=15;
arrowWidth=16;
arrowSpace=12;
}
if(_13>(_e-_c)&&_14<_d&&_14<(_f-_d)){
_9.style.left=_17-_c+ox+arrowWidth+px;
_9.style.top=_18+_1c+oy+px;
_12.className=this.sArrowTR;
}else{
if((_13<_c||_13<_e-_c)&&_14<_d){
_9.style.left=_17+ox-arrowSpace+px;
_9.style.top=_18+_1c+oy+px;
_12.className=this.sArrowTL;
}else{
if(_13>(_e-_c)&&_14>_d){
var B=vjo.dsf.client.Browser;
if(B.bIE&&B.fVer<7){
_9.style.left=_17-_c+ox+arrowWidth+2+px;
}else{
_9.style.left=_17-_c+ox+arrowWidth+px;
}
_9.style.top=_18-_d-_1c+oy+px;
_12.className=this.sArrowBR;
}else{
_9.style.left=_17+ox-arrowSpace+px;
_9.style.top=_18-_d-_1c+oy+px;
_12.className=this.sArrowBL;
}
}
}
},computeMarginAndBorder:function(_1e,_1f){
var _20=0,e=_1e,t=_1f,border=0;
var B=vjo.dsf.client.Browser;
if(B.bIE&&B.fVer<7){
while(e){
if(e.id!=""){
var par=e;
if(t=="left"){
if(par.currentStyle.marginLeft){
var _23=par.currentStyle.marginLeft;
if(_23!="auto"){
_20+=parseInt(_23.substr(0,_23.length-2));
}
}
if(par.currentStyle.borderLeftWidth){
var _24=par.currentStyle.borderLeftWidth;
if(_24!="medium"&&_24!="thin"&&_24!="thick"){
border+=parseInt(_24.substr(0,_24.length-2));
}
}
}else{
if(t=="top"){
if(par.currentStyle.marginTop){
var _25=par.currentStyle.marginTop;
if(_25!="auto"){
_20+=parseInt(_25.substr(0,_25.length-2));
}
}
if(par.currentStyle.borderTopWidth){
var _26=par.currentStyle.borderTopWidth;
if(_26!="medium"&&_26!="thin"&&_26!="thick"){
border+=parseInt(_26.substr(0,_26.length-2));
}
}
}
}
}
e=e.offsetParent;
}
}
return _20+border;
}});

vjo.type("vjo.darwin.app.myebay.DivOverlay").props({currentOverlay:null,oShim:null,show:function(_1){
vjo.darwin.app.myebay.DivOverlay.removeShim(_1);
vjo.darwin.app.myebay.DivOverlay.closeCurrentOverlay();
var _2=document.getElementById(_1);
if(_2){
var _3=new vjo.dsf.Message("MASK_OPEN_SERVICE");
vjo.dsf.ServiceEngine.handleRequest(_3);
var s=_2.style;
var _5=vjo.darwin.app.myebay.DivOverlay.getPositioning(_2,"CENTERED");
s.top=_5[0]+"px";
s.left=_5[1]+"px";
vjo.darwin.app.myebay.DivOverlay.addShim(_1);
_2.style.visibility="visible";
_2.style.display="";
_2.style.zIndex=1000;
}
vjo.darwin.app.myebay.DivOverlay.currentOverlay=_2;
return false;
},hide:function(_6){
var _7=document.getElementById(_6);
if(_7){
vjo.dsf.ServiceEngine.handleRequest(new vjo.dsf.Message("MASK_CLOSE_SERVICE"));
_7.style.visibility="hidden";
_7.style.display="none";
}
vjo.darwin.app.myebay.DivOverlay.currentOverlay=null;
return false;
},removeShim:function(_8){
if(vjo.darwin.app.myebay.DivOverlay.oShim){
var l=document.getElementById(_8);
vjo.dsf.document.Shim.remove(l,vjo.darwin.app.myebay.DivOverlay.oShim);
}
},addShim:function(_a){
var l=document.getElementById(_a);
vjo.darwin.app.myebay.DivOverlay.oShim=vjo.dsf.document.Shim.add(l);
},closeCurrentOverlay:function(){
},getPositioning:function(_c,_d){
var P=vjo.dsf.document.Positioning;
var _f=P.getOffsetTop(_c.offsetParent);
var s=_c.style;
var t=0,l=0;
if(_d=="CENTERED"){
var _12=(P.getClientHeight()-_c.offsetHeight)/2;
var _13=(P.getClientWidth()-_c.offsetWidth)/2;
t=Math.round(_12)-_f;
l=Math.round(_13)-_f;
}else{
if(_d=="MOUSE"){
t=window.mouseY-_f-30;
l=window.mouseX-_f-30;
}else{
t=_c.top-_f;
l=_c.left-_f;
}
}
var _14=P.getScrollLeftTop();
if(parseInt(t)+_c.offsetHeight+_f>_14[1]+P.getClientHeight()){
t=_14[1]+P.getClientHeight()-_c.offsetHeight-_f-30;
}
if(parseInt(t)+_f<_14[1]){
t=_14[1]-_f;
}
return [t,l];
}});

vjo.needs("vjo.darwin.app.myebay.animation.Animation");
vjo.type("vjo.darwin.app.myebay.component.editcomponent.CustomizeModule").protos({constructs:function(_1){
var c=_1;
this.currentRCPStr=c.rcpid;
this.toggleLinkId=c.collpaseStr;
this.sExpandImgSrc=c.expandImgSrc;
this.sCollapseImgSrc=c.collapseImgSrc;
this.sExpandText=c.expandText;
this.sExpandURL=c.expandUrl;
this.sCurrentPageNo=c.currentPage;
this.sCollapseText=c.collapseText;
this.sDeleteId=c.deleteModuleId;
this.currentContentStr=c.contentDivId;
this.deleteStr=c.delMsgId;
this.sWelcomeChkbxId=c.welcomeChkbxId;
this.sSSPageName=c.SSPageName;
this.sErrorDivid=c.errorDivid;
this.aDeleteStatusId=c.deleteStatusId;
this.centralModules=c.centralModules;
this.leftModules=c.leftModules;
this.hasSliding=c.hasSliding;
this.editMoveUpId="editmenu_##1_MOVEUP";
this.editMoveDownId="editmenu_##1_MOVEDOWN";
this.animateJS=vjo.Registry.get(c.animateJsId);
this.E=vjo.dsf.document.Element.get;
if(this.centralModules){
this.setPosition(this.centralModules);
}
if(this.leftModules){
this.setPosition(this.leftModules);
}
},setPosition:function(_3){
for(i=0;i<_3.length;i++){
var _4=this.E(this.sDeleteId+_3[i]);
if(_4){
_4.iPstn=i;
_4.iInd=_3[i];
if(i===0){
sId=this.editMoveUpId.replace("##1",parseInt(_3[i],10));
var _5=this.E(sId);
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.setDisabled(_5);
}
if(i==(_3.length-1)){
sId=this.editMoveDownId.replace("##1",parseInt(_3[i],10));
var _6=this.E(sId);
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.setDisabled(_6);
}
}
}
},HideErroDivId:function(_7){
if(_7){
for(i=0;i<_7.length;i++){
var _8=document.getElementById(_7[i]);
if(_8){
if(_8.style.display===""||_8.style.display==="block"){
_8.style.display="none";
}
}
}
}
},HideDeleteStatusDivId:function(_9){
if(_9){
for(i=0;i<_9.length;i++){
var _a=document.getElementById(_9[i]);
if(_a){
if(_a.style.display==="block"||_a.style.visibility=="visible"){
_a.style.display="none";
if(_a.parentNode.parentNode){
_a.parentNode.parentNode.style.display="none";
}
}
}
}
}
},swapContainers:function(){
if(typeof (this.prevElem.bMoved)=="undefined"){
this.prevElem.bMoved=false;
}
if(typeof (this.currentElem.bMoved)=="undefined"){
this.currentElem.bMoved=false;
}
this.prevElemHeight=0;
this.curElemHeight=0;
this.currentElem.style.position="relative";
this.prevElem.style.position="relative";
if(!this.currentElem.bMoved){
this.prevElemHeight=-(parseInt(this.prevElem.offsetHeight,10));
this.slideUp();
}else{
this.prevElemHeight=(parseInt(this.currentElem.style.top,10)-(parseInt(this.prevElem.offsetHeight,10)));
this.slideUp();
}
if(!this.prevElem.bMoved){
this.curElemHeight=(parseInt(this.currentElem.offsetHeight,10));
this.slideDown();
}else{
this.curElemHeight=(parseInt(this.prevElem.style.top,10)+parseInt(this.currentElem.offsetHeight,10));
this.slideDown();
}
this.prevElem.bMoved=true;
this.currentElem.bMoved=true;
},slideUp:function(){
if(!this.currentElem.style.top){
this.currentElem.style.top="-8px";
}
if(this.hasSliding&&parseInt(this.currentElem.style.top,10)>=(this.prevElemHeight)){
this.currentElem.style.top=(parseInt(this.currentElem.style.top,10)-8)+"px";
setTimeout(vjo.dsf.utils.Object.hitch(this,"slideUp"),0);
}else{
this.currentElem.style.top=this.prevElemHeight+"px";
}
this.currentElem.style.top=(parseInt(this.currentElem.style.top,10)-15)+"px";
},slideDown:function(){
if(!this.prevElem.style.top){
this.prevElem.style.top="0px";
}
if(this.hasSliding&&parseInt(this.prevElem.style.top,10)<=this.curElemHeight){
this.prevElem.style.top=(parseInt(this.prevElem.style.top,10)+8)+"px";
setTimeout(vjo.dsf.utils.Object.hitch(this,"slideDown"),0);
}else{
this.prevElem.style.top=this.curElemHeight+"px";
}
this.prevElem.style.top=(parseInt(this.prevElem.style.top,10)+15)+"px";
},slideCallback:function(){
this.toggleLinkHtml(true);
window.contentDiv.style.display="none";
if(window.iCurrentPos){
this.E(this.currentRCPStr+window.iCurrentPos+"_c").style.display="none";
}
return false;
},toggleLinkHtml:function(_b){
var _c=this.E(this.toggleLinkId+window.iCurrentPos);
if(_c){
if(_b){
_c.innerHTML=this.sExpandImgSrc+"&nbsp;&nbsp;"+this.sExpandText;
setTimeout("vjo.Registry.get('customize').setHref()",100);
}else{
_c.innerHTML=this.sCollapseImgSrc+"&nbsp;&nbsp;"+this.sCollapseText;
}
}
},setHref:function(){
this.E(this.toggleLinkId+window.iCurrentPos).parentNode.href=this.sExpandURL+"&cid="+window.iCurrentPos+"#GoTo"+window.iCurrentPos;
vjo.dsf.EventDispatcher.register(this.toggleLinkId,"click");
setTimeout("vjo.Registry.get('customize').setHref()",100);
},setEdit:function(){
setTimeout("vjo.Registry.get('customize').setEdit()",10);
},slideOpenCallback:function(){
this.toggleLinkHtml(false);
window.contentDiv.style.height=this.contentDiv.oHeight;
window.contentDiv.oHeight="";
},setPreliminaryStyle:function(_d){
if(!parseInt(_d.oHeight,10)){
_d.oHeight=_d.offsetHeight+"px";
}
_d.style.overflow="hidden";
_d.style.position="relative";
if(!_d.style.height){
_d.style.height=_d.offsetHeight+"px";
}
return _d;
},toggleDelete:function(_e,_f){
if(_e){
this.animateJS.slideDeleteModule(this.contentDiv.id,"UP",_f);
}
},toggleCondition:function(_10,_11){
if(_10){
this.animateJS.fadeModule(this.contentDiv.id,false,"");
this.contentDiv.style.display="none";
if(_11){
this.slideCallback();
}
}else{
this.animateJS.fadeModule(this.contentDiv.id,true,"");
this.animateJS.slideModule(this.contentDiv.id,"DOWN",_11);
}
}}).props({baseUrl:"",deleteContainer:function(_12,_13,_14){
var t=vjo.Registry.get(_13);
t.iCurrentPos=_12;
t.contentDiv=t.E(t.currentContentStr+t.iCurrentPos);
t.deleteContainer=t.contentDiv.parentNode.parentNode;
t.setPreliminaryStyle(t.deleteContainer);
t.toggleCondition(true,"");
t.toggleDelete(true,"");
if(t.contentDiv.style.display===""||t.contentDiv.style.display==="block"){
t.contentDiv.style.display="none";
}
var ind=0;
var _17=0;
var _18=0;
var _19=_14?t.leftModules:t.centralModules;
for(i=0;i<_19.length;i++){
if(t.E(t.sDeleteId+_19[i])){
if((t.E(t.currentContentStr+_19[i])==t.contentDiv)){
_18=i;
}
}
}
for(i=0;i<_18;i++){
t.PreviousContainerElem=document.getElementById(t.currentContentStr+_19[i]);
if(t.PreviousContainerElem){
t.PreviousContainerElem.parentNode.parentNode.style.top="0px";
}
}
for(i=0;i<_19.length;i++){
if(t.E(t.sDeleteId+_19[i])){
if((t.E(t.currentContentStr+_19[i])==t.contentDiv)){
ind=i+1;
break;
}
}
}
t.NextContainerElem=document.getElementById(t.currentContentStr+_19[ind]);
if(t.NextContainerElem){
}
if(t.deleteContainer){
t.deleteContainer.style.position="";
t.deleteContainer.style.overflow="visible";
t.deleteContainer.style.height="";
}
var _1a=[];
ind=0;
for(i=0;i<_19.length;i++){
if(!(t.E(t.currentContentStr+_19[i])==t.contentDiv)){
_1a[ind]=_19[i];
ind++;
}
}
if(_14){
t.leftModules=_1a;
t.setPosition(t.leftModules);
}else{
t.centralModules=_1a;
t.setPosition(t.centralModules);
}
if(t.E(t.deleteStr+_12)){
t.E(t.deleteStr+_12).style.display="";
}
window.sDeleteDiv=t.E(t.deleteStr+_12);
},setEditShorcutPosition:function(_1b,_1c){
var _1d=this.baseUrl+"&ssPageName=null&ActionString=EDIT";
_1d+=(_1d.indexOf("?")>0?"&":"?")+"rand="+Math.random();
_1d+=+"#GoTo"+_1c;
document.location.href=_1d;
return false;
},setSavePosition:function(_1e,_1f,_20){
var _21=document.createElement("Form");
_21.method="post";
_21.id="ShortcutEditUserForm";
_21.action=_20;
var _22=vjo.dsf.document.Element.get("ShortcutDiv");
if(_22.firstChild.id=="ShortJSDiv"){
_22.removeChild(_22.firstChild);
_21.appendChild(_22.lastChild);
_22.appendChild(_21);
}
},setCancelPosition:function(_23,_24){
var _25=this.baseUrl+"&ssPageName=null&ActionString=Reset";
_25+=(_25.indexOf("?")>0?"&":"?")+"rand="+Math.random();
_25+="#GoTo"+_24;
document.location.href=_25;
return false;
},setBaseUrl:function(_26){
this.baseUrl=_26;
},closeRCPContainer:function(_27,_28){
var t=vjo.Registry.get(_28);
t.iCurrentPos=_27;
t.contentDiv=t.E(t.currentContentStr+t.iCurrentPos+"_c");
t.footerDiv=t.E(t.currentContentStr+t.iCurrentPos+"_f");
if(typeof (t.contentDiv.bCollapsed)=="undefined"){
t.contentDiv.bCollapsed=false;
}
window.contentDiv=t.contentDiv;
window.iCurrentPos=t.iCurrentPos;
if(t.contentDiv.bCollapsed){
t.setHref();
var str=t.sExpandURL+"&cid="+window.iCurrentPos+"#GoTo"+window.iCurrentPos;
if(document.location.href.indexOf("&cid="+window.iCurrentPos)==-1){
document.location.href=str;
}else{
document.location.reload();
}
return false;
}
if(!t.contentDiv.style.height){
t.contentDiv.style.height=t.contentDiv.offsetHeight+"px";
}
if(!t.contentDiv.bCollapsed){
t.contentDiv.bCollapsed=true;
if(t.footerDiv){
t.footerDiv.style.display="none";
}
t.toggleCondition(true,"vjo.Registry.get('"+_28+"').slideCallback");
t.toggleDelete(true,"");
}else{
t.contentDiv.bCollapsed=false;
t.oFadeLayerElem=t.contentDiv;
t.contentDiv.style.display="";
t.E(t.currentRCPStr+t.iCurrentPos+"_c").style.display="";
t.toggleCondition(false,"vjo.Registry.get('"+_28+"').slideOpenCallback");
}
t.contentDiv=t.E(t.currentContentStr+t.iCurrentPos);
var ind=0;
var _2c=0;
var _2d=t.centralModules;
for(i=0;i<_2d.length;i++){
if(t.E(t.sDeleteId+_2d[i])){
if((t.E(t.currentContentStr+_2d[i]))==t.E(t.currentContentStr+t.iCurrentPos)){
_2c=i;
}
}
}
for(i=0;i<_2c;i++){
t.PreviousContainerElem=document.getElementById(t.currentContentStr+_2d[i]);
if(t.PreviousContainerElem){
t.PreviousContainerElem.parentNode.parentNode.style.top="-50px";
}
}
for(i=_2c;i<_2d.length;i++){
t.NextContainerElem=document.getElementById(t.currentContentStr+_2d[i+1]);
if(t.NextContainerElem){
t.NextContainerElem.parentNode.parentNode.style.top="50px";
}
}
t.contentDiv=t.E(t.currentContentStr+t.iCurrentPos);
if(t.contentDiv){
t.contentDiv.style.height="";
}
if(t.contentDiv.parentNode.parentNode){
if(vjo.dsf.client.Browser.bIE){
t.contentDiv.parentNode.parentNode.style.height="0px";
}else{
t.contentDiv.parentNode.parentNode.style.height="";
}
}
},moveDown:function(_2e,_2f,_30,_31){
var t=vjo.Registry.get(_30);
t.HideErroDivId(t.sErrorDivid);
t.HideDeleteStatusDivId(t.aDeleteStatusId);
if(window.sDeleteDiv){
winodw.sDeleteDiv.style.display="none";
}
t.iCurrentPos=_2e;
t.prevElem=t.E(t.sDeleteId+t.iCurrentPos);
t.prevElem.style.height=t.prevElem.offsetHeight+"px";
var ind=0;
var _34=0;
var _35=_2f?t.leftModules:t.centralModules;
for(i=0;i<_35.length;i++){
if(t.E(t.sDeleteId+_35[i])){
if(t.E(t.sDeleteId+_35[i]).iPstn==t.prevElem.iPstn){
ind=i+1;
break;
}
}
}
t.currentElem=document.getElementById(t.sDeleteId+_35[ind]);
if(t.currentElem){
if(ind==(_35.length-1)){
sId=t.editMoveDownId.replace("##1",_35[ind-1]);
_34=t.E(sId);
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.setDisabled(_34);
sId=t.editMoveDownId.replace("##1",_35[ind]);
_34=t.E(sId);
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.setEnabled(_34);
}
if(ind==1){
sId=t.editMoveUpId.replace("##1",_35[ind-1]);
_34=t.E(sId);
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.setEnabled(_34);
sId=t.editMoveUpId.replace("##1",_35[ind]);
_34=t.E(sId);
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.setDisabled(_34);
}
t.currentElem.style.height=t.currentElem.offsetHeight+"px";
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.togglePosInArray(_35,t.currentElem,t.prevElem);
t.swapContainers();
var _36=this.baseUrl+"&SubmitAction.ContainerOrder=x";
var _37="";
if(!_2f){
var _38=t.leftModules;
for(i=0;i<_38.length;i++){
_37=_37+_38[i]+"|";
}
for(i=0;i<_35.length;i++){
_37=_37+_35[i];
if(i<_35.length-1){
_37=_37+"|";
}
}
}else{
for(i=0;i<_35.length;i++){
_37=_37+_35[i]+"|";
}
var _39=t.centralModules;
for(i=0;i<_39.length;i++){
_37=_37+_39[i];
if(i<_39.length-1){
_37=_37+"|";
}
}
}
_36=_36+"&ContainerOrder="+_37+"&page="+t.sCurrentPageNo+"&ssPageName="+_31;
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.makeContainerOrderScriptRequest(_36);
vjo.dsf.ServiceEngine.handleRequest(new vjo.dsf.Message("MYEBAY_PANEL_MOVED"));
}
},moveUp:function(_3a,_3b,_3c,_3d){
var t=vjo.Registry.get(_3c);
t.HideErroDivId(t.sErrorDivid);
if(window.sDeleteDiv){
window.sDeleteDiv.style.display="none";
}
t.HideDeleteStatusDivId(t.aDeleteStatusId);
t.iCurrentPos=_3a;
t.currentElem=t.E(t.sDeleteId+t.iCurrentPos);
var ind=0;
var _40;
var _41=_3b?t.leftModules:t.centralModules;
for(i=0;i<_41.length;i++){
if(t.E(t.sDeleteId+_41[i])){
if(t.E(t.sDeleteId+_41[i]).iPstn==t.currentElem.iPstn){
ind=i-1;
}
}
}
t.prevElem=t.E(t.sDeleteId+_41[ind]);
if(!t.prevElem){
return false;
}
if(t.prevElem){
if(ind===0){
sId=t.editMoveUpId.replace("##1",_41[ind+1]);
_40=t.E(sId);
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.setDisabled(_40);
sId=t.editMoveUpId.replace("##1",_41[ind]);
_40=t.E(sId);
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.setEnabled(_40);
}
if(ind==(_41.length-2)){
sId=t.editMoveDownId.replace("##1",_41[ind+1]);
_40=t.E(sId);
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.setEnabled(_40);
sId=t.editMoveDownId.replace("##1",_41[ind]);
_40=t.E(sId);
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.setDisabled(_40);
}
t.prevElem.style.height=t.prevElem.offsetHeight+"px";
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.togglePosInArray(_41,t.prevElem,t.currentElem);
t.swapContainers();
var _42=this.baseUrl+"&SubmitAction.ContainerOrder=x";
var _43="";
if(!_3b){
var _44=t.leftModules;
for(i=0;i<_44.length;i++){
_43=_43+_44[i]+"|";
}
for(i=0;i<_41.length;i++){
_43=_43+_41[i];
if(i<_41.length-1){
_43=_43+"|";
}
}
}else{
for(i=0;i<_41.length;i++){
_43=_43+_41[i]+"|";
}
var _45=t.centralModules;
for(i=0;i<_45.length;i++){
_43=_43+_45[i];
if(i<_45.length-1){
_43=_43+"|";
}
}
}
_42=_42+"&ContainerOrder="+_43+"&page="+t.sCurrentPageNo+"&ssPageName="+_3d;
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.makeContainerOrderScriptRequest(_42);
vjo.dsf.ServiceEngine.handleRequest(new vjo.dsf.Message("MYEBAY_PANEL_MOVED"));
}
},makeContainerOrderScriptRequest:function(url){
if(url){
var _47=document.createElement("script");
_47.type="text/javascript";
var _48=vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.addRandomParam(url);
_47.src=_48;
document.getElementsByTagName("head")[0].appendChild(_47);
}
return false;
},addRandomParam:function(url){
url+=(url.indexOf("?")>0?"&":"?")+"rand="+Math.random();
return url;
},processResponse:function(){
return false;
},processMoveUpResponse:function(_4a){
var _4b;
if(_4a){
_4b=_4a;
alert("dfsd");
}
},togglePosInArray:function(_4c,_4d,_4e){
_4c[_4d.iPstn]=_4e.iInd;
_4c[_4e.iPstn]=_4d.iInd;
var _4f=_4d.iPstn;
_4d.iPstn=_4e.iPstn;
_4e.iPstn=_4f;
},setClass:function(_50,_51,_52,_53,_54){
var t=vjo.Registry.get(_52);
var _56=t.E(_50);
for(i=0;i<_56.childNodes.length;i++){
if(_56.childNodes[i].firstChild.className){
_56.childNodes[i].firstChild.className="img_notselected";
_56.childNodes[i].bClicked=false;
}
}
t.E(_51).className="highlightimg";
t.E(_51).bClicked=true;
},setClassOnMouseOver:function(_57,_58,_59,_5a){
var t=vjo.Registry.get(_5a);
var _5c=t.E(_57);
if(t.E(_57).className==_59){
t.E(_57).bClicked=true;
}
if(!t.E(_57).bClicked){
t.E(_57).className=_58;
}
},setClassOnMouseOut:function(_5d,_5e,_5f,_60){
var t=vjo.Registry.get(_60);
var _62=t.E(_5d);
if(!t.E(_5d).bClicked){
t.E(_5d).className=_5e;
}
},setDisabled:function(_63){
if(_63){
_63.className="disabledmenu";
_63.parentNode.className="pdm-disabled";
}
},setEnabled:function(_64){
if(_64){
_64.className="enabledmenu";
_64.parentNode.className="pdm-enabled";
}
},deleteModules:function(_65,_66,_67,_68){
var t=vjo.Registry.get(_67);
t.contentDiv=t.E(_65);
var s=t.contentDiv.style;
window.contentDiv=t.contentDiv;
t.setPreliminaryStyle(t.contentDiv);
var _6b=t.E(_68);
var _6c=t.E(t.sWelcomeChkbxId);
if(_66){
if(s.display=="none"){
s.display="";
t.setPreliminaryStyle(t.contentDiv);
if(_6b){
_6b.style.display="none";
}
s.height="0px";
t.toggleCondition(false);
}else{
s.height="";
s.width="";
s.overflow="visible";
s.opacity="";
s.position="relative";
}
}else{
if(_6b){
_6b.style.display="none";
}
t.toggleCondition(true,"vjo.Registry.get('"+_67+"').slideCallback");
s.height="";
s.width="";
s.overflow="visible";
s.opacity="";
s.position="relative";
}
if(_6c!==null){
if(_6c.checked){
var _6d=this.baseUrl+"&SubmitAction.EditComponentDeleteAction=x";
_6d=_6d+"&cid=353"+"&ActionString=DELETE"+"&ColorChange=null";
vjo.darwin.app.myebay.component.editcomponent.CustomizeModule.makeContainerOrderScriptRequest(_6d);
}
}
vjo.dsf.ServiceEngine.handleRequest(new vjo.dsf.Message("MYEBAY_PANEL_MOVED"));
},processeResponse:function(_6e){
return;
}});

vjo.needs("vjo.dsf.Element");
vjo.needs("vjo.dsf.utils.Object");
vjo.type("vjo.darwin.app.myebay.animation.Animation").protos({constructs:function(_1){
var c=_1;
this.iSlidePixel=c.slidePixel;
this.iSlideTiming=c.slideTiming;
this.iFadeTiming=c.fadeTiming;
this.E=vjo.dsf.Element.get;
this.h=vjo.dsf.utils.Object.hitch;
},slideModule:function(_3,_4,_5){
this.contentDiv=this.E(_3);
this.slideCallback=_5;
if(this.contentDiv){
this.setPreStyle();
if(_4=="UP"){
this.slideClose();
}
if(_4=="DOWN"){
this.slideExpand();
}
if(_4=="LEFT"){
this.slideToLeft();
}
if(_4=="RIGHT"){
this.slideToRight();
}
}
},slideDeleteModule:function(_6,_7,_8){
this.contentDiv=this.E(_6);
this.slideCallback=_8;
if(this.contentDiv){
this.setDeletePreStyle();
if(_7=="UP"){
this.slideClose();
}
if(_7=="DOWN"){
this.slideExpand();
}
if(_7=="LEFT"){
this.slideToLeft();
}
if(_7=="RIGHT"){
this.slideToRight();
}
}
},setPreStyle:function(){
this.s=this.contentDiv.style;
this.s.position="relative";
this.s.overflow="hidden";
this.s.height=this.contentDiv.offsetHeight+"px";
this.s.width=this.contentDiv.offsetWidth+"px";
if(!this.contentDiv.oHeight){
this.contentDiv.oHeight=this.contentDiv.offsetHeight;
}
},setDeletePreStyle:function(){
this.s=this.contentDiv.parentNode.parentNode.style;
this.s.position="relative";
this.s.overflow="hidden";
this.s.height=this.contentDiv.parentNode.parentNode.offsetHeight+"px";
this.s.width=this.contentDiv.parentNode.parentNode.offsetWidth+"px";
if(!this.contentDiv.parentNode.parentNode.oHeight){
this.contentDiv.parentNode.parentNode.oHeight=this.contentDiv.parentNode.parentNode.offsetHeight;
}
},slideToRight:function(){
if(parseInt(this.s.width)>=this.iSlidePixel){
this.s.left=(parseInt(this.s.left)+this.iSlidePixel)+"px";
this.s.width=(parseInt(this.s.width)-this.iSlidePixel)+"px";
setTimeout(this.h(this,"slideToRight"),this.iSlideTiming);
}else{
this.callback();
}
},callback:function(){
if(this.slideCallback){
eval(this.slideCallback+"()");
}
},slideToLeft:function(){
if(parseInt(this.s.width)>=this.iSlidePixel){
this.s.width=(parseInt(this.s.width)-this.iSlidePixel)+"px";
setTimeout(this.h(this,"slideToLeft"),this.iSlideTiming);
}else{
this.callback();
}
},slideClose:function(){
if(parseInt(this.s.height)>this.iSlidePixel){
this.s.height=(parseInt(this.s.height)-this.iSlidePixel)+"px";
setTimeout(this.h(this,"slideClose"),this.iSlideTiming);
}else{
this.callback();
}
},slideExpand:function(){
if(parseInt(this.s.height)<parseInt(this.contentDiv.oHeight)){
this.s.height=(parseInt(this.s.height)+this.iSlidePixel)+"px";
setTimeout(this.h(this,"slideExpand"),this.iSlideTiming);
}else{
this.callback();
}
},fadeModule:function(_9,_a,_b){
if(_9){
this.oFadeLayerElem=document.getElementById(_9);
}
this.fs=this.oFadeLayerElem.style;
this.fadeCallback=_b;
if(!_a){
this.fs.opacity=1;
this.fs.filter="alpha(opacity = 100)";
this.fadeOut();
}else{
this.fs.opacity=0;
this.iOpacity=0;
this.fs.filter="alpha(opacity = 0)";
this.fs.display="";
this.fadeIn();
}
},fadeOut:function(){
if(this.fs.opacity>0){
this.fs.opacity=this.fs.opacity-0.1;
this.fs.filter="alpha(opacity = "+this.fs.opacity*100+")";
setTimeout(this.h(this,"fadeOut"),this.iFadeTiming);
}else{
if(this.fadeCallback){
eval(this.fadeCallback+"()");
}
}
},fadeIn:function(){
if(this.iOpacity<10){
this.iOpacity++;
this.fs.opacity=this.iOpacity/10;
this.fs.filter="alpha(opacity = "+this.fs.opacity*100+")";
setTimeout(this.h(this,"fadeIn"),this.iFadeTiming);
}else{
if(this.fadeCallback){
eval(this.fadeCallback+"()");
}
}
}});

vjo.type("vjo.darwin.app.myebay.ReminderLayerComponent").props({setNoDateSelected:function(_1,_2,_3,_4,_5){
var _6=document.getElementById(_2),dateField=document.getElementById(_3);
if(_6){
_6.disabled=_1;
}
if(dateField){
dateField.disabled=_1;
}
if(_4&&_5){
this.replaceTextField(_3,_4,_5);
}
},setSelectDateDefaultState:function(_7,_8,_9){
var _a=document.getElementById(_7);
if(_a){
vjo.darwin.app.myebay.ReminderLayerComponent.setNoDateSelected(_a.checked,_8,_9);
}
},replaceTextField:function(id,_c,_d){
var e=document.getElementById(id);
if(e&&e.value==_c){
e.value=_d;
}
},clearTextField:function(id){
var _10=document.getElementById(id);
if(_10){
_10.value="";
}
}});

vjo.type("vjo.darwin.app.myebay.ReminderFormComponent").protos({constructs:function(_1){
var b=_1;
this.idMap=b.idMap;
this.actions=b.actions;
this.overlayFormName=b.overlayFormName;
this.overlayId=b.htmlId;
},transferValues:function(_3){
with(this){
var l=idMap.length;
if(l>0){
var f=document.forms[overlayFormName];
if(f){
f.onsubmit=function(){
vjo.darwin.app.myebay.RequestManager.makeAjaxPostRequest(overlayFormName);
return false;
};
}
for(var i=0;i<l;i++){
var _7=idMap[i];
var _8=_7[0]+((_3==null)?"":_3);
var _9=document.getElementById(_8);
if(_9){
var _a=_9.innerHTML;
var _b=_7[1];
var t=_7[2];
var e=f.elements[_b];
switch(t){
case "input":
var _e=(e.length)?e[0].getAttribute("type"):e.getAttribute("type");
switch(_e){
case "text":
case "hidden":
e.value=_a;
break;
case "radio":
var _f=e.length;
if(_f){
for(var x=0;x<_f;x++){
if(e[x].value==_a){
e[x].checked=true;
break;
}
}
}else{
if(e.value==_a){
e.selected=true;
}
}
break;
}
break;
case "select":
var _11=e.options,_f=_11.length;
for(var x=0;x<_f;x++){
if(_11[x].value==_a){
_11[x].selected=true;
break;
}
}
break;
case "textarea":
e.value=_a;
break;
default:
document.getElementById(_b).innerHTML=_a;
}
}
}
}
}
},performShowActions:function(){
with(this){
var l=0;
if(actions){
l=actions.length;
}
for(var i=0;i<l;i++){
eval(actions[i]);
}
}
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.document.Form");
vjo.type("vjo.darwin.app.myebay.MyeBayNotificationPrefRespHandler").satisfies("vjo.dsf.common.IJsResHandler").protos({constructs:function(_1){
this.sObjType="MyeBayNotificationPrefService";
this.sSvcId=_1;
},handleResponse:function(_2){
if(_2.response){
var _3=_2.response.data.errorDiv;
var d=vjo.dsf.document.Element.get(_3);
vjo.dsf.document.Element.toggleHideShow(_3,false);
var _5=_2.response.data.successDiv;
vjo.dsf.document.Element.toggleHideShow(_5,false);
if(d){
vjo.dsf.document.Element.toggleHideShow(_3,true);
return;
}
if(_2.response.data.type==0||_2.response.data.type==1){
this.updateSubscribeDiv(_2);
this.disableRequiredFields(_2);
}else{
this.updateSubsection(_5);
if(_2.response.data.formId){
var _6=vjo.dsf.document.Element.get(_2.response.data.formId+"_"+_2.response.data.flagField);
_6.value="false";
}
}
}else{
return;
}
},updateSubscribeDiv:function(_7){
var _8=_7.response.data.showLink;
vjo.dsf.document.Element.toggleHideShow(_8,true);
var _9=_7.response.data.removeLink;
vjo.dsf.document.Element.toggleHideShow(_9,false);
var _a=_7.response.data.showDiv;
vjo.dsf.document.Element.toggleHideShow(_a,true);
var _b=_7.response.data.removeDiv;
vjo.dsf.document.Element.toggleHideShow(_b,false);
},updateSubsection:function(_c){
var e=vjo.dsf.document.Element.get(_c);
if(e){
vjo.dsf.document.Element.toggleHideShow(_c,true);
}
},disableRequiredFields:function(_e){
var _f=_e.response.data.grayOutFields;
for(var k=0;k<_f.length;k++){
myField=vjo.dsf.document.Element.get(_f[k]);
myField.disabled=true;
myField.checked=false;
}
}});


// en_US/e583/MyEbayV4App_MyEbayBeta_e5837294829_6_en_US
// b=7294829