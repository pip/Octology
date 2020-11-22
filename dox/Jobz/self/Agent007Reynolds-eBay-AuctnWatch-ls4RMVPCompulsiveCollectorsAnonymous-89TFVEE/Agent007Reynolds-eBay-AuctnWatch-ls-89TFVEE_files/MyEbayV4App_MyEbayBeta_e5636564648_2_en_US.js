vjo.type("vjo.darwin.app.myebay.TrackingHead").props({startedAt:(new Date()).getTime(),renderEndedAt:0,pageLoadedAt:0,isPostToServer:false,customData:new Object(),trackUrl:"",connTestUrl:"",connTestTime:0,lineItemElem:"LineID",initData:function(_1,_2,_3,_4,_5){
this.isPostToServer=_1;
this.customData=_4;
this.trackUrl=_2;
this.connTestUrl=_3+((_3.indexOf("?")>0)?"&":"?")+"rdm="+Math.random();
this.lineItemElem=_5;
if(_1&&_3.length>0){
var _6=new Image();
_6.startTime=(new Date()).getTime();
_6.onload=function(){
vjo.darwin.app.myebay.TrackingHead.connTestTime=(new Date()).getTime()-this.startTime;
};
_6.onerror=function(){
vjo.darwin.app.myebay.TrackingHead.connTestTime=-1;
};
_6.src=_3;
}
vjo.dsf.EventDispatcher.addEventListener(window,"load",vjo.darwin.app.myebay.TrackingHead.setLoad,vjo.darwin.app.myebay.TrackingHead);
},setRender:function(){
this.renderEndedAt=(new Date()).getTime();
},setLoad:function(){
if(this.renderEndedAt==0&&vjo.darwin.app.myebay.TrackingRender){
this.renderEndedAt=vjo.darwin.app.myebay.TrackingRender.ranAt;
}
this.pageLoadedAt=(new Date()).getTime();
var _7=this.getFormElem(this.lineItemElem,"checkbox"),cnt=0;
if(_7){
if(_7.length&&_7.length>0){
cnt=_7.length;
}else{
cnt=1;
}
}
this.addCustomData("items",cnt);
this.postToServer(this.getData());
},addCustomData:function(_8,_9){
this.customData[_8]=_9;
},getData:function(){
var _a={};
_a.totalPageLoadTime=this.pageLoadedAt-this.startedAt;
_a.htmlRenderTime=this.renderEndedAt-this.startedAt;
_a.jsLoadTime=this.pageLoadedAt-this.renderEndedAt;
_a.docSize=0;
if(document.body){
_a.docSize=document.body.innerHTML.length;
}
_a.customData=this.customData;
return _a;
},postToServer:function(_b){
if(this.isPostToServer&&this.trackUrl.length>0){
var _c=this.getPostUrl(_b);
var _d=new Image();
_d.src=_c;
}
},getPostUrl:function(_e){
var _f=this.trackUrl;
var _10="";
for(var itm in _e){
var tmp=typeof (_e[itm]);
if(tmp=="function"||tmp=="object"||tmp=="unknown"){
continue;
}
if(_10.length>0){
_10+="&";
}
_10+=itm+"="+_e[itm];
}
if(_e.customData){
for(var itm in _e.customData){
if(_10.length>0){
_10+="&";
}
_10+=itm+"="+_e.customData[itm];
}
}
_f+=((_f.indexOf("?")>0)?"&":"?")+_10;
if(this.connTestTime!=0){
_f+=((_f.indexOf("?")>0)?"&":"?")+"connTime="+this.connTestTime;
}
return _f;
},getFormElem:function(_13,_14){
var d=document;
var _16=d.forms,ln=_16.length,e,eLen;
for(var i=0;i<ln;i++){
e=_16[i].elements;
eLen=e.length;
for(var j=0;j<eLen;j++){
if(e[j].name==_13){
if(_14){
if(e[j].type==_14){
return e[_13];
}
}else{
return e[j];
}
}
}
}
return null;
}});


// en_US/e563/MyEbayV4App_MyEbayBeta_e5636564648_2_en_US
// b=6564648