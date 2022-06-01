<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.3 $

$Log: importColumns.xsl,v $
Revision 1.3  2004/10/25 17:41:41  zz0qx3
updates

Revision 1.2  2004/09/29 13:30:49  vz86k2
update

Revision 1.1  2004/09/24 17:04:08  vz86k2
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

  <TABLE id="Table1" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px">Select Columns to import</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD vAlign="top">
          <a class="button" href="javascript:selectAll()">
            <font class="v8w">&#160;SELECT ALL&#160;</font>
          </a>&#160;
          <a class="button" href="javascript:upload()">
            <font class="v8w">&#160;UPLOAD&#160;</font>
          </a>&#160;
        </TD> 
      </TR>

    </tbody>
  </TABLE>

  <table id="tblResults" class="tbllb" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <TD><font class="v7aquaABoldItalic">File Columns</font></TD>
    </tr>
    <tr>
      <TD valign="top" align="left">   
	<div id="d1" style=" OVERFLOW-Y: scroll; OVERFLOW: scroll; WIDTH: 450px; HEIGHT: 250px">
	  <div id="d2" style=" OVERFLOW:visible; WIDTH:650px">
	    <table id="dtlResults" cellspacing="0" cellpadding="3" rules="cols" bordercolor="#999999" border="1" style="color:Black;background-color:White;border-color:#999999;border-width:1px;border-style:Solid;border-collapse:collapse;">
	      <tr>
		<td style="color:White;background-color:LightGrey;font-weight:bold;">
		  <span class="v7bbold" style="width:75px;VERTICAL-ALIGN: top">Select</span>
		  <span class="v7bbold" style="width:50px;VERTICAL-ALIGN: top">#</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Alias</span>
		  <span class="v7bbold" style="width:250px;VERTICAL-ALIGN: top">Name</span>
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
        <span class="v7b" style="width:75px;VERTICAL-ALIGN: top"><input type="checkbox" name="select"/></span>
        <span class="v7b" style="width:50px;VERTICAL-ALIGN: top"><xsl:value-of select="$columnNum"/></span>
        <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$shortName"/></span>
        <span class="v7b" style="width:250px;VERTICAL-ALIGN: top"><xsl:value-of select="$longName"/></span>
       </td>
     </tr>

</xsl:template>

</xsl:stylesheet>
