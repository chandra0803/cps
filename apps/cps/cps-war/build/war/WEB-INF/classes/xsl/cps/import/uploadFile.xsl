<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.5 $

$Log: uploadFile.xsl,v $
Revision 1.5  2004/11/05 14:45:37  zz0qx3
changes post 11/4 review

Revision 1.4  2004/11/04 16:58:52  zz0qx3
mass update 11/4

Revision 1.3  2004/10/27 21:02:23  zz0qx3
changes this week

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
	<TD style="HEIGHT: 22px">Select System File</TD>
      </TR>
    </thead>
    <tbody>
      <TR> 
	<TD style="HEIGHT: 27px" vAlign="top" align="left">Format:&#160;
          <select name="fileFormat" size="1" style="height:27px;width:120px;">
            <option value="2" selected="true">Flat</option>
            <option value="0">TS - Year</option>
            <option value="1">TS - Year/MDLRUN</option>
            <option value="3">Component Group</option>
          </select>
        </TD>
      </TR>
      <TR> 
	<TD style="HEIGHT: 27px" vAlign="top" align="left">File:&#160;
          <input name="file" type="file" size="40"/>
        </TD>
      </TR>
      <TR>
	<TD vAlign="top">
          <a class="button" href="javascript:upload()">
            <font class="v8w">&#160;UPLOAD&#160;</font>
          </a>
        </TD> 
      </TR>
      <TR>
	<TD style="HEIGHT: 22px"></TD>
      </TR>

    </tbody>
  </TABLE>

</xsl:template>

</xsl:stylesheet>
