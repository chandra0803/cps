<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.5 $

$Log: fileDetails.xsl,v $
Revision 1.5  2004/10/27 21:02:22  zz0qx3
changes this week

Revision 1.4  2004/10/20 15:28:02  vz86k2
update based on prototype review

Revision 1.3  2004/10/05 19:34:24  vz86k2
update

Revision 1.2  2004/09/30 19:40:57  zz0qx3
importing Steve's latest

Revision 1.1  2004/09/24 17:04:23  vz86k2
check in

Revision 1.1  2004/07/23 19:17:41  vz86k2
check in


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

  <xsl:variable name="fileName" select="../Model/Session/CurrentFile/File/name"/>
  <xsl:variable name="fileDt" select="../Model/Session/CurrentFile/File/dt"/>
  <xsl:variable name="fileType" select="../Model/Session/CurrentFile/File/type"/>
  <xsl:variable name="fileComment" select="../Model/Session/CurrentFile/File/comment"/>
<!--
  <xsl:variable name="fileAuthor" select="../Model/Session/CurrentFile/File/author"/>
-->
  <xsl:variable name="fileAuthor" select="'vz86k2'"/>

  <TABLE id="Table1" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="2">Current File</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Name:&#160;</TD>
	<TD align="left" vAlign="top" ><xsl:value-of select="$fileName"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Date:&#160;</TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileDt"/></TD>
      </TR>
<!--
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Type:&#160;</TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileType"/></TD>
      </TR>
-->
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Comment:&#160;</TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileComment"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Author:&#160;</TD>
	<TD vAlign="top" style="width:232px;" align="left"><xsl:value-of select="$fileAuthor"/></TD>
      </TR>
      <TR>
        <TD width="20%"></TD>
	<TD width="80%" style="HEIGHT: 11px"></TD>
      </TR>
     </tbody>
  </TABLE>

  <TABLE id="Table1" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px">Add New Attribute</TD>
      </TR>
    </thead>
    <tbody>

      <TR>
	<TD nowrap="true" style="HEIGHT: 25px">
          <span>Attribute:&#160; 
            <select name="attribute" size="1" style="height:27px;">
              <option value="0">D-H Customer Code (dhcustcode)</option>
              <option value="1">D-H Customer Descriptions (dhcustdescr)</option>
              <option value="2">D-H Customer Part Number (dhcpn)</option>
              <option value="3">D-H Divisional Buyer Code (dhbuyercode)</option>
              <option value="4">D-H DPN Descriptions (dhdpndescr)</option>
            </select>&#160;
          </span>
        </TD>
      </TR>
      <TR>
	<TD nowrap="true" style="HEIGHT: 25px">
          <span>Default Value:&#160;
            <input name="default" type="text" size="12"/>
          </span>
        </TD>
      </TR>
      <TR>
	<TD nowrap="true" style="HEIGHT: 25px">     
           <a class="button" href="javascript:addAttribute()">
            <font class="v8w">&#160;ADD NEW ATTRIBUTE&#160;</font>
          </a>
        </TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 11px"></TD>
      </TR>
     </tbody>
  </TABLE>

  <table id="tblResults" class="tbllb" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <TD><font class="v7aquaABoldItalic">File Attributes</font></TD>
    </tr>
    <tr>
      <TD valign="top" align="left">   
	<div id="d1" style=" OVERFLOW-Y: scroll; OVERFLOW: scroll; WIDTH: 450px; HEIGHT: 250px">
	  <div id="d2" style=" OVERFLOW:visible; WIDTH:620px">
	    <table id="dtlResults" cellspacing="0" cellpadding="3" rules="cols" bordercolor="#999999" border="1" style="color:Black;background-color:White;border-color:#999999;border-width:1px;border-style:Solid;border-collapse:collapse;">
	      <tr>
		<td style="color:White;background-color:LightGrey;font-weight:bold;">
		  <span class="v7bbold" style="width:80px;VERTICAL-ALIGN: top">Action</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Attribute #</span>
		  <span class="v7bbold" style="width:150px;VERTICAL-ALIGN: top">Alias</span>
		  <span class="v7bbold" style="width:250px;VERTICAL-ALIGN: top">Full Name</span>
		</td>
	      </tr>
              <xsl:apply-templates select="FileColumnResultSet/FileColumn">
                <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              </xsl:apply-templates>  
  	    </table>
	  </div>
	</div>
      </TD>
    </tr>
      <TR>
	<TD style="HEIGHT: 11px"></TD>
      </TR>
  </table>

</xsl:template>

<xsl:template match="FileColumn">
  <xsl:param name="imgBaseUrl" select="''"/>

    <xsl:variable name="columnNum" select="id"/>
    <xsl:variable name="shortName" select="sname"/>
    <xsl:variable name="longName" select="lname"/>

    <xsl:variable name="row" select="(position() mod 2)"/>

    <tr>
      <td>
        <xsl:attribute name="style">
          <xsl:choose>
            <xsl:when test="$row = 0">
              <xsl:value-of select="'background-color:#CCCCCC;'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'background-color:#FFFFFF'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <span class="v7b" style="width:80px;VERTICAL-ALIGN: top">
        <a class="button" href="javascript:delete('{$columnNum}')">
          <font class="v8w">&#160;DELETE&#160;</font>
        </a>
        </span>
        <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$columnNum"/></span>
        <span class="v7b" style="width:150px;VERTICAL-ALIGN: top"><xsl:value-of select="$shortName"/></span>
        <span class="v7b" style="width:250px;VERTICAL-ALIGN: top"><xsl:value-of select="$longName"/></span>
       </td>
     </tr>

</xsl:template>

</xsl:stylesheet>
