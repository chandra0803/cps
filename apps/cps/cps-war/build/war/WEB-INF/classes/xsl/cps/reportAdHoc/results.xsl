<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:import href="../commonCriteria.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.6 $

$Log: results.xsl,v $
Revision 1.6  2004/11/04 16:58:51  zz0qx3
mass update 11/4

Revision 1.5  2004/10/28 17:28:39  zz0qx3
alignment fix

Revision 1.4  2004/10/28 15:40:42  zz0qx3
updates

Revision 1.3  2004/10/25 15:56:50  vz86k2
remove displaying report

Revision 1.2  2004/10/06 20:26:11  vz86k2
update

Revision 1.1  2004/10/05 21:10:39  vz86k2
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

    function displayReport()
    {
      document.formA.action="cpsVolumeReport.pdf";
      document.formA.target="_blank";
      document.formA.submit();
    }

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
	<TD style="WIDTH: 100px; HEIGHT: 22px">Report Results</TD><TD>&#160;</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
    	<TD style="WIDTH: 100px; HEIGHT: 12px">&#160;</TD><TD>&#160;</TD>
      </TR>


      <TR> 
	      <TD colspan="2" align="left">Your Results Will Display In A New Window</TD>
      </TR>

      <TR>
    	<TD style="WIDTH: 100px; HEIGHT: 27px">&#160;</TD><TD>&#160;</TD>
      </TR>

      <TR>
	      <TD style="WIDTH: 100px; HEIGHT: 27px" align="right">Bookmark Report:&#160;</TD>

        <TD style="HEIGHT: 27px" align="left">
          <a class="button" href="javascript:addFilterCriteria()">
            <font class="v8w">&#160;BOOKMARK REPORT&#160;</font>
          </a>
        </TD>
      </TR>

      <TR>
    	<TD style="WIDTH: 100px; HEIGHT: 27px">&#160;</TD><TD>&#160;</TD>
      </TR>
    </tbody>
  </TABLE>


</xsl:template>

</xsl:stylesheet>
