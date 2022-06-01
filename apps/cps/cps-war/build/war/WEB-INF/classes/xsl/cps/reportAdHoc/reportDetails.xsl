<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.3 $

$Log: reportDetails.xsl,v $
Revision 1.3  2004/10/21 13:34:03  vz86k2
update

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

    </tbody>
  </TABLE> 


  <TABLE cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="2">Source File(s)</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD style="HEIGHT: 27px" vAlign="top" align="right">Source File:&#160;</TD>
	<TD align="left" vAlign="top" ><input type="text" size="20" name="sourceFile"/>
          &#160;
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;SELECT FILE&#160;</font>
          </a>
          &#160;
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;ADD FILE&#160;</font>
          </a>
        </TD>
      </TR>

      <TR>
        <TD colspan="2" style="HEIGHT: 11px"/>
      </TR>
      <TR>
        <TD colspan="2">

              <xsl:call-template name="table">
                <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
                <xsl:with-param name="columnNum" select="'2'"/>
              </xsl:call-template>

        </TD>
      </TR>  

      <TR>
        <TD colspan="2" style="HEIGHT: 11px"/>
      </TR>
      <TR>
	<TD colspan="2" style="HEIGHT: 27px" vAlign="top" align="center">
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

<xsl:template name="table">
  <xsl:param name="imgBaseUrl" select="''"/>
  <xsl:param name="filename" select="''"/>

  <table id="tblResults" class="tbllb" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <TD valign="top" align="left">   
	<div id="d1" style=" OVERFLOW-Y: scroll; OVERFLOW: scroll; WIDTH: 375px; HEIGHT: 200px">
	  <div id="d2" style=" OVERFLOW:visible; WIDTH:500px">
	    <table id="dtlResults" cellspacing="0" cellpadding="3" rules="cols" bordercolor="#999999" border="1" style="color:Black;background-color:White;border-color:#999999;border-width:1px;border-style:Solid;border-collapse:collapse;">
	      <tr>
		<td style="color:White;background-color:LightGrey;font-weight:bold;">
		  <span class="v7bbold" style="width:25px;VERTICAL-ALIGN: top">#</span>
		  <span class="v7bbold" style="width:200px;VERTICAL-ALIGN: top">Name</span>
		  <span class="v7bbold" style="width:60px;VERTICAL-ALIGN: top">Remove</span>
		</td>
	      </tr>

    <tr>
      <td>
        <xsl:attribute name="style">
          <xsl:value-of select="'background-color:#CCCCCC;'"/>
        </xsl:attribute>
        <span class="v7b" style="width:25px;VERTICAL-ALIGN: top"><xsl:value-of select="'1'"/></span>
        <span class="v7b" style="width:200px;VERTICAL-ALIGN: top"><xsl:value-of select="'DRI BUICK'"/></span>
        <span class="v7b" style="width:60px;VERTICAL-ALIGN: top">
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;X&#160;</font>
          </a>&#160;
        </span>  
       </td>
     </tr>

    <tr>
      <td>
        <xsl:attribute name="style">
          <xsl:value-of select="'background-color:#FFFFFF;'"/>
        </xsl:attribute>
        <span class="v7b" style="width:25px;VERTICAL-ALIGN: top"><xsl:value-of select="'2'"/></span>
        <span class="v7b" style="width:200px;VERTICAL-ALIGN: top"><xsl:value-of select="'DRI PONTIAC'"/></span>
        <span class="v7b" style="width:60px;VERTICAL-ALIGN: top">
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;X&#160;</font>
          </a>&#160;
        </span>  
       </td>
     </tr>

  	    </table>
	  </div>
	</div>
      </TD>
    </tr>
  </table>
</xsl:template>

</xsl:stylesheet>
