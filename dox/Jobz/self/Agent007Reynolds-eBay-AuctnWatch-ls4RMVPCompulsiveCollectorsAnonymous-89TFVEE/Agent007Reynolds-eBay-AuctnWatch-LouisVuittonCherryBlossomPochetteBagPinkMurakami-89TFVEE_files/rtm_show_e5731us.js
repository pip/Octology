//<!--
//1@@m1

ebay.oDocument.oPage.oConfig.bNoRTMDowngrade=false;

//2@@m2

function EbayBizObject(pName)
{if(!this.objType)
this.objType="EbayBizObject";this.name=pName;this.createError=ebObjectCreateErrorWrapper;this.throwDebug=ebObjectThrowDebugWrapper;this.throwWarning=ebObjectThrowWarningWrapper;this.throwError=ebObjectThrowErrorWrapper;}

//3@@m3

function EbayClientServer()
{if(!this.objType)
this.objType="EbayClientServer";this.base=EbayBizObject;this.base("client_server");this.callDynamicScriptObject=ebClientServerCallDynamicScriptObject;this.callIframe=ebClientServerCallIframe;}
function ebClientServerCallDynamicScriptObject(pUrl)
{var oDoc=ebay.oDocument;if(!oDoc.createElement||!pUrl)
return;var oScript=oDoc.createElement("script");oScript.type='text/javascript';oScript.src=pUrl;var oFrag=document.getElementsByTagName("head")||document.getElementsByTagName("body");oFrag[0].appendChild(oScript);}
function ebClientServerCallIframe(pUrl)
{var oFrm=null,doc;var oDoc=ebay.oDocument;if(!oDoc.createElement||!pUrl)
return;var scriptstr='<scr'+'ipt src="'+pUrl+'" type="text/javascript"></scr'+'ipt>';oFrm=oDoc.createElement('iframe');oFrm.height=1;oFrm.width=1;oFrm.style.display='none';document.body.appendChild(oFrm);doc=oFrm.document||oFrm.contentDocument;doc.open();doc.write('<html><head></head><body>'+scriptstr+'</body></html>');doc.close();}
if(typeof(ebay)!="undefined")
ebay.oClientServer=new EbayClientServer();

//4@@m1

function EbayRTMFormConfig(pName)
{if(!this.objType)
this.objType="EbayRTMFormConfig";this.base=EbayConfig;this.base(pName);this.aRadioGroup=[];this.aCheckBoxGroup=[];this.aButtonGroup=[];this.sImageElem="";this.sUrl="";this.sStatusLayerElem="";}

//5@@m6

function EbayHTMLLayer(pParent,pName,pDisabled,pCfg)
{if(!this.objType)
this.objType="EbayHTMLLayer";this.base=EbayHTML;this.base(pParent,pName,pName,pDisabled,pCfg);this.aBindEvents=new Array;this.getElem=ebHTMLLayerGetElem;this.getValue=ebHTMLLayerGetValue;this.setValue=ebHTMLLayerSetValue;}
function ebHTMLLayerGetElem(pName)
{var s=pName,d=this.oDocument.doc;if(d.getElementById)
return d.getElementById(s);else if(d.all)
return d.all(s);this.throwWarning("Not supported","getElem");}
function ebHTMLLayerGetValue(pIsText)
{if(this.eElem)
{if(pIsText)
{if(this.oDocument.oGlobals.oClient.bFirefox)
return this.eElem.textContent;else
return this.eElem.innerText;}
else
return this.eElem.innerHTML;}
else
return"";}
function ebHTMLLayerSetValue(pVal,pIsText)
{if(this.eElem)
{if(pIsText)
{if(this.oDocument.oGlobals.oClient.bFirefox)
this.eElem.textContent=pVal;else
this.eElem.innerText=pVal;}
else
this.eElem.innerHTML=pVal;}}

//6@@m13

function EbayHTMLBaseCheckboxRadio(pParent,pName,pDisabled,pCfg)
{if(!this.objType)
this.objType="EbayHTMLBaseCheckboxRadio";this.base=EbayHTMLFormElem;this.base(pParent,pName,pDisabled,pCfg);this.bGroup=false;this.bindHTML=ebHTMLBaseCheckboxRadioBindHTML;this.bindEvents=ebHTMLBaseCheckboxRadioBindEvents;this.check=ebHTMLBaseCheckboxRadioCheck;this.selectByIndex=ebHTMLBaseCheckboxRadioSelectByIndex;this.selectByValue=ebHTMLBaseCheckboxRadioSelectByValue;this.isCheckedByValue=ebHTMLBaseCheckboxRadioIsCheckedByValue;this.getValueByIndex=ebHTMLBaseCheckboxRadioGetValueByIndex;this.getIndexByValue=ebHTMLBaseCheckboxRadioGetIndexByValue;this.getValue=null;this.enableBase=this.enable;this.enable=ebHTMLBaseCheckboxRadioEnable;this.setValue=this.selectByValue;this.onBeforeCheck=null;this.onAfterCheck=null;this.subscribeEvents("onclick");}
function ebHTMLBaseCheckboxRadioBindHTML()
{with(this)
{eElem=getElem(sElemName);if(eElem)
{if(eElem.length)
{bGroup=true;for(var i=0;i<eElem.length;i++)
assignJSObject(eElem[i]);cleanupMemory=ebHTMLBaseCheckboxRadioCleanupMemory;}
else
{bGroup=false;assignJSObject(eElem);}}
if(bDisabled)
enable(false);}}
function ebHTMLBaseCheckboxRadioCleanupMemory()
{var e=this.eElem;if(e)
{for(var j=0;j<e.length;j++)
{for(var i in e[j].jsObjs)
{e[j].jsObjs[i]=null;}
e[j].jsObjs=null;}
this.eElem=null;}}
function ebHTMLBaseCheckboxRadioBindEvents()
{with(this)
{if(!eElem)
return;var e=aBindEvents,len=e.length,fStr;for(var i in e)
{if(eElem.length&&eElem.length>0)
{for(var ii=0;ii<eElem.length;ii++)
eval("eElem[ii]."+e[i]+" = function(){"+this.bindEventString(e[i],ii)+"}");}
else
{eval("eElem."+e[i]+" = new Function(this.bindEventString(e[i],0))");}}}}
function ebHTMLBaseCheckboxRadioCheck(pChecked,pIndex)
{if(pIndex<0)
return;with(this)
{if(eElem)
{if(bGroup&&typeof(pIndex)=='undefined')
{var len=eElem.length;for(var i=0;i<len;i++)
eElem[i].checked=pChecked;}
else if(bGroup&&eElem[pIndex])
eElem[pIndex].checked=pChecked;else if(!bGroup)
eElem.checked=pChecked;}}}
function ebHTMLBaseCheckboxRadioSelectByIndex(pIdx,pCheck)
{var chx=typeof pCheck!='undefined'?pCheck:true;with(this)
{if(onBeforeCheck)
onBeforeCheck();var e=bGroup?eElem[pIdx]:eElem;if(e)
{e.checked=chx;if(onAfterCheck)
onAfterCheck();}}}
function ebHTMLBaseCheckboxRadioSelectByValue(pVal,pCheck)
{var chx=typeof pCheck!='undefined'?pCheck:true;with(this)
{if(onBeforeCheck)
onBeforeCheck();var e=eElem;if(!e)
return;if(bGroup)
{for(var i=0;i<e.length;i++)
{if(e[i].value==pVal)
{e[i].checked=chx;if(onAfterCheck)
onAfterCheck();return;}}}
else
{if(e.value==pVal)
{e.checked=chx;if(onAfterCheck)
onAfterCheck();}}}}
function ebHTMLBaseCheckboxRadioIsCheckedByValue(pValue)
{with(this)
{var e=eElem;if(e&&bGroup)
{var len=e.length;for(var i=0;i<len;i++)
{if(e[i].value==pValue)
return isChecked(i);}}}}
function ebHTMLBaseCheckboxRadioGetValueByIndex(pIndex)
{with(this)
{var e=eElem;if(e&&bGroup)
return e[pIndex].value;return null;}}
function ebHTMLBaseCheckboxRadioGetIndexByValue(pValue)
{with(this)
{var e=eElem;if(e&&bGroup)
{var len=e.length;for(var i=0;i<len;i++)
{if(e[i].value==pValue)
return i;}}
return-1;}}
function ebHTMLBaseCheckboxRadioEnable(pEnable)
{with(this)
{enableBase(pEnable);if(bGroup)
{var v=pEnable?"true":"false",e=eElem,len=e.length;if(e)
{for(var i=0;i<len;i++)
{e[i].onfocus=new Function("return "+v+";");e[i].disabled=!pEnable;}}}}}

//7@@m7

function EbayHTMLRadio(pParent,pName,pDisabled,pCfg)
{if(!this.objType)
this.objType="EbayHTMLRadio";this.base=EbayHTMLBaseCheckboxRadio;this.base(pParent,pName,pDisabled,pCfg);this.getElem=ebHTMLRadioGetElem;this.getValue=ebHTMLRadioGetValue;this.getSelectedIndex=ebHTMLRadioGetSelectedIndex;}
function ebHTMLRadioGetElem(pName)
{return this.oDocument.getFormElem(pName,"radio");}
function ebHTMLRadioGetValue()
{var e=this.eElem;if(!e){return"";}
if(this.bGroup)
{for(var i=0;i<e.length;i++)
{if(e[i].checked)
return e[i].value;}}
else
{if(e.checked)
return e.value;}
return"";}
function ebHTMLRadioGetSelectedIndex()
{var e=this.eElem;if(!this.bGroup)
return 0;else
{for(var i=0;i<e.length;i++)
{if(e[i].checked)
return i;}}
return-1;}

//8@@m7

function EbayHTMLCheckbox(pParent,pName,pDisabled,pCfg)
{if(!this.objType)
this.objType="EbayHTMLCheckbox";this.base=EbayHTMLBaseCheckboxRadio;this.base(pParent,pName,pDisabled,pCfg);this.getElem=ebHTMLCheckboxGetElem;this.isChecked=ebHTMLCheckboxIsChecked;this.getValue=ebHTMLCheckboxGetValue;this.setValue=this.selectByValue;}
function ebHTMLCheckboxGetElem(pName)
{return this.oDocument.getFormElem(pName,"checkbox");}
function ebHTMLCheckboxIsChecked(pIndex)
{with(this)
{if(eElem)
{if(bGroup&&eElem[pIndex])
return eElem[pIndex].checked;else if(!bGroup)
return eElem.checked;}}
return false;}
function ebHTMLCheckboxGetValue(pUnCheckedValue)
{var e=this.eElem,rv="";if(this.bGroup)
{rv=[];for(var i=0;i<e.length;i++)
{if(e[i].checked)
rv[rv.length]=e[i].value;}
if(!rv.length)rv="";}
else
{if(pUnCheckedValue)
return e.value;if(e.checked)
return e.value;}
return rv;}

//9@@m7

function EbayHTMLImage(pParent,pName,pDisabled,pSource,pDisabledSource,pCfg)
{if(!this.objType)
this.objType="EbayHTMLImage";this.base=EbayHTML;this.base(pParent,pName,pName,pDisabled,pCfg);this.sEnabledSource=this.sDisabledSource=pSource;if(pDisabledSource)
this.sDisabledSource=pDisabledSource;this.getElem=ebHTMLImageGetElem;this.source=ebHTMLImageSource;this.enableBase=this.enable;this.enable=ebHTMLImageEnable;this.subscribeEvents("onclick","onmouseover","onmouseout");}
function ebHTMLImageGetElem(pName)
{return this.getDocElem(pName,'images');}
function ebHTMLImageSource(pSrc,pText)
{var im=this.eElem;if(typeof(im)=='undefined')
return;if(typeof(pSrc)=="undefined")
return(im)?im.src:"";else
{im.src=pSrc;if(pText!=null)
im.alt=pText;}}
function ebHTMLImageEnable(pEnable)
{with(this)
{enableBase(pEnable);if(sDisabledSource&&eElem)
eElem.src=(pEnable)?sEnabledSource:sDisabledSource;}}

//10@@m4

function EbayHTMLButton(pParent,pElemName,pDisabled,pCfg)
{if(!this.objType)
this.objType="EbayHTMLButton";this.base=EbayHTMLFormElem;this.base(pParent,pElemName,pDisabled,pCfg);this.getValue=ebHTMLButtonGetValue;this.setValue=ebHTMLButtonSetValue;this.subscribeEvents("onclick");}
function ebHTMLButtonGetValue()
{return this.eElem.value;}
function ebHTMLButtonSetValue(pValue)
{var e=this.eElem;if(e)
e.value=pValue;}

//11@@m11

function EbayHTMLPopup(pParent,pName,pCfg)
{if(!this.objType)
this.objType="EbayHTMLPopup";this.base=EbayBaseControl;this.base(pParent,pName);this.oConfig=pCfg||null;if(!pCfg)
{this.sUrl="";this.iWidth=this.iHeight=this.iLeft=this.iTop=null;this.bToolbar=this.bLocation=this.bStatus=this.bScrollbars=this.bResizable=this.bMenubar=true;}
else
{var u="undefined";this.sUrl=typeof(pCfg.sUrl)!=u?pCfg.sUrl:"";this.iWidth=typeof(pCfg.iWidth)!=u?pCfg.iWidth:null;this.iHeight=typeof(pCfg.iHeight)!=u?pCfg.iHeight:null;this.iLeft=typeof(pCfg.iLeft)!=u?pCfg.iLeft:null;this.iTop=typeof(pCfg.iTop)!=u?pCfg.iTop:null;this.bToolbar=typeof(pCfg.bToolbar)!=u?pCfg.bToolbar:true;this.bLocation=typeof(pCfg.bLocation)!=u?pCfg.bLocation:true;this.bStatus=typeof(pCfg.bStatus)!=u?pCfg.bStatus:true;this.bScrollbars=typeof(pCfg.bScrollbars)!=u?pCfg.bScrollbars:true;this.bResizable=typeof(pCfg.bResizable)!=u?pCfg.bResizable:true;this.bMenubar=typeof(pCfg.bMenubar)!=u?pCfg.bMenubar:true;}
this.oWin=null;this.sProps=this.sCustomProps="";this.bModal=false;this.sSavedFocusFunction=null;this.iHBuffer=this.iWBuffer=0;this.show=ebHTMLPopupShow;this.getParamString=ebHTMLGetParamString;this.modality=ebHTMLModality
this.showEx=ebHTMLPopupShowEx;this.resizeParent=ebHTMLPopupResizeParent;this.close=ebHTMLPopupClose;this.focus=ebHTMLPopupFocus;this.sizeToContent=ebHTMLPopupSizeToContent;this.clearControls=ebHTMLPopupClearControls;}
function ebHTMLPopupShow(pIsPopUnder)
{var bPopUnder=(typeof(pIsPopUnder)!="undefined"&&pIsPopUnder)?true:false;with(this)
{if(sUrl.length==0)
return null;var sP=getParamString();var oD=oDocument,tWin=oD.win;oD.setGlobalParent(this);modality(tWin);if(sUrl.has("ej2child=true")&&!sUrl.has("ej2parent="))
sUrl+="&ej2parent="+name;var w=tWin.open(sUrl,name,sP);if(bPopUnder)
w.blur();if(w&&!bPopUnder)
w.focus();oWin=w;return w;}}
function ebHTMLGetParamString()
{with(this)
{sP=(iWidth!=null)?",width="+iWidth:"";sP+=(iHeight!=null)?",height="+iHeight:"";sP+=(iLeft!=null)?",screenX="+iLeft+",left="+iLeft:"";sP+=(iTop!=null)?",screenY="+iTop+",top="+iTop:"";sP+=",toolbar="+((bToolbar)?"1":"0");sP+=",location="+((bLocation)?"1":"0");sP+=",status="+((bStatus)?"1":"0");sP+=",scrollbars="+((bScrollbars)?"1":"0");sP+=",resizable="+((bResizable)?"1":"0");sP+=",menubar="+((bMenubar)?"1":"0");sP+=(sCustomProps.length>0)?","+sCustomProps:"";if(sP.length>0)
sP=sP.substring(1);sProps=sP;return sP;}}
function ebHTMLModality(pWin)
{if(pWin)
{with(this)
{if(bModal)
{pWin.g_ebPopupObject=this;sSavedFocusFunction=pWin.onfocus;pWin.onfocus=function()
{try
{g_ebPopupObject.focus();}
catch(e)
{}}}}}}
function ebHTMLPopupShowEx(pUrl,pWidth,pHeight,pToolbar,pLocation,pStatus,pScrollbars,pResizable,pMenubar,pLeft,pTop,pCustomsProps,pModal,pWBuffer,pHBuffer)
{with(this)
{if(pUrl)
sUrl=pUrl;iWidth=pWidth;iHeight=pHeight;iLeft=pLeft;iTop=pTop;bToolbar=pToolbar;bLocation=pLocation;bStatus=pStatus;bScrollbars=pScrollbars;bResizable=pResizable;bMenubar=pMenubar;if(pCustomsProps)
sCustomProps=pCustomsProps;bModal=pModal;iHBuffer=pHBuffer;iWBuffer=pWBuffer;return show();}}
function ebHTMLPopupResizeParent(pX,pY,pW,pH)
{var p=this.parent;if(p)
{if(!isNaN(pX)&&!isNaN(pY))
p.moveTo(pX,pY);if(!isNaN(pW)&&!isNaN(pH))
p.resizeTo(pW,pH);}}
function ebHTMLPopupClose()
{with(this)
{if(bModal)
oDocument.win.onfocus=sSavedFocusFunction;oDocument.closeWindow(oWin);}
this.clearControls();}
function ebHTMLPopupClearControls()
{this.controls=[];}
function ebHTMLPopupFocus()
{var w=this.oWin;if(w&&!w.closed)
w.focus();else
this.close();}
function ebHTMLPopupSizeToContent()
{with(this)
{var c=oGlobals.oClient;if(!(c.bNav&&(c.iVer<5)))
{var ims=oWin.document.images,len=ims.length;var bottom=0,right=0,cB,cR;for(var i=0;i<len;i++)
{cB=ims[i].offsetTop+ims[i].offsetHeight;cR=ims[i].offsetLeft+ims[i].offsetWidth;if(cB>bottom)bottom=cB;if(cR>right)right=cR;}
oWin.resizeTo(right+iWBuffer,bottom+iHBuffer);}}}

//12@@m2

if(typeof(VjRTM)=="undefined"||!VjRTM)
VjRTM={};VjRTM.popUp=function(sPopupTitle,sUrl,iWidth,iHeight,bStatus,bToolbar,bScrollBars,iLeft,iTop,bLocation,bResizable,bMenubar)
{var oCfg={};oCfg.sUrl=sUrl;oCfg.iWidth=iWidth;oCfg.iHeight=iHeight;oCfg.bStatus=bStatus;oCfg.bLocation=bLocation;oCfg.iLeft=iLeft;oCfg.iTop=iTop;oCfg.bToolbar=bToolbar;oCfg.bScrollbars=bScrollBars;oCfg.bResizable=bResizable;oCfg.bMenubar=bMenubar;var oRTMPopup=new EbayHTMLPopup(this,sPopupTitle,oCfg);oRTMPopup.show();return false;}

//13@@m28

function EbayRTM(pParent,pId,pDefUrl,pW,pH,pType,pInd)
{if(!this.objType)
this.objType="EbayRTM";var sName="rtm_"+pId;sName+=pInd?pInd:"";this.base=EbayBaseControl;this.base(pParent,sName);this.name=sName;this.config=new ebRTMConfig(pParent,pId,pDefUrl,pW,pH,pType,pInd);this.writeIFrame=ebWriteRTMFrame;}
function ebRTMConfig(pParent,pId,pDefUrl,pW,pH,pType,pInd)
{var sDivName="rtm_div_"+pId;sDivName+=pInd?pInd:"";var sName="rtm_"+pId;sName+=pInd?pInd:"";this.divname=sDivName;this.base=EbayConfig;this.base(sName);this.id=pId;this.defUrl=pDefUrl;this.defAdUrl="";this.w=(pDefUrl==null?1:pW);if(this.w<=1)
this.w="100%";this.h=(pDefUrl==null?1:pH);this.type=pType||0;this.collapsed=pDefUrl==null||pW<=1||pH<=1?true:false;this.sMaxWidth=null;this.sMaxHeight=null;this.sMinWidth=null;this.sMinHeight=null;this.isDoubleClick=false;this.bReserveMax=false;this.setIFContent=ebSetIFRTMContent;this.getIFHTML=ebGetIFRTMHTML;}
function ebWriteRTMFrame()
{var cfg=this.config,f,d=this.oDocument,oGl=this.oGlobals,xsrc=oGl.oEnvironment.sPicsDir+'s.gif',oCl=oGl.oClient,width,height,un="undefined";if(this.bReserveMax)
{width=(this.sMaxWidth)?this.sMaxWidth:cfg.w;height=(this.sMaxHeight)?this.sMaxHeight:cfg.h;}
else
{if(typeof(cfg.ifWidth)!=un)
width=cfg.ifWidth;else if(cfg.sMinWidth!=null)
width=cfg.sMinWidth;else
width=cfg.w;if(typeof(cfg.ifHeight)!=un)
height=cfg.ifHeight;else if(cfg.sMinHeight!=null)
height=cfg.sMinHeight;else
height=cfg.h;}
f='<div id="'+cfg.divname+'"><img src="'+xsrc+'" height="'+height+'" width="'+width+'" border="0"></div>';if(oCl.bMac&&oCl.bIE)
f+='<img src="'+xsrc+'" height="1" width="1" border="0">';d.write(f);var l=new EbayHTMLLayer(this.parent,cfg.divname);l.bind();}
function ebGetIFRTMHTML(pUrl)
{with(this)
{var width=(sMaxWidth)?sMaxWidth:w;var height=(sMaxHeight)?sMaxHeight:h;if(width=="auto"&&height=="auto")
return"";if(width=="auto")
width="100%";if(height=="auto")
height="100%";var f='<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no"'
+' id="'+name+'"'+' name="'+name+'"'+' src="'+pUrl+'"'
+' width="'+width+'" height="'+height+'"></iframe>';return f;}}
function ebSetIFRTMContent(pUrl)
{var div=ebay.oDocument._getControl(this.divname),ifUrl="",cType=0;if(div)
{var aUrlType=ebGetRTMUrlNType(pUrl);var ifUrl=aUrlType[0],cType=aUrlType[1];if(cType==0)
{if(!this.isDoubleClick&&this.sMinWidth=="0"&&this.sMinHeight=="0")
{div.setValue('');div.setStyle('display','none');return;}
if(this.w!=0&&this.h!=0&&this.sMaxWidth!="0"&&this.sMaxHeight!="0")
div.setValue(this.getIFHTML(ifUrl));else
{div.setValue('');div.setStyle('display','none');}}
else if(cType==1)
{this.type=cType;oP.controls[this.divname].setValue(ifUrl);}}}
function ebGetRTMUrlNType(pUrl)
{var retArray=new Array("",0);if(pUrl&&pUrl.indexOf('*t*')!=-1)
retArray=pUrl.split('*t*');else if(typeof(pUrl)!='undefined')
retArray[0]=pUrl;return retArray;}
function EbayRTMInfo(pParent,pId)
{if(!this.objType)
this.objType="EbayRTMInfo";this.name="rtminfo_"+pId;this.iId=pId;this.w=null;this.h=null;this.base=EbayBaseControl;this.base(pParent,this.name);this.isRtm=false;this.isDoubleClick=false;this.isDefaultPlacement=false;this.isContentPlaced=false;}

//14@@m1

String.prototype.decodeBase64=function()
{var rv=this,len=rv.length,ret="",i=0;var chr1,chr2,chr3="";var enc1,enc2,enc3,enc4="";var aChar="ABCDEFGHIJKLMNOPQRSTUVWXYZ"+"abcdefghijklmnopqrstuvwxyz"+"0123456789+/=*";var test=new RegExp("[^A-Za-z0-9+/=*]");if(test.exec(rv)){return;}
do{enc1=aChar.indexOf(rv.charAt(i++));enc2=aChar.indexOf(rv.charAt(i++));enc3=aChar.indexOf(rv.charAt(i++));enc4=aChar.indexOf(rv.charAt(i++));chr1=(enc1<<2)|(enc2>>4);chr2=((enc2&15)<<4)|(enc3>>2);chr3=((enc3&3)<<6)|enc4;ret+=String.fromCharCode(chr1);if(!(enc3>=64))
ret+=String.fromCharCode(chr2);if(!(enc4>=64))
ret+=String.fromCharCode(chr3);chr1=chr2=chr3=enc1=enc2=enc3=enc4="";}while(i<len);return ret;}
String.prototype.decodeUTF8=function()
{var s=this,len=s.length;var rs="";var i=0;var c=c1=c2=0;while(i<len)
{c=s.charCodeAt(i);if(c<128)
{rs+=String.fromCharCode(c);i++;}
else if((c>191)&&(c<224))
{c2=s.charCodeAt(i+1);rs+=String.fromCharCode(((c&31)<<6)|(c2&63));i+=2;}
else
{c2=s.charCodeAt(i+1);c3=s.charCodeAt(i+2);rs+=String.fromCharCode(((c&15)<<12)|((c2&63)<<6)|(c3&63));i+=3;}}
return rs;}

//15@@m83

ebay.oDocument.oPage.aHtmlFormCache={};ebay.oDocument.oPage.getRtmHtmlFormContent=function(pId){var aCache=ebay.oDocument.oPage.aHtmlFormCache;if(!aCache||!pId){return"";}
return aCache[pId];}
ebay.oDocument.oPage.getPopUnderContent=function(pId)
{var aCache=ebay.oDocument.oPage.aPopUnderCache;if(!aCache||!pId)
return"";var iLen=aCache.length;for(var i=0;i<iLen;i++)
{if(aCache[i].iId==pId)
return aCache[i].sContent;}}
if(typeof(oAdManager)=="undefined")
var oAdManager=new EbayAdManager();function EbayRTMPlacement(pParent,pName)
{if(!this.objType)
this.objType="EbayRTMPlacement";this.base=EbayBaseControl;this.base(pParent,pName);this.srtmEngineHost="";this.aPID=new Array;this.rtms=new Array;this.rtminfos=new Array;this.bPlacementsLoaded=false;this.bOnAfterLoadExec=false;this.bDomainUnknown=false;this.register=ebRegisterRTM;this.delimiter="*t*";this.timeoutID=0;this.rdUrl="";this.sIframeName="rtm";this.bFrameNonDowngraded=false;this.appendUrl=ebAppendUrl;this.getEncodingType=ebEncodingType;this.writePlacement=ebWriteRTMPlacement;this.getRTMContent=ebGetRTMContent;this.setRTMContent=ebSetRTMContent;this.clearPlacements=ebClearRTMPlacements;this.getAdUrl=ebGetRTMAdUrl;this.getUserStr=ebGetRTMUserString;this.loadPlacements=ebLoadPlacements;this.execPageAfterLoad=ebExecPageAfterLoad;this.setRTMInlineTimeout=ebSetRTMInlineTimeout;this.WriteRTMItScriptCall=ebWriteRTMItScriptCall;this.writeInlinePlacement=ebWriteRTMInlinePlacement;this.setRTMInlineContent=ebSetRTMInlineContent;this.setLoadedDoubleClicks=ebSetLoadedDoubleClicks;this.writeContent=ebWriteContent;this.writeAllContents=ebWriteAllContents;this.writeMultipleSameContents=ebWriteMultipleSameContents;this.writeIframe=ebEbayRTMPlacementWriteIframe;this.downgradeDomain=ebRTMDowngradeDomain;this.initIframe=ebRTMPlacementInitIframe;this.initIframe();this.createRTM=ebCreateRTM;this.processRTMForm=ebEbayRTMPlacementProcessRTMForm;this.initRTMPopUnder=ebInitRTMPopUnder;this.processMerchPromo=ebProcessMerchPromo;this.loadScript=ebLoadScript;this.loadPromo=ebLoadPromo;this.bPromoStyle=this.bPromoScript=false;this.loader=this.oDocument.createElement("div");var iFrm=this.oDocument.win.frames[this.sIframeName];if(ebay.oGlobals.oClient.bFirefox&&typeof(iFrm)!='undefined'&&!this.bFrameNonDowngraded)
this.downgradeDomain();this.collectPids=function()
{var ret="",len=this.rtms.length;if(len>0)
{ret="&p=";for(var i=0;i<len;i++)
ret+=this.rtms[i].id+(i<len-1?":":"");}
return ret;}
this.rdPage=function()
{if(!this.rdUrl.is(''))
document.location.replace(this.rdUrl)}}
function ebWriteRTMPlacement(pId,pAdCfg,pDefUrl,pType,pInd)
{if(document.layers)
return;var oRTM=this.createRTM(pId,pAdCfg,pDefUrl,pType,pInd);oRTM.writeIFrame();}
function ebCreateRTM(pId,pAdCfg,pDefUrl,pType,pInd)
{var c=pAdCfg||new EbayConfig(),defAdUrl='';var sMinWidth=c.ifWidth;var sMinHeight=c.ifHeight;if(c.objType.hasAny("EbayAdConfig","EbayAdTableConfig"))
defAdUrl=this.getAdUrl(c);pDefUrl=pDefUrl?pDefUrl:defAdUrl;var w=c.ifWidth||c.width;var h=c.ifHeight||c.height;w=(w=="9999")?"auto":w;h=(h=="9999")?"auto":h;var p=new EbayRTM(this,pId,pDefUrl,w,h,pType,pInd);p.config.defAdUrl=defAdUrl;p.adCfg=pAdCfg;p.config.sMaxWidth=(c.width=="9999")?"auto":c.width;p.config.sMaxHeight=(c.height=="9999")?"auto":c.height;p.config.sMinWidth=(sMinWidth=="9999")?"auto":sMinWidth;p.config.sMinHeight=(sMinHeight=="9999")?"auto":sMinHeight;if(typeof(p.adCfg.bReserveMax)!="undefined"&&p.adCfg.bReserveMax)
p.config.bReserveMax=p.adCfg.bReserveMax;this.register(p.config);return p;}
function ebGetRTMAdUrl(pCfg)
{var defAd=new EbayAd(ebay,pCfg.name,pCfg,oAdManager);defAd.setCountryGlobals=setAdCountryGlobals;defAd.setCountryLocals=setAdCountryLocals;defAd.setCountryGlobals(defAd.globals);defAd.globals.resetGlobals();defAd.setCountryLocals(defAd.config);return defAd.globals.iframeUrl+pCfg.getAdParamString(defAd.globals,defAd.ord);}
function ebSetRTMContent(pUrlArr,pSizeArr)
{var oC=this.oDocument.oPage.oConfig;if(oC.disableRTM)
return;window.clearTimeout(this.timeoutID);var aRTMs=this.rtms,un='undefined';if(aRTMs.length>0)
{for(i=0;i<aRTMs.length;i++)
{var isdc=(pUrlArr[i]!=-1&&pUrlArr[i].indexOf(';')==0)?true:false;if(pUrlArr[i]==-1&&!document.layers)
pUrlArr[i]=aRTMs[i].defUrl;else if(isdc)
{var sz=";sz";if(pUrlArr[i].length==1)
pUrlArr[i]=aRTMs[i].defAdUrl;else if(aRTMs[i].defAdUrl.indexOf(sz)!=-1)
pUrlArr[i]=aRTMs[i].defAdUrl.replace(sz,pUrlArr[i]+sz)}
if(!isdc&&typeof(pSizeArr[i])!=un&&pSizeArr[i]!=-1)
{if(pSizeArr[i].indexOf(":")!=-1)
{var rSize=pSizeArr[i].split(":");aRTMs[i].w=(rSize[0]==-1)?"auto":rSize[0];aRTMs[i].h=(rSize[1]==-1)?"auto":rSize[1];}}
aRTMs[i].setIFContent(pUrlArr[i]+'');}}}
function ebClearRTMPlacements()
{with(this)
{if(rtms.length>0&&!document.layers)
for(var i=0;i<rtms.length;i++)
rtms[i].setIFContent('*t*1');}}
function ebGetRTMContent(pCfg)
{if(document.layers)
return;var oC=ebay.oDocument.oPage.oConfig;if(oC.disableRTM)
{this.clearPlacements();return;}
if(pCfg)
{var path,rHost,id,u,timeout=0,un='undefined';if(!pCfg.rtmEngineHost)
return;if(this.rtms.length==0)
return;if(typeof(pCfg.timeout)!=un)
timeout=pCfg.timeout;path=pCfg.rtmEngineHost+this.collectPids();path+=(pCfg.params)?pCfg.params:"";path+=this.getUserStr(pCfg);var d=this.oDocument,g=this.oGlobals,u=this.oUtils;path+=this.appendUrl(pCfg);this.rdUrl=(typeof(pCfg.rdUrl)!=un)?pCfg.rdUrl:"";var sTimout="",timeout=1500;if(!this.rdUrl.is("")&&timeout>0)
sTimeout="document.location.replace('"+this.rdUrl+"')";else
{var rtmArr="";for(var i=0;i<this.rtms.length;i++)
rtmArr+="-1,";rtmArr=(rtmArr!="")?rtmArr.substr(0,rtmArr.length-1):"";sTimeout="ebay.oDocument._getControl('rtm').setRTMContent(["+
rtmArr+"],["+rtmArr+"])";}
this.timeoutID=window.setTimeout(sTimeout,timeout);d.write(u.scriptTag(path));}}
function ebAppendUrl(pCfg)
{var path="",oCJ=this.oDocument.oCookieJar;if(pCfg.rtmContextData)
path+="&c="+pCfg.rtmContextData;path+=(pCfg.params)?pCfg.params:"";if(pCfg.guid&&pCfg.guid!="")
path+="&g="+pCfg.guid;else
{var sgj=oCJ.readCookielet("ebay","sgj");if(sgj)
{path+="&g="+sgj;oCJ.writeCookielet("ebay","sgj","");}}
var oCJ=ebay.oDocument.oCookieJar,sin=oCJ.readCookielet("ebay","sin"),kms=oCJ.readCookielet("dp1","kms");if(sin.has("in")||kms.has("in"))
path+="&uf=1";else
path+="&uf=0";var oF=ebay.oDocument._getControl("flash");if(oF)
{var iFlashVersion=oF.getVersion();path+="&z="+iFlashVersion;}
path+="&ord=";if(oAdManager.randomKey)
path+=oAdManager.randomKey;else if(pCfg.ord&&pCfg.ord!="")
path+=pCfg.ord;else
{var rda=oCJ.readCookielet("ebay","rda").split('.')[0]||(new Date()).getTime();path+=rda;}
if(ebay.oGlobals.oClient.getBrowserWindowWidth)
var iWidth=ebay.oGlobals.oClient.getBrowserWindowWidth();if(iWidth)
path+='&bw='+iWidth;return path;}
function ebGetRTMUserString(pCfg)
{var s='',qs=document.location.search,qi=qs.indexOf("&i=."),un='undefined',oCJ=this.oDocument.oCookieJar;if(!pCfg)
return s;with(pCfg)
{if(typeof userId!=un&&userId)
s='&i='+userId;else if(qi!=-1)
{var ci=qs.indexOf(";");if(ci!=-1)
s='&i='+qs.substring(qi+3,ci);else
s='&i='+qs.substring(qi+3);}
else if(typeof login!=un&&login)
s='&l='+login;else
{var u1pc=oCJ.readCookielet("dp1","u1p"),u1pd=(u1pc)?u1pc.decodeBase64().decodeUTF8():'';if(u1pd&&!u1pd.has('@@__@@__@@'))
s='&l='+u1pd;}}
return s;}
function ebRegisterRTM(pRTM)
{if(pRTM)
{var r=this.rtms.length;this.rtms[r]=pRTM;}}
function ebEncodingType()
{var encType=null;if(typeof(_GlobalNavHeaderUtf8Encoding)!="undefined")
{encType=_GlobalNavHeaderUtf8Encoding?"UTF-8":"cp1252";}
return encType;}
function ebLoadPlacements(oC)
{if(document.layers)
return;if(!oC)
return;if(!oC.srtmEngineHost)
return;var oGlobalNav;if(typeof(_oGlobalNavRTMInfo)!="undefined")
oGlobalNav=_oGlobalNavRTMInfo;if(oGlobalNav&&oGlobalNav.aRTMPlacementData&&oGlobalNav.aRTMPlacementData.length>0)
{var len=oGlobalNav.aRTMPlacementData.length;for(var i=0;i<len;i++)
{var oPlacementCfg=oGlobalNav.aRTMPlacementData[i];var sPid=oPlacementCfg.pid;oC.aPids[oC.aPids.length]=sPid;var cfg=getCustomAdConfig("globalNav_"+sPid,["default"],"1",oPlacementCfg.maxWidth,oPlacementCfg.maxHeight,oPlacementCfg.minWidth,oPlacementCfg.minHeight,null,null,false);var oRTM=this.createRTM(sPid,cfg,oPlacementCfg.defaultUrl);oRTM.config.divname=oPlacementCfg.htmlId;var oGlobalNavLayer=new EbayHTMLLayer(this,oRTM.config.divname);oGlobalNavLayer.bind();}}
var i=0,aP=oC.aPids;this.srtmEngineHost=oC.srtmEngineHost;this.aPID=oC.aPids;for(i;i<aP.length;i++)
{var oRTMInfo=new EbayRTMInfo(this,aP[i]);this.rtminfos[i]=oRTMInfo;}
var sRtmUrl=oC.srtmEngineHost+"&p="+aP.join(":")+this.getUserStr(oC)+this.appendUrl(oC);if(this.getEncodingType()!=null)
{sRtmUrl=sRtmUrl+"&enc="+this.getEncodingType();}
var oIfrm=eval("this.oDocument.win.frames['"+this.sIframeName+"']"),bIfrm=(typeof(oIfrm)!="undefined"&&typeof(oIfrm.document)!="unknown");var u=this.oUtils;var client=ebay.oGlobals.oClient;if(sRtmUrl.has("a=inline1"))
this.oDocument.write(u.scriptTag(sRtmUrl));else if(client.bFirefox&&bIfrm&&oIfrm)
{if(this.bFrameNonDowngraded)
oIfrm.document.open();oIfrm.document.write(u.scriptTag(sRtmUrl));}
else
ebay.oClientServer.callDynamicScriptObject(sRtmUrl);if(client.bFirefox&&bIfrm)
oIfrm.document.close();var sTimout="",timeout=1500;this.rdUrl=oC.rdUrl||"";if(oC.bMultipleSameIds)
this.writeAllContents=this.writeMultipleSameContents;if(!this.rdUrl.is("")&&timeout>0)
sTimeout="document.location.replace('"+this.rdUrl+"')";else
sTimeout="ebay.oDocument._getControl('rtm').setRTMInlineTimeout()";this.timeoutID=window.setTimeout(sTimeout,timeout);var oD=this.parent.oDocument,oP=oD.oPage;this._registerListener(oD._getEvent("load"),oP.EVENT_AFTER,"execPageAfterLoad");}
function ebEbayRTMPlacementProcessRTMForm(pStatusLayer)
{var oStatus=new EbayHTMLLayer(this,pStatusLayer);oStatus.bind();oStatus.show(true);return true;}
function ebSetRTMInlineTimeout()
{if(this.bOnAfterLoadExec)
{var rtmArr1=[],rtmArr2=[],s=(this.bDomainUnknown)?";":"-1";for(var i=0;i<this.rtminfos.length;i++)
{rtmArr1[i]=s;rtmArr2[i]="-1";if(this.rtminfos[i])
{if(this.rtminfos[i].sMinWidth!=0&&this.rtminfos[i].sMinHeight!=0)
rtmArr2[i]="-1";else
rtmArr2[i]="0:0";}}
var oC=this.oDocument.oPage.oConfig;oC.disableRTM=false;this.setRTMInlineContent(rtmArr1,rtmArr2);this.WriteRTMItScriptCall();}
else
{var sTimeout="ebay.oDocument._getControl('rtm').setRTMInlineTimeout()";var timeout=1500;this.timeoutID=window.setTimeout(sTimeout,timeout);this.WriteRTMItScriptCall();}}
function ebWriteRTMItScriptCall()
{var timeout=1500,rtmItUrl,randomNo;var index=this.srtmEngineHost.indexOf("&");this.srtmEngineHost=this.srtmEngineHost.substring(0,index);rtmItUrl=this.srtmEngineHost+"&p="+this.aPID.join(":")+"&ite=2"+"&to="+timeout;rtmItUrl=rtmItUrl.replace("RtmCmd","RtmIt");randomNo=Math.random();if(randomNo<0.05)
ebClientServerCallDynamicScriptObject(rtmItUrl);window.clearTimeout(this.timeoutID);}
function ebWriteRTMInlinePlacement(pId,pAdCfg,pDefUrl,pType,pInd)
{if(document.layers)
return;this.writePlacement(pId,pAdCfg,pDefUrl,pType,pInd);if(this.bPlacementsLoaded)
this.writeAllContents();}
function ebExecPageAfterLoad()
{this.bOnAfterLoadExec=true;if(this.bPlacementsLoaded)
this.writeAllContents();}
function ebWriteAllContents()
{var aRTMs=this.rtms,aRTMInfos=this.rtminfos,i=0;for(i;i<aRTMInfos.length;i++)
{if(!aRTMInfos[i].isContentPlaced)
{if(aRTMInfos[i].bIsPopUnder)
this.writeContent(aRTMs[j],aRTMInfos[i]);else
for(var j=0;j<aRTMs.length;j++)
{if(aRTMInfos[i].iId==aRTMs[j].id)
{var oDiv=this.controls[aRTMs[j].divname];if(oDiv&&oDiv.eElem)
{this.writeContent(aRTMs[j],aRTMInfos[i]);aRTMInfos[i].isContentPlaced=true;}
break;}}}}}
function ebWriteMultipleSameContents()
{var aRTMs=this.rtms,aRTMInfos=this.rtminfos,i=0,iRILen=this.rtminfos.length,iRLen=aRTMs.length;for(i;i<iRILen;i++)
{for(var j=0;j<iRLen;j++)
{if((aRTMInfos[i].iId==aRTMs[j].id)&&!aRTMs[j].isContentPlaced)
{var oDiv=this.controls[aRTMs[j].divname];if(oDiv&&oDiv.eElem)
{this.writeContent(aRTMs[j],aRTMInfos[i]);aRTMs[j].isContentPlaced=true;}
break;}}}}
function ebWriteContent(pRTM,pRTMInfo)
{if(pRTMInfo.bIsPopUnder)
{this.initRTMPopUnder(pRTMInfo);return;}
else if(pRTMInfo.bIsHtmlForm)
{ebay.oDocument.oPage.aHtmlFormCache[pRTMInfo.iId]=pRTMInfo.sContent;var oL=this.controls[pRTM.divname];if(pRTMInfo.w&&pRTMInfo.h)
{if(pRTMInfo.h=="-1"||pRTMInfo.h==-1)
pRTMInfo.h=pRTM.h;var oLStyle=oL.eElem.style,h,w;oLStyle.height=h=(pRTMInfo.h.has('auto')||pRTMInfo.h.has('%'))?pRTMInfo.h:pRTMInfo.h+"px";oLStyle.width=w=(pRTMInfo.w.has('auto')||pRTMInfo.w.has('%'))?pRTMInfo.w:pRTMInfo.w+"px";if(h!='auto'&&w!='auto')oLStyle.overflow="hidden";}
var iframe=document.createElement("iframe");var oEnv=ebay.oDocument.oGlobals.oEnvironment;var domain=document.domain;var url="http://pages"+oEnv.sCountryDomain+"rtm/popunder.html"+"?downgradeDomainTo="+domain+"&pid="+pRTMInfo.iId+"&htmlForm=1";iframe.setAttribute("src",url);iframe.setAttribute("hspace",0);iframe.setAttribute("vspace",0);iframe.setAttribute("width","100%");iframe.setAttribute("frameBorder",0);iframe.setAttribute("scrolling","no");iframe.setAttribute("marginWidth",0);iframe.setAttribute("marginHeight",0);oL.eElem.appendChild(iframe);}
else if(pRTMInfo.isRtm)
{var oL=this.controls[pRTM.divname];if(pRTMInfo.w&&pRTMInfo.h)
{if(pRTMInfo.h=="-1"||pRTMInfo.h==-1)
pRTMInfo.h=pRTM.h;var oLStyle=oL.eElem.style,h,w;oLStyle.height=h=(pRTMInfo.h.has('auto')||pRTMInfo.h.has('%'))?pRTMInfo.h:pRTMInfo.h+"px";oLStyle.width=w=(pRTMInfo.w.has('auto')||pRTMInfo.w.has('%'))?pRTMInfo.w:pRTMInfo.w+"px";if(h!='auto'&&w!='auto')oLStyle.overflow="hidden";}
oL.setValue(pRTMInfo.sContent);}else if(pRTMInfo.isMerchPromo){var oL=this.controls[pRTM.divname];this.processMerchPromo(pRTMInfo,oL);}else
{if(pRTMInfo.w)
pRTM.w=pRTMInfo.w;if(pRTMInfo.h)
pRTM.h=pRTMInfo.h;if(pRTMInfo.isDoubleClick)
this.setLoadedDoubleClicks(pRTM,pRTMInfo);else
pRTM.setIFContent(pRTM.defUrl+'');}}
function ebSetLoadedDoubleClicks(pRTM,pRTMInfo)
{if(pRTMInfo.isDoubleClick)
pRTM.isDoubleClick=true;var sz=";sz";if(pRTMInfo.sAdContent.length==1)
pRTM.defAdUrl=pRTM.defAdUrl;else if(pRTM.defAdUrl.indexOf(sz)!=-1)
pRTM.defAdUrl=pRTM.defAdUrl.replace(sz,pRTMInfo.sAdContent+sz);pRTM.setIFContent(pRTM.defAdUrl+'');}
function ebInitRTMPopUnder(pRTMInfo)
{if(pRTMInfo.isContentPlaced)
return;pRTMInfo.isContentPlaced=true;var aCache=ebay.oDocument.oPage.aPopUnderCache=new Array();aCache[aCache.length]=pRTMInfo;var oEnv=ebay.oDocument.oGlobals.oEnvironment;var domain=document.domain;var oCfg={};oCfg.sUrl="http://pages"+oEnv.sCountryDomain+"rtm/popunder.html"+"?downgradeDomainTo="+domain+"&pid="+pRTMInfo.iId;oCfg.iWidth=pRTMInfo.w;oCfg.iHeight=pRTMInfo.h;oCfg.iLeft=null;oCfg.iTop=null;oCfg.bToolbar=false;oCfg.bLocation=false;oCfg.bStatus=false;oCfg.bScrollbars=false;oCfg.bResizable=false;oCfg.bMenubar=false;var oPopUnder=new EbayHTMLPopup(this.parent,"Advertisement",oCfg);oPopUnder.show(true);}
function ebSetRTMInlineContent(pContentArr,pSizeArr)
{window.clearTimeout(this.timeoutID);var oC=this.oDocument.oPage.oConfig;if(oC.disableRTM)return;var aRTMs=this.rtms,aRTMInfos=this.rtminfos,un='undefined',i=0;if(aRTMInfos.length>0)
{for(i=0;i<aRTMInfos.length;i++)
{var currContent=pContentArr[i];var bIsMerchPromo=(currContent!=-1&&currContent.errors)?true:false;var bIsPopUnder=(!bIsMerchPromo&&currContent!=-1&&pContentArr[i].indexOf(':')==0)?true:false;var isdc=(!bIsMerchPromo&&currContent!=-1&&pContentArr[i].indexOf(';')==0)?true:false;var bIsHtmlForm=(!bIsMerchPromo&&pContentArr[i]!=-1&&pContentArr[i].indexOf('~')==0)?true:false;if(pContentArr[i]==-1&&!document.layers)
{aRTMInfos[i].isDefaultPlacement=true;}else if(bIsMerchPromo){if(currContent.length>0)
currContent=currContent[0];aRTMInfos[i].promoMap=currContent.data.map;aRTMInfos[i].isMerchPromo=true;}else if(isdc)
{aRTMInfos[i].isDoubleClick=true;aRTMInfos[i].sAdContent=pContentArr[i];}else if(bIsPopUnder)
{if(pContentArr[i].length>1)
pContentArr[i]=pContentArr[i].substring(1);aRTMInfos[i].sContent=pContentArr[i];aRTMInfos[i].bIsPopUnder=true;}else if(bIsHtmlForm)
{if(pContentArr[i].length>1)
pContentArr[i]=pContentArr[i].substring(1);aRTMInfos[i].sContent=pContentArr[i];aRTMInfos[i].bIsHtmlForm=true;}else
{aRTMInfos[i].sContent=pContentArr[i];aRTMInfos[i].isRtm=true;}
if(!isdc&&typeof(pSizeArr[i])!=un&&pSizeArr[i]!=-1)
{if(pSizeArr[i].indexOf(":")!=-1)
{var rSize=pSizeArr[i].split(":");aRTMInfos[i].w=(rSize[0]==-1||rSize[0]=="9999")?"auto":rSize[0];aRTMInfos[i].h=(rSize[1]==-1||rSize[1]=="9999")?"auto":rSize[1];}}}}
this.bPlacementsLoaded=true;this.writeAllContents();var oIfrm=this.oDocument.getUIElem(this.sIframeName);if(ebay.oGlobals.oClient.bIE&&oIfrm)
oIfrm.outerHTML='';}
function ebEbayRTMPlacementWriteIframe()
{var f='<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width="1" height="1" scrolling="no" id="'+this.sIframeName+'" name="'+this.sIframeName+'"></iframe>';this.oDocument.doc.write(f);}
function ebRTMPlacementInitIframe()
{var oIfrm=this.oDocument.win.frames[this.sIframeName],b=this.oDocument.oPage.oConfig.bNoRTMDowngrade;if(b||typeof(oIfrm)=="undefined"||typeof(oIfrm.document)=="unknown")
this.bFrameNonDowngraded=true;if(b==false)
this.bFrameNonDowngraded=false;if(!(this.oDocument.doc.location.toString().indexOf('https')==0))
{this.sIframeName="rtm_data_frame";if(ebay.oGlobals.oClient.bFirefox)
this.writeIframe();}}
function ebRTMDowngradeDomain()
{var oIfrm=this.oDocument.win.frames[this.sIframeName],dd=document.domain,i=dd.indexOf(".ebay."),dd=dd.substring(i+1),cl=this.oGlobals.oClient,sIfrm_downgrade_domain='<scr'+'ipt language=javascript>document.domain="'+dd+'";</scr'+'ipt>';if(cl.bOpera&&(!oIfrm||!oIfrm.document))
ebay.oDocument._getControl("rtm").downgradeDomain();else
{if(oIfrm&&oIfrm.document)
{oIfrm.document.open();oIfrm.document.write(sIfrm_downgrade_domain);}}}
function ebProcessMerchPromo(pMerchInfo,pLayer)
{var map=pMerchInfo.promoMap;for(var property in map){var match=property.match(/ME([0-9]+)(.*)/);if(match&&pLayer){this.loadPromo(map[property],pLayer);}else if(property.match("Script")&&!this.bPromoScript)
this.bPromoScript=this.loadScript(map[property]);else if(property.match("Style")&&!this.bPromoStyle){if(map[property]){this.bPromoStyle=true;}}}}
function ebLoadScript(pTxt)
{with(window){try{eval(pTxt);return true;}catch(except){}}
return false;}
function ebLoadPromo(pContent,pLayer)
{this.loader.innerHTML=this.loader.innerHTML+pContent;pLayer.setValue(this.loader.innerHTML);}
new EbayRTMPlacement(ebay.oDocument.oPage,"rtm");

//16@@m2

function EbayHTMLActiveX(pParent,pName,pDisabled,pCfg)
{if(!this.objType)
this.objType="EbayHTMLActiveX";this.base=EbayHTML;this.base(pParent,pName,pName,pDisabled,pCfg);this.getElem=ebHTMLActiveXGetElem;}
function ebHTMLActiveXGetElem(pName)
{return this.oDocument.doc.getElementById(pName);}

//17@@m2

function EbayHTMLActiveXWriter(pParent,pName)
{if(!this.objType)
this.objType="EbayHTMLActiveXWriter";this.base=EbayHTMLActiveX;this.base(pParent,pName);this.sID="";this.sName="";this.iWidth=0;this.iHeight=0;this.sClassID="";this.sCodeBase="";this.sType="";this.sPluginsPage="";this.aParams=[];this.aNestedText=[];this.addParam=function(pName,pValue)
{this.aParams[pName]=pValue;}
this.addNestedText=function(pText)
{this.aNestedText[this.aNestedText.length]=pText;}
this.writeObject=function()
{var str="<object ";str+="id='"+this.sID+"' ";str+="name='"+this.sName+"' ";str+="width='"+this.iWidth+"' ";str+="height='"+this.iHeight+"' ";str+="codebase='"+this.sCodeBase+"' ";str+="classid='"+this.sClassID+"' ";str+=">";for(var i in this.aParams)
{this.addNestedText("<param name='"+i+"' value='"+this.aParams[i]+"'>");}
for(var i=0;i<this.aNestedText.length;i++)
{str+=this.aNestedText[i];}
str+="</object>";return str;}
this.clearParam=function(pName)
{this.aParams[pName]=null;}
this.clearNestedText=function()
{this.aNestedText=[];}}

//18@@m1

function EbayHTMLFlashWriter(pParent,pName)
{if(!this.objType)
this.objType="EbayHTMLFlashWriter";this.base=EbayHTMLActiveXWriter;this.base(pParent,pName);this.aFlashVars=[];this.addFlashVar=function(pName,pValue)
{this.aFlashVars[pName]=pValue;}
this.writeFlash=function()
{var fv="";for(var i in this.aFlashVars)
{fv+=i+"="+this.aFlashVars[i]+"&";}
this.addParam("flashvars",fv);var embed="<EMBED";embed+=" src='"+this.aParams["movie"]+"'";embed+=" width='"+this.iWidth+"'";embed+=" height='"+this.iHeight+"'";embed+=" flashvars='"+fv+"'";embed+=" scale='"+this.aParams["scale"]+"'";embed+=" salign='"+this.aParams["salign"]+"'";embed+=" menu='"+this.aParams["menu"]+"'";embed+=" type='"+this.sType+"'";embed+=" pluginspage='"+this.sPluginsPage+"'";embed+=" wmode='"+this.aParams["wmode"]+"'";embed+="></embed>";this.addNestedText(embed);var text=this.writeObject();this.clearParam("flashvars");this.clearNestedText();return text;}}

//19@@m8

function EbayHTMLFlash(pParent,pName)
{if(!this.objType)
this.objType="EbayHTMLFlash";this.base=EbayBaseControl;this.base(pParent,pName);this.oFlashWriterConfig=[];this.oFlashModule=[];this.oRTM=null;this.bUseRTM=false;this.bRTMReady=false;this.aSeg=[];this.aConfigNames=[];this.addModule=function(pConfig)
{var unique=pConfig.sName+""+Math.ceil(Math.random()*1000000000);this.oFlashModule[pConfig.sName]=unique;pConfig.sUniqueName=unique;}
this.registerRTM=function()
{var o=this.oRTM=this.parent._getControl('rtm');if(o)
{o.setRTMInlineContentBase=this.oRTM.setRTMInlineContent;o.setRTMInlineContent=function(pContent,pSize)
{this.setRTMInlineContentBase(pContent,pSize);var o=this.oDocument._getControl('flash');o.bRTMReady=true;o.aSegs=pContent||[];o.loadAllOnDemand();}}}
this.write=function(pConfig)
{if(!this.oRTM)
this.registerRTM();var c=pConfig;this.addModule(c);if(c.objType=="EbayFlashModuleConfig")
{var dc=this.oDocument.getConfig("Common.Flash.DoubleClick.UrlData");if(typeof(dc)!="undefined")
{if(typeof(dc.iOrd)=="undefined")
dc.iOrd=Math.ceil(Math.random()*100000000);}
if(c.sExecuteOn=="rtm-response")
{if(this.bRTMReady)
{var aS=this.aSegs;if(aS.length)
{var seg=aS[this.aConfigNames.length];c.sSeg=(seg!=-1&&seg.indexOf(';')==0)?aS[this.aConfigNames.length]:"";}
c.sExecuteOn="inline";}
else
this.aConfigNames[this.aConfigNames.length]=c.sName;}
if(c.sExecuteOn=="inline")
{var str,f=this.getFlashWriter(c,dc);str=f.writeFlash();if(c.bWindowMode)
{str='<div style="height:'+c.iMinHeight+'px"><div style="position:absolute; z-index:1">'+str;str+="</div></div>";}
this.parent.write(str);}
else
{this.oFlashWriterConfig[c.sName]=c;this.parent.write("<div style='width:"+c.iWidth+"' id='"+c.sName+"_placeholder'></div>");}}}
this.loadAllOnDemand=function()
{var l=this.aConfigNames.length,name,aC=this.oFlashWriterConfig,bAllLoaded=true,slen=this.aSegs.length;for(var i=0;i<l;i++)
{name=this.aConfigNames[i];if(name&&aC[name])
{var seg=this.aSegs[i]||-1;aC[name].sSeg=(slen&&seg!=-1&&seg.indexOf(';')==0)?seg:"";this.loadOnDemand(name);}
else
bAllLoaded=false;}}
this.getFlashWriter=function(pConfig,pDc)
{var dc=pDc,f=new EbayHTMLFlashWriter(this,pConfig.sName);with(pConfig)
{f.sID=sName;f.sName=sName;f.iWidth=iWidth;f.iHeight=iHeight;if(bWindowMode&&!ebay.oGlobals.oClient.bIE)
{f.iHeight=iMinHeight;}
f.sClassID="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000";f.sCodeBase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab";f.sType="application/x-shockwave-flash";f.sPluginsPage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash";f.addParam("movie",sSWF);f.addParam("wmode",bWindowMode?"transparent":"");f.addParam("scale",sScale);f.addParam("salign",sSAlign);f.addParam("menu",false);f.addFlashVar("xmlFile",sXMLFile);f.addFlashVar("movieid",sName);f.addFlashVar("initialSize",iInitialSize);f.addFlashVar("config",sXMLFile);f.addFlashVar("name",sName);f.addFlashVar("uniqueName",sUniqueName);f.addFlashVar("width",iWidth);f.addFlashVar("height",iHeight);if(typeof(sRendererPath)!="undefined")
f.addFlashVar("fvRenderer",sRendererPath);f.addFlashVar("fvIncludePath",this.oGlobals.oEnvironment.sIncludeHost);f.addFlashVar("fvPicsPath",this.oGlobals.oEnvironment.sPicsDir);f.addFlashVar("fvComponentPath",this.oGlobals.oEnvironment.sIncludeHost+"aw/pics/flash/");f.addFlashVar("fvConfig",sXMLFile);f.addFlashVar("fvDataConfig",sXMLFile2);f.addFlashVar("fvName",sName);f.addFlashVar("fvUniqueName",sUniqueName);f.addFlashVar("fvWidth",iWidth);f.addFlashVar("fvHeight",iHeight);if(typeof(sCurrentSiteId)!="undefined")
f.addFlashVar("fvCurrentSiteId",sCurrentSiteId);if(typeof(sTargetSiteId)!="undefined")
f.addFlashVar("fvTargetSiteId",sTargetSiteId);if(dc)
{if(dc.sDomain.lastIndexOf("/")==dc.sDomain.length-1)
dc.sDomain=dc.sDomain.substring(0,dc.sDomain.length-1);f.addFlashVar("dclk_Domain",dc.sDomain);f.addFlashVar("dclk_DartSite",dc.sDartSite);f.addFlashVar("dclk_AdSize",sAdSize);f.addFlashVar("dclk_Tile",sTile);f.addFlashVar("dclk_Ord",dc.iOrd);f.addFlashVar("dclk_Seg",sSeg);f.addFlashVar("dclk_Zone",dc.sZone);}}
return f;}
this.loadOnDemand=function(pName)
{var c=this.oFlashWriterConfig[pName]
if(typeof(c)=='undefined')
return;var str,f=this.getFlashWriter(c,this.oDocument.getConfig("Common.Flash.DoubleClick.UrlData"));str=f.writeFlash();if(c.bWindowMode)
{str='<div style="height:'+c.iMinHeight+'px"><div style="position:absolute; z-index:1">'+str;str+="</div></div>";}
var placeholder=new EbayHTMLLayer(this,pName+"_placeholder");placeholder.bind();if(placeholder.eElem)
placeholder.setValue(str);}
this.notify=function(pMod,pFunc,pParam)
{var notifySrc=this.oGlobals.oEnvironment.sIncludeHost+'aw/pics/flash/global/notify/dist/notify.swf';var div=new EbayHTMLLayer(this,"EbayHTMLFlash_notify_div");div.bind();div.setValue("<embed src='"+notifySrc+"' FlashVars='mod="+pMod+"&func="+pFunc+"&param="+pParam+"' width='0' height='0' type='application/x-shockwave-flash'></embed>");}
this.getVersion=function()
{var fv=0,cl=this.oGlobals.oClient;if(cl.bIE&&cl.bWin&&!cl.bOpera)
{for(var i=3;i<10;i++)
{if(cl.activeXLibLoaded("ShockwaveFlash.ShockwaveFlash."+i))
fv=i;}}
else
{if(navigator.plugins["Shockwave Flash"])
{var pd=navigator.plugins["Shockwave Flash"].description;fv=parseInt(pd.charAt(pd.indexOf(".")-1));}
if(cl.bWebTV)fv=3;}
return fv;}
this.init=function()
{var d=this.parent,cl=this.oGlobals.oClient;d.write("<div id='EbayHTMLFlash_notify_div'></div>");}
this.init();}
function EbayFlashModuleConfig(pName)
{this.objType="EbayFlashModuleConfig";this.sName=pName;this.sUniqueName="";this.sMod="";this.iWidth=0;this.iHeight=0;this.iMinHeight=0;this.sSWF="";this.sExecuteOn="inline";this.bWindowMode=false;this.sFlashVars="";this.sScale="noscale";this.sSAlign="lt";this.sXMLFile="";this.sXMLFile2="";this.iInitialSize=0;this.sAdSize="";this.sTile="";this.sSeg="";}
new EbayHTMLFlash(ebay.oDocument,"flash");

//20@@m5

ebay.oDocument._getControl("rtm").writeContentShowBase=ebay.oDocument._getControl("rtm").writeContent;ebay.oDocument._getControl("rtm").writeContent=function(pRTM,pRTMInfo)
{this.writeContentShowBase(pRTM,pRTMInfo);var oRTM=this.parent._getControl("rtm_"+pRTM.id);if(oRTM&&parseInt(pRTMInfo.h)!=0&&parseInt(pRTMInfo.w)!=0&&oRTM.adCfg&&oRTM.adCfg.showIds&&oRTM.adCfg.showIds.length>0)
for(var j=0;j<oRTM.adCfg.showIds.length;j++)
{var o=new EbayHTML(ebay.oDocument,oRTM.adCfg.showIds[j],oRTM.adCfg.showIds[j]);o.bind();o.show(true);}}
// b=6879737 -->