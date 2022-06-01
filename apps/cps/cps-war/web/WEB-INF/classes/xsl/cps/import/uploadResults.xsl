<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.2 $

$Log: uploadResults.xsl,v $
Revision 1.2  2004/09/29 13:30:48  vz86k2
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
	<TD style="HEIGHT: 22px">Upload Summary</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD style="HEIGHT: 22px" vAlign="top">Total # Records: <xsl:value-of select="UploadStatusResultSet/UploadStatus/rows"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 22px" vAlign="top">Time: <xsl:value-of select="UploadStatusResultSet/UploadStatus/time"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 22px" vAlign="top">Errors: <xsl:value-of select="UploadStatusResultSet/UploadStatus/errors"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 27px" vAlign="top">
          <a class="button" href="javascript:reload()">
            <font class="v8w">&#160;CONTINUE&#160;</font>
          </a>
        </TD> 
      </TR>
    </tbody>
  </TABLE>

  <table id="tblResults" class="tbllb" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <TD><font class="v7aquaABoldItalic">Errors</font></TD>
    </tr>
    <tr>
      <TD valign="top" align="left">   
	<div id="d1" style=" OVERFLOW-Y: scroll; OVERFLOW: scroll; WIDTH: 450px; HEIGHT: 250px">
	  <div id="d2" style=" OVERFLOW:visible; WIDTH:1200px">
	    <table id="dtlResults" cellspacing="0" cellpadding="3" rules="cols" bordercolor="#999999" border="1" style="color:Black;background-color:White;border-color:#999999;border-width:1px;border-style:Solid;border-collapse:collapse;">
	      <tr>
		<td style="color:White;background-color:LightGrey;font-weight:bold;">
		  <span class="v7bbold" style="width:50px;VERTICAL-ALIGN: top">Id</span>
		  <span class="v7bbold" style="width:50px;VERTICAL-ALIGN: top">Row #</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Attribute</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Value</span>
		  <span class="v7bbold" style="width:200px;VERTICAL-ALIGN: top">Error Type</span>
		  <span class="v7bbold" style="width:200px;VERTICAL-ALIGN: top">Error</span>
		  <span class="v7bbold" style="width:400px;VERTICAL-ALIGN: top">Resolution</span>
		</td>
	      </tr>
              <xsl:apply-templates select="UploadErrorResultSet/UploadError">
                <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              </xsl:apply-templates>  
  	    </table>
	  </div>
	</div>
      </TD>
    </tr>
  </table>

</xsl:template>

<xsl:template match="UploadError">
  <xsl:param name="imgBaseUrl" select="''"/>

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
        <span class="v7bbold" style="width:50px;VERTICAL-ALIGN: top"><xsl:value-of select="id"/></span>
        <span class="v7bbold" style="width:50px;VERTICAL-ALIGN: top"><xsl:value-of select="row"/></span>
        <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="attr"/></span>
        <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="val"/></span>
        <span class="v7bbold" style="width:200px;VERTICAL-ALIGN: top"><xsl:value-of select="errType"/></span>
        <span class="v7bbold" style="width:200px;VERTICAL-ALIGN: top"><xsl:value-of select="err"/></span>
        <span class="v7bbold" style="width:400px;VERTICAL-ALIGN: top"><xsl:value-of select="res"/></span>
       </td>
     </tr>

</xsl:template>

</xsl:stylesheet>
