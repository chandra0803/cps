<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:import href="../commonCriteria.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.4 $

$Log: saveFile.xsl,v $
Revision 1.4  2004/10/27 21:02:23  zz0qx3
changes this week

Revision 1.3  2004/10/25 17:41:43  zz0qx3
updates

Revision 1.2  2004/10/25 13:23:16  zz0qx3
tweaks for allocation

Revision 1.1  2004/10/18 17:40:27  zz0qx3
Checkpoint prior to making post-review changes

Revision 1.3  2004/10/14 21:15:57  zz0qx3
added component groups, other tweaks

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
	<TD style="HEIGHT: 22px">Save File</TD>
      </TR>
    </thead>
  </TABLE>
<xsl:call-template name="saveAs"/>


</xsl:template>

</xsl:stylesheet>
