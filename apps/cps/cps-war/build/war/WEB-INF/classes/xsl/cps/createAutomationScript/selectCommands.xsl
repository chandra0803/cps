<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.3 $
$Log: selectCommands.xsl,v $
Revision 1.3  2004/10/14 21:15:56  zz0qx3
added component groups, other tweaks

Revision 1.2  2004/10/13 14:19:24  zz0qx3
no message

Revision 1.1  2004/10/12 20:28:35  zz0qx3
create automation


-->


<xsl:template name="LocalScript">
  <script type="text/javascript" language="javascript">

    function pageLoaded()
    {
    }

  </script>

</xsl:template>

<xsl:template match="View">
  <xsl:param name="imgBaseUrl" select="''"/>

  <TABLE cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="4">Select File(s)</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	      <TD style="HEIGHT: 27px; WIDTH=30%;" vAlign="top" align="left">
          Add Command:&#160;
          <select name="selectCommand">
          <option>&lt;choose command &gt;</option>
          <option selected="true">Copy File</option>
          <option>Load Allocation</option>
          <option>Load Source</option>
          <option>Choose Attributes</option>
          <option>Execute Allocation</option>
          </select>
        </TD>
	      <TD style="HEIGHT: 27px" vAlign="top" align="left">
          Add Input File:&#160;
          <input type="text" size="20" name="sourceFile"/>
          &#160;
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;SELECT FILE&#160;</font>
          </a>
          &#160;
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;ADD FILE&#160;</font>
          </a>
          <br/>
          As Argument:&#160;<select name="selectCommand">
          <option selected="true">&lt;choose argument&gt;</option>
          <option>Source File</option>
          </select>
        </TD>
	      <TD style="HEIGHT: 27px" vAlign="top" align="left">
          Name Output File:&#160;
          <input type="text" size="20" name="outputFile" value="Tuesday Buick copy"/>
          &#160;
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;ADD COMMAND&#160;</font>
          </a>
        </TD>

      </TR>
<TR>
<TD colspan="3" style="HEIGHT: 27px" vAlign="top" align="left">&#160;</TD>
</TR>

      <TR>
	      <TD style="HEIGHT: 27px" vAlign="top" align="left">&#160;</TD>
        <TD  vAlign="top" align="left">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr> 
<td>
    <table width="100%" border="1" cellspacing="0" cellpadding="3">
    <tr class="TableHeader"> 
    <td class="TableHeader">Argument</td>
    <td class="TableHeader">Name</td>
    <td  class="TableHeader" align="center">Type</td>
    <td class="TableHeader" >Delete</td>
    <td class="TableHeader">Comment</td>
    </tr>
    <tr> 
    <td>Source File</td>
    <td><a href="javascript:alert('show details')">Buick 
    Platform &amp; 
    Eng</a> </td>
    <td align="center" >A</td>
    <td><a href="#" onclick="confirm('Are you sure you want to delete this file?'); return false;"><img src="{$imgBaseUrl}/buttons/delete.gif" border="0"/></a></td>
    <td>Buick 
    Platform &amp; 
    Eng Allocation</td>
    </tr>
    </table>
</td>
</tr>
</table>
        </TD>
	      <TD style="HEIGHT: 27px" vAlign="top" align="left">&#160;</TD>
      </TR>
<TR>
<TD colspan="3" style="HEIGHT: 27px" vAlign="top" align="center"><hr width="80%"/></TD>
</TR>



      <TR>
	      <TD style="HEIGHT: 27px" vAlign="top" align="left">
          Add Condition:&#160;
          <select name="selectCommand">
          <option>&lt;choose command &gt;</option>
          <option selected="true">Stop On Condition</option>
          </select>
          &#160;
        </TD>

	      <TD style="HEIGHT: 27px" vAlign="top" align="left">

        <table border="0" cellpadding="0" cellspacing="0">

        <tr>
        <td align="right">Select Condition File &#160;</td>
        <td align="left"><input type="text" size="20" name="sourceFile"/>&#160;&#160;
          <a class="button" href="javascript:selectSourceFile()"><font class="v8w">&#160;SELECT FILE&#160;</font></a>
          </td>
        </tr>

        <tr>
        <td align="right">Select Attribute:&#160;</td>
        <td align="left"><select name="attribute" size="1">
              <option value="0">D-H Customer Code (dhcustcode)</option>
              <option value="1">D-H Customer Descriptions (dhcustdescr)</option>
              <option value="2">D-H Customer Part Number (dhcpn)</option>
              <option value="3">D-H Divisional Buyer Code (dhbuyercode)</option>
              <option value="4">D-H DPN Descriptions (dhdpndescr)</option>
              <option value="5">D-H Year (year)</option>
              <option value="6">D-H Model Year (myear)</option>
            </select>
        </td>
        </tr>
        <tr>
        <td align="right">Select Operator:&#160;</td>
        <td align="left"><select name="operator" size="1">
              <option value="0">=</option>
              <option value="1">!=</option>
              <option value="2">&lt;</option>
              <option value="3">&gt;</option>
              <option value="4">&lt;=</option>
              <option value="5">&gt;=</option>
            </select>
        </td>
        </tr>
        <tr>
        <td align="right">Enter Value:&#160;</td>
        <td align="left"><input type="text" value="" size="20"/>
        </td>
        </tr>
        <tr><td align="right">
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;APPEND CRITERIA&#160;</font>
          </a>
          </td><td>&#160;</td>
          </tr>
          </table>
          &#160;
          
        </TD>
	      <TD style="HEIGHT: 27px" vAlign="top" align="left">
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;ADD CONDITION&#160;</font>
          </a>
        </TD>


      </TR>



<TR>
<TD colspan="3" style="HEIGHT: 27px" vAlign="top" align="center"><hr width="80%"/></TD>
</TR>



      <TR>
<TD colspan="3" style="HEIGHT: 27px" vAlign="top" align="left">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr> 
<td>
    <table width="100%" border="1" cellspacing="0" cellpadding="3">
    <tr class="TableHeader"> 
    <td class="TableHeader">Sequence</td>
    <td class="TableHeader">Command</td>
    <td class="TableHeader">Input File(s)</td>
    <td class="TableHeader">Save Output As</td>
    <td colspan="3" class="TableHeader">Action</td>
    </tr>
    <tr> 
    <td>1.</td>
    <td>Execute Allocation</td>
    <td>Source - DRI Buick<br/>Allocation - Buick Brand &amp; Market</td>
    <td>Temp DRI BUICK and Brand Market</td>
    <td>&#160;
          </td>
    <td><a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;DOWN&#160;</font>
          </a></td>

    <td><a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;EDIT&#160;</font>
          </a>
          </td>
    </tr>
    <tr> 
    <td>2.</td>
    <td>Execute Allocation</td>
    <td>Source - Temp DRI BUICK and Brand Market<br/>Allocation - Buick Platform &amp; Engineering</td>
    <td>Tuesday Script Result File 1</td>
    <td><a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;UP&#160;</font>
          </a>
          </td>
    <td><a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;DOWN&#160;</font>
          </a></td>

    <td><a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;EDIT&#160;</font>
          </a>
          </td>

    </tr>
    <tr> 
    <td>3.</td>
    <td>Execute Allocation</td>
    <td>Source - Temp DRI BUICK and Brand Market<br/>Allocation - Buick Platform &amp; Engineering</td>
    <td>Tuesday Script Result File 2</td>

    <td><a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;UP&#160;</font>
          </a>
          </td>
    <td>&#160;</td>
    <td><a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;EDIT&#160;</font>
          </a>
          </td>
    </tr>
    </table>
</td>
</tr>
</table>



</TD>

      </TR>

    </tbody>
  </TABLE> 
</xsl:template>

</xsl:stylesheet>
