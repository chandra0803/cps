<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.1 $

$Log: error.xsl,v $
Revision 1.1  2004/09/24 17:03:42  vz86k2
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
          <TD colspan="2">
            <font class="v8b">
            Error processing request.
            </font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD colspan="3" align="left"><HR/></TD>
          <TD>&#160;</TD>
        </TR>

        <TR>
  	  <TD colspan="4" height="35">&#160;</TD>
        </TR>

   </TABLE>

</xsl:template>

</xsl:stylesheet>
