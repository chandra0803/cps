<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.2 $

$Log: reportDetails.xsl,v $
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
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="2">Report Information</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD style="HEIGHT: 27px" vAlign="top" align="right">Report Title:&#160;</TD>
	<TD align="left" vAlign="top" ><input type="text" size="40" name="reportTitle"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 27px" vAlign="top" align="right">Report Date:&#160;</TD>
	<TD align="left" vAlign="top" ><input type="text" size="8" name="reportDate"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 27px" vAlign="top" align="right">Report Template:&#160;</TD>
	<TD align="left" vAlign="top" ><input type="text" size="20" name="reportTemplate"/>
          &#160;
          <a class="button" href="javascript:selectReportTemplate()">
            <font class="v8w">&#160;SELECT REPORT TEMPLATE&#160;</font>
          </a>
        </TD>
      </TR>
      <TR>
        <TD colspan="2" style="HEIGHT: 11px"/>
      </TR>
      <TR>
	<TD colspan="2" style="HEIGHT: 27px" vAlign="top" align="center">
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;PREV&#160;</font>
          </a>&#160;
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;NEXT&#160;</font>
          </a>
        </TD>
      </TR>
      <TR>
        <TD colspan="2" style="HEIGHT: 11px"/>
      </TR>
    </tbody>
  </TABLE> 
</xsl:template>

</xsl:stylesheet>
