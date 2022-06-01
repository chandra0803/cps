<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:java="http://xml.apache.org/xslt/java" xmlns:xsli="XSLTTabInclude" extension-element-prefixes="xsli" version="1.0">
<xsl:import href="screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<xsl:template name="LocalScript">
<script type="text/javascript" language="javascript">

function pageLoaded()
{
  <xsl:if test="RedirectMessage">
      alert('<xsl:value-of select="RedirectMessage/@text"/>');    
  </xsl:if>
  <xsl:if test="Presentation/Results/vendorAlert">
      alert('<xsl:value-of select="Presentation/Results/vendorAlert/@text"/>');    
  </xsl:if>
  <xsl:if test="Presentation/Results/browserAlert">
      alert('<xsl:value-of select="Presentation/Results/browserAlert/@text"/>');    
  </xsl:if>

}
</script>
</xsl:template>

<xsl:template match="Presentation">
  <TABLE width="80%" border="0" cellpadding="2" cellspacing="2">
    <tr>
      <td colspan="4" height="50">&#160;</td>
    </tr>
    <tr>
      <td width="15">&#160;</td>
      <td align="left" valign="bottom" nowrap="true"><font class="v10aquaA"><b>Welcome to WebEDI</b></font></td>
      <td width="20">&#160;</td>
      <td align="right" valign="top"><img src="{$infImgBasePath}header_image_suppliers.jpg" border="0"/></td>
    </tr>
    <tr>
      <td colspan="4"><hr/></td>
    </tr>
    <tr>
      <td width="15">&#160;</td>
      <td colspan="3">
         <font face="Arial" size="2">
         Welcome to the Delphi WebEDI Application.  In this application you
         will be able to manage your EDI based shipping transactions with Delphi.  For
         a detailed explanation of this application please refer to the help section for
         documentation and Delphi contacts.</font></td>
    </tr>
  </TABLE>
  <xsl:apply-templates select="Results"/>

</xsl:template>

<xsl:template match="Results">  
  <xsl:apply-templates select="BroadcastResultSet"/>
</xsl:template>
  
<xsl:template match="BroadcastResultSet">
  <br/>
  <TABLE width="80%" border="0" cellpadding="2" cellspacing="2">
    <tr>
      <td width="15">&#160;</td>
      <td align="left" valign="bottom" nowrap="true"><font class="v10aquaA"><b>Please be aware of the following messages:</b></font></td>
      <td>&#160;</td>
      <td>&#160;</td>
    </tr>

    <tr>
      <td colspan="4"><hr/></td>
    </tr>
    <tr>
      <td width="15">&#160;</td>
      <td colspan="3">
        <xsl:choose>
          <xsl:when test="Broadcast">
            <xsl:apply-templates select="Broadcast"/>
          </xsl:when>
          <xsl:otherwise>
            <font class="v8b">There are no messages for you today.</font>
          </xsl:otherwise>
        </xsl:choose>          
      </td>
    </tr>
  </TABLE>
  
</xsl:template>
  
<xsl:template match="Broadcast">
  <TABLE width="100%" border="0" cellpadding="2" cellspacing="2">
    <tr>
      <td width="15" align="right">&#160;</td>
      <td align="left">&#160;</td>
    </tr>
    <tr>
      <td width="15" align="right">
        <img src="{$infImgBasePath}clear.gif" width="5" height="0"/>  
        <img src="{$infImgBasePath}delphi/menuSquare.gif" align="middle"/> 
        <img src="{$infImgBasePath}clear.gif" width="5" height="0"/>         
      </td>
      <td align="left"><font class="v9b"><xsl:value-of select="message"/></font></td>
    </tr>
  </TABLE>
</xsl:template>

</xsl:stylesheet>
