<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.4 $

$Log: copyTo.xsl,v $
Revision 1.4  2004/10/27 21:02:22  zz0qx3
changes this week

Revision 1.3  2004/10/20 15:28:45  vz86k2
update based on prototype review

Revision 1.2  2004/10/05 19:31:41  vz86k2
update

Revision 1.1  2004/09/24 17:04:23  vz86k2
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

  <xsl:variable name="fileName" select="../Model/Session/CurrentFile/File/name"/>
  <xsl:variable name="fileDt" select="../Model/Session/CurrentFile/File/dt"/>
  <xsl:variable name="fileType" select="../Model/Session/CurrentFile/File/type"/>
  <xsl:variable name="fileComment" select="../Model/Session/CurrentFile/File/comment"/>
<!--
  <xsl:variable name="fileAuthor" select="../Model/Session/CurrentFile/File/author"/>
-->
  <xsl:variable name="fileAuthor" select="'vz86k2'"/>

  <TABLE id="Table1" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="2">Current File</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Name:&#160;</TD>
	<TD align="left" vAlign="top" ><xsl:value-of select="$fileName"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Date:&#160;</TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileDt"/></TD>
      </TR>
<!--
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Type:&#160;</TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileType"/></TD>
      </TR>
-->
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Comment:&#160;</TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileComment"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Author:&#160;</TD>
	<TD vAlign="top" style="width:232px;" align="left"><xsl:value-of select="$fileAuthor"/></TD>
      </TR>
      <TR>
        <TD width="20%"></TD>
	<TD width="80%" style="HEIGHT: 11px"></TD>
      </TR>
     </tbody>
  </TABLE>


  <TABLE id="Table1" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colspan="2">New File</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD nowrap="true" valign="center" align="right" width="100px">
          <span>New File Name:&#160;</span></TD>
  <TD align="left">     
        <input name="newFileName" type="text" size="20"/>&#160;&#160;
           <a class="button" href="javascript:saveToNewFile()">
            <font class="v8w">&#160;SELECT FILE&#160;</font>
          </a>
        </TD>
      </TR>    
      <TR>
	<TD style="HEIGHT: 11px" colspan="2">&#160;</TD>
      </TR>
      <TR>
	<TD nowrap="true" valign="top"  align="right">
          <span>Comment:&#160;</span>
        </TD>
        <TD align="left">
          <textarea name="comment" style="height:52px;width:232px;"/>
        </TD>
      </TR>    
      <TR>
	<TD colspan="2" align="left" nowrap="true">
           <a class="button" href="javascript:saveToNewFile()">
            <font class="v8w">&#160;SAVE&#160;</font>
          </a>
        </TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 27px" colspan="2">&#160;</TD>
      </TR>
     </tbody>
  </TABLE>

</xsl:template>

</xsl:stylesheet>
