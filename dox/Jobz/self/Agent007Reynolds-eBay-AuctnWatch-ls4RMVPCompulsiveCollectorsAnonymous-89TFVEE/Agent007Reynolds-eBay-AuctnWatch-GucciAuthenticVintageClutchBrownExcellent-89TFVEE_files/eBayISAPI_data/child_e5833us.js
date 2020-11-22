//<!--
//1@@m6

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

//2@@m10

function EbayHTMLAnchor(pParent,pName,pDisabled,pCfg)
{if(!this.objType)
this.objType="EbayHTMLAnchor";this.base=EbayHTML;this.base(pParent,pName,pName,pDisabled,pCfg);this.getElem=ebHTMLAnchorGetElem;this.enableBase=this.enable;this.enable=ebHTMLAnchorEnable;this.subscribeEvents("onclick");}
function ebHTMLAnchorGetElem(pName)
{var d=this.oDocument.doc,l=null;l=d.links[pName];if(l)return l;if(d.getElementById)
l=d.getElementById(pName);if(l)return l;if(d.all)
l=d.all[pName];if(l)return l;if(d.layers)
{var lyrs=d.layers;var len=lyrs.length;for(var i=0;i<len;i++)
{l=this.getElem(lyrs[i].document,pName);if(l)
return l;}}
for(var j=0;j<d.links.length;j++)
{l=d.links[j];if(typeof(l.name)=="undefined")
{if(l.onclick)
{var oc=l.onclick.toString();if(oc.indexOf("{#"+pName+"#}")!=-1)
return l;}}
else
{if(l.name==pName)
return l;}
l=null;}
return l;}
function ebHTMLAnchorEnable(pEnable)
{var cur=(pEnable)?"hand":"default";var el=this.eElem;if(el&&el.style)
{el.style.cursor=cur;el.style.color=pEnable?"":"gray";}
this.enableBase(pEnable);}
function setEbayLink(pS)
{return true;}

//3@@m7

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

//4@@m5

ebay.oDocument.oPage.onBeforeLoad=function()
{var eb=this.oDocument.parent,frame=eb.parent,ctr=frame.parent,cfg=this.oDocument.getConfig("ContentRetrieval");var elems=cfg.aEntities;for(var i=0,elem=elems[i];i<elems.length;i++,elem=elems[i])
{elem[2]=new EbayHTMLLayer(this,elem[1]);}
var divObj=parent.ebay.oDocument.doc.getElementById(cfg.sFreeIconDiv);if(divObj&&(cfg.sFreeIconImg!=""))
{divObj.innerHTML='<img src="'+cfg.sFreeIconImg+'" align="right"/>';divObj.style.display="block";}}
ebay.oDocument.oPage.onAfterLoad=function()
{cfg=this.oDocument.getConfig("ContentRetrieval");if(cfg)
{var elems=cfg.aEntities;var ctr=parent.ebay.oDocument._getControl("ContentRetrieval");ctr.populateEntities(elems);var oConfig=this.oDocument.getConfig("DynamicTransit");if(oConfig)
ctr.getChildConfig(oConfig);}}
// b=7298324 -->