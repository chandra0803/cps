<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.1 $

$Log: about.xsl,v $
Revision 1.1  2004/09/24 17:03:42  vz86k2
check in

Revision 1.2  2004/08/25 22:43:19  vz86k2
check in

Revision 1.1  2004/07/23 19:17:42  vz86k2
check in

Revision 1.23  2003/09/26 14:12:28  zz0qx3
changed wording

Revision 1.22  2003/09/26 13:05:01  zz0qx3
specified vendor issue

-->


<xsl:template name="LocalScript">
  <script type="text/javascript" language="javascript">

    function pageLoaded()
    {
<xsl:if test="RedirectMessage">
      alert('<xsl:value-of select="RedirectMessage/@text"/>');    
</xsl:if>
<xsl:if test="State/SuccessMessage">
      alert('<xsl:value-of select="State/SuccessMessage/@text"/>');    
</xsl:if>
    }

  </script>

</xsl:template>

<xsl:template match="View">
      <TABLE width="80%" border="0" cellpadding="2" cellspacing="2">
        <TR>
  	      <TD colspan="4" height="35">&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="2" align="left" valign="bottom" nowrap="true"><font class="v10aquaA"><b>Welcome to the ASN Creation Wizard</b></font></TD>
          <TD align="right" valign="top"><img src="{$infImgBasePath}Tech15_6_240.jpg" border="0"/></TD>
        </TR>
	      <TR>
  	      <TD colspan="4"><hr/></TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="2">
            <font class="v8b">
            Welcome to the ASN Creation Wizard where the WebEDI Application will guide
            you through the process of creating an ASN.  The process includes the following
            steps:</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="2">
            <font class="v8b">
            1. Select a Delphi Plant as the shipping destination, and a Vendor as the shipping source.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="2">
            <font class="v8b">
            2. Complete ASN Header Information.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="2">
            <font class="v8b">
            3. Select Containers.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="2">
            <font class="v8b">
            4. Review the ASN details.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="2">
            <font class="v8b">
            5. Review or alter serial numbers and generate labels as required.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="2">
            <font class="v8b">
            6. Submit the ASN to Delphi for processing.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD colspan="3" align="left"><HR/></TD>
          <TD>&#160;</TD>
        </TR>

<xsl:choose>
<xsl:when test="Criteria/CreateAsnPlantResultSet/CreateAsnPlant">
        <TR>
          <TD width="15">&#160;</TD>
          <TD nowrap="true" align="right">
            <font class="v7b">
            <b>First Select the Destination Plant:&#160;</b>
            </font>
          </TD>
          <TD nowrap="true" align="left">
            <SELECT type="select" name="plantCd" class="v8b" onChange="plantChanged(selectedIndex);">
              <xsl:apply-templates select="Criteria/CreateAsnPlantResultSet/CreateAsnPlant">
                <xsl:with-param name="SelectedPlant" select="../State/Plant/@selected"/>
              </xsl:apply-templates>
            </SELECT>
          </TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD nowrap="true" align="right">
            <font class="v7b">
            <b>Next Select the Source Vendor Code:&#160;</b>
            </font>
          </TD>
          <TD nowrap="true" align="left">
            <SELECT type="select" name="vendorId" class="v8b">
            </SELECT>
          </TD>
          <TD>&#160;</TD>
        </TR>

</xsl:when>
<xsl:otherwise>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="2" nowrap="true" align="center">
            <font class="v9b">
            <b>You have no available Plant Codes for ASN creation</b>
            </font>
          </TD>
          <TD>&#160;</TD>
        </TR>

</xsl:otherwise>
</xsl:choose>
        <TR>
  	  <TD colspan="4" height="35">&#160;</TD>
        </TR>

        <TR>
          <TD colspan="3" align="center" bgcolor="#C3C3C3">
<xsl:if test="Criteria/CreateAsnPlantResultSet/CreateAsnPlant">
            <a href="javascript:void(next())"><IMG border="0" src="{$infImgBasePath}delphi/nextLarger.gif"/></a>&#160;&#160;
</xsl:if>
            <a href="javascript:void(cancel())"><IMG border="0" src="{$infImgBasePath}delphi/cancelLarger.gif"/></a>
          </TD>
          <TD>&#160;</TD>
        </TR>
   </TABLE>

</xsl:template>

<xsl:template match="CreateAsnPlant">
  <xsl:param name="SelectedPlant" select="''"/>

  <xsl:choose>
    <xsl:when test="@plantCd = $SelectedPlant">  
      <OPTION value="{@plantCd}" selected="true"><xsl:apply-templates select="@plantCd"/> - <xsl:apply-templates select="@plantName"/></OPTION>
    </xsl:when>
    <xsl:otherwise>
      <OPTION value="{@plantCd}"><xsl:apply-templates select="@plantCd"/> - <xsl:apply-templates select="@plantName"/></OPTION>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template>

</xsl:stylesheet>
