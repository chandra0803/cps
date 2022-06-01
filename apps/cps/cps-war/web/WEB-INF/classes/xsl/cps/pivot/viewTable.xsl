<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.10 $

$Log: viewTable.xsl,v $
Revision 1.10  2004/10/28 15:40:42  zz0qx3
updates

Revision 1.9  2004/10/19 13:39:15  zz0qx3
updates post review

Revision 1.8  2004/10/13 20:25:16  zz0qx3
chpt

Revision 1.7  2004/10/12 20:28:36  zz0qx3
create automation

Revision 1.6  2004/10/11 17:15:35  zz0qx3
chpr

Revision 1.4  2004/10/08 18:51:59  zz0qx3
chpt without grid code

Revision 1.3  2004/10/07 15:24:00  zz0qx3
CHPT including grid sample (initial)

Revision 1.2  2004/10/06 18:15:02  zz0qx3
checkpt

Revision 1.1  2004/10/06 14:04:54  zz0qx3
Path corrections

Revision 1.2  2004/10/05 18:30:25  zz0qx3
export file prototype

Revision 1.1  2004/09/24 17:04:42  vz86k2
check in

Revision 1.1  2004/07/23 19:17:41  vz86k2
check in


-->

<xsl:variable name="javaScriptBaseUrl" select="Screen/Model/Entity/JavaScriptBaseUrl"/>
<xsl:variable name="htmlBaseUrl" select="Screen/Model/Entity/HtmlBaseUrl"/>


<xsl:template name="LocalScript">
  <script type="text/javascript" language="javascript">

    function pageLoaded()
    {
      document.all['netChange'].disabled  = true;

      document.all['editDiv'].style.posLeft  = 600;
      document.all['editDiv'].style.posTop = 250;

      document.all['percentDiv'].style.posLeft  = 550;
      document.all['percentDiv'].style.posTop = 300;

    }

    function showEditDiv(currentVal, cellName)
    {
      document.getElementById('valueEditField').value = currentVal
      document.all['editDiv'].style.visibility  = 'visible';
    }
    function hideEditDiv()
    {
      document.all['editDiv'].style.visibility  = 'hidden';
    }

    function showPercentDiv()
    {
      document.all['percentDiv'].style.visibility  = 'visible';
    }
    function hidePercentDiv()
    {
      document.all['percentDiv'].style.visibility  = 'hidden';
    }


  </script>


</xsl:template>

<xsl:template match="View">
  <xsl:param name="imgBaseUrl" select="''"/>

  <TABLE id="Table1" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px">&#160;</TD>
      </TR>
    </thead>

     <tbody>
      <TR> 
	<TD  style="HEIGHT: 27px" vAlign="top" align="left">
  <a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;SAVE&#160;</font></a>&#160;&#160;&#160;
  <a class="button" href="javascript:showPercentDiv()"><font class="v8w">&#160;%&#160;</font></a>&#160;
  <a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;NUMERIC&#160;</font></a>&#160;&#160;&#160;
  <a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;-&#160;0.0&#160;</font></a>&#160;
  <a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;+&#160;0.0&#160;</font></a>&#160;&#160;&#160;
  <a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;APPLY&#160;</font></a>&#160;
  <a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;DISCARD&#160;</font></a>&#160;&#160;&#160;&#160;&#160;&#160;
  Net Change: <input type="text" name="netChange" value="0" length="5" onfocus="blur();"/>
  </TD>
      </TR>
    </tbody>
  </TABLE>

<span id="editDiv" class="absoluteHidden">
<form id="editDivForm" name="editDivForm" action="/" method="post">
<table cellspacing="1" callpadding="1" border="1" style="background-color: #99CCCC; width:150px; height:75px; align: center;">
<tr>
  <td class="TableHeader"><i>Edit Cell Value</i></td>
</tr>
<tr>
  <td><center>
    <input type="text" name="valueEditField" value="123" length="25"/><br/>&#160;<br/>
<a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;APPLY&#160;</font></a>&#160;&#160;
<a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;CANCEL&#160;</font></a>
  </center></td>
</tr>
</table>
    </form>
</span>

<span id="percentDiv" class="absoluteHidden">
<form id="percentDivForm" name="percentDivForm" action="/" method="post">
<table cellspacing="1" callpadding="1" border="1" style="background-color: #99CCCC; width:150px; height:75px; align: center;">
<tr>
  <td class="TableHeader" colspan="6"><i>Select 100% Level</i></td>
</tr>
<tr>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">modrn</td>
  <td class="TableHeader">Totalmodrn</td>
</tr>
<tr>
  <td class="TableHeader">cva</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
</tr>
<tr>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">vehppcode</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
</tr>
<tr>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">brand</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
</tr>
<tr>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">engnm</td>
  <td class="TableHeader">&#160;</td>
  <td  class="WhiteRow" >&#160;</td>
</tr>
<tr>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">Totalengnm</td>
  <td  class="WhiteRow">&#160;</td>
  <td  class="WhiteRow">&#160;</td>
</tr>
<tr>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">Totalbrand</td>
  <td class="TableHeader">&#160;</td>
  <td  class="WhiteRow">&#160;</td>
  <td  class="WhiteRow">&#160;</td>
</tr>
<tr>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">Totalvehppcode</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td  class="WhiteRow">&#160;</td>
  <td  class="WhiteRow">&#160;</td>
</tr>
<tr>
  <td class="TableHeader">Totalcva</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td class="TableHeader">&#160;</td>
  <td  class="WhiteRow">&#160;</td>
  <td  class="WhiteRow">&#160;</td>
</tr>
<tr>
  <td class="TableHeader" colspan="6"><a class="button" href="javascript:hidePercentDiv()"><font class="v8w">&#160;APPLY&#160;</font></a>&#160;
  <a class="button" href="javascript:hidePercentDiv()"><font class="v8w">&#160;CANCEL&#160;</font></a></td>
</tr>
</table>
    </form>
</span>


  <table  style="background-color: #99CCCC; width:1062px; height:500px" border="0" cellpadding="0" cellspacing="0">
    <tr style="width: 1062px; height: 500px;">
      <TD style="width: 1062px; height: 500px;">

          <div id="columnHeaders" style="VERTICAL-ALIGN: bottom; OVERFLOW-Y: hidden; OVERFLOW: hidden; width:1045px; height:25px">
            <table id="grid" style="VERTICAL-ALIGN: bottom;" width="100%" border="1" cellpadding="0" cellspacing="0">
            
            <tr style="height: 25px;">
            <!-- top left empty squares -->
            <TD  class="TableHeader" style="width: 65px;">&#160;&#160;&#160;</TD>
            <TD  class="TableHeader" style="width: 65px;">&#160;&#160;&#160;</TD>
            <TD  class="TableHeader" style="width: 105px;">&#160;&#160;&#160;</TD>
            <TD  class="TableHeader" style="width: 30px;">&#160;&#160;&#160;</TD>
<TD   style="width: 65px;" class="TableHeader" >2003</TD>
<TD   style="width: 65px;" class="TableHeader" >2004</TD>
<TD   style="width: 65px;" class="TableHeader" >2005</TD>
<TD   style="width: 65px;" class="TableHeader" >2006</TD>
<TD   style="width: 65px;" class="TableHeader" >2007</TD>
<TD   style="width: 65px;" class="TableHeader" >2008</TD>
<TD   style="width: 65px;" class="TableHeader" >2009</TD>
<TD   style="width: 65px;" class="TableHeader" >2010</TD>
<TD   style="width: 65px;" class="TableHeader" >2011</TD>
<TD   style="width: 65px;" class="TableHeader" >2012</TD>
<TD   style="width: 65px;" class="TableHeader" >2013</TD>
<TD   style="width: 65px;" class="TableHeader" >2014</TD>

            </tr>
            </table>
          </div>

          <div id="chart" style="background-color: #ffffff; OVERFLOW-X: hidden; OVERFLOW: scroll; width:1062px; height:500px">
            <table id="grid"  width="100%" border="1" cellpadding="0" cellspacing="0">

    <tr width="1062px">
      <TD  ondblclick="javascript:showEditDiv('UNITED STATES', 'Y');"   style="width: 65px;"   class="TableHeader" >UNITED STATES</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 105px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 30px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
    </tr>

    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   ondblclick="javascript:showEditDiv('GMT-360', 'Y');"  style="width: 65px;"   class="TableHeader" >GMT-360</TD>
      <TD   style="width: 105px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 30px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
    </tr>
    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   ondblclick="javascript:showEditDiv('ENVOY', 'Y');"  style="width: 105px;"   class="TableHeader" >ENVOY</TD>
      <TD   style="width: 30px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
    </tr>


    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader">&#160;</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 105px;"   class="TableHeader" >&#160;</TD>
      <TD    ondblclick="javascript:showEditDiv('LL8', 'Y');"   style="width: 30px;"   class="TableHeader" >LL8</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >150351</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >977719</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >44724</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('40158', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
    </tr>

    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   ondblclick="javascript:showEditDiv('TRAILBLAZER', 'Y');"  style="width: 105px;"   class="TableHeader" >TRAILBLAZER</TD>
      <TD   style="width: 30px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
    </tr>


    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader">&#160;</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 105px;"   class="TableHeader" >&#160;</TD>
      <TD   ondblclick="javascript:showEditDiv('LL8', 'Y');"  style="width: 30px;"   class="TableHeader" >LL8</TD>
      <TD  ondblclick="javascript:showEditDiv('150351', 'Y');"  class="WhiteRow" style="width: 65px;" >150351</TD>
      <TD  ondblclick="javascript:showEditDiv('977719', 'Y');"  class="WhiteRow" style="width: 65px;" >977719</TD>
      <TD  ondblclick="javascript:showEditDiv('44724', 'Y');"  class="WhiteRow" style="width: 65px;" >44724</TD>
      <TD  ondblclick="javascript:showEditDiv('44739', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('44739', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
    </tr>
    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 105px;"   class="BoldTableHeader" >Total</TD>
      <TD   style="width: 30px;"   class="TableHeader" >&#160;</TD>
     <TD  ondblclick="javascript:showEditDiv('150351', 'Y');"  class="WhiteRow" style="width: 65px;" >150351</TD>
      <TD  ondblclick="javascript:showEditDiv('977719', 'Y');"  class="WhiteRow" style="width: 65px;" >977719</TD>
      <TD  ondblclick="javascript:showEditDiv('44724', 'Y');"  class="WhiteRow" style="width: 65px;" >44724</TD>
      <TD  ondblclick="javascript:showEditDiv('44739', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('44739', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
    </tr>

    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('GMT-361', 'Y');"   style="width: 65px;"   class="TableHeader" >GMT-361</TD>
      <TD   style="width: 105px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 30px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
    </tr>
    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   ondblclick="javascript:showEditDiv('ENVOY', 'Y');"  style="width: 105px;"   class="TableHeader" >ENVOY</TD>
      <TD   style="width: 30px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
    </tr>


    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader">&#160;</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 105px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('LL8', 'Y');"   style="width: 30px;"   class="TableHeader" >LL8</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('44739', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('44739', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('44739', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('44739', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('44739', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('44739', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
      <TD  ondblclick="javascript:showEditDiv('44739', 'Y');"  class="WhiteRow" style="width: 65px;" >44739</TD>
    </tr>

    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('TRAILBLAZER', 'Y');"   style="width: 105px;"   class="TableHeader" >TRAILBLAZER</TD>
      <TD   style="width: 30px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
    </tr>


    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader">&#160;</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 105px;"   class="TableHeader" >&#160;</TD>
      <TD     ondblclick="javascript:showEditDiv('LL8', 'Y');"  style="width: 30px;"   class="TableHeader" >LL8</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('103747', 'Y');"  class="WhiteRow" style="width: 65px;" >103747</TD>
      <TD  ondblclick="javascript:showEditDiv('103747', 'Y');"  class="WhiteRow" style="width: 65px;" >103747</TD>
      <TD  ondblclick="javascript:showEditDiv('103747', 'Y');"  class="WhiteRow" style="width: 65px;" >103747</TD>
      <TD  ondblclick="javascript:showEditDiv('103747', 'Y');"  class="WhiteRow" style="width: 65px;" >103747</TD>
      <TD  ondblclick="javascript:showEditDiv('103747', 'Y');"  class="WhiteRow" style="width: 65px;" >103747</TD>
      <TD  ondblclick="javascript:showEditDiv('103747', 'Y');"  class="WhiteRow" style="width: 65px;" >103747</TD>
      <TD  ondblclick="javascript:showEditDiv('103747', 'Y');"  class="WhiteRow" style="width: 65px;" >103747</TD>
    </tr>
    <tr width="1062px">
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 105px;"   class="BoldTableHeader" >Total</TD>
      <TD   style="width: 30px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('', 'Y');"  class="WhiteRow" style="width: 65px;" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
    </tr>

    <tr width="1062px">
      <TD   style="width: 65px;"   class="BoldTableHeader" >Total</TD>
      <TD   style="width: 65px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 105px;"   class="TableHeader" >&#160;</TD>
      <TD   style="width: 30px;"   class="TableHeader" >&#160;</TD>
      <TD  ondblclick="javascript:showEditDiv('300702', 'Y');"  class="WhiteRow" style="width: 65px;" >300702</TD>
      <TD  ondblclick="javascript:showEditDiv('324963', 'Y');"  class="WhiteRow" style="width: 65px;" >324963</TD>
      <TD  ondblclick="javascript:showEditDiv('148442', 'Y');"  class="WhiteRow" style="width: 65px;" >148442</TD>
      <TD  ondblclick="javascript:showEditDiv('148491', 'Y');"  class="WhiteRow" style="width: 65px;" >148491</TD>
      <TD  ondblclick="javascript:showEditDiv('148491', 'Y');"  class="WhiteRow" style="width: 65px;" >148491</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
      <TD  ondblclick="javascript:showEditDiv('148484', 'Y');"  class="WhiteRow" style="width: 65px;" >148484</TD>
    </tr>


            </table>
          </div>
      </TD>
    </tr>
  </table>



</xsl:template>


<!--
<xsl:call-template name="PivotAttributeSelected">
  <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
  <xsl:with-param name="attributes" select="PivotAttributeResultSet/PivotAttribute[@selected='across']"/>
</xsl:call-template>
-->




</xsl:stylesheet>
