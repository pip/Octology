//<!--
//1@@m4

var ss_Error;ebay.oDocument._getControl("siteCatalyst").propertyReportsError=function(obj)
{if(typeof(obj)=="object"){obj.prop22+=";"+obj.ssError;}
else{s_prop22+=";"+ss_Error;}}
ebay.oDocument._getControl("siteCatalyst").registerFunction("propertyReportsError");

//2@@m2

var ss_RegWidget;ebay.oDocument._getControl("siteCatalyst").propertyReportsPaypalRegistration=function(obj)
{if(typeof(obj)=="object"){obj.prop26=obj.prop26+=";"+ss_RegWidget;}
else{s_prop26+=";"+ss_RegWidget;}}
ebay.oDocument._getControl("siteCatalyst").registerFunction("propertyReportsPaypalRegistration");

//3@@m4

var prop25;ebay.oDocument._getControl("siteCatalyst").cookiesWriteHomepage=function(obj)
{if(typeof(obj)=="object"){obj.eVar11=obj.prop25;this.writeCookie("homepage",obj.prop25);}
else{s_eVar11=prop25;this.writeCookie("homepage",prop25);}}
ebay.oDocument._getControl("siteCatalyst").registerFunction("cookiesWriteHomepage");

//4@@m4

var prop25;ebay.oDocument._getControl("siteCatalyst").propertyReportsHomepage=function(obj)
{if(typeof(obj)=="object"){obj.prop25=obj.pageName+";"+obj.prop25;}
else{s_prop25=this.sPageName+";"+prop25;}}
ebay.oDocument._getControl("siteCatalyst").registerFunction("propertyReportsHomepage");

//5@@m4

ebay.oDocument._getControl("siteCatalyst").cookiesReadHomepage=function()
{var v=this.readCookie("homepage");if(v!=""){if(typeof(obj)=="object"){obj.prop25=obj.pageName+";"+v;}
else{s_prop25=this.sPageName+";"+v;}}}
ebay.oDocument._getControl("siteCatalyst").registerFunction("cookiesReadHomepage");ebay.oDocument._getControl("siteCatalyst").addCookieName("homepage",true);

//6@@m8

ebay.oDocument._getControl("siteCatalyst").attachFunctionality=function()
{this.biboCreateArray=function()
{with(this)
{var c1=readCookieletEx("reg","bibo");var c2=readCookieletEx("reg","segF");if(c1=="")c1=" ### ### # #";if(c2=="")c2="B0#S0";var ba=aBibo=c1.split("#");aSegF=c2.split("#");if(!ba[2]||(ba[2]==""))ba[2]="3";if(!ba[5]||(ba[5]==""))ba[5]="3";if(readCookieEx("reg")!="")
biboSetNewSegment(biboSetFlag(ba[0]),biboSetFlag(ba[3]));}}
this.registerFunction("biboCreateArray");this.biboSetFlag=function(pVal)
{var f=parseInt(pVal.substring(1));return(((f>=2)&&(f<5))||((f>=11)&&(f<14))||((f>=20)&&(f<23)));}
this.biboGetRecency=function(pID)
{var rv="91";if(this.aBibo!="")
{var d=new Date();var dArr=this.aBibo[pID].split("/");d.setDate(dArr[1]);d.setMonth(dArr[0]-1);d.setYear(dArr[2]);rv=(new Date()-d)/86400000;}
return rv;}
this.biboDetermineNewSegment=function(pSeg,pID)
{var rv=parseInt(pSeg.substring(1));var rc=this.biboGetRecency(pID);if(isNaN(rc)||isNaN(rv))
rv="0";else if(rv==0)
{rv="52";if(rc<30)rv="2";else if(rc>=30&&rc<60)rv="5";else if(rc>=60&&rc<90)rv="8";}
else if(rv<52)
{if(rc>=30&&rc<60)rv+=3;else if(rc>=60&&rc<90)rv+=6;else if(rc>=90)rv+=50;}
return rv;}
this.biboWMC=function(pVal,pStr)
{writeCookieletEx("reg",pVal,pStr.toString().replace(/,/gi,"#"));}
this.biboSetNewSegment=function(pFlag1,pFlag2)
{with(this)
{var sa=aSegF,ba=aBibo;if(readCookieletEx("reg","segF")=="")
{sa[0]=ba[0]=ba[6]="B0";sa[1]=ba[3]=ba[7]="S0";}
else
{if(pFlag1)sa[0]=ba[0];if(pFlag2)sa[1]=ba[3];ba[0]=ba[6]="B"+biboDetermineNewSegment(sa[0],1);ba[3]=ba[7]="S"+biboDetermineNewSegment(sa[1],4);}
biboWMC("segF",sa);biboWMC("bibo",ba);}}
this.buyerOrSeller=function()
{var s=this.sSample,x=s.substring(0,s.length-2),rv="S";if((parseFloat(x/2)+'').indexOf(".")==-1)rv="B";return rv;}
this.biboSetProp21=function(obj)
{with(this)
{var v=aBibo[7];if(sUser.is("Nonreg"))v=sUser;else if(buyerOrSeller()=="B")v=aBibo[6];if(typeof(obj)=="object"){obj.prop21=obj.pageName+";"+v;}
else{s_prop21=sPageName+";"+v;}}}
this.registerFunction("biboSetProp21");this.addCookieName("reg");}
ebay.oDocument._getControl("siteCatalyst")._exec("attachFunctionality");

//7@@m3

ebay.oDocument._getControl("siteCatalyst").propertyReportsCommonGetSSPagename=function()
{var tp=this.sPage,ind=tp.indexOf("sspagename"),rv='';if(ind!=-1)
{var str=tp.substring(ind+11),end=str.indexOf('&');if(end==-1)
end=str.length;rv=str.substring(0,end).toUpperCase();}
return rv;}

//8@@m4

ebay.oDocument._getControl("siteCatalyst").propertyReportsSSPagename=function(obj)
{if(typeof(obj)!="object"){s_prop18=this.sPageName+";"+
this.propertyReportsCommonGetSSPagename();}}
ebay.oDocument._getControl("siteCatalyst").registerFunction("propertyReportsSSPagename");
// b=7298324 -->