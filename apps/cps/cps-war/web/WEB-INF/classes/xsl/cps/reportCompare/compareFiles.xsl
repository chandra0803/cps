<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.2 $

$Log: compareFiles.xsl,v $
Revision 1.2  2004/11/04 16:58:50  zz0qx3
mass update 11/4

Revision 1.1  2004/10/08 20:02:10  vz86k2
check in

Revision 1.2  2004/10/06 20:26:10  vz86k2
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

    function pageLoaded()
    {
    }

  </script>

</xsl:template>

<xsl:template match="View">
  <xsl:param name="imgBaseUrl" select="''"/>
  <xsl:variable name="fileName1" select="../Model/Session/CurrentFile[@id='1']/File/name"/>
  <xsl:variable name="fileDt1" select="../Model/Session/CurrentFile[@id='1']/File/dt"/>
  <xsl:variable name="fileType1" select="../Model/Session/CurrentFile[@id='1']/File/type"/>
  <xsl:variable name="fileComment1" select="../Model/Session/CurrentFile[@id='1']/File/comment"/>
  <xsl:variable name="fileAuthor1" select="../Model/Session/CurrentFile[@id='1']/File/author"/>
  <xsl:variable name="fileName2" select="../Model/Session/CurrentFile[@id='2']/File/name"/>
  <xsl:variable name="fileDt2" select="../Model/Session/CurrentFile[@id='2']/File/dt"/>
  <xsl:variable name="fileType2" select="../Model/Session/CurrentFile[@id='2']/File/type"/>
  <xsl:variable name="fileComment2" select="../Model/Session/CurrentFile[@id='2']/File/comment"/>
  <xsl:variable name="fileAuthor2" select="../Model/Session/CurrentFile[@id='2']/File/author"/>

  <TABLE id="Table1" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="3">Compare Files</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top"></TD>
	<TD align="left" vAlign="top" >File 1</TD>
	<TD align="left" vAlign="top" >File 2</TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Name:&#160;</TD>
	<TD align="left" vAlign="top" ><xsl:value-of select="$fileName1"/></TD>
	<TD align="left" vAlign="top" ><xsl:value-of select="$fileName2"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Date:&#160;</TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileDt1"/></TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileDt2"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Type:&#160;</TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileType1"/></TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileType2"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Comment:&#160;</TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileComment1"/></TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileComment2"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Author:&#160;</TD>
	<TD vAlign="top" style="width:232px;" align="left"><xsl:value-of select="$fileAuthor1"/></TD>
	<TD vAlign="top" style="width:232px;" align="left"><xsl:value-of select="$fileAuthor2"/></TD>
      </TR>
      <TR>
	<TD colspan="3" style="HEIGHT: 11px"></TD>
      </TR>
      <TR>
        <TD></TD>
        <TD>
           <a class="button" href="javascript:selectFile1()">
            <font class="v8w">&#160;SELECT FILE&#160;</font>
          </a>
        </TD>
        <TD>
           <a class="button" href="javascript:selectFile2()">
            <font class="v8w">&#160;SELECT FILE&#160;</font>
          </a>
        </TD>
      </TR>
      <TR>
	<TD colspan="3" style="HEIGHT: 11px"></TD>
      </TR>
      <TR>
	<TD colspan="3" style="HEIGHT: 27px" vAlign="top" align="center">
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;NEXT&#160;</font>
          </a>
        </TD>
      </TR>
      <TR>
        <TD colspan="3" style="HEIGHT: 11px"/>
      </TR>

      <TR>
        <TD width="20%" style="HEIGHT: 11px"></TD>
	<TD width="40%"></TD>
	<TD width="40%"></TD>
      </TR>

     </tbody>
  </TABLE>


</xsl:template>

</xsl:stylesheet>
