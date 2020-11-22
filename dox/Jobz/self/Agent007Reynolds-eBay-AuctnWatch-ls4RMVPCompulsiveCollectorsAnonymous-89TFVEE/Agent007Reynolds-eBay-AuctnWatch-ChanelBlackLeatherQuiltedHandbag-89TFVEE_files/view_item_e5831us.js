//<!--
//1@@m27

function EbayDocument(pWin,pName)
{this.htmlWin=pWin||null;this.htmlDoc=pWin?pWin.document:null;this.name=pName||null;this.status=null;this.controls=new Array;this.events=new Array;this.bindHTML=EbayDocumentBindHTML;this.bindEvents=EbayDocumentBindEvents;this.addControl=EbayAddControl;this.getFormElem=EbayGetFormElem;this.onLoad=EbayDocumentOnLoad;this.onUnload=EbayDocumentOnUnLoad;}
window.EbayDocument=EbayDocument;function EbayGetFormElem(pName,pType)
{if(!this.htmlDoc)
return null;var frms=this.htmlDoc.forms;var ln=frms.length;for(var i=0;i<ln;i++)
{var elems=frms[i].elements;for(var j=0;j<elems.length;j++)
{if(elems[j].name==pName)
{if(pType)
{if(elems[j].type==pType)
return elems[pName];}
else
return elems[j];}}}}
function EBayPreviewDocument(pWin,pName)
{this.baseObject=EbayDocument;this.baseObject(pWin,pName);this.isPreviewMode=true;this.skipElems=new Array;this.skipLinks=new Array;this.onLoad=EbayDisableDoc;}
function EbayDisableDoc()
{if(!this.isPreviewMode)
return;var doc=this.htmlDoc;for(var j=0;j<doc.forms.length;j++)
{var frms=doc.forms;var iElems=frms[j].elements.length;frms[j].onsubmit=EbayDisableOnSubmit;for(var i=0;i<iElems;i++)
{var elem=frms[j].elements[i];var skEs=this.skipElems;var skip=false;if(skEs.length>0)
{for(var k=0;k<skEs.length;k++)
{if(elem.name==skEs[k])
{skip=true;break;}}}
if(!skip)
EbayDisableFormElement(elem);}}
var iLinks=doc.links.length;for(var i=0;i<iLinks;i++)
{var lnk=doc.links[i];var skLnks=this.skipLinks;var skip=false;if(lnk.href)
{for(var k=0;k<skLnks.length;++k)
{if(lnk.href.indexOf(skLnks[k])!=-1)
{skip=true;break;}}}
if(!skip)
{lnk.href="#";lnk.onclick=EbayDisableLink;}}}
function EbayDisableLink()
{return false;}
function EbayDisableFormElement(pElem)
{if(pElem.type)
{switch(pElem.type.toLowerCase())
{case"hidden":break;case"text":break;case"button","submit":pElem.onclick=null;break;default:pElem.onclick=null;break;}}}
function EbayDisableText()
{if(typeof(this.disabled)!="undefined")
this.htmlElement.disabled=this.disabled=true;}
function EbayEnableText()
{if(typeof(this.disabled)!="undefined")
this.htmlElement.disabled=this.disabled=false;}
function EbayDisableOnSubmit()
{return false;}
function EbayControl(pEbayDoc,pParent,pHTMLDoc,pElementName)
{this.htmlElement=null;this.htmlElementName=pElementName||null;this.name=pElementName||null;this.parent=pParent||null;this.ebayDoc=pEbayDoc||null;this.htmlDoc=pHTMLDoc||null;this.controls=new Array;this.listeners=new Array;this.bindHTML=null;this.bindEvents=null;this.registerListener=EbayControlRegisterListener;this.allowUpdateOnload=false;this.onBeforeLoad=null;this.onAfterLoad=null;this.onBeforeUnload=null;this.onAfterUnload=null;this.onUpdate=EbayControlOnUpdate;if(this.parent&&this.parent.addControl)this.parent.addControl(this);}
window.EbayControl=EbayControl;function EbayControlRegisterListener(pControl)
{this.listeners[this.listeners.length]=pControl;}
function EbayControlOnUpdate(pParent)
{var parent=pParent?pParent:this.ebayControl;for(var i=0;i<parent.listeners.length;i++)
{if(parent.listeners[i].onUpdate)parent.listeners[i].onUpdate(parent);}}
function EbayText(pebayDoc,pParent,pHTMLDoc,pElementName)
{if(!this.objType)
this.objType="ebayText";this.baseObject=EbayControl;this.baseObject(pebayDoc,pParent,pHTMLDoc,pElementName);this.disabled=false;this.bindHTML=EbayBindHTMLText;this.bindEvents=tbd;this.disable=EbayDisableText;this.enable=EbayEnableText;}
window.EbayText=EbayText;function EbayHyperLink(pEbayDoc,pParent,pHTMLDoc,pElementName,pLink)
{if(!this.objType)
this.objType="EbayHyperLink";this.baseObject=EbayControl;this.baseObject(pEbayDoc,pParent,pHTMLDoc,pElementName);this.link=pLink||null;this.mouseOverText="";this.urlPath=null;this.eventBound=false;this.bindHTML=EbayBindHTMLHyperLink;this.bindEvents=EbayBindEventsHyperLink;this.getLink=EbayGetLink;this.onClick=null;this.onMouseOver=tbd;this.onMouseOut=tbd;}
window.EbayHyperLink=EbayHyperLink;function EbayBindHTMLText()
{this.htmlElement=this.ebayDoc.getFormElem(this.htmlElementName,"text");if(this.htmlElement)
{this.htmlElement.ebayControl=this;if(this.disabled)
this.disable();else
this.enable();}}
function EbayMoveLayer(pLayer,x,y)
{if(document.getElementById)
{pLayer.style.left=x+'px';pLayer.style.top=y+'px';}
else if(document.all)
{pLayer.style.left=x;pLayer.style.top=y;}
else if(document.layers)
{pLayer.pageX=x;pLayer.pageY=y;}}
function EbayDocumentBindHTML()
{this.htmlDoc.ebayDoc=this;EbayBindAllControls(this,false);}
function EbayDocumentBindEvents()
{EbayBindAllControls(this,true);}
function EbayBindAllControls(pThis,pIsEvents)
{var cctrl;var ctrls=pThis.controls;for(var i=0;i<ctrls.length;i++)
{cctrl=ctrls[i];if(pIsEvents)
{if(cctrl&&cctrl.bindEvents&&cctrl.objType!="EbayHyperLink")
cctrl.bindEvents();}
else
{if(cctrl&&cctrl.bindHTML)
cctrl.bindHTML();}}}
function EbayAddControl(pControl)
{var isSet=false;if(pControl.htmlElementName)
{var ctrls=this.controls;for(var i=0;i<ctrls.length;i++)
{if(ctrls[i].htmlElementName==pControl.htmlElementName)
{this.controls[i]=pControl;return;}}}
this.controls[this.controls.length]=pControl;}
function EbayDocumentOnLoad()
{this.bindHTML();this.bindEvents();}
function EbayDocumentOnUnLoad()
{}
function EbayBindHTMLHyperLink()
{this.htmlElement=this.getLink(this.htmlDoc,this.htmlElementName);if(this.htmlElement)
{this.link=this.htmlElement.href;this.htmlElement.ebayControl=this;}
this.bindEvents();}
function EbayGetLink(pDoc,pLinkName)
{var lnk=null;if(pDoc&&pLinkName&&!this.ebayDoc.htmlWin.closed)
{if(pDoc.all)
lnk=pDoc.all[pLinkName];if(lnk)return lnk;if(pDoc.getElementById)
lnk=pDoc.getElementById(pLinkName);if(lnk)return lnk;for(var j=0;j<pDoc.links.length;j++)
{lnk=pDoc.links[j];if(typeof(lnk.name)!="undefined")
{if(lnk.name==pLinkName)
return lnk;}
else
{if(lnk.onclick)
{var oc=lnk.onclick.toString();if(oc.indexOf("{#"+pLinkName+"#}")!=-1)
return lnk;}}}
lnk=null;if(pDoc.layers)
{var lyrs=pDoc.layers;var len=lyrs.length;for(var i=0;i<len;i++)
{if(this.ebayDoc.htmlDoc==null)
return;else
{lnk=this.getLink(lyrs[i].document,pLinkName);if(lnk)
return lnk;}}}}
return lnk;}
function setEbayLink(pS)
{return true;}
function EbayBindEventsHyperLink()
{if(!this.htmlElement)
return;this.htmlElement.onclick=this.onClick;}
function EbayImage(pEbayDoc,pParent,pHTMLDoc,pElementName)
{if(!this.objType)
this.objType="EbayImage";this.baseObject=EbayControl;this.baseObject(pEbayDoc,pParent,pHTMLDoc,pElementName);this.image=pElementName||null;this.mouseOverText="";this.bindHTML=EbayBindHTMLImage;this.bindEvents=tbd;this.getImage=EbayGetImage;}
window.EbayImage=EbayImage;function EbayBindHTMLImage()
{this.htmlElement=this.getImage(this.htmlDoc,this.htmlElementName);if(this.htmlElement)
this.htmlElement.ebayControl=this;}
function EbayGetImage(pDoc,pImageName)
{var image=null;if(pDoc&&pImageName&&!this.ebayDoc.htmlWin.closed)
{var len=pDoc.images.length;for(var i=0;i<len;i++)
{if(!this.ebayDoc.htmlDoc)
return;else if(pDoc.images[i].name==pImageName)
return pDoc.images[i];}
if(pDoc.layers)
{var lyrs=pDoc.layers;var len=lyrs.length;for(var i=0;i<len;i++)
{if(this.ebayDoc.htmlDoc==null)
return;else
{image=this.getImage(lyrs[i].document,pImageName);if(image)
return image;}}}}
return image;}
function EbaySelect(pEbayDoc,pParent,pHTMLDoc,pElementName)
{if(!this.objType)
this.objType="EbaySelect";this.baseObject=EbayControl;this.baseObject(pEbayDoc,pParent,pHTMLDoc,pElementName);this.bindHTML=EbayBindHTMLSelect;this.bindEvents=EbayBindEventsSelect;this.clearOptions=EbaySelectClearOptions;this.getSelect=EbayGetSelect;this.onAfterLoad=null;this.onChange=tbd;}
window.EbaySelect=EbaySelect;function EbayBindHTMLSelect()
{this.htmlElement=this.getSelect(this.htmlDoc,this.htmlElementName);if(this.htmlElement)
this.htmlElement.ebayControl=this;if(this.allowUpdateOnload&&this.update)
this.update();}
function EbayBindEventsSelect()
{if(this.htmlElement)
{this.htmlElement.onchange=this.onChange;if(this.onAfterLoad)this.onAfterLoad();}}
function EbaySelectClearOptions()
{if(this.htmlElement)
{var len=this.htmlElement.options.length;for(var i=0;i<len;i++)
{this.htmlElement.options[0]=null;}}}
function EbayGetLayer(pDoc,pLayerName)
{var layer=null;if(pDoc&&pLayerName&&!this.ebayDoc.htmlWin.closed)
{if(pDoc.getElementById)
{layer=pDoc.getElementById(pLayerName);}
else if(pDoc.all)
{layer=pDoc.all[pLayerName];}
else if(pDoc.layers)
{var lyrs=pDoc.layers;var len=lyrs.length;layer=lyrs[pLayerName];if(!layer){for(var i=0;i<len;i++)
{if(lyrs[i].name==pLayerName||lyrs[i].id==pLayerName)
{layer=lyrs[i];}
else
{layer=this.getLayer(lyrs[i].document,pLayerName);}
if(layer)break;}}}}
return layer;}
function EbayGetSelect(pHtmlDoc,pName)
{if(!pHtmlDoc)
return null;var elem;var frms=pHtmlDoc.forms;var ln=frms.length;for(var i=0;i<ln;i++)
{var elems=frms[i].elements;elem=elems[pName];if(elem)
return elem;}
return null;}
function EbayGetRadio(pHtmlDoc,pName)
{if(!pHtmlDoc)
return null;var elem;var frms=pHtmlDoc.forms;var ln=frms.length;for(var i=0;i<ln;i++)
{var elems=frms[i].elements;elem=elems[pName];if(elem)
return elem;}
return null;}
function EbayRadio(pEbayDoc,pParent,pHTMLDoc,pElementName)
{if(!this.objType)
this.objType="EbayRadio";this.baseObject=EbayControl;this.baseObject(pEbayDoc,pParent,pHTMLDoc,pElementName);this.bindHTML=EbayBindHTMLRadio;this.bindEvents=EbayBindEventsRadio;this.getRadio=EbayGetRadio;this.onClick=null;this.onAfterLoad=null;}
window.EbayRadio=EbayRadio;function EbayBindHTMLRadio()
{this.htmlElement=this.getRadio(this.htmlDoc,this.htmlElementName);if(this.htmlElement)
{if(this.htmlElement.length&&this.htmlElement.length>0)
{for(var i=0;i<this.htmlElement.length;i++)
{if(this.htmlElement[i])
this.htmlElement[i].ebayControl=this;}}
else
this.htmlElement.ebayControl=this;}}
function EbayBindEventsRadio()
{if(this.htmlElement&&this.onClick)
{if(this.htmlElement.length&&this.htmlElement.length>0)
{for(var i=0;i<this.htmlElement.length;i++)
this.htmlElement[i].onclick=this.onClick;}
else
this.htmlElement.onclick=this.onClick;}
if(this.onAfterLoad)this.onAfterLoad();}
function EbayGetCheckBox(pHtmlDoc,pName)
{return this.ebayDoc.getFormElem(pName);}
function EbayCheckBox(pEbayDoc,pParent,pHTMLDoc,pElementName)
{if(!this.objType)
this.objType="EbayCheckBox";this.baseObject=EbayControl;this.baseObject(pEbayDoc,pParent,pHTMLDoc,pElementName);this.bindHTML=EbayBindHTMLCheckBox;this.bindEvents=EbayBindEventsCheckBox;this.getCheckBox=EbayGetCheckBox;this.onClick=null;this.onAfterLoad=null;}
window.EbayCheckBox=EbayCheckBox;function EbayBindHTMLCheckBox()
{this.htmlElement=this.getCheckBox(this.htmlDoc,this.htmlElementName);if(this.htmlElement)this.htmlElement.ebayControl=this;}
function EbayBindEventsCheckBox()
{if(this.onClick&&typeof(this.htmlElement)!='undefined')
this.htmlElement.onclick=this.onClick;if(this.onAfterLoad)this.onAfterLoad();}
function EbayGetInput(pHtmlDoc,pName)
{return this.ebayDoc.getFormElem(pName);}
function EbayInput(pEbayDoc,pParent,pHTMLDoc,pElementName)
{if(!this.objType)
this.objType="EbayInput";this.baseObject=EbayControl;this.baseObject(pEbayDoc,pParent,pHTMLDoc,pElementName);this.bindHTML=EbayBindHTMLInput;this.bindEvents=EbayBindEventsInput;this.getInput=EbayGetInput;this.onClick=null;this.onAfterLoad=null;}
window.EbayInput=EbayInput;function EbayBindHTMLInput()
{this.htmlElement=this.getInput(this.htmlDoc,this.htmlElementName);if(this.htmlElement)this.htmlElement.ebayControl=this;}
function EbayBindEventsInput()
{if(this.onClick)this.htmlElement.onclick=this.onClick;if(this.onAfterLoad)this.onAfterLoad();}
function EbayGetObject(pDoc,pObjName)
{return pDoc.getElementById(pObjName);}
function EBayConfig(pName)
{if(!this.objType)
this.objType="EBayConfig";this.name=pName;this.set=ebConfigSetVar;this.get=ebConfigGetString;this.copy=ebConfigObjectCopy;}
window.EBayConfig=EBayConfig;function ebConfigSetVar(pName,pVal)
{eval("this."+pName+" = '"+pVal+"';");}
function ebConfigGetString(pName,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10)
{var s=eval("this."+pName);var r="";if(!s)
return r;var len=s.length;for(var i=0;i<len;i++)
{if(s.substring(i,i+2)=="##")
{r+=new String(eval('p'+s.charAt(i+2)));i+=2;}
else
r+=s.charAt(i);}
return r;}
function ebConfigObjectCopy(pObj)
{if(pObj)
{for(var i in pObj)
{var prop=eval("pObj."+i),ti="this."+i;if(prop&&(typeof(eval("prop.copy"))=="function")&&prop.objType&&(i!="parent"))
{eval(ti+"=new "+prop.objType+"();");eval(ti).copy(prop);}
if(prop&&typeof prop=="function")continue;if(prop&&typeof prop=="object"&&prop.toString().indexOf("function")==0)continue;eval(ti+"=prop;");}}}
function EbayGetForm(pDoc,pFormName)
{if(!pDoc)
return null;var frms=pDoc.forms;var ln=frms.length;for(var i=0;i<ln;i++)
{if(frms[i].name==pFormName)
return frms[i];}}
function EbayLabel(pEbayDoc,pParent,pHTMLDoc,pElementName,pLabel,pCssClass,pCssInline)
{if(!this.objType)
this.objType="EbayLabel";this.baseObject=EbayControl;this.baseObject(pEbayDoc,pParent,pHTMLDoc,pElementName);this.label=pLabel;this.getLayer=EbayGetLayer;this.bindHTML=EbayLabelBindHTML;this.onUpdate=null;this.setLabel=EbaySetLabel;this.getLabel=EbayGetLabel;this.cssInline=pCssInline;this.cssClass=pCssClass;this.hide=EbayHideLabel;this.show=EbayShowLabel;this.moveLyr=EbayMoveLayer;this.moveTo=EbayLabelMoveTo;}
function EbayLabelBindHTML()
{if(this.ebayDoc.htmlDoc&&this.htmlElementName)
{this.htmlElement=this.getLayer(this.ebayDoc.htmlDoc,this.htmlElementName);this.htmlElement.ebayControl=this;if(document.layers)
{var lyr=this.htmlElement;var peer=null;if(!lyr.peerLayer)
{peer=lyr.peerLayer=new Layer(lyr.clip.width,lyr.parentLayer);peer.clip.height=lyr.clip.height;peer.moveTo(lyr.pageX,lyr.pageY);lyr.visibility='hide';peer.visibility='show';}}
if(this.label)
{this.setLabel(this.label);}}}
function EbaySetLabel(text)
{var str='<span ';if(this.cssClass)
{str+='class="'+this.cssClass+'" ';}
if(this.cssInline)
{str+='style="'+this.cssInline+'" ';}
str+='>'+text+'</span>';if(document.all||document.getElementById)
{this.htmlElement.innerHTML=str;}
else if(document.layers)
{with(this.htmlElement.peerLayer.document)
{open();write(str);close();}}
this.label=text;}
function EbayGetLabel()
{return this.label;}
function EbayHideLabel()
{if(document.getElementById||document.all)
{this.htmlElement.style.visibility='hidden';}
else if(document.layers)
{this.htmlElement.visibility='hide';this.setLabel('');}}
function EbayShowLabel()
{if(document.getElementById||document.all)
{this.htmlElement.style.visibility='visible';}
else if(document.layers)
{this.htmlElement.visibility='show';}}
function EbayLabelMoveTo(x,y)
{if(document.getElementById||document.all)
{this.moveLyr(this.htmlElement,x,y);}
else if(document.layers)
{this.moveLyr(this.htmlElement.peerLayer,x,y);}}
function tbd()
{}

//2@@m24

var viSpcrPic='http://pics.ebaystatic.com/aw/pics/x.gif';var unloading=false;function MM_reloadPage(init)
{if(init)with(navigator)
{if((appName=="Netscape")&&(parseInt(appVersion)==4))
{document.MM_pgW=innerWidth;document.MM_pgH=innerHeight;onresize=MM_reloadPage;}}
else if(innerWidth!=document.MM_pgW||innerHeight!=document.MM_pgH)location.reload();}
function clientBrowserSniffer()
{var ua=navigator.userAgent.toLowerCase();this.major=parseInt(navigator.appVersion);if((is.opera&&(is.ver>4))||(is.ie&&(is.ver<4))||is.webTV||is.safari||ua.contains('hotjava')||(is.nav&&(is.ver<4)))
return true;return false;}
function getOriginalImg()
{return document.images['eBayBig'];}
function resizeImage(imageOrImageName)
{var u="undefined";var image=typeof imageOrImageName=='string'?document[imageOrImageName]:imageOrImageName;if((is.nav&&(is.ver>4))||(is.opera&&(is.ver==5)))
{image=new Image();image.src=typeof imageOrImageName=='string'?document[imageOrImageName]:imageOrImageName;}
var imw=eBayUser_SelfHosted_image.width;var imh=eBayUser_SelfHosted_image.height;if((is.ie||is.safari)&&is.mac)
{var origImg=getOriginalImg();if(typeof(origImg)!="undefined")
{if(typeof(origImg.width)!="undefined")
{imw=origImg.width;}
if(typeof(origImg.height)!="undefined")
{imh=origImg.height;}}}
var rw=imw/200,rh=imh/200,ratio=(rw>rh)?rw:rh;if(document.layers)
{var l;imageOrImageName.src=viSpcrPic;if(!image.overLayer)
l=image.overLayer=new Layer(200);l=image.overLayer;l.bgColor=document.bgColor;if(ratio>1)
{l.clip.width=Math.round(imw/ratio);l.clip.height=Math.round(imh/ratio);}
else
{l.clip.width=imw;l.clip.height=imh;}
l.left=image.x+((200-l.clip.width)/2);l.top=image.y+((200-l.clip.height)/2);var im=eBayUser_SelfHosted_image;if(im&&im.src)
{var i=' <a href=\"#ebayphotohosting\"><IMG SRC="'+im.src+'"';i+=image.name?' NAME="overLayer'+image.name+'"':'';i+=' border=0  WIDTH="'+l.clip.width+'" HEIGHT="'+l.clip.height+'"> </a>';l.document.open();l.document.write(i);l.document.close();}
l.visibility='show';}
else
{if(ratio>=1)
{if(typeof(document.SelfHostedImage)!='undefined'){document.SelfHostedImage.setAttribute('width',imw/ratio);document.SelfHostedImage.setAttribute('height',imh/ratio);}}
else
{if((is.ie||is.safari)&&is.mac)
{if(typeof(document.SelfHostedImage)!='undefined'){document.SelfHostedImage.setAttribute('width',imw);document.SelfHostedImage.setAttribute('height',imh);}}}}}
function init()
{var i=document.SelfHostedImage;var u="undefined";if(typeof(i)==u)
return;if(typeof(i.src)!=u&&i.src.length!=0)
resizeImage(i);}
function hostedImageLoaded(img,wellSize)
{var n=(typeof(wellSize)=="number")?wellSize:200;var h=img.height,w=img.width;if((h&&w)&&(h>n)&&(w>n))
{if(h/n>w/n)
{img.width=n*w/h;img.height=n;}
else
{img.height=h*n/w;img.width=n;}}}
function writeHostedImage()
{var u="undefined",h=200;var w=200,img=new Image();img.src=hostedimageSRc;if(typeof(img.height)!=u)
if(img.height>1&&img.height<h)
h=img.height;if(typeof(img.width)!=u)
if(img.width>1&&img.width<w)
w=img.width;s='<a href="#ebayphotohosting">';s+='<img src="'+hostedimageSRc+'" width='+w.toString()+' align=middle border=0 ';s+='name=SelfHostedImage height='+h.toString()+' onload="hostedImageLoaded(this);"></a>';document.open();document.write(s);document.close();}
function slideshow(direction)
{if(direction==null||typeof(direction)=='undefined')
{if((lastTime+delay)>new Date().getTime())
direction=0;else
direction=currentDirection;}
else
currentDirection=direction;if(direction!=0)
{if(direction>0)
{currentSlide++;if(currentSlide>(slides.length-1))
currentSlide=0;}
else
{currentSlide=currentSlide-1;if(currentSlide<0)
currentSlide=(slides.length-1);}
lastTime=new Date().getTime();update(slides[currentSlide]);setTimeout('slideshow()',delay);}}
function update(url,index,isSuper)
{currentIndex=index;currentIsSuper=isSuper;document['eBayBig'].src=url;visibleState="hidden";if(isSuper)
visibleState="visible";if(document.layers&&document.eBaySuperLink1)
{document.eBaySuperLink1.visibility=visibleState;document.eBaySuperLink2.visibility=visibleState;}
if(document.all&&document.all.eBaySuperLink1)
{document.all.eBaySuperLink1.style.visibility=visibleState;document.all.eBaySuperLink2.style.visibility=visibleState;}
if(!document.all&&document.getElementById&&document.getElementById("eBaySuperLink1"))
{document.getElementById("eBaySuperLink1").style.visibility=visibleState;document.getElementById("eBaySuperLink2").style.visibility=visibleState;}
return false;}
function supersize()
{if(currentIsSuper){var modSuperSizeUrl=superSizeURL.substr(0,superSizeURL.indexOf("indexURL=")+9)+
currentIndex+superSizeURL.substr(superSizeURL.indexOf("indexURL=")+10);location.href=modSuperSizeUrl;}
return;}
function converter(page)
{appletwin=window.open(page,"currency_page","width=550,height=300,resizable=1,screenX=300,screenY=300");}
function gotoNext()
{document['eBaySuper'].src=images[++current];updateLabels();return false;}
function gotoPrev()
{current=current-1;document['eBaySuper'].src=images[current];updateLabels();return false;}
function updateLabels()
{visibleStatePrevious="hidden";if(current)
visibleStatePrevious="visible";visibleStateNext="visible";if(current+1==images.length-1)
visibleStateNext="hidden";if(document.layers)
{document.nextLabel1.visibility=visibleStateNext;document.nextLabel2.visibility=visibleStateNext;document.prevLabel1.visibility=visibleStatePrevious;document.prevLabel2.visibility=visibleStatePrevious;}
var da=document.all;if(da)
{da.nextLabel1.style.visibility=visibleStateNext;da.nextLabel2.style.visibility=visibleStateNext;da.prevLabel1.style.visibility=visibleStatePrevious;da.prevLabel2.style.visibility=visibleStatePrevious;}
if(!da&&document.getElementById)
{document.getElementById("nextLabel1").style.visibility=visibleStateNext;document.getElementById("nextLabel2").style.visibility=visibleStateNext;document.getElementById("prevLabel1").style.visibility=visibleStatePrevious;document.getElementById("prevLabel2").style.visibility=visibleStatePrevious;}}
function gotoOther()
{if(typeof(descSS)!="undefined"&&descSS!=null){currentIndex=descSS.position;}
var modSuperSizeUrl=superSizeGotoURL.substr(0,superSizeGotoURL.indexOf("indexURL=")+9)+
currentIndex+superSizeGotoURL.substr(superSizeGotoURL.indexOf("indexURL=")+10);location.href=modSuperSizeUrl;return false;}
function doButtons(picimage)
{document['mainPicture'].src=picimage;}
function ebVICheckRedirect()
{if(iframeApproved)
{var dr=document.referrer.toLowerCase();var si=dr.indexOf("/",dr.indexOf("://")+3);if(si!=-1)dr=dr.substring(0,si);var ls=location.search.toLowerCase(),i=ls.indexOf("ifrdesc=0");if((i>-1)&&(dr.indexOf(".ebay.")==-1))
location.replace(location.pathname+ls.substring(0,i)+ls.substr(i+9));}}
function standardizeImage(image,dimension){var u="undefined";if(document.layers){return false;}
var agt=navigator.userAgent.toLowerCase();if(is.mac&&is.ie){var version=parseInt(agt.substring(agt.indexOf("msie")+4));if(version<=5){return false;}}
if((image==u)||(!image)){return false;}
if(dimension==u){dimension=400;}
var customImage=new Image();customImage.src=image.src;var imw;var imh;if(is.safari&&is.mac)
{var origImg=getOriginalImg();if(typeof(origImg)!=u)
{if(typeof(origImg.width)!=u)
{imw=origImg.width;}
if(typeof(origImg.height)!=u)
{imh=origImg.height;}}}
else
{imw=customImage.width;imh=customImage.height;}
var rw=imw/dimension,rh=imh/dimension,ratio=(rw>rh)?rw:rh;if(ratio>=1)
{image.width=imw/ratio;image.height=imh/ratio;}
else
{image.width=imw;image.height=imh;}}
ebVICheckRedirect();

//3@@m5

function openShippingCalculator(path,form){if(form>0)
{var oD=ebay.oDocument,iid,zip,tid,o,url,pop;o=oD.getFormElem("itemId");iid=o?encodeURIComponent(o.value):"";o=oD.getFormElem("destinationZipCode");zip=o?encodeURIComponent(o.value):"";o=oD.getFormElem("TransactionId");tid=o?encodeURIComponent(o.value):"";url=oD.doc.forms["shippingcalcbox"].action;url+="?EmitBuyerShippingCalculator&itemId="+iid+"&destinationZipCode="+zip+"&TransactionId="+tid;ebayShowPopupWindow(url,"",800,620,0,0,1,1,0);return false;}}
function popupWindow(u,n,w,h,sc,r,le,top,props)
{le=le?le:(screen.width)?(screen.width-w)/2:0;top=top?top:(screen.height)?(screen.height-h)/2:0;ebayShowPopupWindow(u,n,w,h,0,0,0,sc.has('no')?0:1,r.has('no')?0:1,0,le,top,props);}
function popup(url)
{var w=400,h=400;ebayShowPopupWindow(url,"",w,h,0,0,0,1,0,0,(screen.width)?(screen.width-w)/2:1,(screen.height)?(screen.height-h)/2:0);}

//4@@m8

function EBayClient()
{var agt=navigator.userAgent.toLowerCase();this.major=parseInt(navigator.appVersion);this.webTV=this.opera=this.nav=this.ie=this.safari=false;var vInd=0;if(agt.indexOf("webtv")!=-1)
{this.webTV=true;vInd=agt.indexOf("webtv/")+6;}
else if(agt.indexOf("safari")!=-1)
{this.safari=true;vInd=agt.lastIndexOf("safari")+7;}
else if(agt.indexOf("opera")!=-1)
{this.opera=true;vInd=agt.lastIndexOf("opera")+6;}
else if(agt.indexOf("firefox")!=-1)
{this.firefox=true;vInd=agt.indexOf("firefox")+7;}
else if(navigator.appName.toLowerCase()=="netscape")
{this.nav=true;vInd=agt.lastIndexOf("/")+1;var tmp=parseInt(agt.substring(vInd));if(isNaN(tmp))
vInd=agt.lastIndexOf("netscape")+9;}
else if(agt.indexOf("msie")!=-1)
{this.ie=true;vInd=agt.indexOf("msie")+4;}
this.version=parseInt(agt.substring(vInd));this.win=(agt.indexOf("win")!=-1);this.mac=(agt.indexOf("mac")!=-1);this.macppc=(this.mac&&((agt.indexOf("ppc")!=-1)||(agt.indexOf("powerpc")!=-1)));this.isAXLoaded=EbayDetectActX;this.isAXSupported=EbaySupportActX;this.msnTv=(agt.indexOf("msntv")!=-1);this.xpSp2=(agt.indexOf("sv1")!=-1&&!this.msnTv);this.xp=(this.win&&agt.indexOf("windows nt 5.1")!=-1&&!this.msnTv);}
if(typeof(client)=="undefined")
var client=new EBayClient();if(typeof(is)=="undefined")
var is=new EBayClient();function EbaySupportActX()
{return this.isAXLoaded("Scripting.Dictionary");}
function EbayDetectActX(pActXName)
{if(!client.ie)
return false;var h='<scr'+'ipt language="JavaScript" type="text/JavaScript">';h+='var aX;';h+='</scr'+'ipt>';document.writeln(h+'<scr'+'ipt language="vbscript" type="text/vbscript">');document.writeln('on error resume next');document.writeln('aX = IsObject(CreateObject("'+pActXName+'"))');document.writeln('</scr'+'ipt>');if(typeof(aX)=="undefined"||!aX)
return false;else
return true;}

//5@@m4

function EbayPopupWindow(pEbayDoc,pParent,pName)
{if(!this.objType)
this.objType="EbayPopupWindow";this.baseObject=EbayControl;this.baseObject(pEbayDoc,pParent,pEbayDoc.htmlDoc,pName);this.url="";this.width=null;this.height=null;this.left=null;this.top=null;this.toolbar=true;this.location=true;this.status=true;this.scrollbars=true;this.resizable=true;this.menubar=true;this.props="";this.customProps="";this.winObj=null;this.show=ebayShowPopup;this.showEx=ebayShowPopupEx;this.resizeParent=EbayPopupResizeParent;}
window.EbayPopupWindow=EbayPopupWindow;function ebayShowPopup()
{if(this.url.length==0)
return null;var sP="";if(this.width!=null)sP+=",width="+this.width;if(this.height!=null)sP+=",height="+this.height;if(this.left!=null)sP+=",screenX="+this.left+",left="+this.left;if(this.top!=null)sP+=",screenY="+this.top+",top="+this.top;sP+=",toolbar="+((this.toolbar)?"1":"0");sP+=",location="+((this.location)?"1":"0");sP+=",status="+((this.status)?"1":"0");sP+=",scrollbars="+((this.scrollbars)?"1":"0");sP+=",resizable="+((this.resizable)?"1":"0");sP+=",menubar="+((this.menubar)?"1":"0");if(this.customProps.length>0)
sP+=","+this.customProps;if(sP.length>0)sP=sP.substring(1);this.props=sP;var w=window.open(this.url,this.name,sP);if(w)
w.focus();this.winObj=w;return w;}
function ebayShowPopupEx(width,height,left,top,toolbar,location,status,scrollbars,resizable,menubar,customprops,url)
{if(url)
this.url=url;this.width=width;this.height=height;this.left=left;this.top=top;this.toolbar=toolbar;this.location=location;this.status=status;this.scrollbars=scrollbars;this.resizable=resizable;this.menubar=menubar;if(customprops)
this.customProps=customProps;return this.show();}
function EbayPopupResizeParent(pX,pY,pW,pH)
{var p=this.parent;if(p)
{if(!isNaN(pX)&&!isNaN(pY))
p.moveTo(pX,pY);if(!isNaN(pW)&&!isNaN(pH))
p.resizeTo(pW,pH);}}

//6@@m5

function EbayVIPopupSlideShowConfig(pName)
{if(!this.objType)
this.objType="EbayVIPopupSlideShowConfig";this.base=EBayConfig;this.base(pName);this.imageUrls=null;this.startPosition=0;this.superSizeUrl='';this.itemId=0;this.itemTitle='';this.itemIdTxt='';this.maxPicTxt='';this.smallPicTxt='';this.nextPicTxt='';this.prevPicTxt='';this.playPicTxt='';this.stopPicTxt='';this.closeWinTxt='';this.wellWidth=EbayVIPopupSlideShowConfig.SS_WIDTH;this.wellHeight=EbayVIPopupSlideShowConfig.SS_HEIGHT;this.itemUrl='';this.parentConfig=null;this.mode=null;this.caller=null;this.picStatusFmt='';this.getSSWidth=function()
{return screen.width/2+25;}
this.getSSHeight=function()
{return screen.height/2+5;}
this.getSSLeft=function()
{var l=screen.width-this.getSSWidth();if(typeof client!="undefined"&&client.opera)
{if(screen.availWidth!=screen.availHeight)
{l-=90;}}
return l;}
this.getSSTop=function()
{var t=screen.availHeight-this.getSSHeight()-5;if(typeof client!="undefined"&&client.opera)
{if(screen.height-screen.availHeight)
{t-=150;}}
return t;}
this.getFSSWidth=function()
{return EbayVIPopupSlideShowConfig.FSS_WIDTH+35;}
this.getFSSHeight=function()
{return screen.height-10;}
this.getFSSLeft=function()
{var l=screen.width-this.getFSSWidth();if(typeof client!="undefined"&&client.opera&&screen.width!=screen.availWidth)
{l-=108;}
return l;}
this.getFSSTop=function()
{var t=screen.height-this.getFSSHeight()-5;if(typeof client!="undefined"&&client.opera&&screen.height!=screen.availHeight)
{t-=100;}
return t;}
this.copyImageUrls=function(o_urls)
{if(o_urls!=null)
{var n_urls=new Array();for(var i=0;i<o_urls.length;++i)
{var arr=new Array();n_urls[n_urls.length]=arr;for(var j=0;j<o_urls[i].length;j++)
{arr[arr.length]=new String(o_urls[i][j]);}}
this.imageUrls=n_urls;}}}
EbayVIPopupSlideShowConfig.SS_WIDTH=500;EbayVIPopupSlideShowConfig.SS_HEIGHT=500;EbayVIPopupSlideShowConfig.FSS_WIDTH=800;EbayVIPopupSlideShowConfig.FSS_HEIGHT=800;EbayVIPopupSlideShowConfig.MODES={NORMAL:"normal",SLIDESHOW:"slideshow"};EbayVIPopupSlideShowConfig.CALLERS={VIEW_ITEM:"viewitem",PREVIEW_ITEM:"previewitem"};EbayVIPopupSlideShowConfig.queryRe=new RegExp("^.*\\?(.+)$");EbayVIPopupSlideShowConfig.pairsRe=new RegExp("([^=]+)=\\'?([^\\&\\']*)\\'?\\&?");EbayVIPopupSlideShowConfig.numberRe=new RegExp("^\\-?\\d+$");EbayVIPopupSlideShowConfig.parseQueryString=function(queryString)
{var queryObject=new Object();queryString=queryString.replace(EbayVIPopupSlideShowConfig.queryRe,'$1');while((pair=queryString.match(EbayVIPopupSlideShowConfig.pairsRe))&&pair[0].length)
{queryString=queryString.substring(pair[0].length);if(EbayVIPopupSlideShowConfig.numberRe.test(pair[2]))pair[2]=parseInt(pair[2]);queryObject[pair[1]]=pair[2];}
return queryObject;}

//7@@m7

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

//8@@m1

function EbayHTMLImageScalable(pParent,pName,pDisabled,pSource,pDisabledSource,pCfg)
{if(!this.objType)
this.objType="EbayHTMLImageScalable";this.base=EbayHTMLImage;this.base(pParent,pName,pDisabled,pSource,pDisabledSource,pCfg);this.sSrc='';this.sText='';this.iWidth=null;this.iHeight=null;this.bDisableUpscale=false;if(pCfg)
{this.iWidth=pCfg.iWidth;this.iHeight=pCfg.iHeight;if(pCfg.bNoUpscale)
this.bDisableUpscale=true;}
this.oImage=null;this.iOriginalWidth=this.iOriginalHeight=0;if(this.oGlobals.oClient.bMac&&this.oGlobals.oClient.bIE)
this.oMacIECompatibilityImage=new EbayHTMLImage(this,pCfg.sMacIEImage);this.init=ebHTMLImageScalableInit;this.sourceBase=this.source;this.source=ebHTMLImageScalableSource;this.onSetSource=ebHTMLImageScalableOnSetSource;this.absTop=ebHTMLImageScalableAbsTop;this.absLeft=ebHTMLImageScalableAbsLeft;this.getPosition=ebHTMLImageScalableGetPosition;this.onAfterImageLoad=ebHTMLImageScalableOnAfterImageLoad;this.setOriginalDimensions=ebHTMLImageScalableSetOriginalDimensions;this.baseBind=this.bind;this.onBeforeUnload=ebHTMLImageScalableOnBeforeUnload;this.onImageLoadError=ebHTMLImageScalableOnImageLoadError;this.getScaleDimensions=ebHTMLImageScalableGetScaleDimensions;this._registerEvent("setSource","onSetSource");this._registerEvent("imageLoaded","onAfterImageLoad");this._registerEvent("imageLoadError","onImageLoadError");this._registerEvent("bind","ebHTMLImageScalableBind");this._registerEvent("scale","ebHTMLImageScalableScale");this._registerListener(this._getEvent("bind"),this.EVENT_AFTER,"init");this._registerListener(this.oDocument._getEvent("unload"),this.EVENT_BEFORE,"onBeforeUnload");}
function ebHTMLImageScalableInit()
{with(this)
{if(!iWidth&&this.eElem.width)
iWidth=this.eElem.width;if(!iHeight&&this.eElem.height)
iHeight=this.eElem.height;}}
function ebHTMLImageScalableSource(pSrc,pText)
{this._exec("setSource",pSrc,pText);}
function ebHTMLImageScalableOnSetSource(pEvent,pSrc,pText)
{with(this)
{sSrc=pSrc;sText=pText;oImage=new Image();oImage.parent=this;eval('oImage.onload = function(){ebay.oDocument.oPage._getControl("'+this.name+'")._exec("imageLoaded")};');eval('oImage.onerror = function(){ebay.oDocument.oPage._getControl("'+this.name+'")._exec("imageLoadError")};');oImage.src=sSrc;}}
function ebHTMLImageScalableScale(pEvent,pWidth,pHeight)
{with(this)
{var a=getScaleDimensions(pWidth,pHeight);eElem.width=a[0];eElem.height=a[1];}}
function ebHTMLImageScalableGetScaleDimensions(pWidth,pHeight)
{with(this)
{var a=[];if(!pWidth)
pWidth=iWidth;if(!pHeight)
pHeight=iHeight;var imgW=iOriginalWidth,imgH=iOriginalHeight;var rw=pWidth/imgW,rh=pHeight/imgH,ratio=(rw>rh)?rh:rw;if(bDisableUpscale&&ratio>1)
ratio=1;a[0]=imgW*ratio;a[1]=imgH*ratio;return a;}}
function ebHTMLImageScalableSetOriginalDimensions()
{with(this)
{var w,h;if(oImage)
{var oClient=oGlobals.oClient;if(oClient.bIE&&oClient.bMac)
{oMacIECompatibilityImage.source(sSrc);w=oMacIECompatibilityImage.eElem.width;h=oMacIECompatibilityImage.eElem.height;}
else
{w=oImage.width;h=oImage.height;}
iOriginalWidth=w;iOriginalHeight=h;}}}
function ebHTMLImageScalableOnAfterImageLoad()
{with(this)
{setOriginalDimensions();_exec("scale");sourceBase(sSrc,sText);}}
function ebHTMLImageScalableGetPosition(pName)
{var e=this.eElem;if(e)
{var offset=0,o=e;while(o.offsetParent)
{offset+=eval('o.offset'+pName);o=o.offsetParent;}
return offset;}}
function ebHTMLImageScalableAbsTop()
{return this.getPosition('Top');}
function ebHTMLImageScalableAbsLeft()
{return this.getPosition('Left');}
function ebHTMLImageScalableBind()
{this.baseBind();if(this.oGlobals.oClient.bMac&&this.oGlobals.oClient.bIE)
this.oMacIECompatibilityImage.bind();}
function ebHTMLImageScalableOnBeforeUnload()
{this.oImage=null;}
function ebHTMLImageScalableOnImageLoadError()
{with(this)
sourceBase(oImage.src,sText);}

//9@@m2

function EbayHTMLSlideshowConfig(pName)
{if(!this.objType)
this.objType="EbayHTMLSlideshowConfig";this.base=EbayConfig;this.base(pName);this.sSource=null;this.sDisabledSource=null;this.iWidth=null;this.iHeight=null;this.sImgName='';this.sMacIEImage='';this.bPreload=true;this.sBackImgName;this.sNextImgName;this.sPlayImgName;this.sStopImgName;this.sDisabledPlayImgSrc;this.sEnabledStopImgSrc;this.iInterval=2000;this.aImageUrls=[];this.sStatusDivId=null;this.sImgCountDivId=null;this.sImgCountToken;this.sImgCountTxt;}
function EbayHTMLSlideshow(pParent,pName,pDisabled,pCfg)
{if(!this.objType)
this.objType="EbayHTMLSlideshow";this.base=EbayBaseControl;this.base(pParent,pName);this.oConfig=pCfg;this.oImage=new EbayHTMLImageScalable(this,pCfg.sImgName,pDisabled,pCfg.sSource,pCfg.sDisabledSource,pCfg);this.iCurrentIdx=-1;this.oPlayBtn=new EbayHTMLImage(this,pCfg.sPlayImgName,false,pCfg.sDisabledPlayImgSrc);this.oStopBtn=new EbayHTMLImage(this,pCfg.sStopImgName,true);this.oBackBtn=new EbayHTMLImage(this,pCfg.sBackImgName);this.oNextBtn=new EbayHTMLImage(this,pCfg.sNextImgName);this.iInterval=pCfg.iInterval;this.oTimerId=null;this.aImageUrls=pCfg.aImageUrls;this.oStatusLyr=null;if(pCfg.sStatusDivId)
this.oStatusLyr=new EbayHTMLLayer(this,pCfg.sStatusDivId);this.oImgCountLyr=null;if(pCfg.sImgCountDivId)
{this.oImgCountLyr=new EbayHTMLLayer(this,pCfg.sImgCountDivId);this.sImgCountToken=pCfg.sImgCountToken;this.sImgCountTxt=pCfg.sImgCountTxt;}
this.play=ebHTMLSlideshowPlay;this.back=ebHTMLSlideshowBack;this.next=ebHTMLSlideshowNext;this.stop=ebHTMLSlideshowStop;this.preload=ebHTMLSlideshowPreload;this.init=ebHTMLSlideshowInit;this.updateCount=ebHTMLSlideshowUpdateCount;this.displaySlide=ebHTMLSlideshowDisplaySlide;this.onBeforeImageLoad=ebHTMLSlideshowOnBeforeImageLoad;this.onAfterImageLoad=ebHTMLSlideshowOnAfterImageLoad;this.bindChildren=ebHTMLSlideshowBindChildren;this.bInitialized=false;with(this)
{oPlayBtn._registerEvent('onclick','parent.play');oStopBtn._registerEvent('onclick','parent.stop');oBackBtn._registerEvent('onclick','parent.back');oNextBtn._registerEvent('onclick','parent.next');_registerEvent('onDisplay','displaySlide');if(oStatusLyr)
{_registerListener(oImage._getEvent('setSource'),EVENT_BEFORE,'onBeforeImageLoad');_registerListener(oImage._getEvent('imageLoaded'),EVENT_AFTER,'onAfterImageLoad');}}
this._registerListener(this.oDocument._getEvent('load'),this.EVENT_AFTER,'init');}
function ebHTMLSlideshowInit()
{with(this)
{if(bInitialized)
return;oPlayBtn.sEnabledSource=oPlayBtn.source();oStopBtn.sDisabledSource=oStopBtn.source();oStopBtn.sEnabledSource=oConfig.sEnabledStopImgSrc;if(oStatusLyr)
{with(oStatusLyr)
{top(oImage.absTop());left(oImage.absLeft());width(oImage.iWidth);height(oImage.iHeight);setStyle('zIndex','100');}}
if(oConfig.bPreload)
preload();bInitialized=true;}}
function ebHTMLSlideshowPlay()
{var scope=(this.objType=='EbayHTMLSlideshow')?this:this.parent;with(scope)
{oPlayBtn.enable(false);oStopBtn.enable(true);oTimerId=setInterval('ebay.oDocument.oPage._getControl("'+name+'").next()',iInterval);}}
function ebHTMLSlideshowBack()
{var scope=(this.objType=='EbayHTMLSlideshow')?this:this.parent;with(scope)
{var idx=iCurrentIdx-1;if(idx<0)
idx=aImageUrls.length-1;_exec('onDisplay',idx);updateCount();}}
function ebHTMLSlideshowNext()
{var scope=(this.objType=='EbayHTMLSlideshow')?this:this.parent;with(scope)
{var idx=iCurrentIdx+1;if(idx>=aImageUrls.length)
idx=0;_exec('onDisplay',idx);updateCount();}}
function ebHTMLSlideshowStop()
{var scope=(this.objType=='EbayHTMLSlideshow')?this:this.parent;with(scope)
{oPlayBtn.enable(true);oStopBtn.enable(false);clearInterval(oTimerId);}}
function ebHTMLSlideshowPreload()
{var i=0,a=this.aImageUrls,len=a.length;for(;i<len;i++)
{var img=new Image();img.src=a[i];img=null;}}
function ebHTMLSlideshowUpdateCount(pIdx)
{with(this)
{if(oImgCountLyr)
{var regex=new RegExp(sImgCountToken),s=sImgCountTxt.replace(regex,iCurrentIdx+1);if(oConfig.sImgCountTotalToken)
{regex=new RegExp(oConfig.sImgCountTotalToken);s=s.replace(regex,oConfig.iImgCountTotal);}
oImgCountLyr.setValue(s);}}}
function ebHTMLSlideshowDisplaySlide(pEvent,pIdx)
{with(this)
{iCurrentIdx=isNaN(pIdx)?iCurrentIdx:pIdx;oImage.source(aImageUrls[iCurrentIdx]);}}
function ebHTMLSlideshowOnBeforeImageLoad(){this.oStatusLyr.show(true);}
function ebHTMLSlideshowOnAfterImageLoad(){this.oStatusLyr.show(false);}
function ebHTMLSlideshowBindChildren()
{for(var sName in this.controls)
this.controls[sName].bind();}

//10@@e1

function EbayBackToList(pParent,pName,pCfg)
{if(!this.objType)
this.objType="EbayBackToList";this.base=EbayHTML;this.base(pParent,pName,false,pCfg);this.c=pCfg;this.init=function()
{with(this)
{for(var a=0,alen=c.aSearchLinkId.length;a<alen;a++)
{oSearchLink=new EbayHTMLAnchor(this,c.aSearchLinkId[a]);if(!oSearchLink.eElem)
oSearchLink.bind();oSearchLink._registerEvent("onclick","parent.BacktoList");}}}
this.BacktoList=function()
{c=this.parent.c;if(c.bWiredOn)
{if((new Date()).getTime()<c.sTimeOut)
this.eElem.href="javascript:history.go(-1);";}}
this.init();}
// b=7236837 -->