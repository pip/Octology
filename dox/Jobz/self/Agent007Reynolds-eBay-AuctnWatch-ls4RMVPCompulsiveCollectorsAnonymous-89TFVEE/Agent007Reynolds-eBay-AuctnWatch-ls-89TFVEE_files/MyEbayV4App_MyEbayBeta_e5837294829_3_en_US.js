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

vjo.type("vjo.darwin.core.rtm.RTMHelper").props({setRtm:function(_1){
this.oRtm=_1;
},render:function(_2){
var t=this;
if(t.oRtm){
t.oRtm.renderPromos(_2);
}
}});

vjo.needs("vjo.dsf.utils.URL");
vjo.needs("vjo.darwin.core.rtm.RTMHelper");
vjo.type("vjo.darwin.core.rtm.RTMInit").satisfies("vjo.dsf.common.IJsServiceHandler").protos({constructs:function(_1){
this.oRTM=new vjo.darwin.core.rtm.RTM(_1);
vjo.darwin.core.rtm.RTMHelper.setRtm(this.oRTM);
},invoke:function(_2){
var _3=this.oRTM.processGlobalNavPids();
if(_3!=""){
var U=vjo.dsf.utils.URL;
var _5=this.oRTM.oJSBean.url;
_5=U.addArg(_5,"e","USC:"+this.oRTM.getSegment(false));
var p=U.getArg(_5,"p");
if((p!=null)&&!p.has(_3)){
this.oRTM.oJSBean.url=_5.replace("p="+p,"p="+p+":"+_3);
}
}
this.oRTM.appendUrl("&z="+this.oRTM.getFlashVersion());
this.oRTM.appendUrl("&bw="+this.oRTM.getBrowserWidth());
if(this.oRTM.getEncodingType()!=null){
this.oRTM.appendUrl("&enc="+this.oRTM.getEncodingType());
}
this.oRTM.registerGlobalNavPlacements();
if(!this.oRTM.oJSBean.onload){
this.onSend();
}else{
vjo.dsf.EventDispatcher.addEventListener(window,"load",this.onLoad,this);
}
vjo.dsf.EventDispatcher.addEventListener(window,"load",this.oRTM.setTimeOut,this.oRTM);
_2.returnData=false;
return _2;
},onLoad:function(){
var _7=this;
window.setTimeout(function(){
_7.onSend();
},0);
},onSend:function(){
var _8=this.oRTM,opt=_8.bOptimize,func=opt?_8.storeResponse:_8.setInlineContent;
var _9=new vjo.dsf.assembly.VjClientAssemblerRequest(_8.oJSBean.url,func,_8,"cb",!opt);
vjo.dsf.assembly.VjClientAssembler.load(_9);
}});

vjo.needs("vjo.dsf.typeextensions.string.Comparison");
vjo.needs("vjo.dsf.cookie.VjCookieJar");
vjo.needs("vjo.dsf.client.Browser");
vjo.needs("vjo.dsf.client.ActiveX");
vjo.needs("vjo.dsf.EventDispatcher");
vjo.needs("vjo.darwin.core.rtm.RTMInit");
vjo.type("vjo.darwin.core.rtm.RTM").protos({constructs:function(_1){
this.oJSBean=_1||{};
this.aContent=[];
this.iContentLen=0;
this.bTimedOut=false;
this.oTimeoutId=null;
this.iTIMEOUT=3000;
this.oClient=vjo.dsf.client.Browser;
this.bResponseReturned=false;
this.iOrd=(new Date()).getTime();
this.aGlobalNavPlacements=null;
this.promos=new Object();
this.response=null;
this.renderedStatus={};
this.bBodyLoaded=false;
this.bOptimize=true;
if(this.bOptimize){
vjo.dsf.EventDispatcher.add("body","load",this.render,this);
}
},getFlashVersion:function(){
var b=this.oClient;
var fv=0;
if(b.bIE&&b.bWin&&!b.bOpera){
for(var i=3;i<10;i++){
if(vjo.dsf.client.ActiveX.isLibLoaded("ShockwaveFlash.ShockwaveFlash."+i)){
fv=i;
}
}
}else{
if(navigator.plugins["Shockwave Flash"]){
var pd=navigator.plugins["Shockwave Flash"].description;
fv=parseInt(pd.charAt(pd.indexOf(".")-1));
}
if(b.bWebTV){
fv=3;
}
}
return fv;
},getEncodingType:function(){
var _6=null;
if(typeof (_GlobalNavHeaderUtf8Encoding)!="undefined"){
_6=_GlobalNavHeaderUtf8Encoding?"UTF-8":"cp1252";
}
return _6;
},setInlineContent:function(_7){
this.bResponseReturned=true;
this.visiblePromos=new Array();
if(this.bTimedOut){
return;
}
if(this.oTimeoutId){
window.clearTimeout(this.oTimeoutId);
}
this.hidePromos(this.promos);
this.aContent=_7;
this.iContentLen=this.aContent.length;
var _8=false;
this.bPromoScript=false;
this.bPromoStyle=false;
for(var i=0;i<this.iContentLen;i++){
with(this){
this.processPromo(aContent[i]);
}
}
var _a=new vjo.dsf.Message("RTM_COMPLETE");
_a.status=1;
_a.vjRTMObject=this;
vjo.dsf.ServiceEngine.handleRequest(_a);
if(_8){
var _a=new vjo.dsf.Message("PROMO_COMPLETE");
_a.vjPromoClientObject=this;
vjo.dsf.ServiceEngine.handleRequest(_a);
}
return;
},processPromoResponse:function(_b){
var _c=_b.content.data.map;
var _d=0;
var id="-1";
var _f=false;
for(var _10 in _c){
var _11=_10.match(/ME([0-9]+)(.*)/);
if(_11){
_d++;
id=_b.id;
}
}
var _12=_c.VisualPreview;
if(_12){
this.loadVisualPreview(_c.VisualPreview);
}
var _13=_c.Style;
if(_13&&!this.bPromoStyle){
this.loadStyle(_13);
this.bPromoStyle=true;
}
for(var _10 in _c){
var _11=_10.match(/ME([0-9]+)(.*)/);
if(_11){
promoLoaded=this.loadPromo(_b.id,_11[2],_c[_10],_d>1);
if(promoLoaded){
_f=true;
}
}
}
var _14=_c.Script;
if(_14&&!this.bPromoScript){
this.bPromoScript=this.loadScript(_14);
}
if(_f){
var _15=this.getIndex(id);
var _16=this.getUIElement(this.oJSBean.htmlIds[_15]);
if(_16&&!_16.length){
_16.style.display="block";
}
}else{
this.processNoneAd(_b);
}
return;
},loadVisualPreview:function(_17){
var _18=this.getUIElement("VisualPreviewContent");
if(_18==null){
_18=document.createElement("div");
_18.name="VisualPreviewContent";
document.body.appendChild(_18);
}
_18.innerHTML=_17;
},loadStyle:function(_19){
var _1a=document.body.appendChild(document.createElement("style"));
_1a.setAttribute("type","text/css");
if(_1a.styleSheet){
_1a.styleSheet.cssText=_19;
}else{
_1a.appendChild(document.createTextNode(_19));
}
},loadPromo:function(id,_1c,_1d,_1e){
var _1f=this.getIndex(id);
var _20;
if(_1e){
_20=this.oJSBean.merchPrefix+id+_1c;
}else{
_20=this.oJSBean.htmlIds[_1f];
}
var _21=this.getUIElement(_20);
if(this.getStatus(_20)){
return true;
}
if(_21&&!_21.length){
this.addStatus(_20,true);
var _22=document.createElement("div");
_22.innerHTML=_1d;
_21.appendChild(_22);
return true;
}else{
this.addStatus(_20,false);
}
return false;
},hidePromos:function(_23){
for(var _24 in _23){
var _25=document.getElementById(_24);
if(_25!=null){
_25.style.display="none";
}
}
},loadScript:function(_26){
with(window){
try{
eval(_26);
return true;
}
catch(except){
}
}
return false;
},processPopUnderAd:function(pAd){
var _28="height="+pAd.height;
_28+=",width="+pAd.width;
_28+=",menubars=no,scrollbars=no'";
var id="p_u_"+pAd.id;
var _2a=window.open("",id,_28);
if(_2a){
_2a.blur();
_2a.document.open();
_2a.document.write(pAd.content);
_2a.document.close();
}
return;
},processDoubleClickAd:function(pAd){
var _2c=this.oJSBean;
var _2d=this.getIndex(pAd.id);
var id=_2c.htmlIds[_2d];
var _2f=this.getUIElement(id);
var url=_2c.dblclkUrls[_2d];
if(this.getStatus(id)){
return;
}
if(_2f&&!_2f.length){
this.addStatus(id,true);
if(pAd.content!=""){
url+=pAd.content+";";
}
url+="ord="+this.iOrd;
_2f.innerHTML=this.createIframe(id,url,_2c.heights[_2d],_2c.widths[_2d]);
}else{
this.addStatus(id,false);
}
return;
},processNoneAd:function(pAd){
var _32=this.oJSBean;
var _33=this.getIndex(pAd.id);
var id=_32.htmlIds[_33];
var _35=this.getUIElement(id);
var _36=_32.defaultUrls[_33];
if(this.getStatus(id)){
return;
}
if(_35&&!_35.length){
this.addStatus(id,true);
if(!_36||_36=="collapse"||_36==""){
_35.style.height="0px";
_35.style.height="0px";
_35.style.display="none";
}else{
_35.innerHTML=this.createIframe(id,_36,_32.heights[_33],_32.widths[_33]);
}
}else{
this.addStatus(id,false);
}
return;
},processHTMLAd:function(pAd){
if(pAd.height=="-1"||pAd.height=="9999"){
pAd.height="auto";
}
if(pAd.width=="-1"||pAd.width=="9999"){
pAd.width="auto";
}
var _38=this.getIndex(pAd.id);
var _39=this.getUIElement(this.oJSBean.htmlIds[_38]);
if(this.getStatus(this.oJSBean.htmlIds[_38])){
return;
}
if(_39&&!_39.length){
this.addStatus(this.oJSBean.htmlIds[_38],true);
var _3a=_39.style,h,w;
_3a.height=h=(pAd.height.has("auto"))?pAd.height:pAd.height+"px";
_3a.width=w=(pAd.width.has("auto"))?pAd.width:pAd.width+"px";
if(h!="auto"&&w!="auto"){
_3a.overflow="hidden";
}
_39.innerHTML=pAd.content;
}else{
this.addStatus(this.oJSBean.htmlIds[_38],false);
}
return;
},processHTMLFormAd:function(pAd){
if(pAd.height=="-1"||pAd.height=="9999"){
pAd.height="auto";
}
if(pAd.width=="-1"||pAd.width=="9999"){
pAd.width="auto";
}
var _3c=this.getIndex(pAd.id);
var _3d=this.getUIElement(this.oJSBean.htmlIds[_3c]);
if(this.getStatus(this.oJSBean.htmlIds[_3c])){
return;
}
if(_3d&&!_3d.length){
this.addStatus(this.oJSBean.htmlIds[_3c],true);
var _3e=_3d.style,h,w;
_3e.height=h=(pAd.height.has("auto"))?pAd.height:pAd.height+"px";
_3e.width=w=(pAd.width.has("auto"))?pAd.width:pAd.width+"px";
if(h!="auto"&&w!="auto"){
_3e.overflow="hidden";
}
var _3f=document.createElement("iframe");
_3f.setAttribute("hspace",0);
_3f.setAttribute("vspace",0);
_3f.setAttribute("width","100%");
_3f.setAttribute("frameBorder",0);
_3f.setAttribute("scrolling","no");
_3f.setAttribute("marginWidth",0);
_3f.setAttribute("marginHeight",0);
_3d.appendChild(_3f);
_3f.doc=null;
if(_3f.contentDocument){
_3f.doc=_3f.contentDocument;
}else{
if(_3f.contentWindow){
_3f.doc=_3f.contentWindow.document;
}else{
if(_3f.document){
_3f.doc=_3f.document;
}
}
}
if(_3f.doc==null){
throw "Document not found, append the parent element to the DOM before creating the IFrame";
}
_3f.doc.open();
try{
_3f.doc.write(pAd.content);
}
finally{
_3f.doc.close();
}
}else{
this.addStatus(this.oJSBean.htmlIds[_3c],false);
}
return;
},getUIElement:function(_40){
var s=_40,d=window.document;
if(d.getElementById){
return d.getElementById(s);
}else{
if(d.all){
return d.all(s);
}
}
return null;
},getIndex:function(pId){
for(var i=0;i<this.iContentLen;i++){
if(this.aContent[i].id==pId){
return i;
}
}
return;
},createIframe:function(pId,_45,_46,_47){
var _48="ifrm_"+pId;
var f="<iframe frameborder=\"no\" border=\"0\" marginwidth=\"0\" marginheight=\"0\" scrolling=\"no\""+" id=\""+_48+"\""+" name=\""+_48+"\""+" src=\""+_45+"\""+" width=\""+_47+"\" height=\""+_46+"\"></iframe>";
return f;
},appendUrl:function(_4a){
this.oJSBean.url+=_4a;
},processGlobalNavPids:function(){
var _4b="";
var _4c;
if(typeof (_oGlobalNavRTMInfo)!="undefined"){
_4c=_oGlobalNavRTMInfo;
this.aGlobalNavPlacements=_4c.aRTMPlacementData;
}
if(_4c&&this.aGlobalNavPlacements&&this.aGlobalNavPlacements.length>0){
var _4d=_oGlobalNavRTMInfo.aRTMPlacementData,data;
for(i=0;i<_4d.length;i++){
data=_4d[i];
if(_4b){
_4b+=":";
}
_4b+=data.pid;
}
}
return _4b;
},registerGlobalNavPlacements:function(){
if(!this.aGlobalNavPlacements||this.aGlobalNavPlacements.length==0){
return;
}
var _4e=this.oJSBean;
var len=this.aGlobalNavPlacements.length;
for(var i=0;i<len;i++){
var _51=_4e.htmlIds.length;
var _52=this.aGlobalNavPlacements[i];
_4e.htmlIds[_51]=(_52.htmlId)?_52.htmlId:"glbl_nav_no_html_id";
_4e.pids[_51]=(_52.pid)?_52.pid:"glbl_nav_no_pid";
_4e.heights[_51]=(_52.maxHeight)?_52.maxHeight:"glbl_nav_no_height";
_4e.widths[_51]=(_52.maxWidth)?_52.maxWidth:"glbl_nav_no_width";
_4e.dblclkUrls[_51]=(_52.dblclkUrl)?_52.dblclkUrl:"glbl_nav_no_dblclk";
_4e.defaultUrls[_51]=(_52.defaultUrl)?_52.defaultUrl:"collapse";
}
},setTimeOut:function(){
if(!this.bResponseReturned){
var _53="vjo.darwin.core.rtm.RTM.processTimeOut()";
var _54=this;
var _55=function(){
_54.processTimeOut();
};
this.oTimeoutId=window.setTimeout(_55,this.iTIMEOUT);
}
},processTimeOut:function(){
this.bTimedOut=true;
var _56=this.oJSBean;
var _57=_56.defaultUrls.length;
for(var i=0;i<_57;i++){
var id=_56.htmlIds[i];
var _5a=this.getUIElement(id);
var _5b=_56.defaultUrls[i];
if(this.getStatus(id)){
continue;
}
if(_5a&&!_5a.length){
this.addStatus(id,true);
if(!_5b||_5b=="collapse"||_5b==""){
_5a.style.height="0px";
_5a.style.height="0px";
_5a.style.display="none";
}else{
_5a.innerHTML=this.createIframe(id,_5b,_56.heights[i],_56.widths[i]);
}
}else{
this.addStatus(id,false);
}
}
var _5c=_56.url;
var _5d=_5c.indexOf("&");
var _5e=Math.random();
_5c=_5c.substring(0,_5d);
_5c=_5c+"&p="+_56.pids.join(":")+"&ite=2"+"&to="+this.iTIMEOUT;
_5c=_5c.replace("RtmCmd","RtmIt");
var _5f=document.createElement("script");
_5f.type="text/javascript";
if(_5e<0.05){
_5f.src=_5c;
document.getElementsByTagName("head")[0].appendChild(_5f);
}
window.clearTimeout(this.oTimeoutId);
var _60=new vjo.dsf.Message("RTM_COMPLETE");
_60.status=0;
_60.vjRTMObject=this;
vjo.dsf.ServiceEngine.handleRequest(_60);
return;
},getBrowserWidth:function(){
var b=this.oClient;
var _62=document.body.clientWidth;
if(!b.bIE){
_62=window.innerWidth;
}
return _62;
},popUp:function(_63,_64,_65,_66,_67,_68,_69,_6a,_6b,_6c,_6d,_6e){
var sP="";
sP+=(_65!=null)?",width="+_65:"";
sP+=(_66!=null)?",height="+_66:"";
sP+=(_6a!=null)?",screenX="+_6a+",left="+_6a:"";
sP+=(_6b!=null)?",screenY="+_6b+",top="+_6b:"";
sP+=",toolbar="+((_68)?"1":"0");
sP+=",location="+((_6c)?"1":"0");
sP+=",status="+((_67)?"1":"0");
sP+=",scrollbars="+((_69)?"1":"0");
sP+=",resizable="+((_6d)?"1":"0");
sP+=",menubar="+((_6e)?"1":"0");
if(sP.length>0){
sP=sP.substring(1);
}
window.open(_64,_63,sP);
return false;
},getSegment:function(_70){
var oCJ=vjo.dsf.cookie.VjCookieJar,e=oCJ.readCookie("etfc"),r=oCJ.readCookie("reg"),s=oCJ.readCookie("ebay","sin"),c,n;
if(e=="0"){
n="3";
c="E";
}else{
if(e=="1"){
n="4";
c="C";
}else{
if(e=="2"){
n="5";
c="D";
}else{
if((e==""&&(r!=""&&r!=";"))||s=="in"||e=="5"){
n="2";
c="B";
}else{
n="1";
c="A";
}
}
}
}
return _70?c:n;
},addStatus:function(_72,_73){
this.renderedStatus[_72]=_73;
},getStatus:function(_74){
return this.renderedStatus[_74];
},storeResponse:function(_75){
var t=this,c=_75,qp;
t.response=c;
t.aContent=c;
t.iContentLen=c.length;
if(t.bBodyLoaded){
t.setInlineContent(c);
}else{
qp=t.oJSBean.quickPids;
if(qp&&qp.length>0){
t.renderPromos(t.oJSBean.quickPids);
}
}
},render:function(){
var t=this,r=t.response;
if(r){
t.setInlineContent(r);
}
t.bBodyLoaded=true;
},processPromo:function(_78){
with(this){
if(_78.type=="doubleclick"){
processDoubleClickAd(_78);
}else{
if(_78.type=="html"){
processHTMLAd(_78);
}else{
if(_78.type=="popUnder"){
processPopUnderAd(_78);
}else{
if(_78.type=="promo"){
bHasPromo=true;
processPromoResponse(_78);
}else{
if(_78.type=="htmlform"){
processHTMLFormAd(_78);
}else{
processNoneAd(_78);
}
}
}
}
}
}
},renderPromos:function(_79){
var r=this.response,i,j;
if(r){
for(j=0;j<r.length;j++){
for(i=0;i<_79.length;i++){
if(r[j].id==_79[i]+""){
this.processPromo(r[j]);
}
}
}
}
}});


// en_US/e583/MyEbayV4App_MyEbayBeta_e5837294829_3_en_US
// b=7294829