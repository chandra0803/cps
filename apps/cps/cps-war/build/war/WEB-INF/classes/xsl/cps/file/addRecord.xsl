<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.5 $

$Log: addRecord.xsl,v $
Revision 1.5  2004/10/27 21:02:22  zz0qx3
changes this week

Revision 1.4  2004/10/20 15:28:02  vz86k2
update based on prototype review

Revision 1.3  2004/10/05 19:31:18  vz86k2
update

Revision 1.2  2004/09/30 19:40:57  zz0qx3
importing Steve's latest

Revision 1.1  2004/09/29 13:31:25  vz86k2
check in

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
        <TD></TD>
      </TR>
      <TR>
        <TD width="20%">
        </TD>
	<TD width="80%" style="HEIGHT: 22px"></TD>
      </TR>
     </tbody>
  </TABLE>

  <table id="tblResults" class="tbllb" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <TD><font class="v7aquaABoldItalic">Enter Record Attribute Values</font></TD>
    </tr>
      <TR>
        <TD colspan="2" style="HEIGHT: 11px"/>
      </TR>
      <TR>
        <TD>
	    <table cellspacing="0" cellpadding="3" bordercolor="#999999" border="1" style="color:Black;background-color:White;border-color:#999999;border-width:1px;border-style:Solid;">
	      <tr style="color:White;background-color:LightGrey;font-weight:bold;">
		<td align="center">
		  <span class="v7bbold" style="WIDTH: 200px;VERTICAL-ALIGN: top">Attribute</span>
		</td>
		<td align="center">
		  <span class="v7bbold" style="WIDTH: 150px;VERTICAL-ALIGN: top">Value</span>
		</td>
              </tr>
                <TD style="HEIGHT: 27px" vAlign="top" align="left">CVA</TD>
	        <TD align="left" vAlign="top" ><input type="text" name="x1" />
                </TD>
              <tr>
                <TD style="HEIGHT: 27px" vAlign="top" align="left">DRI Model Range</TD>
                <TD nowrap="true" align="left" vAlign="top" ><input type="text" name="x2"/>
                </TD>
              </tr>
              <tr>
                <TD style="HEIGHT: 27px" vAlign="top" align="left">DRI Platform</TD>
                <TD align="left" vAlign="top" ><input type="text" name="x3"/>
                </TD>
              </tr>
              <tr>
                <TD style="HEIGHT: 27px" vAlign="top" align="left">DRI Production Brand</TD>
                <TD align="left" vAlign="top" ><input type="text" name="x4"/>
                </TD>
              </tr>
              <tr>
                <TD style="HEIGHT: 27px" vAlign="top" align="left">DRI Vehicle Manufacturer</TD>
                <TD align="left" vAlign="top" ><input type="text" name="x5" />
                </TD>
              </tr>
              <tr>
                <TD style="HEIGHT: 27px" vAlign="top" align="left">Marketing Area</TD>
                <TD align="left" vAlign="top" ><input type="text" name="x6" />
                </TD>
              </tr>
              <tr>
                <TD style="HEIGHT: 27px" vAlign="top" align="left">Model Run</TD>
                <TD align="left" vAlign="top" ><input type="text" name="x7"/>
                </TD>
              </tr>
              <tr>
                <TD style="HEIGHT: 27px" vAlign="top" align="left">Vehicle Type</TD>
                <TD align="left" vAlign="top" ><input type="text" name="x8"/>
                </TD>
              </tr>
              <tr>
                <TD style="HEIGHT: 27px" vAlign="top" align="left">Year</TD>
                <TD align="left" vAlign="top" ><input type="text" name="x9"/>
                </TD>
              </tr>
              <tr>
                <TD style="HEIGHT: 27px" vAlign="top" align="left">Volume</TD>
                <TD align="left" vAlign="top" ><input type="text" name="x10"/></TD>
              </tr>
            </table>  
        </TD>
      </TR>
      <TR>
        <TD colspan="2" style="HEIGHT: 11px"/>
      </TR>
      <TR>
        <TD width="20%">
          <a class="button" href="javascript:addAttribute()">
            <font class="v8w">&#160;SAVE RECORD&#160;</font>
          </a>
        </TD>
	<TD width="80%" style="HEIGHT: 22px"></TD>
      </TR>
  </table>

</xsl:template>

</xsl:stylesheet>
