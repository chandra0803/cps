<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:import href="../commonCriteria.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.4 $
$Log: saveGroup.xsl,v $
Revision 1.4  2004/10/27 21:02:21  zz0qx3
changes this week

Revision 1.3  2004/10/22 20:04:55  zz0qx3
combined manage and create

Revision 1.2  2004/10/19 18:35:43  zz0qx3
added edit template

Revision 1.1  2004/10/14 21:15:56  zz0qx3
added component groups, other tweaks

Revision 1.2  2004/10/12 20:35:20  zz0qx3
create automation

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
	<TD style="HEIGHT: 22px" colSpan="2">Save Component Group Template</TD>
      </TR>
    </thead>
  </TABLE> 

<xsl:call-template name="saveAs">
  <xsl:with-param name="saveButton" select="'SAVE TEMPLATE'"/>
  <xsl:with-param name="selectButton" select="'SELECT TEMPLATE'"/>
</xsl:call-template>

</xsl:template>

</xsl:stylesheet>
