<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.1 $
$Log: scriptResults.xsl,v $
Revision 1.1  2004/10/18 17:40:27  zz0qx3
Checkpoint prior to making post-review changes

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
	<TD style="HEIGHT: 42px" colSpan="2">Save Script Results</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD style="HEIGHT: 42px" vAlign="top" align="left">Script Saved</TD>
      </TR>

    </tbody>
  </TABLE> 
</xsl:template>

</xsl:stylesheet>
