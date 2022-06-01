<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.2 $

$Log: downloadFile.xsl,v $
Revision 1.2  2004/10/05 18:30:25  zz0qx3
export file prototype

Revision 1.1  2004/09/24 17:04:42  vz86k2
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
	<TD style="HEIGHT: 22px">Download File</TD>
      </TR>
    </thead>

    <tbody>
      <TR> 
	<TD style="HEIGHT: 27px" vAlign="top" align="left">Your download should begin automatically in the next few moments</TD>
      </TR>
      <TR>
	<TD vAlign="top">
          <a class="button" href="javascript:selectAll()">
            <font class="v8w">&#160;RETURN&#160;</font>
          </a>
        </TD> 
      </TR>

    </tbody>
  </TABLE>

<!-- replace with handler reference to fetch file -->
<iframe height="0" width="0" src="{$imgBaseUrl}/screen/demo-export-excel.xls"></iframe>

</xsl:template>


</xsl:stylesheet>
