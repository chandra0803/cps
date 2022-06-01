<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.7 $

$Log: commonCriteria.xsl,v $
Revision 1.7  2004/11/05 14:45:36  zz0qx3
changes post 11/4 review

Revision 1.6  2004/10/28 17:28:39  zz0qx3
alignment fix

Revision 1.5  2004/10/27 21:02:20  zz0qx3
changes this week

Revision 1.4  2004/10/25 16:50:59  zz0qx3
changed to INCLUDE EXCLUDE

Revision 1.3  2004/10/25 16:10:50  vz86k2
update to only use AND

Revision 1.2  2004/10/25 13:23:18  zz0qx3
tweaks for allocation

Revision 1.1  2004/10/20 16:10:48  vz86k2
check in as common filter/search criteria component

Revision 1.1  2004/09/24 17:03:42  vz86k2


-->

<xsl:template name="Criteria">
  <xsl:param name="addSectionTitle" select="''"/>
  <xsl:param name="tableSectionTitle" select="''"/>

  <TABLE cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0">
    <TR>
      <TD>

  <TABLE cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="2"><xsl:value-of select="$addSectionTitle"/></TD>
      </TR>
    </thead>
    <tbody>
      <TR>
        <TD style="HEIGHT: 27px" align="right">Select Attribute:&#160;</TD>
        <TD>
            <select name="attribute" size="1">
              <option value="0">Country of Vehicle Assembly (cva)</option>
              <option value="0">D-H Customer Code (dhcustcode)</option>
              <option value="1">D-H Customer Descriptions (dhcustdescr)</option>
              <option value="2">D-H Customer Part Number (dhcpn)</option>
              <option value="3">D-H Divisional Buyer Code (dhbuyercode)</option>
              <option value="4">D-H DPN Descriptions (dhdpndescr)</option>
              <option value="5">D-H Year (year)</option>
              <option value="6">D-H Model Year (myear)</option>
            </select>
        </TD>
      </TR>
      <TR>
        <TD style="HEIGHT: 27px" align="right">Select Operator:&#160;</TD>
        <TD>
            <select name="operator" size="1">
              <option value="0">=</option>
              <option value="1">!=</option>
              <option value="2">&lt;</option>
              <option value="3">&gt;</option>
              <option value="4">&lt;=</option>
              <option value="5">&gt;=</option>
              <option value="6">INCLUDE</option>
              <option value="6">EXCLUDE</option>
            </select>
        </TD>
      </TR>
      <TR>
        <TD style="HEIGHT: 27px" align="right">Enter Value:&#160;</TD>
        <TD>
            <input type="text" value="" size="20"/>
        </TD>
      </TR>
      <TR>
        <TD/>
        <TD style="HEIGHT: 32px" align="left">
          <a class="button" href="javascript:addFilterCriteria()">
            <font class="v8w">&#160;ADD FILTER CRITERIA&#160;</font>
          </a>
        </TD>
      </TR>

      <TR>
        <TD colspan="2" style="HEIGHT: 11px"/>
      </TR>
    </tbody>
  </TABLE> 

  </TD>
  <TD>

  <TABLE cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="2"><xsl:value-of select="$tableSectionTitle"/></TD>
      </TR>
    </thead>
    <tbody>
      <TR>
      <TD valign="top" align="left">   
	<div id="d1" style=" OVERFLOW-Y: scroll; OVERFLOW: scroll; WIDTH: 375px; HEIGHT: 200px">
	  <div id="d2" style=" OVERFLOW:visible; WIDTH:425px">
	    <table id="dtlResults" cellspacing="0" cellpadding="3" rules="cols" bordercolor="#999999" border="1" style="color:Black;background-color:White;border-color:#999999;border-width:1px;border-style:Solid;border-collapse:collapse;">
	      <tr>
		<td style="color:White;background-color:LightGrey;font-weight:bold;">
		  <span class="v7bbold" style="width:35px;VERTICAL-ALIGN: top">Select</span>
		  <span class="v7bbold" style="width:150px;VERTICAL-ALIGN: top">Filter</span>
		</td>
	      </tr>


    <tr>
      <td style="background-color:#FFFFFF;">
        <span class="v7b" style="width:35px;VERTICAL-ALIGN: top"><input type="checkbox" name="edit"/></span>
        <span class="v7b" style="width:150px;VERTICAL-ALIGN: top"><xsl:value-of select="'cva = US'"/></span>
<!--
        <span class="v7b" style="width:50px;VERTICAL-ALIGN: top">
          <select name="logical" size="1">
            <option value="0">AND</option>
            <option value="0" selected="true">AND</option>
          </select> 
        </span>
        <span class="v7b" style="width:100px;VERTICAL-ALIGN: top">
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;UP&#160;</font>
          </a>&#160;
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;DOWN&#160;</font>
          </a>
        </span>
-->
       </td>
     </tr>

    <tr>
      <td style="background-color:#CCCCCC;">
        <span class="v7b" style="width:35px;VERTICAL-ALIGN: top"><input type="checkbox" name="edit"/></span>
        <span class="v7b" style="width:150px;VERTICAL-ALIGN: top"><xsl:value-of select="'year INCLUDE (1999,2001,2004)'"/>&#160;</span>
<!--
        <span class="v7b" style="width:50px;VERTICAL-ALIGN: top">
        </span>
        <span class="v7b" style="width:100px;VERTICAL-ALIGN: top">
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;UP&#160;</font>
          </a>&#160;
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;DOWN&#160;</font>
          </a>
        </span>
-->
       </td>
     </tr>

  	    </table>
	  </div>
	</div>
      </TD>
      </TR> 

      <TR>
        <TD colspan="2" style="HEIGHT: 11px"/>
      </TR>

      <TR>
	<TD colspan="2" style="HEIGHT: 27px" vAlign="top" align="center">
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;SELECT ALL&#160;</font>
          </a>&#160;
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;REMOVE SELECTED&#160;</font>
          </a>
        </TD>
      </TR>

      <TR>
        <TD colspan="2" style="HEIGHT: 11px"/>
      </TR>
    </tbody>
  </TABLE>  

  </TD>
  </TR>
  </TABLE>

</xsl:template>


<xsl:template name="saveAs">
<xsl:param name="saveButton" select="'SAVE FILE'"/>
<xsl:param name="selectButton" select="'SELECT FILE'"/>

  <TABLE id="saveFile" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
      <TR>
	<TD style="HEIGHT: 27px"  align="right" width="100px">Save As:&#160;</TD>
	<TD align="left" vAlign="top" ><input type="text" size="20" name="sourceFile"/>
          &#160;
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;<xsl:value-of select="$selectButton"/>&#160;</font>
          </a>
        </TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 27px" align="right">Comments:&#160;</TD>
	<TD align="left" vAlign="top" ><input type="text" size="20" name="sourceFile"/>
          &#160;
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;<xsl:value-of select="$saveButton"/>&#160;</font>
          </a>
        </TD>
      </TR>
</TABLE>
</xsl:template>

</xsl:stylesheet>
