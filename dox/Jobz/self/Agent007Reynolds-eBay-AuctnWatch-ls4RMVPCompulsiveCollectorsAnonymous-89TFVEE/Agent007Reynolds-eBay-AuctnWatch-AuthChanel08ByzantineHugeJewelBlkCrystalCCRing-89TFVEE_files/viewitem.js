//<!--
//1@@m4

var eBayTRItemId;ebay.oDocument._getControl("siteCatalyst").eventsWatchConfirm=function()
{s_events="event6";}
ebay.oDocument._getControl("siteCatalyst").registerFunction("eventsWatchConfirm");

//2@@m3

ebay.oDocument._getControl("siteCatalyst").propertyReportsWatchConfirm=function()
{var cv=this.readCookie("ssSBR");s_prop23=cv.is("")?this.sPageNameCountrySite:cv;s_prop23+=";WAT";}
ebay.oDocument._getControl("siteCatalyst").registerFunction("propertyReportsWatchConfirm");

//3@@m4

ebay.oDocument._getControl("siteCatalyst").cookiesLastListGetChannel=function()
{var sc=ebay.oDocument._getControlEx("cobrandCollection").oSelCobrand;return sc?sc.sCBName+" at ebay":"ebay";}
ebay.oDocument._getControl("siteCatalyst").cookiesLastListWrite=function()
{var val;with(this)
{val=cookiesLastListGetChannel()+":"+s_prop18;writeCookie("lastList",val);}
s_eVar19=this.sCountry+val;}
ebay.oDocument._getControl("siteCatalyst").registerFunction("cookiesLastListWrite");

//4@@m3

ebay.oDocument._getControl("siteCatalyst").pagenamesViewItem=function()
{with(this)
{if(sPage.has("&showtutorial=1"))
pageName="PageViewItemTutorial";if((typeof(itemTimeElasped)!="undefined")&&(itemTimeElapsed=="11"))
pageName+="Ended";}}
ebay.oDocument._getControl("siteCatalyst")._exec("pagenamesViewItem");

//5@@m3

var offerId;ebay.oDocument._getControl("siteCatalyst").propertyReportsViewItem=function()
{var v=this.sPageName+";";s_prop1=s_prop2=s_prop3=s_prop4=s_prop6=s_prop7=s_prop11=s_prop12=s_prop15=s_prop16=v;for(var i=0;i<5;i++)
{eval("s_prop"+(i+1)+"+=category"+i+";");v+="C"+i+eval("category"+i)+";";}
v=v.substring(0,v.length-1);s_prop6+=itemState;v+=";ST"+itemState.charAt(itemState.length-1);s_prop7+=itemPrice;v+=";PR"+itemPrice.substr(5);v+=";FO"+itemFormat.substr(6);s_prop11+=sellerFeedback;v+=";"+sellerFeedback;s_prop12+=offerId;s_prop15+=itemReserve;v+=";RE"+itemReserve.substr(3);s_prop16+=itemCurrency;v+=";CU"+itemCurrency.substr(1);v+=";TR"+itemTimeRemaining.substr(1);v+=";NB"+itemNumBids.substr(4);v+=";FT"+itemFeatured;s_prop5=v;}
ebay.oDocument._getControl("siteCatalyst").registerFunction("propertyReportsViewItem");

//6@@m3

ebay.oDocument._getControl("siteCatalyst").eventsViewItem=function()
{s_events="event7";}
ebay.oDocument._getControl("siteCatalyst").registerFunction("eventsViewItem");

//7@@m3

ebay.oDocument._getControl("siteCatalyst").cookiesSearchListingsViewItemWrite=function()
{var v="",un="undefined";if(typeof(category_level0)!=un)v=category_level0;else if(typeof(category0)!=un)v=category0;s_eVar17=this.sPageName+";"+v;}
ebay.oDocument._getControl("siteCatalyst").registerFunction("cookiesSearchListingsViewItemWrite");
// b=7298324 -->