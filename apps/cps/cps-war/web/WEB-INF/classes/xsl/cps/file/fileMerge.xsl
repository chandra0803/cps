<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.5 $

$Log: fileMerge.xsl,v $
Revision 1.5  2004/11/05 14:45:36  zz0qx3
changes post 11/4 review

Revision 1.4  2004/11/04 16:58:52  zz0qx3
mass update 11/4

Revision 1.3  2004/10/20 15:28:01  vz86k2
update based on prototype review

Revision 1.2  2004/10/05 19:31:59  vz86k2
update

Revision 1.1  2004/09/24 17:04:22  vz86k2
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
  <xsl:variable name="fileName1" select="../Model/Session/CurrentFile[@id='1']/File/name"/>
  <xsl:variable name="fileDt1" select="../Model/Session/CurrentFile[@id='1']/File/dt"/>
  <xsl:variable name="fileType1" select="../Model/Session/CurrentFile[@id='1']/File/type"/>
  <xsl:variable name="fileComment1" select="../Model/Session/CurrentFile[@id='1']/File/comment"/>
  <xsl:variable name="fileName2" select="../Model/Session/CurrentFile[@id='2']/File/name"/>
  <xsl:variable name="fileDt2" select="../Model/Session/CurrentFile[@id='2']/File/dt"/>
  <xsl:variable name="fileType2" select="../Model/Session/CurrentFile[@id='2']/File/type"/>
  <xsl:variable name="fileComment2" select="../Model/Session/CurrentFile[@id='2']/File/comment"/>
<!--
  <xsl:variable name="fileAuthor1" select="../Model/Session/CurrentFile[@id='1']/File/author"/>
  <xsl:variable name="fileAuthor2" select="../Model/Session/CurrentFile[@id='2']/File/author"/>
-->
  <xsl:variable name="fileAuthor1" select="'vz86k2'"/>
  <xsl:variable name="fileAuthor2" select="'vz86k2'"/>

  <TABLE id="Table1" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="3">Current Files</TD>
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
<!--
      <TR>
	<TD style="HEIGHT: 16px" vAlign="top" align="right">Type:&#160;</TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileType1"/></TD>
	<TD vAlign="top" style="width:232px;"><xsl:value-of select="$fileType2"/></TD>
      </TR>
-->
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
	<TD colspan="3" style="HEIGHT: 32px"></TD>
      </TR>

      <TR>


        <TD width="20%" style="HEIGHT: 16px" vAlign="top" align="right">&#160;</TD>
	<TD width="40%">File 1</TD>
	<TD width="40%">File 2</TD>
      </TR>

      <TR>
	<TD colspan="3" style="HEIGHT: 7px"></TD>
      </TR>


      <TR>
	<TD colspan="3" align="center">

              <xsl:call-template name="table">
                <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              </xsl:call-template>  
        </TD>
      </TR>



      <TR>
	<TD colspan="3" style="HEIGHT: 11px"></TD>
      </TR>
      <TR>
        <TD></TD>
        <TD colspan="2">
           <a class="button" href="javascript:merge()">
            <font class="v8w">&#160;MERGE&#160;</font>
          </a>
        </TD>
      </TR>
      <TR>
        <TD width="20%" style="HEIGHT: 11px"></TD>
	<TD width="40%"></TD>
	<TD width="40%"></TD>
      </TR>
     </tbody>
  </TABLE>


</xsl:template>

<xsl:template name="table">
  <xsl:param name="imgBaseUrl" select="''"/>

  <table id="tblResults" class="tbllb" width="70%" border="1" cellpadding="0" cellspacing="0">
    <xsl:call-template name="rows">
      <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
    </xsl:call-template>  
  </table>

</xsl:template>

<xsl:template name="rows">
  <xsl:param name="imgBaseUrl" select="''"/>

  <xsl:for-each select="FileColumnResultSet[@id='1']/FileColumn">

    <xsl:variable name="colPos" select="position()"/>

    <xsl:variable name="shortName1" select="sname"/>
    <xsl:variable name="longName1" select="lname"/>

    
    <xsl:variable name="shortName2" select="../../FileColumnResultSet[@id='2']/FileColumn[$colPos]/sname"/>
    <xsl:variable name="longName2" select="../../FileColumnResultSet[@id='2']/FileColumn[$colPos]/lname"/>


    <xsl:variable name="row" select="(position() mod 2)"/>

    <tr>
      <td>
        <xsl:attribute name="style">
          <xsl:choose>
            <xsl:when test="$row = 0">
              <xsl:value-of select="'background-color:#CCCCCC;'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'background-color:#FFFFFF'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <span class="v7b" style="width:25px;VERTICAL-ALIGN: top"><xsl:value-of select="$colPos"/></span>
       </td>

      <td>
        <xsl:attribute name="style">
          <xsl:choose>
            <xsl:when test="$row = 0">
              <xsl:value-of select="'background-color:#CCCCCC;'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'background-color:#FFFFFF'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <span  style="width:150px;VERTICAL-ALIGN: top"><xsl:value-of select="$shortName1"/></span>
        <span  style="width:250px;VERTICAL-ALIGN: top"><xsl:value-of select="$longName1"/></span>
       </td>

      <td>
        <xsl:attribute name="style">
          <xsl:choose>
            <xsl:when test="$row = 0">
              <xsl:value-of select="'background-color:#CCCCCC;'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'background-color:#FFFFFF'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <span  style="width:150px;VERTICAL-ALIGN: top"><xsl:value-of select="$shortName2"/></span>
        <span  style="width:250px;VERTICAL-ALIGN: top"><xsl:value-of select="$longName2"/></span>
       </td>

     </tr>
  </xsl:for-each>

</xsl:template>

</xsl:stylesheet>
