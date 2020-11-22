//<!--
//1@@m4

ebay.oDocument._getControl("siteCatalyst").cookiesLastListGetChannel=function()
{var sc=ebay.oDocument._getControlEx("cobrandCollection").oSelCobrand;return sc?sc.sCBName+" at ebay":"ebay";}
ebay.oDocument._getControl("siteCatalyst").cookiesLastListWrite=function()
{var val;with(this)
{val=cookiesLastListGetChannel()+":"+s_prop18;writeCookie("lastList",val);}
s_eVar19=this.sCountry+val;}
ebay.oDocument._getControl("siteCatalyst").registerFunction("cookiesLastListWrite");
// b=7298324 -->