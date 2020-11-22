if(typeof (vjo)=="undefined"){
var vjo={};
}
vjo.global=this;
vjo._bScope=null;
vjo.createPkg=function(_1){
var _2=_1.split("."),len=_2.length;
var _3=this.global;
for(var i=0;i<len-1&&_3&&_2[i];i++){
_3=(_3[_2[i]])?_3[_2[i]]:_3[_2[i]]={};
}
return {pkg:_3,className:(len>0)?_2[len-1]:""};
};
vjo.needs=function(_5,_6){
if(!_5){
return;
}
if(!vjo._bScope){
vjo._bScope={};
}
var _7=vjo.createPkg(_5);
if(_7.pkg[_7.className]){
if(typeof _6=="string"&&_6!=""){
vjo._bScope[_6]=_7.pkg[_7.className];
}else{
vjo._bScope[_7.className]=_7.pkg[_7.className];
}
}
};
vjo.needsLib=function(){
};
vjo.type=function(_8){
var _9=function(){
this.b=_9.b;
if(this.base){
this.base.parent=this;
}
if(this.constructs){
var rv=this.constructs.apply(this,arguments);
if(rv){
return rv;
}
}
return null;
};
_9.props=function(_b){
for(var i in _b){
if(i!="props"&&i!="protos"&&i!="inherits"&&i!="prototype"&&i!="inits"&&i!="satisfies"&&i!="satisfiers"&&i!="b"){
_9[i]=_b[i];
}
}
return _9;
};
function createBaseMethod(_d,_e,_f){
_d.prototype.base[_f]=function(){
var _10=this.parent,supBase=(_e.prototype&&_e.prototype.base)?_e.prototype.base[_f]:null,curBase;
if(supBase){
curBase=_10.base[_f];
_10.base[_f]=supBase;
}
var scp=(this.parent)?this.parent:this;
var rv=_e.prototype[_f].apply(scp,arguments);
if(curBase){
_10.base[_f]=curBase;
}
return rv;
};
}
_9.protos=function(obj,_14){
for(var i in obj){
if(i!="base"&&i!="b"&&(!_14||i!="constructs")){
if(_14&&_14.prototype&&_14.prototype[i]&&typeof obj[i]=="function"){
createBaseMethod(_9,_14,i);
}
if((!_14&&!_9.prototype[i])&&_9.prototype.base&&_9.prototype.base[i]){
_9.prototype[i]=function(){
_9.prototype.base[i].apply(this,arguments);
};
}else{
if(!(_14&&_9.prototype[i])){
_9.prototype[i]=obj[i];
}
}
}
}
return _9;
};
function createBase(clz,_17){
return (function(){
var _18=_17.prototype.base||_17,constructs=this.constructs,curBase=this.base;
if(_17.prototype.constructs&&constructs){
this.constructs=_17.prototype.constructs;
}
this.base=function(){
_18.apply(this,arguments);
};
_17.apply(this,arguments);
if(constructs){
this.constructs=constructs;
}
this.base=curBase;
});
}
_9.inherits=function(_19){
var _1a=vjo.createPkg(_19);
var _1b=_1a.pkg[_1a.className];
_9.prototype.base=createBase(_9,_1b);
_9.protos(_1b.prototype,_1b);
_9.props(_1b);
return _9;
};
_9.singleton=function(){
return _9;
};
_9.inits=function(_1c){
var _1d=vjo.createPkg(_8);
if(typeof _1d.pkg[_1d.className]=="function"){
_1c.call(this);
}
return _9;
};
_9.satisfies=function(_1e){
return _9;
};
_9.satisfiers=function(_1f){
return _9;
};
_9.makeFinal=function(){
return _9;
};
_9.b=vjo._bScope;
vjo._bScope=null;
if(!_8){
return _9;
}
var _20=vjo.createPkg(_8);
return (_20.pkg[_20.className])?_9:(_20.pkg[_20.className]=_9);
};

vjo.type("vjo.dsf.Event").protos({constructs:function(_1,_2,_3){
this.src=_1;
this.eventType=_2;
this.nativeEvent=_3;
}});

vjo.type("vjo.dsf.Element").props({get:function(_1){
var d=document,e=null;
if(typeof (d.getElementById)!="undefined"){
e=d.getElementById(_1);
}else{
if(!e&&d.all){
e=d.all[_1];
}
}
return e;
},toggleHideShow:function(_3,_4){
var e=this.get(_3),s,d,u="undefined";
if(e){
s=e.style;
d=s.display;
if(typeof (_4)===u){
_4=(d===""||d==="block")?false:true;
}
e.bIsShown=_4;
s.display=(_4)?"block":"none";
}
},promoteToBody:function(_6){
var e=this.get(_6),b=document.body;
if(e&&b&&e.parentNode&&(e.parentNode!==b)){
e.parentNode.removeChild(e);
b.appendChild(e);
}
},toggleVisibility:function(_8,_9){
var e=this.get(_8),v,s,u="undefined";
if(e){
s=e.style;
v=s.visibility;
if(typeof (_9)===u){
_9=(v==="")?false:true;
}
e.bIsVisible=_9;
s.visibility=(_9)?"":"hidden";
}
},enable:function(_b,_c){
var e=this.get(_b);
if(e){
e.disabled=!_c;
}
},left:function(_e,_f){
return this.setLTWH(_e,_f,"Left");
},top:function(_10,_11){
return this.setLTWH(_10,_11,"Top");
},width:function(_12,_13){
return this.setLTWH(_12,_13,"Width");
},height:function(_14,_15){
return this.setLTWH(_14,_15,"Height");
},setLTWH:function(_16,_17,_18){
var e=this.get(_16);
if(e){
if((_17!=null)&&!isNaN(parseInt(_17))){
e.style[_18.toLowerCase()]=_17;
}
return e["offset"+_18];
}
},createElement:function(_1a){
return document.standardCreateElement?document.standardCreateElement(_1a):document.createElement(_1a);
},containsElement:function(_1b,_1c){
while((_1c!=null)&&(_1c!=_1b)&&(_1c.parentNode!=null)){
_1c=_1c.parentNode;
}
return (_1c==_1b);
},getElementByTagClass:function(_1d,tag,_1f){
var _20=_1d.getElementsByTagName(tag);
for(var ndx=0;((ndx<_20.length)&&(_20[ndx].className.match(_1f)==null));ndx++){
}
return (ndx<_20.length)?_20[ndx]:null;
},getElementsByTagClass:function(_22,tag,_24){
var _25=new Array();
var _26=_22.getElementsByTagName(tag);
for(var ndx=0;(ndx<_26.length);ndx++){
if(_26[ndx].className.match(_24)){
_25.push(_26[ndx]);
}
}
return _25;
}});

vjo.needs("vjo.dsf.Event");
vjo.needs("vjo.dsf.Element");
vjo.type("vjo.dsf.EventDispatcher").singleton().protos({constructs:function(){
this.eventHandlers={};
this.nativeEventHandlers={};
this.unboundElems=[];
this.fCustomLoad={};
},process:function(_1,_2){
var _3=this.eventHandlers[_1];
if(!_3){
return true;
}
var _4=_3[_2.eventType];
if(!_4){
return true;
}
var _5;
for(var i=0;i<_4.length;i++){
var _7=_4[i].handle(_2);
if(_7&&_7.objType=="dsf_Message"){
if(vjo.dsf.ServiceEngine){
vjo.dsf.ServiceEngine.handleRequest(_7);
}
if(_7.returnData===false){
_5=false;
}
}else{
if(_5!=false&&typeof _7!="undefined"){
_5=_7;
}
}
}
return _5;
},register:function(id,_9,_a,_b){
if(!id||!_9||!_a){
return this;
}else{
if(typeof _a.handle!="function"){
if(typeof _a=="function"){
var _c=_a,scp=_b||this;
var _d={handle:function(){
return _c.apply(scp,arguments);
}};
_a=_d;
}else{
return this;
}
}
}
var _e=this.eventHandlers[id];
if(!_e){
_e=this.eventHandlers[id]={};
}
if(!_e[_9]){
_e[_9]=[];
}
var _f=_e[_9].length;
_e[_9][_f]=_a;
return _a;
},unregister:function(id,_11){
if(!this.eventHandlers[id]){
return;
}
this.eventHandlers[id][_11]=[];
},registerNative:function(_12,_13,_14){
var id=(_12==window)?"body":_12.id;
var _16=this.nativeEventHandlers[id];
if(!_16){
_16=this.nativeEventHandlers[id]={};
}
if(!_16[_13]){
_16[_13]=[];
}
var len=_16[_13].length;
_16[_13][len]=_14;
},add:function(id,_19,_1a,_1b){
if(!id||!_19||!_1a){
return this;
}
var b=this.isBound(id,_19),rv=this.register(id,_19,_1a,_1b);
if(!b){
var b=this.bind(id,_19);
if(b==null){
var len=this.unboundElems.length;
this.unboundElems[len]=id;
}
}
return rv;
},addEventListener:function(_1e,_1f,_20,_21,_22){
var scp=_21||vjo.global;
if(typeof _1e=="string"){
_1e=this.b.Element.get(_1e);
}
if(!_1e){
return false;
}
var _24=function(_25){
var ev=_25||window.event;
var rv=_20.call(scp,ev,_1f);
if(rv===false){
vjo.dsf.EventDispatcher.stopEvent(ev);
}
if(typeof rv!="undefined"){
return rv;
}
};
if(window.addEventListener){
_1e.addEventListener(_1f,_24,_22||false);
this.registerNative(_1e,_1f,_24);
return _24;
}else{
if(window.attachEvent){
_1e.attachEvent("on"+_1f,_24);
this.registerNative(_1e,_1f,_24);
return _24;
}
}
_1e["on"+_1f]=_24;
return false;
},bind:function(id,_29){
var _2a=this.b.Element.get(id);
if(id=="body"||_2a==document.body){
_2a=document.body;
if(_29=="load"||_29=="unload"){
var rv=this.addEventListener(window,_29,function(_2c){
var oED=vjo.dsf.EventDispatcher;
if(typeof oED.fCustomLoad[_29]=="function"){
oED.fCustomLoad[_29]();
}
oED.run(document.body,_2c||window.event,_29);
oED.unregister("body",_29);
oED.fCustomLoad={};
});
if(rv===false){
if(_2a.vjLoadSet){
return this;
}else{
_2a.vjLoadSet=true;
var _2e=window["on"+_29]||"";
if(_2e){
this.fCustomLoad[_29]=_2e;
}
}
}
return this;
}
}
if(_2a){
this.addEventListener(_2a,_29,this.notifier,_2a);
return this;
}
return null;
},notifier:function(_2f,_30){
return vjo.dsf.EventDispatcher.run(this,_2f||window.event,_30);
},reBind:function(){
var eH=this.eventHandlers,uE=this.unboundElems,len=uE.length,tmp=[];
for(var i=0;i<len;i++){
var id=uE[i],hdls=eH[id];
if(hdls){
for(var _34 in hdls){
if(!this.hasBinding(id,_34)){
var rv=this.bind(id,_34);
if(rv==null){
tmp[tmp.length]=id;
}
}
}
}
}
this.unboundElems=tmp;
},isBound:function(id,_37){
var _38=this.eventHandlers[id];
return (_38&&_38[_37]&&_38[_37].length>0);
},hasBinding:function(id,_3a){
var nEH=this.nativeEventHandlers;
if(nEH[id]&&nEH[id][_3a]){
var aH=nEH[id][_3a],len=aH.length,rv=false;
for(var i=0;i<len;i++){
var str=aH[i].toString();
if(str&&str.indexOf("vjo.dsf.EventDispatcher")!=-1){
return true;
}
}
}
return false;
},removeEventListener:function(_3f,_40,_41){
if(!_3f||!_40){
return;
}else{
if(typeof _3f=="string"){
_3f=this.b.Element.get(_3f);
}
}
if(window.addEventListener&&_41){
_3f.removeEventListener(_40,_41,false);
}else{
if(window.attachEvent&&_41){
_3f.detachEvent("on"+_40,_41);
}else{
_3f["on"+_40]=null;
}
}
},detachNativeHandlers:function(_42,_43){
var id=(_42==window)?"body":_42.id;
var _45=this.nativeEventHandlers[id];
if(_45&&_45[_43]){
var h=_45[_43];
for(var i=0;i<h.length;i++){
this.removeEventListener(_42,_43,_45[_43][i]);
}
_45[_43]=[];
}
},detachHandler:function(id,_49,_4a){
var _4b=this.eventHandlers[id];
if(!_4b||!_4b[_49]){
return;
}
var h=[],len=_4b[_49].length;
for(var i=0;i<len;i++){
if(_4a!=_4b[_49][i]){
h[h.length]=_4b[_49][i];
}
}
this.eventHandlers[id][_49]=h;
},detachHandlers:function(id,_4f){
this.unregister(id,_4f);
var _50=this.b.Element.get(id);
if(id=="body"){
_50=window;
}
if(_50){
this.detachNativeHandlers(_50,_4f);
}
},stopEvent:function(evt){
this.stopPropagation(evt);
this.preventDefault(evt);
},stopPropagation:function(evt){
if(evt.stopPropagation){
evt.stopPropagation();
}else{
evt.cancelBubble=true;
}
},preventDefault:function(evt){
if(evt.preventDefault){
evt.preventDefault();
}else{
evt.returnValue=false;
}
},target:function(_54){
return this.resolveTextNode((_54.target)?_54.target:_54.srcElement);
},relatedTarget:function(_55){
if(_55.relatedTarget){
return this.resolveTextNode(_55.relatedTarget);
}else{
if((_55.type=="mouseover")&&_55.fromElement){
return this.resolveTextNode(_55.fromElement);
}else{
if((_55.type=="mouseout")&&_55.toElement){
return this.resolveTextNode(_55.toElement);
}else{
return null;
}
}
}
},resolveTextNode:function(_56){
return (_56&&(_56.nodeType==3))?_56.parentNode:_56;
},cleanUp:function(){
var _57=this.nativeEventHandlers;
for(var id in _57){
for(var ev in _57[id]){
if(ev!="unload"){
this.detachHandlers(id,ev,true);
}
}
}
},getId:function(src,id){
var _5c=id;
if(_5c===null||!_5c){
_5c=src.id;
}
return _5c;
},getBodyId:function(src,id){
var _5f=this.getId(src,id);
if(!_5f||src==document.body){
_5f="body";
}
return _5f;
},unload:function(src,_61){
return this.process(this.getBodyId(src),new vjo.dsf.Event(src,"unload",_61));
},change:function(src,_63){
return this.process(this.getId(src),new vjo.dsf.Event(src,"change",_63));
},submit:function(src,_65){
return this.process(this.getId(src),new vjo.dsf.Event(src,"submit",_65));
},reset:function(src,_67){
return this.process(this.getId(src),new vjo.dsf.Event(src,"reset",_67));
},select:function(src,_69){
return this.process(this.getId(src),new vjo.dsf.Event(src,"select",_69));
},blur:function(src,_6b){
return this.process(this.getId(src),new vjo.dsf.Event(src,"blur",_6b));
},focus:function(src,_6d){
return this.process(this.getId(src),new vjo.dsf.Event(src,"focus",_6d));
},keydown:function(src,_6f){
return this.process(this.getBodyId(src),new vjo.dsf.Event(src,"keydown",_6f));
},keypress:function(src,_71){
return this.process(this.getBodyId(src),new vjo.dsf.Event(src,"keypress",_71));
},keyup:function(src,_73){
return this.process(this.getBodyId(src),new vjo.dsf.Event(src,"keyup",_73));
},click:function(src,_75){
return this.process(this.getBodyId(src),new vjo.dsf.Event(src,"click",_75));
},dblclick:function(src,_77){
return this.process(this.getBodyId(src),new vjo.dsf.Event(src,"dblclick",_77));
},mousedown:function(src,_79){
return this.process(this.getBodyId(src),new vjo.dsf.Event(src,"mousedown",_79));
},mousemove:function(src,_7b){
return this.process(this.getBodyId(src),new vjo.dsf.Event(src,"mousemove",_7b));
},mouseout:function(src,_7d){
return this.process(this.getBodyId(src),new vjo.dsf.Event(src,"mouseout",_7d));
},mouseover:function(src,_7f){
return this.process(this.getBodyId(src),new vjo.dsf.Event(src,"mouseover",_7f));
},mouseup:function(src,_81){
return this.process(this.getBodyId(src),new vjo.dsf.Event(src,"mouseup",_81));
},load:function(src,_83){
return this.run(src,_83,"load");
},run:function(src,_85,_86){
var id=this.getBodyId(src);
var _88=new vjo.dsf.Event(src,_86,_85);
var rv=this.process(id,_88);
if(_86==="load"&&id==="body"){
this.unregister("body","load");
}
return rv;
}}).inits(function(){
vjo.dsf.EventDispatcher=new vjo.dsf.EventDispatcher();
vjo.dsf.EventDispatcher.addEventListener(window,"load",function(){
vjo.dsf.EventDispatcher.addEventListener(window,"unload",function(){
vjo.dsf.EventDispatcher.cleanUp();
});
});
});

vjo.type("vjo.dsf.RemoteReqtHdl").protos({constructs:function(){
this.reqTimers={};
this.timerCount=0;
this.processed={};
},handleRequest:function(_1){
_1.trace=_1.trace+"-->RemoteHdl_"+_1.svcId;
if(_1.svcConfig){
this.invoke(_1);
}
},invoke:function(_2){
var _3=vjo.dsf.Service,xmlHttpReq=_3.getXmlHttpReq(),requestUrl=_2.svcConfig.url,cfg=_2.svcConfig;
_2.status=-1;
if(cfg.respMarshalling=="JSCALLBACK"){
vjo.dsf.XDomainRequest.send(_2);
return;
}
try{
var _4=(cfg.async===false)?false:true;
xmlHttpReq.open(cfg.method,requestUrl,_4);
}
catch(e){
var _5=new vjo.dsf.ServiceResponse();
var _6=new vjo.dsf.Error();
_6.id="SYS.DARWIN_SERVICE_PROTOCOL_ERROR";
_6.message="SYS.PROTOCOL_ERROR: Cannot open URL '"+requestUrl+"'";
_5.errors=[_6];
_2.response=_5;
vjo.dsf.ServiceEngine.handleResponse(_2);
return;
}
var _7=this.timerCount++;
this.setupReadyState(xmlHttpReq,_2,_7);
if(cfg.method=="POST"){
xmlHttpReq.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
xmlHttpReq.setRequestHeader("Content-Length",_2.rawRequest.length);
xmlHttpReq.send(_2.rawRequest);
}else{
xmlHttpReq.send(null);
}
if(cfg.timeout){
var _8=this;
this.reqTimers[_7]=window.setTimeout(function(){
_8.timeout(xmlHttpReq,_2,_7);
},cfg.timeout);
}
},setupReadyState:function(_9,_a,_b){
var _c=this;
_9.onreadystatechange=function(){
if(_9.readyState!=4){
return;
}
if(_c.processed[_b]){
return;
}
_c.processed[_b]=true;
var _d=_c.reqTimers[_b];
if(_d){
window.clearTimeout(_d);
delete _c.reqTimers[_b];
}
vjo.dsf.Service.callback(_9,_a);
};
},timeout:function(_e,_f,idx){
if(this.processed[idx]){
return;
}
this.processed[idx]=true;
delete _e.onreadystatechange;
_e.abort();
delete this.reqTimers[idx];
var _11=new vjo.dsf.ServiceResponse();
var _12=new vjo.dsf.Error();
_12.id="SYS.DARWIN_SERVICE_PROTOCOL_ERROR";
_12.message="SYS.PROTOCOL_ERROR: Service timed out.";
_11.errors=[_12];
_f.response=_11;
vjo.dsf.ServiceEngine.handleResponse(_f);
}});

vjo.type("vjo.dsf.ServiceResponse").protos({constructs:function(){
this.objType="dsf_ServiceResponse";
this.errors=[];
this.data=null;
}});

vjo.needs("vjo.dsf.ServiceResponse");
vjo.type("vjo.dsf.InProcReqtHdl").protos({constructs:function(){
this.svcHdls={};
},registerSvcHdl:function(_1,_2){
this.svcHdls[_1]=_2;
},getSvcHdl:function(_3){
return this.svcHdls[_3];
},handleRequest:function(_4){
var _5=this.svcHdls[_4.svcId];
if(_5){
var _6=new vjo.dsf.ServiceResponse();
_6.data=_5.invoke(_4);
_4.trace=_4.trace+"-->SvcHdl_"+_4.svcId;
if(_6){
_4.response=_6;
}
}
if(typeof _4.status=="undefined"||_4.status==null){
_4.status=1;
}
}});

vjo.type("vjo.dsf.Error").protos({constructs:function(_1,_2){
this.id=_1;
this.message=_2;
}});

vjo.type("vjo.dsf.Enc").inits(function(){
if(typeof (vjo.dsf.Enc.unescape)!="undefined"){
return;
}
vjo.dsf.Enc.unescape=window.unescape;
vjo.dsf.Enc.decodeURI=window.decodeURI;
vjo.dsf.Enc.decodeURIComponent=window.decodeURIComponent;
vjo.dsf.Enc.encodeURIComponent=window.encodeURIComponent;
vjo.dsf.Enc.encodeURI=window.encodeURI;
});

vjo.needs("vjo.dsf.Error");
vjo.needs("vjo.dsf.ServiceResponse");
vjo.needs("vjo.dsf.Enc");
vjo.type("vjo.dsf.Service").props({callback:function(_1,_2){
try{
if(_1.readyState!=4){
return;
}
if(_1.status>=200&&_1.status<300){
var _3=_1.responseText;
if(_2.svcConfig.respMarshalling=="JSON"){
try{
_3=eval("("+_3+")");
}
catch(e){
_3=new vjo.dsf.ServiceResponse();
var _4=new vjo.dsf.Error();
_4.id="SYS.JSON_PARSE_ERROR";
_4.message="SYS.JSON_PARSE_ERROR";
_3.errors=[_4];
}
}else{
if(_2.svcConfig.respMarshalling=="XML"){
_3=_1.responseXML;
}
}
_2.response=_3;
_2.status=1;
}else{
var _5=new vjo.dsf.ServiceResponse();
var _4=new vjo.dsf.Error();
_4.id="SYS.DARWIN_SERVICE_PROTOCOL_ERROR";
_4.message="SYS.PROTOCOL_ERROR: status = "+_1.status;
_5.errors=[_4];
_2.response=_5;
}
}
catch(e){
var _5=new vjo.dsf.ServiceResponse();
var _4=new vjo.dsf.Error();
_4.id="SYS.DARWIN_SERVICE_PROTOCOL_ERROR";
_4.message="SYS.PROTOCOL_ERROR: unknown ";
_5.errors=[_4];
_2.response=_5;
}
vjo.dsf.ServiceEngine.handleResponse(_2);
delete _1.onreadystatechange;
_1=null;
},getXmlHttpReq:function(){
var _6=false;
try{
_6=new ActiveXObject("Msxml2.XMLHTTP");
}
catch(e){
try{
_6=new ActiveXObject("Microsoft.XMLHTTP");
}
catch(e){
_6=false;
}
}
if(!_6&&typeof XMLHttpRequest!="undefined"){
_6=new XMLHttpRequest();
}
return _6;
},getClientInfo:function(){
if(this.clientInfo){
return this.clientInfo;
}
var nv=navigator,agt=nv.userAgent.toLowerCase(),i=0,ver=b="";
if(agt.indexOf("firefox")!=-1){
b="Firefox";
i=agt.lastIndexOf("firefox")+8;
}else{
if((/webkit|khtml/).test(agt)){
b="Safari";
i=agt.lastIndexOf("safari")+7;
}else{
if(typeof (window.opera)!="undefined"){
b="Opera";
i=agt.lastIndexOf("opera")+6;
}else{
if(nv.appName=="Netscape"){
b="Netscape";
i=agt.lastIndexOf("/")+1;
}else{
if(agt.indexOf("msie")!=-1){
b="IE";
i=agt.indexOf("msie")+4;
}
}
}
}
}
if(b){
ver=parseInt((b=="Opera")?window.opera.version():agt.substring(i));
}
this.clientInfo=b+":"+ver+":";
return this.clientInfo;
},generateReqParams:function(_8){
var _9="svcid="+vjo.dsf.Enc.encodeURIComponent(_8.svcId);
if(_8.stok){
_9+="&stok="+_8.stok;
}
if(_8.pId){
_9+="&pId="+_8.pId;
}
_9=_9+"&reqttype="+_8.svcConfig.reqtMarshalling;
_9=_9+"&resptype="+_8.svcConfig.respMarshalling;
_9=_9+"&clientType="+this.getClientInfo();
_9+="&request=";
var _a=_8.request,reqtmarsh=_8.svcConfig.reqtMarshalling;
if(reqtmarsh=="JSON"){
_9+=vjo.dsf.Enc.encodeURIComponent(JSON.stringify(_a));
}else{
if(reqtmarsh=="JSCALLBACK"){
_9+=vjo.dsf.Enc.encodeURIComponent(JSON.stringify(_a));
}else{
if(reqtmarsh=="XML"){
_9+=vjo.dsf.Enc.encodeURIComponent(dsf_xmlize(_a,"Request"));
}else{
_9+=vjo.dsf.Enc.encodeURIComponent(_a);
}
}
}
return _9;
},xmlize:function(_b,_c,_d){
_d=_d?_d:"";
var s=_d+"<"+_c+">";
if(!(_b instanceof Object)||_b instanceof Number||_b instanceof String||_b instanceof Boolean||_b instanceof Date){
s+=dsf_escape(""+_b);
}else{
s+="\n";
var _f="";
var _10=_b instanceof Array;
for(var _11 in _b){
if(_10&&_11=="______array"){
continue;
}
s+=this.xmlize(_b[_11],(_10?"array-item key=\""+_11+"\"":_11),_d+"   ");
}
s+=_d;
}
return s+=(_c.indexOf(" ")!=-1?"</array-item>\n":"</"+_c+">\n");
},escape:function(_12){
return _12.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;").replace(/'/g,"&apos;");
}});

vjo.type("vjo.dsf.SvcConfig").protos({constructs:function(_1,_2){
this.objType="dsf_SvcConfig";
this.url=_2;
this.method=_1;
this.reqtMarshalling="raw";
this.respMarshalling="raw";
this.async=true;
this.timeout=0;
}});

vjo.needs("vjo.dsf.EventDispatcher");
vjo.type("vjo.dsf.XDomainRequest").protos({constructs:function(){
this.callbacks=[];
this.sCallbackName="callback";
this.sPreId="xdr_";
this.sPreExtId=this.sPreId+"ext_";
this.iCount=0;
this.bUseIframe=(navigator.userAgent.indexOf("Firefox")>0);
vjo.dsf.EventDispatcher.addEventListener(window,"load",this.onLoad,this);
},onLoad:function(){
this.bodyLoaded=true;
},getReqDiv:function(){
return document.getElementsByTagName(this.bodyLoaded?"body":"head")[0];
},send:function(_1){
if(!document.createElement||!_1){
return;
}
var _2="",eid="";
if(typeof _1=="string"){
_2=_1;
eid=this.sPreExtId+this.iCount++;
}else{
if(_1.objType=="dsf_Message"&&_1.svcConfig){
var cb=this.createCallback(_1);
eid=this.sPreId+this.callbacks[this.callbacks.length-1];
_2=_1.svcConfig.url+"&callback="+cb;
}
}
var _4=null,doc;
if(this.bUseIframe){
var _5="<scr"+"ipt src=\""+_2+"\" type=\"text/javascript\"></scr"+"ipt>";
_4=this.createElement("iframe");
_4.height=1;
_4.width=1;
_4.id=eid;
_4.style.display="none";
this.getReqDiv().appendChild(_4);
doc=_4.document||_4.contentDocument;
doc.open();
doc.write("<html><head></head><body>"+_5+"</body></html>");
doc.close();
}else{
doc=document;
var _6=this.createElement("script");
_6.id=eid;
_6.type="text/javascript";
_6.src=_2;
this.getReqDiv().appendChild(_6);
}
return eid;
},createCallback:function(_7){
var _8=this.callbacks.length,name=this.sCallbackName+_8,eid=this.sPreId+name;
this.callbacks[_8]=name;
this[name]=function(_9){
var _a;
try{
_a=_9;
}
catch(e){
_a=new vjo.dsf.ServiceResponse();
var _b=new vjo.dsf.Error();
_b.id="SYS.JSON_PARSE_ERROR";
_b.message="SYS.JSON_PARSE_ERROR";
_a.errors=[_b];
}
this.loaded(eid);
_7.response=_a;
vjo.dsf.ServiceEngine.handleResponse(_7);
};
var rv="vjo.dsf.XDomainRequest."+name;
if(this.bUseIframe){
rv="parent."+rv;
}
return rv;
},loaded:function(_d){
var e=document.getElementById(_d);
if(e!=null){
e.parentNode.removeChild(e);
}
},createElement:function(_f){
return (typeof (createElementV4)!="undefined")?createElementV4(_f):document.createElement(_f);
}}).inits(function(){
vjo.dsf.XDomainRequest=new vjo.dsf.XDomainRequest();
});

vjo.type("vjo.dsf.Message").protos({constructs:function(_1){
this.objType="dsf_Message";
this.svcId=_1;
this.request;
this.response;
this.rawRequest="";
this.clientContext={};
this.trspType="InProc";
this.status;
this.svcConfig;
this.returnData=true;
this.trace="";
}});

// @JsDoNotOptimize
// @JsDoNotLintValidate
// @Package vjo.dsf

var JSON = {
    org: 'http://www.JSON.org',
    copyright: '(c)2005 JSON.org',
    license: 'http://www.crockford.com/JSON/license.html',

    stringify: function (arg) {
        var c, i, l, s = '', v;

        switch (typeof arg) {
        case 'object':
            if (arg) {
                if (arg instanceof Array) {
                    for (i = 0; i < arg.length; ++i) {
                        v = this.stringify(arg[i]);
                        if (s) {
                            s += ',';
                        }
                        s += v;
                    }
                    return '[' + s + ']';
                } else if (typeof arg.toString != 'undefined') {
                    for (i in arg) {
                        v = arg[i];
                        if (typeof v != 'undefined' && typeof v != 'function') {
                            v = this.stringify(v);
                            if (s) {
                                s += ',';
                            }
                            s += this.stringify(i) + ':' + v;
                        }
                    }
                    return '{' + s + '}';
                }
            }
            return 'null';
        case 'number':
            return isFinite(arg) ? String(arg) : 'null';
        case 'string':
            l = arg.length;
            s = '"';
            for (i = 0; i < l; i += 1) {
                c = arg.charAt(i);
                if (c >= ' ') {
                    if (c == '\\' || c == '"') {
                        s += '\\';
                    }
                    s += c;
                } else {
                    switch (c) {
                        case '\b':
                            s += '\\b';
                            break;
                        case '\f':
                            s += '\\f';
                            break;
                        case '\n':
                            s += '\\n';
                            break;
                        case '\r':
                            s += '\\r';
                            break;
                        case '\t':
                            s += '\\t';
                            break;
                        default:
                            c = c.charCodeAt();
                            s += '\\u00' + Math.floor(c / 16).toString(16) +
                                (c % 16).toString(16);
                    }
                }
            }
            return s + '"';
        case 'boolean':
            return String(arg);
        default:
            return 'null';
        }
    },
    parse: function (text) {
        var at = 0;
        var ch = ' ';

        function error(m) {
            throw {
                name: 'JSONError',
                message: m,
                at: at - 1,
                text: text
            };
        }

        function next() {
            ch = text.charAt(at);
            at += 1;
            return ch;
        }

        function white() {
            while (ch !== '' && ch <= ' ') {
                next();
            }
        }

        function str() {
            var i, s = '', t, u;

            if (ch == '"') {
outer:          while (next()) {
                    if (ch == '"') {
                        next();
                        return s;
                    } else if (ch == '\\') {
                        switch (next()) {
                        case 'b':
                            s += '\b';
                            break;
                        case 'f':
                            s += '\f';
                            break;
                        case 'n':
                            s += '\n';
                            break;
                        case 'r':
                            s += '\r';
                            break;
                        case 't':
                            s += '\t';
                            break;
                        case 'u':
                            u = 0;
                            for (i = 0; i < 4; i += 1) {
                                t = parseInt(next(), 16);
                                if (!isFinite(t)) {
                                    break outer;
                                }
                                u = u * 16 + t;
                            }
                            s += String.fromCharCode(u);
                            break;
                        default:
                            s += ch;
                        }
                    } else {
                        s += ch;
                    }
                }
            }
            error("Bad string");
        }

        function arr() {
            var a = [];

            if (ch == '[') {
                next();
                white();
                if (ch == ']') {
                    next();
                    return a;
                }
                while (ch) {
                    a.push(val());
                    white();
                    if (ch == ']') {
                        next();
                        return a;
                    } else if (ch != ',') {
                        break;
                    }
                    next();
                    white();
                }
            }
            error("Bad array");
        }

        function obj() {
            var k, o = {};

            if (ch == '{') {
                next();
                white();
                if (ch == '}') {
                    next();
                    return o;
                }
                while (ch) {
                    k = str();
                    white();
                    if (ch != ':') {
                        break;
                    }
                    next();
                    o[k] = val();
                    white();
                    if (ch == '}') {
                        next();
                        return o;
                    } else if (ch != ',') {
                        break;
                    }
                    next();
                    white();
                }
            }
            error("Bad object");
        }

        function num() {
            var n = '', v;
            if (ch == '-') {
                n = '-';
                next();
            }
            while (ch >= '0' && ch <= '9') {
                n += ch;
                next();
            }
            if (ch == '.') {
                n += '.';
                while (next() && ch >= '0' && ch <= '9') {
                    n += ch;
                }
            }
            if (ch == 'e' || ch == 'E') {
                n += 'e';
                next();
                if (ch == '-' || ch == '+') {
                    n += ch;
                    next();
                }
                while (ch >= '0' && ch <= '9') {
                    n += ch;
                    next();
                }
            }
            v = +n;
            if (!isFinite(v)) {
                error("Bad number");
            } else {
                return v;
            }
        }

        function word() {
            switch (ch) {
                case 't':
                    if (next() == 'r' && next() == 'u' && next() == 'e') {
                        next();
                        return true;
                    }
                    break;
                case 'f':
                    if (next() == 'a' && next() == 'l' && next() == 's' &&
                            next() == 'e') {
                        next();
                        return false;
                    }
                    break;
                case 'n':
                    if (next() == 'u' && next() == 'l' && next() == 'l') {
                        next();
                        return null;
                    }
                    break;
            }
            error("Syntax error");
        }

        function val() {
            white();
            switch (ch) {
                case '{':
                    return obj();
                case '[':
                    return arr();
                case '"':
                    return str();
                case '-':
                    return num();
                default:
                    return ch >= '0' && ch <= '9' ? num() : word();
            }
        }

        return val();
    }
};

vjo.needs("vjo.dsf.RemoteReqtHdl");
vjo.needs("vjo.dsf.InProcReqtHdl");
vjo.needs("vjo.dsf.Service");
vjo.needs("vjo.dsf.ServiceResponse");
vjo.needs("vjo.dsf.SvcConfig");
vjo.needs("vjo.dsf.XDomainRequest");
vjo.needs("vjo.dsf.Message");
vjo.needs("vjo.dsf.Json");
vjo.type("vjo.dsf.ServiceEngine").singleton().protos({STATUS:{ABORT:-1,JUMP:1},constructs:function(){
this.svcReqtHdls={};
this.svcRespHdls={};
this.glbReqtHdls=[];
this.glbRespHdls=[];
this.trspReqtHdls={};
this.trspRespHdls={};
this.svcHdls={};
this.inProcHdl=new vjo.dsf.InProcReqtHdl();
this.remoteHdl=new vjo.dsf.RemoteReqtHdl();
this.registerTrspReqtHdl("Remote",this.remoteTrspHdl);
},handleRequest:function(_1){
var _2;
if(_1.status!=this.STATUS.ABORT&&typeof _2=="undefined"){
_2=this.processServiceRequestHandlers(_1);
}
if(_1.status!=this.STATUS.ABORT&&typeof _2=="undefined"){
_2=this.processGlobalRequestHandlers(_1);
}
if(_1.status!=this.STATUS.ABORT&&typeof _2=="undefined"){
_2=this.processTransportHandlers(_1);
}
if(_1.status!=this.STATUS.ABORT&&(_1.trspType!="Remote"||typeof _2!="undefined")){
this.handleResponse(_1,_2);
}
return _1.returnData;
},processServiceRequestHandlers:function(_3){
var _4;
var _5=this.svcReqtHdls[_3.svcId];
if(_5){
try{
for(var i=0;i<_5.length;i++){
_3.trace=_3.trace+"-->svcReqtHdl_"+i;
_5[i].handleRequest(_3);
if(_3.status==this.STATUS.JUMP){
_4="SVC";
this.genResponseError(_3,"SYS.SVC_REQUEST_ERROR","SYS.SVC_REQUEST_ERROR");
break;
}
}
}
catch(e){
_4="SVC";
this.genResponseError(_3,"SYS.SVC_REQUEST_ERROR","SYS.SVC_REQUEST_ERROR");
}
}
return _4;
},processGlobalRequestHandlers:function(_7){
var _8;
if(_7.status!=this.STATUS.JUMP){
try{
for(var i=0;i<this.glbReqtHdls.length;i++){
_7.trace=_7.trace+"-->glbReqtHdl_"+i;
this.glbReqtHdls[i].handleRequest(_7);
if(_7.status==this.STATUS.JUMP){
_8="GLB";
this.genResponseError(_7,"SYS.GLOBAL_REQUEST_ERROR","SYS.GLOBAL_REQUEST_ERROR");
break;
}
}
}
catch(e){
_8="GLB";
this.genResponseError(_7,"SYS.GLOBAL_REQUEST_ERROR","SYS.GLOBAL_REQUEST_ERROR");
}
}
return _8;
},processTransportHandlers:function(_a){
var _b;
if(_a.status!=this.STATUS.JUMP&&_a.trspType){
var _c=this.trspReqtHdls[_a.trspType];
if(_c){
try{
for(var i=0;i<_c.length;i++){
_a.trace=_a.trace+"-->trspReqtHdl_"+i;
_c[i].handleRequest(_a);
if(_a.status==this.STATUS.JUMP){
this.genResponseError(_a,"SYS.TRANS_REQUEST_ERROR","SYS.TRANS_REQUEST_ERROR");
break;
}
}
}
catch(e){
this.genResponseError(_a,"SYS.TRANS_REQUEST_ERROR","SYS.TRANS_REQUEST_ERROR");
}
}
if(_a.status!=this.STATUS.JUMP&&_a.status!=this.STATUS.ABORT){
if(_a.trspType==="Remote"){
this.remoteHdl.handleRequest(_a);
}else{
this.inProcHdl.handleRequest(_a);
}
}
}
return _b;
},handleResponse:function(_e,_f){
if(_e.trspType&&typeof _f=="undefined"){
this.processTransResponseHandlers(_e);
}
if(_f!="SVC"){
this.processGlobalResponseHandlers(_e);
}
this.processServiceResponseHandlers(_e);
},processTransResponseHandlers:function(msg){
var _11=this.trspRespHdls[msg.trspType];
try{
if(_11){
for(var i=_11.length-1;i>=0;i--){
msg.trace=msg.trace+"-->trspRespHdl_"+i;
_11[i].handleResponse(msg);
}
}
}
catch(e){
this.genResponseError(msg,"SYS.TRANS_RESPONSE_ERROR","SYS.TRANS_RESPONSE_ERROR");
}
},processGlobalResponseHandlers:function(msg){
try{
for(var i=this.glbRespHdls.length-1;i>=0;i--){
msg.trace=msg.trace+"-->glbRespHdl_"+i;
this.glbRespHdls[i].handleResponse(msg);
}
}
catch(e){
this.genResponseError(msg,"SYS.GLOB_RESPONSE_ERROR","SYS.GLOB_RESPONSE_ERROR");
}
},processServiceResponseHandlers:function(msg){
var _16;
if(msg.clientContext){
_16=msg.clientContext.svcApplier;
}
try{
if(_16){
if(typeof _16.onResponse=="function"){
_16.onResponse(msg);
}else{
if(typeof _16=="function"){
_16(msg);
}
}
}
}
catch(e){
this.genResponseError(msg,"SYS.SVC_RESPONSE_ERROR","SYS.SVC_RESPONSE_ERROR");
}
var _17=this.svcRespHdls[msg.svcId];
if(_17){
try{
for(var i=_17.length-1;i>=0;i--){
msg.trace=msg.trace+"-->svcRespHdl_"+i;
_17[i].handleResponse(msg);
}
}
catch(e){
this.genResponseError(msg,"SYS.SVC_RESPONSE_ERROR","SYS.SVC_RESPONSE_ERROR");
}
}
},createHandler:function(_19,_1a){
if(typeof _19[_1a]!="function"){
if(typeof _19=="function"){
var _1b=_19;
var obj={};
obj[_1a]=function(){
return _1b.apply(this,arguments);
};
_19=obj;
}
}
return _19;
},registerSvcHdl:function(_1d,_1e){
if(!_1d||!_1e){
return;
}
_1e=this.createHandler(_1e,"invoke");
this.inProcHdl.registerSvcHdl(_1d,_1e);
},getSvcHdl:function(_1f){
return this.inProcHdl.getSvcHdl(_1f);
},registerSvcReqtHdl:function(_20,_21){
if(!_20||!_21){
return;
}
if(typeof this.svcReqtHdls[_20]=="undefined"){
this.svcReqtHdls[_20]=[];
}
var _22=this.svcReqtHdls[_20];
_22[_22.length]=this.createHandler(_21,"handleRequest");
},registerSvcRespHdl:function(_23,_24){
if(!_23||!_24){
return;
}
if(typeof this.svcRespHdls[_23]=="undefined"){
this.svcRespHdls[_23]=[];
}
var _25=this.svcRespHdls[_23];
_25[_25.length]=this.createHandler(_24,"handleResponse");
},registerGlbReqtHdl:function(_26){
if(!_26){
return;
}
this.glbReqtHdls[this.glbReqtHdls.length]=this.createHandler(_26,"handleRequest");
},registerGlbRespHdl:function(_27){
if(!_27){
return;
}
this.glbRespHdls[this.glbRespHdls.length]=this.createHandler(_27,"handleResponse");
},registerTrspReqtHdl:function(_28,_29){
if(!_28||!_29){
return;
}
if(typeof this.trspReqtHdls[_28]=="undefined"){
this.trspReqtHdls[_28]=[];
}
var _2a=this.trspReqtHdls[_28];
_2a[_2a.length]=this.createHandler(_29,"handleRequest");
},registerTrspRespHdl:function(_2b,_2c){
if(!_2b||!_2c){
return;
}
if(typeof this.trspRespHdls[_2b]=="undefined"){
this.trspRespHdls[_2b]=[];
}
var _2d=this.trspRespHdls[_2b];
_2d[_2d.length]=this.createHandler(_2c,"handleResponse");
},remoteTrspHdl:function(_2e){
var cfg=_2e.svcConfig;
if(!cfg||cfg.objType!="dsf_SvcConfig"){
return;
}else{
if(cfg.respMarshalling=="JSCALLBACK"){
if(typeof vjo.dsf.assembly!="undefined"&&typeof vjo.dsf.assembly.VjClientAssembler!="undefined"&&!vjo.dsf.assembly.VjClientAssembler.bBodyLoaded){
vjo.dsf.assembly.VjClientAssembler.load(_2e);
_2e.status=-1;
return;
}
}
}
var svc=vjo.dsf.Service,requestParams=svc.generateReqParams(_2e),requestUrl=cfg.url;
if(_2e.svcConfig.method=="GET"){
requestUrl=requestUrl+"?"+requestParams;
}else{
_2e.rawRequest=requestParams;
}
_2e.svcConfig.url=requestUrl;
},genResponseError:function(msg,_32,_33){
if(typeof msg.response=="undefined"){
var _34=new vjo.dsf.ServiceResponse();
msg.response=_34;
}
var _35=new vjo.dsf.Error(_32,_33);
msg.response.errors[msg.response.errors.length]=_35;
},register:function(_36,_37,_38){
var _s=vjo.dsf.ServiceEngine;
switch(_36){
case 0:
_s.registerSvcHdl(_37,_38);
break;
case 1:
_s.registerSvcReqtHdl(_37,_38);
break;
case 2:
_s.registerGlbReqtHdl(_37,_38);
break;
case 3:
_s.registerTrspReqtHdl(_37,_38);
break;
case 4:
_s.registerSvcRespHdl(_37,_38);
break;
case 5:
_s.registerGlbRespHdl(_37,_38);
break;
case 6:
_s.registerTrspRespHdl(_37,_38);
break;
}
}}).inits(function(){
vjo.dsf.ServiceEngine=new vjo.dsf.ServiceEngine();
});

vjo.type("vjo.dsf.assembly.VjClientAssemblerRequest").protos({constructs:function(_1,_2,_3,_4,_5){
this.sUrl=_1;
this.fCallback=_2;
this.oScope=_3||window;
this.sCallbackParam=_4;
var b=_5;
if(typeof (b)=="undefined"){
b=true;
}
this.bSendResponseOnLoad=b;
}});

vjo.needs("vjo.dsf.EventDispatcher");
vjo.needs("vjo.dsf.ServiceEngine");
vjo.needs("vjo.dsf.assembly.VjClientAssemblerRequest");
vjo.type("vjo.dsf.assembly.VjClientAssembler").singleton().protos({constructs:function(){
this.aCallbacks=[];
this.aResponses={};
this.aModels={};
this.sPreCallback="_callback";
this.bBodyLoaded=false;
this.bLock=false;
},load:function(_1){
var m=_1,url=m.sUrl||"";
var _3=this.generateCallback(m);
var cb="vjo.dsf.assembly.VjClientAssembler."+_3;
if(vjo.dsf.XDomainRequest.bUseIframe){
cb="parent."+cb;
}
if(m&&m.objType=="dsf_Message"){
url=m.svcConfig.url+"?";
url+=vjo.dsf.Service.generateReqParams(m)+"&callback="+cb;
}else{
if(m.sCallbackParam){
url=url+"&"+m.sCallbackParam+"="+cb;
}
}
return vjo.dsf.XDomainRequest.send(url);
},generateCallback:function(_5){
var m=_5;
var _7=this.aCallbacks.length;
var _8=this.sPreCallback+_7;
this.aCallbacks[_7]=_8;
this.aModels[_8]=m;
this[_8]=function(){
if(this.bBodyLoaded||!m.bSendResponseOnLoad){
if(m.objType=="dsf_Message"){
m.response=this.getResponse(arguments[0]);
vjo.dsf.ServiceEngine.handleResponse(m);
}else{
m.fCallback.apply(m.oScope,arguments);
}
}else{
if(m.objType=="dsf_Message"){
this.aResponses[_8]=this.getResponse(arguments[0]);
m.response=this.aResponses[_8];
}else{
this.aResponses[_8]=arguments;
}
if(this.bBodyLoaded){
VjClientAssembler.assemble();
}
}
};
return _8;
},assemble:function(){
this.bBodyLoaded=true;
if(this.bLock){
setTimeout("vjo.dsf.assembly.VjClientAssembler.assemble()",1000);
return;
}
this.bLock=true;
try{
for(var _9 in this.aResponses){
var m=this.aModels[_9];
if(this.aResponses[_9]!=null){
if(m.objType=="dsf_Message"){
vjo.dsf.ServiceEngine.handleResponse(m);
}else{
m.fCallback.apply(m.oScope,this.aResponses[_9]);
}
}
this.aResponses[_9]=null;
}
}
finally{
this.bLock=false;
}
},getResponse:function(_b){
var _c;
try{
_c=_b;
}
catch(e){
_c=new vjo.dsf.ServiceResponse();
var _d=new vjo.dsf.Error();
_d.id="SYS.JSON_PARSE_ERROR";
_d.message="SYS.JSON_PARSE_ERROR";
_c.errors=[_d];
}
return _c;
}}).inits(function(){
vjo.dsf.assembly.VjClientAssembler=new vjo.dsf.assembly.VjClientAssembler();
vjo.dsf.EventDispatcher.addEventListener(window,"load",function(){
vjo.dsf.assembly.VjClientAssembler.assemble();
});
});

String.prototype.has=function(_1){
return (this.indexOf(_1)!=-1);
};
String.prototype.hasArg=function(_2){
var a=_2,rv=false;
if(typeof (a)=="string"){
rv=this.has(a);
}else{
var aL=a.length;
for(var j=0;j<aL&&!rv;j++){
rv=this.has(a[j]);
}
}
return rv;
};
String.prototype.hasAny=function(){
var a=arguments,l=a.length,rv=false;
for(var i=0;i<l&&!rv;i++){
rv=this.hasArg(a[i]);
}
return rv;
};
String.prototype.hasAll=function(){
var a=arguments,l=a.length;
for(var i=0;i<l;i++){
if(!this.hasArg(a[i])){
return false;
}
}
return true;
};
String.prototype.is=function(s){
return (this==s);
};
String.prototype.isAny=function(){
var a=arguments,l=a.length,rv=false,aL;
for(var i=0;i<l&&!rv;i++){
if(typeof (a[i])=="string"){
rv=(this==a[i]);
}else{
aL=a[i].length;
for(var j=0;j<aL&&!rv;j++){
rv=(this==a[i][j]);
}
}
}
return rv;
};

String.prototype.hex2Dec=function(){
return parseInt(this,16);
};

Number.prototype.dec2Hex=function(){
return parseInt(this,10).toString(16);
};

vjo.needs("vjo.dsf.typeextensions.string.Comparison");
vjo.needs("vjo.dsf.typeextensions.string.HexToDecimal");
vjo.needs("vjo.dsf.typeextensions.number.DecimalToHex");
vjo.type("vjo.dsf.cookie.VjCookieJar").props({Default_Cookie_Format:{"COOKIELET_DELIMITER":"^","NAME_VALUE_DELIMITER":"/","escapedValue":true},DP_Cookie_Format:{"COOKIELET_DELIMITER":"^","NAME_VALUE_DELIMITER":"/","bUseExp":true,"startDelim":"b"},Session_Cookie_Format:{"COOKIELET_DELIMITER":"^","NAME_VALUE_DELIMITER":"=","escapedValue":true,"startDelim":"^"},DS_Cookie_Format:{"COOKIELET_DELIMITER":"^","NAME_VALUE_DELIMITER":"/"},sPath:"/",aConversionMap:{"reg":["dp1","reg"],"recent_vi":["ebay","lvmn"],"ebaysignin":["ebay","sin"],"p":["dp1","p"],"etfc":["dp1","etfc"],"keepmesignin":["dp1","kms"],"ItemList":["ebay","wl"],"BackToList":["s","BIBO_BACK_TO_LIST"]},aFormatMap:{},sCOMPAT:"10",sCONVER:"01",sSTRICT:"00",sModesCookie:"ebay",sModesCookielet:"cv",readCookie:function(_1,_2){
var rv=this.readCookieObj(_1,_2).value;
return (rv)?decodeURIComponent(rv):"";
},createDefaultCookieBean:function(_4,_5){
var _6={};
_6.name=_4;
_6.cookieletname=_5;
_6.value="";
_6.maxage=0;
_6.rawcookievalue="";
_6.mode="";
return _6;
},readCookieObj:function(_7,_8){
var _9=this.createDefaultCookieBean(_7,_8);
this.update();
this.checkConversionMap(_9);
_9.rawcookievalue=this.aCookies[_9.name];
if(!_9.name||!_9.rawcookievalue){
_9.value="";
}else{
if(!_9.cookieletname){
this.readCookieInternal(_9);
}else{
this.readCookieletInternal(_9);
}
}
return (typeof (_9)!="undefined")?_9:"";
},checkConversionMap:function(_a){
var _b=this.aConversionMap[_a.name];
if(_b){
_a.mode=this.getMode(_a.name);
_a.name=_b[0];
_a.cookieletname=_b[1];
}
},readCookieInternal:function(_c){
_c.value=_c.rawcookievalue;
return _c;
},readCookieletInternal:function(_d){
var _e=this.getCookielet(_d.name,_d.cookieletname,_d.rawcookievalue);
var _f=this.getFormat(_d.name);
if(_e&&_f.bUseExp){
var _10=_e;
_e=_e.substring(0,_e.length-8);
if(_10.length>8){
_d.maxage=_10.substring(_10.length-8);
}
}
_d.value=_e;
if(_d.mode==this.sCOMPAT){
_d.value=_d.rawcookievalue;
}
return _d;
},readMultiLineCookie:function(_11,_12){
if(!_11||!_12){
return "";
}
var val,r="";
var _14=this.aConversionMap[_11];
if(_14){
val=this.readCookieObj(_14[0],_14[1]).value||"";
}
if(val){
r=this.getCookielet(_11,_12,val)||"";
}
return (typeof (r)!="undefined")?r:"";
},writeCookie:function(_15,_16,_17){
var _18=this.aConversionMap[_15];
if(_18){
this.writeCookielet(_18[0],_18[1],_16,_17);
return;
}
var _19=this.getFormat(_15);
if(_16&&_19.escapedValue){
_16=encodeURIComponent(_16);
}
this.writeRawCookie(_15,_16,_17);
},writeRawCookie:function(_1a,_1b,_1c){
if(_1a&&(_1b!==undefined)){
if((isNaN(_1b)&&_1b.length<4000)||(_1b+"").length<4000){
if(typeof _1c=="number"){
_1c=this.getExpDate(_1c);
}
var _1d=_1c?new Date(_1c):new Date(this.getExpDate(730));
var _1e=this.getFormat(_1a);
var _1f=this.sCookieDomain;
var dd=document.domain;
if(!dd.has(_1f)){
var _21=dd.indexOf(".ebay.");
if(_21>0){
this.sCookieDomain=dd.substring(_21);
}
}
if(document.cookie){
document.cookie=_1a+"="+(_1b||"")+((_1c||_1e.bUseExp)?"; expires="+_1d.toGMTString():"")+"; domain="+this.sCookieDomain+"; path="+this.sPath;
}
}
}
},writeCookieEx:function(_22,_23,_24){
this.writeCookie(_22,_23,this.getExpDate(_24));
},writeCookielet:function(_25,_26,_27,_28,_29){
if(_25&&_26){
this.update();
var _2a=this.getFormat(_25);
if(_2a.bUseExp&&_27){
if(typeof _28=="number"){
_28=this.getExpDate(_28);
}
var _2b=_28?new Date(_28):new Date(this.getExpDate(730));
var _2c=Date.UTC(_2b.getUTCFullYear(),_2b.getUTCMonth(),_2b.getUTCDate());
_2c=Math.floor(_2c/1000);
_27+=_2c.dec2Hex();
}
var val=this.createCookieValue(_25,_26,_27);
this.writeRawCookie(_25,val,_29);
}
},writeMultiLineCookie:function(_2e,_2f,_30,_31,_32){
this.update();
var val=this.createCookieValue(_2e,_2f,_30);
if(val){
var _34=this.aConversionMap[_2e];
if(_34){
this.writeCookielet(_34[0],_34[1],val,_31,_32);
}
}
},getBitFlagOldVersion:function(_35,_36){
_35=parseInt(_35,10);
var b=_35.toString(2),r=_35?b.charAt(b.length-_36-1):"";
return (r=="1")?1:0;
},setBitFlagOldVersion:function(_38,_39,_3a){
var b="",p,i,e,l;
_38=parseInt(_38,10);
if(_38){
b=_38.toString(2);
}
l=b.length;
if(l<_39){
e=_39-l;
for(i=0;i<=e;i++){
b="0"+b;
}
}
p=b.length-_39-1;
return parseInt(b.substring(0,p)+_3a+b.substring(p+1),2);
},getBitFlag:function(_3c,_3d){
if(_3c!=null&&_3c.length>0&&_3c.charAt(0)=="#"){
var _3e=_3c.length;
var q=_3d%4;
var _40=Math.floor(_3d/4)+1;
var _41=_3e-_40;
var _42=parseInt(_3c.substring(_41,_41+1),16);
var _43=1<<q;
return ((_42&_43)==_43)?1:0;
}else{
return this.getBitFlagOldVersion(_3c,_3d);
}
},setBitFlag:function(_44,_45,_46){
if(_44!=null&&_44.length>0&&_44.charAt(0)=="#"){
var _47=_44.length;
var q=_45%4;
var _49=Math.floor(_45/4)+1;
if(_47<=_49){
if(_46!=1){
return _44;
}
var _4a=_49-_47+1;
var _4b=_44.substring(1,_47);
while(_4a>0){
_4b="0"+_4b;
_4a--;
}
_44="#"+_4b;
_47=_44.length;
}
var _4c=_47-_49;
var _4d=parseInt(_44.substring(_4c,_4c+1),16);
var _4e=1<<q;
if(_46==1){
_4d|=_4e;
}else{
_4d&=~_4e;
}
_44=_44.substring(0,_4c)+_4d.toString(16)+_44.substring(_4c+1,_47);
return _44;
}else{
if(_45>31){
return _44;
}
return this.setBitFlagOldVersion(_44,_45,_46);
}
},createCookieValue:function(_4f,_50,_51){
var _52=this.aConversionMap[_4f],format=this.getFormat(_4f),mode=this.getMode(_4f),val;
if(_52&&(mode==this.sSTRICT||mode==this.sCONVER)){
val=this.readCookieObj(_52[0],_52[1]).value||"";
}else{
val=this.aCookies[_4f]||"";
}
if(format){
var _53=this.getCookieletArray(val,format);
_53[_50]=_51;
var str="";
for(var i in _53){
if(_53[i]){
str+=i+format.NAME_VALUE_DELIMITER+_53[i]+format.COOKIELET_DELIMITER;
}
}
if(str&&format.startDelim){
str=format.startDelim+str;
}
val=str;
if(format.escapedValue){
val=encodeURIComponent(val);
}
}
return val;
},update:function(){
var aC=document.cookie.split("; ");
this.aCookies={};
for(var i=0;i<aC.length;i++){
var sC=aC[i].split("=");
var _59=this.getFormat(sC[0]),cv=sC[1],sd=_59.startDelim;
if(sd&&cv&&cv.indexOf(sd)===0){
sC[1]=cv.substring(sd.length,cv.length);
}
this.aCookies[sC[0]]=sC[1];
}
},getCookielet:function(_5a,_5b,_5c){
var _5d=this.getFormat(_5a);
var _5e=this.getCookieletArray(_5c,_5d);
return _5e[_5b]||"";
},getFormat:function(_5f){
return this.aFormatMap[_5f]||vjo.dsf.cookie.VjCookieJar.Default_Cookie_Format;
},getCookieletArray:function(_60,_61){
var rv=[],val=_60||"";
if(_61.escapedValue){
val=decodeURIComponent(val);
}
var a=val.split(_61.COOKIELET_DELIMITER);
for(var i=0;i<a.length;i++){
var idx=a[i].indexOf(_61.NAME_VALUE_DELIMITER);
if(idx>0){
rv[a[i].substring(0,idx)]=a[i].substring(idx+1);
}
}
return rv;
},getExpDate:function(_66){
var _67;
if(typeof _66=="number"&&_66>=0){
var d=new Date();
d.setTime(d.getTime()+(_66*24*60*60*1000));
_67=d.toGMTString();
}
return _67;
},getMode:function(_69){
var h=this.readCookieObj(this.sModesCookie,this.sModesCookielet).value,b;
if(!(_69 in this.aConversionMap)){
return null;
}
if(!h){
return "";
}
if(h===0){
return this.sSTRICT;
}
if(h&&h!="0"){
if(h.has(".")){
var a=h.split(".");
for(i=0;i<a.length;i++){
b=a[i].hex2Dec().toString(2)+b;
}
}else{
b=h.hex2Dec().toString(2);
}
i=0;
var l=b.length,j;
for(o in this.aConversionMap){
j=l-(2*(i+1));
f=b.substring(j,j+2).toString(10);
f=(!f)?this.sSTRICT:f;
if(_69==o){
return (f.length==1)?"0"+f:f;
}
i++;
}
return null;
}
}}).inits(function(){
var vCJ=vjo.dsf.cookie.VjCookieJar;
vCJ.aFormatMap={"r":vCJ.Default_Cookie_Format,"dp1":vCJ.DP_Cookie_Format,"npii":vCJ.DP_Cookie_Format,"ebay":vCJ.Session_Cookie_Format,"reg":vCJ.Session_Cookie_Format,"apcCookies":this.Session_Cookie_Format,"ds2":vCJ.DS_Cookie_Format};
});

vjo.type("vjo.Registry").singleton().protos({constructs:function(){
this.controls=[];
},put:function(_1,_2){
this.controls[_1]=_2;
if(this.isKeyValid(_1)){
this["_"+_1]=this.controls[_1];
}
return this.controls[_1];
},get:function(_3){
return this.controls[_3];
},dump:function(){
var _4=this.controls;
var _5="controls on page:\n";
for(var i in _4){
_5+="key = "+i;
_5+="controlName = "+_4[i].objtype;
_5+="\n";
}
return _5;
},isKeyValid:function(_7){
if(typeof _7!="string"){
return false;
}
return /^([a-zA-Z0-9_$]+)$/.test(_7);
}}).inits(function(){
vjo.Registry=new vjo.Registry();
});

vjo.needs("vjo.dsf.typeextensions.string.Comparison");
vjo.type("vjo.dsf.client.Browser").props({init:function(){
this.bFirefox=this.bWebTV=this.bOpera=this.bNav=this.bIE=this.bSafari=this.bWin=this.bMac=this.bMacppc=this.bMactel=this.bActiveXSupported=this.bWinXp=this.bXpSp2=this.bAOL=this.bVista=false;
this.iVer=this.fVer=-1;
this.fMinorVer=0;
this.aMimeTypes=null;
var nv=navigator,agt=nv.userAgent.toLowerCase(),i=0,ver;
with(this){
if(agt.has("webtv")){
bWebTV=true;
i=agt.indexOf("webtv/")+6;
}else{
if(agt.has("firefox")){
bFirefox=true;
i=agt.lastIndexOf("firefox")+8;
}else{
if(agt.has("safari")){
bSafari=true;
i=agt.lastIndexOf("safari")+7;
}else{
if(typeof (window.opera)!="undefined"){
bOpera=true;
i=agt.lastIndexOf("opera")+6;
}else{
if(nv.appName.is("Netscape")){
bNav=true;
i=agt.lastIndexOf("/")+1;
}else{
if(agt.has("msie")){
bIE=true;
i=agt.indexOf("msie")+4;
if(agt.has("aol")||agt.has("america online")){
bAOL=true;
}
}
}
}
}
}
}
ver=bOpera?window.opera.version():agt.substring(i);
iVer=parseInt(ver);
fVer=parseFloat(ver);
fMinorVer=fVer-iVer;
bWin=agt.has("win");
bWinXp=(bWin&&agt.has("windows nt 5.1"));
bVista=(bWin&&agt.has("windows nt 6.0"));
bXpSp2=(bWinXp&&agt.has("sv1"));
bMac=agt.has("mac");
bMacppc=(bMac&&agt.hasAny("ppc","powerpc"));
bMactel=(bMac&&agt.has("intel"));
aMimeTypes=nv.mimeTypes;
bActiveXSupported=(!(bMac||bMacppc)&&(typeof (ActiveXObject)=="function"));
}
}}).inits(function(){
vjo.dsf.client.Browser.init();
});

vjo.type("vjo.darwin.tracking.sojourner.SojData").singleton().protos({constructs:function(){
this.sojD;
}}).inits(function(){
vjo.darwin.tracking.sojourner.SojData=new vjo.darwin.tracking.sojourner.SojData();
});

vjo.type("vjo.darwin.tracking.sojourner.CalData").singleton().protos({constructs:function(){
this.cal={};
},setData:function(_1,_2){
if(!_1||!_2){
return;
}
this.cal[_1]=_2;
},getData:function(_3){
if(_3){
return this.cal[_3];
}
}}).inits(function(){
vjo.darwin.tracking.sojourner.CalData=new vjo.darwin.tracking.sojourner.CalData();
});

vjo.needs("vjo.darwin.tracking.sojourner.SojData");
vjo.needs("vjo.darwin.tracking.sojourner.CalData");
vjo.type("vjo.darwin.tracking.sojourner.TrackingRespHdl").props({handleResponse:function(_1){
if(_1.errors&&_1.errors.length>0){
vjo.darwin.tracking.sojourner.SojData.sojD="";
}
if(_1.response&&_1.response.dataMap&&_1.response.dataMap.SOJDATA){
vjo.darwin.tracking.sojourner.SojData.sojD=_1.response.dataMap.SOJDATA;
}
if(_1.response&&_1.response.dataMap&&_1.response.dataMap.TDATA){
vjo.darwin.tracking.sojourner.CalData.setData(_1.svcId,_1.response.dataMap.TDATA);
}
}});


// en_US/e583/SYS_vjo_e5837294829_1_en_US
// b=7294829