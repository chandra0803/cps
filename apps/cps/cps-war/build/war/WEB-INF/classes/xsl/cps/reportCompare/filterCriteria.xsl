<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:import href="../commonCriteria.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.2 $

$Log: filterCriteria.xsl,v $
Revision 1.2  2004/10/27 21:02:24  zz0qx3
changes this week

Revision 1.1  2004/10/08 20:02:10  vz86k2
check in

Revision 1.2  2004/10/06 20:26:11  vz86k2
update

Revision 1.1  2004/10/05 21:10:40  vz86k2
check in

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
    }

  </script>

</xsl:template>

<xsl:template match="View">
  <xsl:param name="imgBaseUrl" select="''"/>
  <TABLE cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
  <tr><td>
      
      <xsl:call-template name="Criteria">
        <xsl:with-param name="addSectionTitle" select="'Define Report Filter Criteria'"/>
        <xsl:with-param name="tableSectionTitle" select="'Filter Criteria'"/>
      </xsl:call-template>
  </td></tr>
  <tr><td align="center">

          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;PREV&#160;</font>
          </a>&#160;
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;NEXT&#160;</font>
          </a>

  </td></tr>
  </TABLE>
</xsl:template>

</xsl:stylesheet>
