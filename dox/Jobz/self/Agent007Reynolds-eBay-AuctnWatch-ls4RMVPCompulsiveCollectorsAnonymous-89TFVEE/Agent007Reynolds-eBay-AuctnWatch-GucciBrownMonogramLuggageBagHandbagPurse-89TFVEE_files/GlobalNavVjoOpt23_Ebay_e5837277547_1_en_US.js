vjo.type("vjo.darwin.core.dynamicmenu.ReplaceHandler").props({replace:function(_1,_2,_3){
var dm=vjo.Registry.get(_1);
if(null!=dm){
dm.replaceJSONDataHandler(_2,_3);
}
}});

// @JsDoNotOptimize

/*
 *
 * Handling Encoding/Decoding more efficently when switching from ISO to UTF-8 
 * for encoding
 *
 */
 vjo.needs("vjo.dsf.Enc"); // not using but these two classes are related do not remove dependency
 
 vjo.type("vjo.darwin.core.encoding.Enc")
 .inits(function(){
	if (vjo.darwin.core.encoding.Enc.loaded) { 
		return;
	}
	
 	vjo.darwin.core.encoding.Enc.loaded = true;
  	//http://support.microsoft.com/kb/944397
	// ALLOW for backward compatibility between ISO encoding and UTF-8 encoding
 
	// ALLOW for backward compatibility between ISO encoding and UTF-8 encoding
	var vjoDecodeURI = window.decodeURI;
	window.decodeURI = function(str){
	 try {
      		return vjoDecodeURI(str);
        }catch(e){
        	return unescape(str);
        }
	};
	
	// ALLOW for backward compatibility between ISO encoding and UTF-8 encoding
	var vjoDecodeURIComponent = window.decodeURIComponent;
	window.decodeURIComponent = function(str){
	 try {
      	return vjoDecodeURIComponent(str);
        }catch(e){
        return unescape(str);
        }
	};
 });
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

vjo.needs("vjo.dsf.typeextensions.string.TokenReplacement");
vjo.needs("vjo.dsf.typeextensions.string.Comparison");
vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.needs("vjo.dsf.utils.Object");
vjo.type("vjo.darwin.core.express.ExpressCrossLinking").protos({constructs:function(_1,_2,_3,_4,_5,_6,_7){
this.sLayerId=_1;
this.sCloseAnchorId=_2;
this.sCartCountText=_3;
this.aHostCoutryId=_4;
this.aHostCountryDomain=_5;
this.aHideOnParams=_6;
this.sHtmlProvider=_7;
this.sReferrer=document.referrer;
},getHost:function(){
var _8=vjo.dsf.cookie.VjCookieJar,df=this.sReferrer,sid=_8.readCookie("ebay","ecs")||"",rv="",i;
if(sid=="-1"){
return rv;
}
if(sid){
rv=this.getHostById(sid);
}else{
if((i=df.indexOf(".express."))!=-1){
df=df.substring(i+9).toLowerCase();
var f=df.indexOf("/");
if(f>0){
df=df.substring(0,f);
}
for(i in this.aHostCountryDomain){
if(this.compareHost(this.aHostCountryDomain[i],df)){
rv=this.aHostCountryDomain[i];
_8.writeCookielet("ebay","ecs",this.aHostCoutryId[i]);
break;
}
}
}
}
return rv.toLowerCase();
},compareHost:function(_a,_b){
var _c=_a.toLowerCase(),sh2=_b.toLowerCase();
if(_c.indexOf(".")==0){
_c=_c.substring(1);
}
if(sh2.indexOf(".")==0){
sh2=sh2.substring(1);
}
_c=_c.replace("/","");
sh2=sh2.replace("/","");
return (_c==sh2);
},hideOnParams:function(){
if(this.aHideOnParams){
var _d=this.aHideOnParams;
var _e=_d.length;
for(var i=0;i<_e;i++){
if(document.location.href.has(_d[i])){
return true;
}
}
}
return false;
},init:function(){
return;
if(this.hideOnParams()){
return;
}
var oD=document,oCJ=vjo.dsf.cookie.VjCookieJar,sh="",l=this.sLayerId,E=vjo.dsf.document.Element;
if(sh=this.getHost()){
var oL=E.get(l),ct=oCJ.readCookie("dp1","exc")||"",sc="",lh=oD.location.host;
ct=ct.split(".")[2];
lh=lh.substring(lh.indexOf(".")+1);
if(ct&&ct!="0"&&this.compareHost(lh,sh)){
sc=this.sCartCountText.replaceTokensEx("##n##",ct);
}
if(oL){
oL.innerHTML=this.sHtmlProvider.replaceTokensEx("##n##",sh,sc);
E.toggleHideShow(l,true);
var oCL=E.get(this.sCloseAnchorId);
if(oCL){
oCL.onclick=vjo.dsf.utils.Object.hitch(this,"close");
}
}
}
},getHostById:function(_13){
var ids=this.aHostCoutryId,i,ind=-1,o="";
for(i=0;i<ids.length;i++){
if(_13==ids[i]){
ind=i;
break;
}
}
if(ind!=-1){
o=this.aHostCountryDomain[ind];
}
return o;
},close:function(){
vjo.dsf.document.Element.toggleHideShow(this.sLayerId,false);
vjo.dsf.cookie.VjCookieJar.writeCookielet("ebay","ecs","-1");
return false;
}});

vjo.needs("vjo.dsf.client.Browser");
vjo.type("vjo.dsf.client.ActiveX").props({init:function(){
var oC=vjo.dsf.client.Browser;
if(oC.bIE){
var d=document;
dw=function(s){
d.writeln(s);
};
dw("<scr"+"ipt language=\"vbscript\" type=\"text/vbscript\">");
dw("\tFunction vbCheckActiveXControl (pActXName)");
dw("\t\taX = false");
dw("\t\ton error resume next");
dw("\t\taX = IsObject(CreateObject(pActXName))");
dw("\t\tvbCheckActiveXControl = aX");
dw("End Function");
dw("</scr"+"ipt>");
}
},isLibLoaded:function(_4){
var oC=vjo.dsf.client.Browser;
return oC.bActiveXSupported&&vbCheckActiveXControl(_4);
}}).inits(function(){
vjo.dsf.client.ActiveX.init();
});

vjo.needs("vjo.dsf.client.ActiveX");
vjo.type("vjo.darwin.core.ebaytoolbar.VjEbayToolbarDetect").props({isEnabled:function(){
var V1="eBayToolbar.Helper",V2="eBayToolbarCommLib.IWebEvent.1";
with(this){
var _2=vjo.dsf.client.ActiveX;
return (_2.isLibLoaded(V1)||_2.isLibLoaded(V2));
}
}});

vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.needs("vjo.dsf.typeextensions.string.Comparison");
vjo.needs("vjo.dsf.client.Browser");
vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.utils.Object");
vjo.needs("vjo.darwin.core.ebaytoolbar.VjEbayToolbarDetect");
vjo.type("vjo.darwin.core.bta.BuyerTransactionAlert").protos({constructs:function(_1,_2,_3,_4,_5,_6,_7,_8,_9,_a,_b){
this.sId=_1;
this.iPollingInterval=_2;
this.iMaxHits=_3;
this.iHitTimeout=_4;
this.iServerHits=0;
this.sLastCookieletValue="";
this.sServerUrl=_5;
if(document.location.protocol.has("https")){
_6=_6.replace("http://pics.","https://securepics.");
}
this.sImgServer=_6+"/";
this.sViewItemUrl=_7;
this.aAlertInfo=[["h:h:alt:2",_9,"icon/iconOutbid_16x16.gif"],["h:h:alt:3",_8,"icon/iconWatchB_16x16.gif"],["h:h:alt:4",_9,"icon/iconOutbid_16x16.gif"],["h:h:alt:5",_a,"icon/iconchanceBlu_16x16.gif"],["h:h:alt:tcr",_b,"icon/iconMailBlue_16x16.gif"]];
var c,oC=vjo.dsf.client.Browser,oCJ=vjo.dsf.cookie.VjCookieJar;
if((oC.bNav&&oC.iVer<7)||(oC.bOpera&&(oC.iVer+oC.fMinorVer)<0.5)||(oC.bIE&&oC.iVer<5)){
return;
}
c=oCJ.readCookie("ebaysignin");
if(!c||!c.is("in")){
return;
}
c=oCJ.readCookie("dp1","a1p");
if(c&&c.length>0&&parseInt(c)>0){
return;
}
if(vjo.darwin.core.ebaytoolbar.VjEbayToolbarDetect.isEnabled()){
return;
}
},setValue:function(_d,_e){
var oL=this.oL;
if(oL){
if(_d.is("")&&!oL.ctrld){
return;
}
if(_e){
if(vjo.dsf.client.Browser.bFirefox){
oL.textContent=_d;
}else{
oL.innerText=_d;
}
}else{
oL.innerHTML=_d;
}
oL.ctrld=1;
}
},onRefresh:function(){
var E=vjo.dsf.document.Element;
if(!this.oL){
this.oL=E.get(this.sId);
}
if(!_GH_Bta_PC){
return;
}
if(!this.oL){
return;
}
var c=vjo.dsf.cookie.VjCookieJar.readCookie("npii","mri");
if(c){
return;
}
c=vjo.dsf.cookie.VjCookieJar.readCookie("ebay","a2p");
if(!c){
this.onCookieExpire();
return;
}
var at=parseInt(c.charAt(8));
if(isNaN(at)){
return;
}
if(at===0){
this.setValue("");
return;
}
var nrt=parseInt(c.substring(0,8),16)*1000;
if(isNaN(nrt)){
return;
}
var ct=new Date();
ct=ct.getTime();
if(at==6||at==9){
if(!c.is(this.sLastCookieletValue)){
this.iServerHits=0;
}
this.setValue("");
this.sLastCookieletValue=c;
var t=(nrt>ct)?parseInt((nrt-ct)/1000):this.iPollingInterval;
window.setTimeout(vjo.dsf.utils.Object.hitch(this,this.onCookieExpire),t*1000);
return;
}
if(ct>=nrt){
this.onCookieExpire();
return;
}
this.iServerHits=0;
var cfg=this.aAlertInfo;
if(at<0&&at>=cfg.length){
return;
}
var ii=c.substring(9,c.lastIndexOf("."));
if(!c.is(this.sLastCookieletValue)){
var _18=cfg[at-1],imgSrv=this.sImgServer;
var _19=imgSrv+"s.gif";
var _1a="<img src=\""+_19+"\" width=\"10\" height=\"16\" style=\"vertical-align:middle\">|<img src=\""+_19+"\" width=\"10\" height=\"16\" style=\"vertical-align:middle\">";
_1a+="<img src=\""+imgSrv+_18[2]+"?t\" style=\"vertical-align:middle\"><img src=\""+_19+"\" width=\"5\" height=\"16\" style=\"vertical-align:middle\">";
var url=this.sViewItemUrl+"&item="+ii;
_1a+="<a href=\""+url+"&ssPageName="+_18[0]+"\">"+_18[1]+"</a>";
this.setValue(_1a);
this.sLastCookieletValue=c;
}
this.fireRefreshEvent();
},fireRefreshEvent:function(_1c){
if(!_1c){
_1c=this.iPollingInterval;
}
window.setTimeout(vjo.dsf.utils.Object.hitch(this,this.onRefresh),_1c*1000);
},onCookieExpire:function(){
var oCJ=vjo.dsf.cookie.VjCookieJar,signin=oCJ.readCookie("ebaysignin");
if(!signin.has("in")){
return;
}
if(document.location.href.has("https:")){
return;
}
if(this.iServerHits<this.iMaxHits){
this.iServerHits++;
var ct=new Date();
ct=ct.getTime();
this.setValue("<img height=\"1\" width=\"1\" src=\""+this.sServerUrl+"&clientTime="+ct+"\" style=\"visibility:hidden;vertical-align:middle\">");
this.fireRefreshEvent(this.iHitTimeout);
}else{
this.setValue("");
oCJ.writeCookielet("ebay","a2p","1111111101111111111.");
}
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

vjo.type("vjo.darwin.core.dynamicmenu.Show").satisfies("vjo.dsf.common.IJsHandler").protos({constructs:function(_1){
this.id=_1;
},handle:function(_2){
vjo.Registry.get(this.id).setup();
}});

vjo.type("vjo.darwin.core.dynamicmenu.Hide").satisfies("vjo.dsf.common.IJsHandler").protos({constructs:function(_1){
this.id=_1;
},handle:function(_2){
vjo.Registry.get(this.id).hide();
}});

vjo.type("vjo.darwin.core.dynamicmenu.Stay").satisfies("vjo.dsf.common.IJsHandler").protos({constructs:function(_1){
this.id=_1;
},handle:function(_2){
vjo.Registry.get(this.id).clear();
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.document.Positioning");
vjo.needs("vjo.dsf.document.Shim");
vjo.needs("vjo.dsf.utils.Object");
vjo.needs("vjo.dsf.client.Browser");
vjo.needs("vjo.darwin.core.dynamicmenu.Show");
vjo.needs("vjo.darwin.core.dynamicmenu.Hide");
vjo.needs("vjo.darwin.core.dynamicmenu.Stay");
vjo.type("vjo.darwin.core.dynamicmenu.DynamicMenu").protos({constructs:function(_1,_2,_3,_4,_5,_6,_7,_8,_9,_a,_b,_c,_d,_e,_f,_10,_11,_12,_13,_14){
this.iMouseOutTimer=null;
this.iMouseOverTimer=null;
this.iLeftPadding=_b;
this.iTopPadding=_c;
this.iRightPadding=_d;
this.sAnchorId=_1;
this.sContainerLayerId=_2;
this.sContentLayerId=_3;
this.iMouseOutDelay=_4;
this.iMouseOverDelay=_5;
this.iHighResDocWidth=_6;
this.iLowResDocWidth=_7;
this.iHighResColumns=_8;
this.iMediumResColumns=_9;
this.iLowResColumns=_a;
this.sHandler=_e;
this.sCollName=_f;
this.sWidth=_10;
this.sAnchorMouseOverClass=_11;
this.sAnchorMouseOutClass=_12;
this.iframeShim=null;
this.sHTML=null;
this.oAnchor=null;
this.sTemplate=null;
this.sAnchorText=_13;
this.sDomain=_14;
if(this.sAnchorId=="Help"){
this.iLeftPadding-=5;
}
this.oCobrand=null;
},setup:function(){
var oL,oA,iL,iT,iWW,noc,iAL,iAW,iLW,op,oSI,bF=false,t,lh=window.location.href;
var vd=vjo.dsf,D=vd.document,E=D.Element,P=D.Positioning,S=D.Shim,B=vd.client.Browser;
var O=vd.utils.Object;
with(this){
clear();
if(sTemplate==null){
t=E.get(sContentLayerId);
if(t){
sTemplate=t.innerHTML;
}
}
oL=E.get(sContainerLayerId);
if(oL){
op=oL.offsetParent;
}
oA=E.get(sAnchorId);
iAL=DynamicMenuGetOffsetLeft(oA);
iAW=oA.offsetWidth;
iT=P.getOffsetTop(oA)+(oA.offsetHeight)+iTopPadding;
iWW=P.getClientWidth();
if(typeof (iWW)=="undefined"){
iWW=800;
}
if(iWW>iHighResDocWidth){
noc=iHighResColumns;
}else{
if(iWW>iLowResDocWidth&&iWW<=iHighResDocWidth){
noc=iMediumResColumns;
}else{
if(iWW<=iLowResDocWidth){
noc=iLowResColumns;
}else{
noc=5;
}
}
}
if(sHTML==null){
bF=true;
if(B.bFirefox&&!lh.has("motors.")&&!lh.hasAny("shop.","local.","catalog.")){
E.promoteToBody(sContainerLayerId);
}
sHTML=getMenuHtml(noc);
if(sHTML==null){
return;
}
oL.innerHTML=sHTML;
}
iLW=oL.offsetWidth;
var _18=GetContainerDiv(),cw,bRA=false;
if(sAnchorId=="Help"){
bRA=true;
}
if(_18&&B.bIE&&!lh.hasAny("community","education")){
cw=_18.offsetWidth;
if((iAL+iLW)>cw){
bRA=true;
}
}
var bE=(sAnchorId=="EbxBrowseCategories")?true:false;
if(lh.hasAny("securitycenter","payments.")&&lh.has(".hk")){
iAL=P.getOffsetLeft(oA);
}else{
if(lh.hasAny("securitycentre","contact_ebay")&&lh.has(".au")){
iAL=P.getOffsetLeft(oA);
}else{
if((typeof (pageName)!="undefined")?pageName.has("CCHP_"):false){
iAL=P.getOffsetLeft(oA);
}else{
if(lh.hasAll("pages.","ebaymotors")){
}else{
if(lh.hasAny("/buy/")){
iAL=P.getOffsetLeft(oA);
}else{
if(lh.hasAny("pages.",".html",".shtml","cgi.","tools.ebay.de","neighborhoods.","themenwelten.","neighbourhoods.","motors.ebay.co.uk","motors.uk.","ebaymotors.at","motors.at.","motors.ebay.de","motors.de.")){
iAL=P.getOffsetLeft(oA);
}else{
if(typeof (bCenterAlignedPage)!="undefined"&&bCenterAlignedPage){
iAL=P.getOffsetLeft(oA);
}else{
if(bE&&((typeof (pageName)!="undefined")?pageName.has("KP_HomePage"):false)){
iAL=P.getOffsetLeft(oA);
}else{
if(sAnchorId=="StoreBrowseCats"&&lh.has("stores.")){
iAL=P.getOffsetLeft(oA);
}else{
if(lh.hasAny("shop.")&&lh.has(".de")){
if(B.bFirefox){
iAL=P.getOffsetLeft(oA);
}else{
iAL+=15;
}
}else{
if(typeof (pageName)!="undefined"&&pageName=="HomePagePortal"){
iAL=P.getOffsetLeft(oA);
}
}
}
}
}
}
}
}
}
}
}
var _1a=E.get("2tabPopularProducts");
if(_1a&&B.bIE){
iAL=P.getOffsetLeft(oA);
}
if((((iWW-iAL-iLW)<=10)&&iWW>iLW)||(iWW<(vjo.dsf.document.Positioning.getOffsetLeft(oA)+iAW+iLW))||bRA||bE){
iL=iAL+iAW-iLW;
}else{
iL=iAL;
}
if(sAnchorId=="Buy"||sAnchorId=="Sell"||sAnchorId=="MyEbay"||sAnchorId=="OV"){
iL=iAL;
}
iL+=iLeftPadding;
if(lh.has("securitycentre")&&lh.has(".sg")&&B.bIE){
iL+=10;
}else{
if(lh.has("feedback")&&lh.has(".hk")&&B.bFirefox){
iL+=7;
}else{
if(lh.has("my.")&&B.bFirefox){
iL-=7;
}else{
if(lh.has("myworld")&&B.bIE){
iL+=10;
}else{
if(bE){
var sn=E.get("dynamicmenu-snavW");
iT=P.getOffsetTop(sn)+(sn.offsetHeight)+iTopPadding;
if(B.bFirefox){
iL+=2;
}
if(B.bIE&&((typeof (pageName)!="undefined")?pageName.has("KP_HomePage"):false)){
iL-=9;
}
}else{
if(lh.has("search.")&&sAnchorId=="BrowseCategories"&&B.bIE&&B.iVer==7){
iL+=22;
iT-=2;
}else{
if(!lh.has("motors.shop.")&&B.bIE){
if(lh.hasAll("shop.","local.")){
if(sAnchorId=="BrowseCategories"){
iL+=15;
}
}else{
if(lh.has("shop.")){
if(sAnchorId=="BrowseCategories"){
iL+=15;
}
}else{
if(lh.hasAny("catalog.")){
iL+=15;
iT-=2;
}
}
}
}else{
if(lh.has("motors.shop.")&&B.bIE){
if(sAnchorId!="Buy"&&sAnchorId!="Sell"&&sAnchorId!="MyEbay"){
iL+=15;
}
}
}
}
}
}
}
}
}
if(bF){
oL.style.left=(iL>=0)?(iL-1)+"px":"14px";
oL.style.top=(iT)+"px";
oL.style.zIndex="1000";
if(lh.has("motors")||sAnchorId=="BrowseCategories"&&!lh.has("myworld")){
iframeShim=this.add(oL,12);
}else{
iframeShim=this.add(oL);
}
}else{
if(B.bIE||B.bFirefox){
oL.appendChild(iframeShim);
}
}
oSI=E.get(sContainerLayerId+"-spacer");
if(oSI&&bF){
oSI.width=iLW-12;
}
iMouseOverTimer=setTimeout(O.hitch(this,"show"),iMouseOverDelay);
}
},show:function(){
var oA,E=vjo.dsf.document.Element;
with(this){
oA=E.get(sAnchorId);
if(oA){
oA.className=sAnchorMouseOverClass;
}
E.toggleVisibility(sContainerLayerId,true);
}
},hide:function(){
with(this){
clearTimeout(iMouseOverTimer);
iMouseOutTimer=setTimeout(vjo.dsf.utils.Object.hitch(this,"close"),iMouseOutDelay);
}
},close:function(){
var oA,E=vjo.dsf.document.Element;
with(this){
oA=E.get(sAnchorId);
if(oA){
oA.className=sAnchorMouseOutClass;
}
E.toggleVisibility(sContainerLayerId,false);
if(iframeShim){
vjo.dsf.document.Shim.remove(E.get(sContainerLayerId),iframeShim);
}
}
},clear:function(){
clearTimeout(this.iMouseOutTimer);
},sortByValue:function(_1e,_1f){
if(_1e.value.has("Everything")){
return 1;
}else{
if(_1f.value.has("Everything")){
return -1;
}else{
return _1e.value<_1f.value?-1:(_1e.value>_1f.value?1:0);
}
}
},getMenuHtml:function(_20){
with(this){
var i,j,c,n,h,ipc,html,img="",si,sTemp=".paradise.qa.ebay.com",sTemp2=".qa.ebay.com",u,ff,ll,sTemp3=".no-pool-name.qa.ebay.com";
var E=vjo.dsf.document.Element;
var lh=window.location.href;
si="<img src='";
if(document.location.protocol.has("https")){
si+="https://secure";
}else{
si+="http://";
}
si+="pics.ebaystatic.com/aw/pics/s.gif' height='1' width='1'  border='0' ";
var _24=window[sHandler];
if(!_24){
return;
}
var _25=_24(),items=_25[sCollName],l=items.length;
if(sAnchorId=="BrowseCategories"&&lh.has("ebay.com/")){
for(i=0;i<l;i++){
if(items[i].value.has("eBay Motors")){
items[i].value="Cars, Boats, Vehicles & Parts";
items[i].url="http://www.motors.ebay.com";
items.sort(sortByValue);
break;
}
}
}
ipc=Math.ceil(l/_20);
h="<table bgcolor='white' border='0' cellpadding='0' cellspacing='0'";
if(this.sWidth!=""){
h+=" width='"+sWidth+"'";
}
h+=">";
for(i=0;i<ipc;i++){
h+="<tr>";
for(j=0;j<_20;j++){
h+="<td nowrap>";
if(i==0&&!E.get("EbxBrowseCategories-menu")){
h+=si+"><br/>";
img=si+" id='"+sContainerLayerId+"-spacer'>";
}
n=i+(j)*ipc;
c=items[n];
if(c){
if(typeof (c.url)!="undefined"){
u=sDomain?c.url.replace(sTemp,sDomain):c.url;
u=sDomain?c.url.replace(sTemp2,sDomain):c.url;
u=sDomain?c.url.replace(sTemp3,sDomain):c.url;
u=cobrandUrl(u);
h+="<a href='"+u+"'>";
h+=c.value;
h+="</a>";
}else{
u=c.value;
ff=u.indexOf("href=\"");
if(ff==-1){
h+=u;
}else{
ff+=6;
ll=u.lastIndexOf("\"");
u=u.substr(ff,ll-ff);
h+=c.value.substr(0,ff)+cobrandUrl(u)+c.value.substr(ll);
}
}
}else{
h+="&nbsp;";
}
h+="</td>";
}
h+="</tr>";
}
h+="</table>";
html=h;
if(sTemplate){
html=sTemplate.replace("##1##",h).replace("##2##",img);
}
return html;
}
},DynamicMenuGetOffsetLeft:function(e){
var l=0,oCl=vjo.dsf.client.Browser,ex=(oCl.bIE||oCl.bSafari),lh=window.location.href;
var bH=(typeof (isHomepage)!="undefined")?isHomepage:false;
var _29=false;
if(e.offsetParent){
l=e.offsetLeft;
while(e=e.offsetParent){
if(!_29){
_29=e.innerHTML.has("snav");
}
if(!e.id.toLowerCase().has("maincontent")&&!e.className.has("pagecontainer")){
l+=e.offsetLeft;
}
if(((e.className.is("pnav")||_29)&&ex)&&e.offsetLeft!=0&&(!lh.hasAny("community","sitemap","/help/","/education/","blogs","feedback","my"))){
return l;
}else{
if((e.className.is("pnav")||_29)&&e.offsetLeft!=0&&oCl.bFirefox&&lh.has(".hk")&&(!lh.has("community")&&!bH)){
return l;
}else{
if((e.className.is("pnav")||_29)&&e.offsetLeft!=0&&oCl.bIE&&lh.has(".au")&&lh.hasAny("/help/")){
return l;
}
}
}
}
}
return l;
},GetContainerDiv:function(){
var d=document,aa,i,l;
if(d.getElementsByTagName){
aa=d.getElementsByTagName("div");
}else{
if(d.all){
aa=d.all;
}
}
l=aa.length;
for(i=0;i<l;i++){
if(aa[i].className=="gbhdr"){
return aa[i];
}
}
},cobrandUrl:function(_2b){
var u="undefined",cc,cf;
if(this.oCobrand==null&&typeof (ebay)!=u&&typeof (ebay.oDocument)!=u){
cc=ebay.oDocument._getControl("cobrandCollection");
if(cc){
cf=cc._getControl("cobrandFunctions");
this.oCobrand=cf;
}
}else{
cf=this.oCobrand;
}
if(cf&&typeof (cf.cobrandURL)!=u){
var lc=(_2b.substring(_2b.length)!="/")?"/":"";
return cf.cobrandURL(_2b+lc);
}
return _2b;
},add:function(_2e,_2f,_30){
var f,p="px",w,h,s,S=vjo.dsf.document.Shim;
if(S.check()){
w=_2e.offsetWidth;
h=_2e.offsetHeight;
w+=_2f?_2f:0;
h+=_30?_30:0;
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
if(document.location.protocol.has("https")){
f.src="https://securepics.ebaystatic.com/aw/pics/s.gif";
}
_2e.appendChild(f);
return f;
}
},replaceJSONDataHandler:function(_32,_33){
if(_32!=null){
this.sHandler=_32;
}
if(_33!=null){
this.sDomain=_33;
}
}});

vjo.needs("vjo.dsf.typeextensions.string.Comparison");
vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.darwin.core.ebayheader.playground.Playground").protos({constructs:function(_1,_2){
this.sLayerId=_1;
this.sHandle=_2;
},show:function(){
var _3=vjo.dsf.cookie.VjCookieJar,sbf=_3.readCookie("ebay","sbf"),pcon=_3.getBitFlag(sbf,24),l,h;
var _4=this.sLayerId,E=vjo.dsf.document.Element;
if(pcon){
l=E.get(_4);
h=window[this.sHandle];
if(h&&l){
l.innerHTML=h();
E.toggleHideShow(_4,true);
}
}else{
E.toggleHideShow(_4,false);
}
}});

vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.type("vjo.darwin.core.ebayheader.timezone.TimeZone").props({init:function(){
var o=new Date(),oCJ,os;
os=o.getTimezoneOffset();
oCJ=vjo.dsf.cookie.VjCookieJar;
oCJ.writeCookielet("dp1","tzo",os.dec2Hex());
}}).inits(function(){
vjo.darwin.core.ebayheader.timezone.TimeZone.init();
});

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

vjo.type("vjo.dsf.utils.URL").props({addArg:function(_1,_2,_3){
if(_1==null||_1==undefined){
return null;
}
if(_1.indexOf("?")<0){
_1+="?"+_2+"="+_3;
return _1;
}
var _4=this.getArgPairIfExists(_1,_2);
if(_4!==null){
_1=_1.replace(_4,_2+"="+_3);
}else{
_1+="&"+_2+"="+_3;
}
return _1;
},getArg:function(_5,_6){
if(_5==null||_5==undefined){
return null;
}
if(_5.indexOf("?")<0){
return null;
}
var _7=this.getArgPairIfExists(_5,_6);
if(_7!==null){
return _7.substring(_7.indexOf("=")+1);
}
return null;
},getArgPairIfExists:function(_8,_9){
var _a=_8.indexOf("?");
if(_a<0){
return null;
}
var _b=_8;
var _c,argName;
while(_a>=0){
_b=_b.substring(_a+1);
_c=_b;
_a=_b.indexOf("&");
if(_a>=0){
_c=_b.substring(0,_a);
}
argName=_c.substring(0,_c.indexOf("="));
if(argName==_9){
return _c;
}
}
return null;
}});

vjo.needs("vjo.dsf.utils.URL");
vjo.needs("vjo.dsf.typeextensions.string.Comparison");
vjo.type("vjo.darwin.tracking.enabler.TrackingModuleEnabler").satisfies("vjo.dsf.common.IJsHandler").protos({constructs:function(_1,_2,_3,_4){
this.sCid=_1;
this.sParms=_2;
this.sCidParms=_3;
this.sDelim=_4;
},rewriteUrl:function(_5){
if(_5.nativeEvent===null||_5.nativeEvent===undefined){
return;
}
var _6=_5.nativeEvent.srcElement||_5.nativeEvent.target;
if(_6===null||_6===undefined){
return;
}
_6=this.getAnchor(_6);
var _7=this.sCidParms.split(this.sDelim);
if(_7[0]&&_6&&!_6.href.has("javascript:")){
var _8=vjo.dsf.utils.URL.addArg(_6.href,this.sCid,_7[0]);
if(_7[1]){
_8=vjo.dsf.utils.URL.addArg(_8,this.sParms,_7[1]);
}
_6.href=" "+_8;
}
},getAnchor:function(_9){
var e=_9;
if(e&&e.tagName){
if(!e.tagName.is("A")){
e=this.getAnchor(e.parentNode);
}
return e;
}
},handle:function(_b){
this.rewriteUrl(_b);
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


function get_Buy_menu(){
return {"items":[{"value":"<a href=\"http://listings.ebay.com/\">Browse Categories</a>"},{"value":"<a href=\"http://www.ebayuniversity.com/gotraining/First_Time_Bidding_And_Buying\">Help with bidding &amp; buying</a>"},{"value":"<a href=\"http://pages.ebay.com/buy/tools.html\">Buyer Tools</a>"},{"value":"<a href=\"http://reviews.ebay.com/\">Reviews &amp; Guides</a>"},{"value":"<a href=\"http://www.ebay.com/mobile/\">eBay Mobile</a>"}]};
}
function get_Sell_menu(){
return {"items":[{"value":"<a href=\"http://sell.ebay.com/sell\">Sell an item</a>"},{"value":"<a href=\"http://pages.ebay.com/sell/top10tips.html\">Selling Tips</a>"},{"value":"<a href=\"http://pages.ebay.com/sell/whatshot/\">What's Hot</a>"},{"value":"<a href=\"http://pages.ebay.com/sell/tools.html\">Seller tools &amp; eBay Stores</a>"},{"value":"<a href=\"http://pages.ebay.com/services/buyandsell/shipping.html\">Shipping center</a>"}]};
}
function get_MyEbay_menu(){
return {"items":[{"value":"<a href=\"http://my.ebay.com/ws/eBayISAPI.dll?MyEbay&amp;gbh=1&amp;smGHR=true\" rel=\"nofollow\">Summary</a>"},{"value":"<a href=\"http://my.ebay.com/ws/eBayISAPI.dll?MyEbay&amp;gbh=1&amp;CurrentPage=MyeBayWatching\" rel=\"nofollow\">Watching</a>"},{"value":"<a href=\"http://my.ebay.com/ws/eBayISAPI.dll?MyEbay&amp;gbh=1&amp;CurrentPage=MyeBayBidding\" rel=\"nofollow\">Bidding</a>"},{"value":"<a href=\"http://my.ebay.com/ws/eBayISAPI.dll?MyEbay&amp;gbh=1&amp;CurrentPage=MyeBaySelling&amp;smGHR=true\" rel=\"nofollow\">Selling</a>"},{"value":"<a href=\"http://my.ebay.com/ws/eBayISAPI.dll?MyEbay&amp;gbh=1&amp;CurrentPage=MyeBayAllFavorites\" rel=\"nofollow\">Favorites</a>"}]};
}
function get_Community_menu(){
return {"items":[{"value":"<a href=\"http://www2.ebay.com/aw/marketing.shtml\">News</a>"},{"value":"<a href=\"http://pages.ebay.com/community/answercenter/index.html\">Answer Center</a>"},{"value":"<a href=\"http://pages.ebay.com/community/boards/index.html\">Workshops/Discussion Forums</a>"},{"value":"<a href=\"http://neighborhoods.ebay.com\">Neighborhoods</a>"},{"value":"<a href=\"http://groups.ebay.com/index.jspa?categoryID=1&amp;redirected=1\">Groups</a>"}]};
}
function get_Help_menu(){
return {"items":[{"value":"<a href=\"http://pages.ebay.com/help/index.html\">Help Topics</a>"},{"value":"<a href=\"http://pages.ebay.com/education/index.html\">Learning Center</a>"},{"value":"<a href=\"http://pages.ebay.com/securitycenter/index.html\">Security &amp; Resolution Center</a>"},{"value":"<a href=\"http://pages.ebay.com/university/index.html\">eBay University</a>"},{"value":"<a href=\"http://pages.ebay.com/help/contact_us/_base/index.html\">Contact Us</a>"}]};
}


vjo.needs("vjo.dsf.document.Element");
vjo.type("vjo.dsf.document.Select").props({addOption:function(_1,_2,_3){
var e=_1;
if(e){
var o=new Option(_3,_2,false,false),os;
os=e.options;
os[os.length]=o;
}
}});

vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.document.Select");
vjo.type("vjo.darwin.core.dynamicdropdown.DynamicDropdown").protos({constructs:function(_1,_2,_3,_4){
this.sDropdownId=_1;
this.sHandler=_2;
this.sCollName=_3;
this.iCondNo=_4;
},fill:function(){
var e,h,d,col,i,l,c,D=vjo.dsf.document,E=D.Element,S=D.Select;
with(this){
e=E.get(sDropdownId);
if(e&&typeof (e.length)!="undefined"){
e=e[0];
}
if(e&&e.options){
if(iCondNo==-1||e.options.length<=iCondNo){
h=window[sHandler];
if(!h){
return;
}
d=h(),col=d[sCollName],l=col.length;
for(i=0;i<l;i++){
c=col[i];
S.addOption(e,c.id,c.value);
}
}
}
}
}});


vjo.needs("vjo.dsf.document.Element");
vjo.needs("vjo.dsf.EventDispatcher");
vjo.type("vjo.darwin.core.greetings.Sandbox").props({init:function(){
var l=vjo.dsf.document.Element.get("registerLink"),s="https://scgi.sandbox.ebay.com/ws/eBayISAPI.dll?RegisterEnterInfo",t="https://developer.ebay.com/DevZone/sandboxuser/Default.aspx";
if(l){
if(l.href==s){
l.href=t;
}
}
},adBanner:function(){
var l=window.location.href,s="sandbox.",c;
if(l.indexOf(s)!=-1){
c="<sty"+"le type=\"text/css\">#gnheader {background: url(http://pics.ebaystatic.com/aw/pics/devprogram/watermark.gif)}</sty"+"le>";
document.write(c);
}
}}).inits(function(){
vjo.darwin.core.greetings.Sandbox.adBanner();
vjo.dsf.EventDispatcher.addEventListener(window,"load",function(){
vjo.darwin.core.greetings.Sandbox.init();
});
});

vjo.needs("vjo.dsf.utils.URL");
vjo.needs("vjo.darwin.core.greetings.Sandbox");
vjo.type("vjo.darwin.core.greetings.VjGreetingsServer").props({handleClick:function(_1,_2){
var _3=_2.srcElement||_2.target;
if(_3){
_3.href=vjo.dsf.utils.URL.addArg(_1,"ru",encodeURIComponent(document.location.href));
}
}});

var _oGlobalNavRTMInfo={};
_oGlobalNavRTMInfo.aRTMPlacementData=[];

String.prototype.decodeBase64=function(){
var rv=this,len=rv.length,ret="",i=0;
if(len===0){
return ret;
}
var _2,chr2,chr3="";
var _3,enc2,enc3,enc4="";
var _4="ABCDEFGHIJKLMNOPQRSTUVWXYZ"+"abcdefghijklmnopqrstuvwxyz"+"0123456789+/=*";
var _5=new RegExp("[^A-Za-z0-9+/=*]");
if(_5.exec(rv)){
return;
}
do{
_3=_4.indexOf(rv.charAt(i++));
enc2=_4.indexOf(rv.charAt(i++));
enc3=_4.indexOf(rv.charAt(i++));
enc4=_4.indexOf(rv.charAt(i++));
_2=(_3<<2)|(enc2>>4);
chr2=((enc2&15)<<4)|(enc3>>2);
chr3=((enc3&3)<<6)|enc4;
ret+=String.fromCharCode(_2);
if(!(enc3>=64)){
ret+=String.fromCharCode(chr2);
}
if(!(enc4>=64)){
ret+=String.fromCharCode(chr3);
}
_2=chr2=chr3=_3=enc2=enc3=enc4="";
}while(i<len);
return ret;
};
String.prototype.decodeUTF8=function(){
var s=this,len=s.length;
var rs="";
var i=0;
var c=0,c1=0,c2=0;
while(i<len){
c=s.charCodeAt(i);
if(c<128){
rs+=String.fromCharCode(c);
i++;
}else{
if((c>191)&&(c<224)){
c2=s.charCodeAt(i+1);
rs+=String.fromCharCode(((c&31)<<6)|(c2&63));
i+=2;
}else{
c2=s.charCodeAt(i+1);
c3=s.charCodeAt(i+2);
rs+=String.fromCharCode(((c&15)<<12)|((c2&63)<<6)|(c3&63));
i+=3;
}
}
}
return rs;
};

vjo.needs("vjo.dsf.typeextensions.string.Decode");
vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.needs("vjo.dsf.utils.Object");
vjo.type("vjo.darwin.core.ebayheader.rtm.GlobalHeaderRtmCall").props({iTimer:null,submitRTMCall:function(_1){
var un="undefined";
if(!(typeof (ebay)!=un&&typeof (ebay.oDocument)!=un&&ebay.oDocument._getControl("rtm"))&&!(typeof (vjo)!=un&&typeof (vjo.dsf)!=un&&typeof (vjo.dsf.ServiceEngine)!=un&&typeof (vjo.dsf.ServiceEngine.inProcHdl)!=un&&typeof (vjo.dsf.ServiceEngine.inProcHdl.svcHdls)!=un&&typeof (vjo.dsf.ServiceEngine.inProcHdl.svcHdls.RTM_CALLBACK_SERVICE)!=un)&&typeof (_oGlobalNavRTMInfo)!==un&&!(typeof (rtm)!=un)){
if(_1&&_oGlobalNavRTMInfo.aRTMPlacementData.length>0){
document.write("<scr"+"ipt src=\""+_1+"\">"+"</scr"+"ipt>");
this.iTimer=window.setInterval(vjo.dsf.utils.Object.hitch(this,"init"),1);
}
}else{
if(_oGlobalNavRTMInfo.aRTMPlacementData.length>0){
var lh=window.location.href;
if(lh.hasAny("shop.","icatalog.")){
this.init();
}
}
}
},getUid:function(){
var _4=vjo.dsf.cookie.VjCookieJar,u1p=_4.readCookie("dp1","u1p"),u1pDecoded;
if(u1p){
u1pDecoded=u1p.decodeBase64().decodeUTF8();
}
return u1pDecoded;
},getGuid:function(){
var _5=vjo.dsf.cookie.VjCookieJar,guid=_5.readCookie("ebay","sgj");
return guid;
},hasUid:function(_6){
if(_6){
return true;
}
if(this.getUid().has("@@__@@__@@")){
return false;
}
return true;
},init:function(){
if(typeof (vjo.darwin.core.rtm)=="undefined"){
return;
}
if(this.iTimer!=null){
window.clearInterval(this.iTimer);
}
var _7=_oGlobalNavRTMInfo.aRTMPlacementData,data;
var _8=[],htmlIds=[],heights=[],pids=[],dblclkUrls=[],defaultUrls=[],url;
for(i=0;i<_7.length;i++){
data=_7[i];
_8[i]=data.maxWidth;
htmlIds[i]=data.htmlId;
heights[i]=data.maxHeight;
pids[i]=data.pid;
dblclkUrls[i]=data.dblclkUrl;
defaultUrls[i]=data.defaultUrl;
url=data.rtmUrl+"?RtmCmd&a=json"+(this.hasUid(data.userId)?("&l="+(data.userId?data.userId:this.getUid())):"")+"&g="+(data.gUid?data.gUid:this.getGuid())+"&ord="+data.ord+((data.oid)?"&i="+data.oid:"");
}
url+="&p="+pids.join(":");
_oGlobalNavRTMInfo.sRTMUrl=url;
if(_7.length>0){
var _9=new vjo.darwin.core.rtm.RTMInit({"url":url,"widths":_8,"htmlIds":htmlIds,"heights":heights,"pids":pids,"dblclkUrls":dblclkUrls,"defaultUrls":defaultUrls});
_9.invoke({});
}
}});

vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.type("vjo.darwin.tracking.rover.Rover").props({roverTrack:function(){
var _1=new Date().getTime();
var _2=vjo.darwin.tracking.rover.Rover.getClientOffset(_1);
var _3=vjo.dsf.cookie.VjCookieJar.readCookieObj("npii","tpim");
if(_3!==null){
var _4=parseInt(_3.maxage,16)*1000;
if(_4>0){
var _5=_4-_1+_2;
var _6=15552000000;
if(_5>_6||_5<0){
vjo.dsf.cookie.VjCookieJar.writeCookielet("npii","tpim","");
}
}
}
},getClientOffset:function(_7){
var _8;
var _9=vjo.dsf.cookie.VjCookieJar.readCookie("ebay","cos");
if(_9!==null&&_9.length>0){
_8=parseInt(_9,16)*1000;
}else{
if(typeof (svrGMT)!=="undefined"){
_8=_7-svrGMT;
var _a=Math.round(_8/1000);
if(!isNaN(_a)){
vjo.dsf.cookie.VjCookieJar.writeCookielet("ebay","cos",_a.toString(16));
}
}
}
if(isNaN(_a)){
_8=1800000;
}
return _8;
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

/* compspec addJsCompRegistration*/ 

/* end comp spec*/

function FooterTrk() { 	return { handle : function (event) { (function(){
var _d=vjo.dsf.EventDispatcher;
var _r=vjo.Registry;
_r.put('FooterTrackingCompSpecGenerator_0', new vjo.darwin.tracking.enabler.TrackingModuleEnabler("_trksid", "_trkparms", "m40;", ";")); _d.add('glbfooter','click',_r.get('FooterTrackingCompSpecGenerator_0'));})();  } }; }
vjo.dsf.EventDispatcher.add('body','load', new FooterTrk());
/* compspec addJsCompRegistration*/ 
(function () {
var _r = vjo.Registry;
function $o0(p0,p1,p10,p13){return new vjo.darwin.core.dynamicmenu.DynamicMenu(p0,p1,"dynMenuCtr",75,250,900,800,1,1,1,p10,1,0,p13,"items","","hovered","","","");};_r.put('BuyMenu',$o0("Buy","Buy-menu",5,"get_Buy_menu")); _r.put('SellMenu',$o0("Sell","Sell-menu",1,"get_Sell_menu")); _r.put('MyEbayMenu',$o0("MyEbay","MyEbay-menu",1,"get_MyEbay_menu")); _r.put('CommunityMenu',$o0("Community","Community-menu",1,"get_Community_menu")); _r.put('HelpMenu',$o0("Help","Help-menu",1,"get_Help_menu")); })();
/* end comp spec*/

function NavMenuBind() { 	return { handle : function (event) { (function(){
var _d=vjo.dsf.EventDispatcher;
var _r=vjo.Registry;
_r.put('CorePrimaryNavResourceSpec_1', new vjo.darwin.core.dynamicmenu.Hide("BuyMenu")); _r.put('CorePrimaryNavResourceSpec_2', new vjo.darwin.core.dynamicmenu.Stay("BuyMenu")); _r.put('CorePrimaryNavResourceSpec_3', new vjo.darwin.core.dynamicmenu.Show("BuyMenu")); _r.put('CorePrimaryNavResourceSpec_4', new vjo.darwin.core.dynamicmenu.Hide("BuyMenu")); _r.put('CorePrimaryNavResourceSpec_6', new vjo.darwin.core.dynamicmenu.Hide("SellMenu")); _r.put('CorePrimaryNavResourceSpec_7', new vjo.darwin.core.dynamicmenu.Stay("SellMenu")); _r.put('CorePrimaryNavResourceSpec_8', new vjo.darwin.core.dynamicmenu.Show("SellMenu")); _r.put('CorePrimaryNavResourceSpec_9', new vjo.darwin.core.dynamicmenu.Hide("SellMenu")); _r.put('CorePrimaryNavResourceSpec_11', new vjo.darwin.core.dynamicmenu.Hide("MyEbayMenu")); _r.put('CorePrimaryNavResourceSpec_12', new vjo.darwin.core.dynamicmenu.Stay("MyEbayMenu")); _r.put('CorePrimaryNavResourceSpec_13', new vjo.darwin.core.dynamicmenu.Show("MyEbayMenu")); _r.put('CorePrimaryNavResourceSpec_14', new vjo.darwin.core.dynamicmenu.Hide("MyEbayMenu")); _r.put('CorePrimaryNavResourceSpec_16', new vjo.darwin.core.dynamicmenu.Hide("CommunityMenu")); _r.put('CorePrimaryNavResourceSpec_17', new vjo.darwin.core.dynamicmenu.Stay("CommunityMenu")); _r.put('CorePrimaryNavResourceSpec_18', new vjo.darwin.core.dynamicmenu.Show("CommunityMenu")); _r.put('CorePrimaryNavResourceSpec_19', new vjo.darwin.core.dynamicmenu.Hide("CommunityMenu")); _r.put('CorePrimaryNavResourceSpec_21', new vjo.darwin.core.dynamicmenu.Hide("HelpMenu")); _r.put('CorePrimaryNavResourceSpec_22', new vjo.darwin.core.dynamicmenu.Stay("HelpMenu")); _r.put('CorePrimaryNavResourceSpec_23', new vjo.darwin.core.dynamicmenu.Show("HelpMenu")); _r.put('CorePrimaryNavResourceSpec_24', new vjo.darwin.core.dynamicmenu.Hide("HelpMenu")); _d.add('Buy-menu','mouseout',_r.get('CorePrimaryNavResourceSpec_1'));_d.add('Buy-menu','mouseover',_r.get('CorePrimaryNavResourceSpec_2'));_d.add('Buy','mouseover',_r.get('CorePrimaryNavResourceSpec_3'));_d.add('Buy','mouseout',_r.get('CorePrimaryNavResourceSpec_4'));_d.add('Sell-menu','mouseout',_r.get('CorePrimaryNavResourceSpec_6'));_d.add('Sell-menu','mouseover',_r.get('CorePrimaryNavResourceSpec_7'));_d.add('Sell','mouseover',_r.get('CorePrimaryNavResourceSpec_8'));_d.add('Sell','mouseout',_r.get('CorePrimaryNavResourceSpec_9'));_d.add('MyEbay-menu','mouseout',_r.get('CorePrimaryNavResourceSpec_11'));_d.add('MyEbay-menu','mouseover',_r.get('CorePrimaryNavResourceSpec_12'));
_d.add('MyEbay','mouseover',_r.get('CorePrimaryNavResourceSpec_13'));_d.add('MyEbay','mouseout',_r.get('CorePrimaryNavResourceSpec_14'));_d.add('Community-menu','mouseout',_r.get('CorePrimaryNavResourceSpec_16'));_d.add('Community-menu','mouseover',_r.get('CorePrimaryNavResourceSpec_17'));_d.add('Community','mouseover',_r.get('CorePrimaryNavResourceSpec_18'));_d.add('Community','mouseout',_r.get('CorePrimaryNavResourceSpec_19'));_d.add('Help-menu','mouseout',_r.get('CorePrimaryNavResourceSpec_21'));_d.add('Help-menu','mouseover',_r.get('CorePrimaryNavResourceSpec_22'));_d.add('Help','mouseover',_r.get('CorePrimaryNavResourceSpec_23'));_d.add('Help','mouseout',_r.get('CorePrimaryNavResourceSpec_24'));
})();  } }; }
vjo.dsf.EventDispatcher.add('body','load', new NavMenuBind());
/* compspec addJsCompRegistration*/ 
(function () {
var _r = vjo.Registry;
_r.put('BrowseCategoriesMenu',new vjo.darwin.core.dynamicmenu.DynamicMenu("BrowseCategories", "BrowseCategories-menu", "dynMenuCtr", 75, 250, 900, 800, 3, 3, 3, -10, 7, 0, "getBrowseCategoriesData", "items", "100%", "hovered", "", "", ".ebay.com")); })();
/* end comp spec*/

function SecNavMenuBind() { 	return { handle : function (event) { (function(){
var _d=vjo.dsf.EventDispatcher;
var _r=vjo.Registry;
_r.put('CoreSecondaryNavResourceSpec_1', new vjo.darwin.core.dynamicmenu.Hide("BrowseCategoriesMenu")); _r.put('CoreSecondaryNavResourceSpec_2', new vjo.darwin.core.dynamicmenu.Stay("BrowseCategoriesMenu")); _r.put('CoreSecondaryNavResourceSpec_3', new vjo.darwin.core.dynamicmenu.Show("BrowseCategoriesMenu")); _r.put('CoreSecondaryNavResourceSpec_4', new vjo.darwin.core.dynamicmenu.Hide("BrowseCategoriesMenu")); _d.add('BrowseCategories-menu','mouseout',_r.get('CoreSecondaryNavResourceSpec_1'));_d.add('BrowseCategories-menu','mouseover',_r.get('CoreSecondaryNavResourceSpec_2'));_d.add('BrowseCategories','mouseover',_r.get('CoreSecondaryNavResourceSpec_3'));_d.add('BrowseCategories','mouseout',_r.get('CoreSecondaryNavResourceSpec_4'));})();  } }; }
vjo.dsf.EventDispatcher.add('body','load', new SecNavMenuBind());
/* compspec addJsCompRegistration*/ 
(function () {
var _r = vjo.Registry;
_r.put('category0',new vjo.darwin.core.dynamicdropdown.DynamicDropdown("category0", "getBrowseCategoriesData", "items", 1)); })();
/* end comp spec*/

(function(){(function(){
var _d=vjo.dsf.EventDispatcher;
var _r=vjo.Registry;
_d.add('body','load',function(event) { this.fill(); },_r._category0);})();})();
/* compspec addJsCompRegistration*/ 

/* end comp spec*/

function HeaderTrk() { 	return { handle : function (event) { (function(){
var _d=vjo.dsf.EventDispatcher;
var _r=vjo.Registry;
_r.put('HeaderTrackingCompSpecGenerator_0', new vjo.darwin.tracking.enabler.TrackingModuleEnabler("_trksid", "_trkparms", "m37;", ";")); _r.put('HeaderTrackingCompSpecGenerator_1', new vjo.darwin.tracking.enabler.TrackingModuleEnabler("_trksid", "_trkparms", "m37;", ";")); _d.add('BrowseCategories-menu','click',_r.get('HeaderTrackingCompSpecGenerator_0'));_d.add('gnheader','click',_r.get('HeaderTrackingCompSpecGenerator_1'));})();  } }; }
vjo.dsf.EventDispatcher.add('body','load', new HeaderTrk());

// en_US/e583/GlobalNavVjoOpt23_Ebay_e5837277547_1_en_US
// b=7277547