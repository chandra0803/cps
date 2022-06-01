<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.3 $

$Log: attributes.xsl,v $
Revision 1.3  2004/11/05 14:45:37  zz0qx3
changes post 11/4 review

Revision 1.2  2004/10/27 21:02:24  zz0qx3
changes this week

Revision 1.1  2004/10/25 15:30:56  vz86k2
check in

Revision 1.2  2004/10/06 20:26:12  vz86k2
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

  <TABLE cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" >
    <tbody>
      <TR>
        <TD>
          <xsl:call-template name="attr">
            <xsl:with-param name="title" select="'Down'"/>
            <xsl:with-param name="a1" select="'D-H Customer Code (dhcustcode)'"/>
            <xsl:with-param name="a2" select="'D-H Customer Part Number (dhcpn)'"/>
          </xsl:call-template>
        </TD>
        <TD>
          <xsl:call-template name="attr">
            <xsl:with-param name="title" select="'Across'"/>
            <xsl:with-param name="a1" select="'Year (year)'"/>
            <xsl:with-param name="a2" select="'Model Run Year (modelrun)'"/>
          </xsl:call-template>
        </TD>
      </TR>
    </tbody>
  </TABLE>     
  <TABLE cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <tbody>
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

<xsl:template name="attr">
  <xsl:param name="imgBaseUrl" select="''"/>
  <xsl:param name="a1" select="''"/>
  <xsl:param name="a2" select="''"/>
  <xsl:param name="title" select="''"/>

  <TABLE cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px">Select <xsl:value-of select="$title"/> Attributes</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD>
          <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
            <TR>
              <TD style="HEIGHT: 27px" align="left">Select Attribute:&#160;</TD>
            </TR>
            <TR>
              <TD>
            <select name="attribute" size="3" multiple="true">
              <option value="0"><xsl:value-of select="$a1"/></option>
              <option value="1"><xsl:value-of select="$a2"/></option>
              <option value="0">cva</option>
              <option value="0"><xsl:value-of select="$a1"/></option>
              <option value="0"><xsl:value-of select="$a1"/></option>
            </select>
              </TD>
            </TR>
            <TR>
              <TD style="HEIGHT: 32px" align="left">
              <!--
                <span style="VERTICAL-ALIGN: bottom">
                <font face="symbol"><b>S</b></font>:&#160;<input type="checkbox"/>&#160;Repeat:&#160;<input type="checkbox"/>&#160;
                </span>
              -->
                <select name="display" size="1">
              <option value="0">Name</option>
              <option value="1">Name/Alias</option>
              <option value="2">Alias/Name</option>
              <option value="3">Alias</option>
              <option value="3">Shortest</option>
                </select>

                &#160;&#160;&#160;

                <a class="button" href="javascript:addAttributes()">
                  <font class="v8w">&#160;ADD&#160;</font>
                </a>
              </TD>
            </TR>
          </TABLE>
        </TD>
      </TR> 
      <TR>  
	<TD>
          <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
            <TR>
              <TD style="HEIGHT: 27px" align="left">Attributes:&#160;</TD>
            </TR>
            <TR>
              <TD>
                <xsl:call-template name="table">
                  <xsl:with-param name="a1" select="$a1"/>
                  <xsl:with-param name="a2" select="$a2"/>
                </xsl:call-template>
              </TD>
            </TR>
          </TABLE>
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
  <xsl:param name="a1" select="''"/>
  <xsl:param name="a2" select="''"/>

  <table id="tblResults" class="tbllb" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <TD valign="top" align="left">   
	<div id="d1" style=" OVERFLOW-Y: scroll; OVERFLOW: scroll; WIDTH: 375px; HEIGHT: 200px">
	  <div id="d2" style=" OVERFLOW:visible; WIDTH:575px">
	    <table id="dtlResults" cellspacing="0" cellpadding="3" rules="cols" bordercolor="#999999" border="1" style="color:Black;background-color:White;border-color:#999999;border-width:1px;border-style:Solid;border-collapse:collapse;">
	      <tr>
		<td style="color:White;background-color:LightGrey;font-weight:bold;">
		  <span class="v7bbold" style="width:25px;VERTICAL-ALIGN: top">#</span>
		  <span class="v7bbold" style="width:125px;VERTICAL-ALIGN: top">Attribute</span>
		  <span class="v7bbold" style="width:30px;VERTICAL-ALIGN: top"><font face="symbol" size="3"><b>S</b></font></span>
		  <span class="v7bbold" style="width:60px;VERTICAL-ALIGN: top">Repeat</span>
		  <span class="v7bbold" style="width:130px;VERTICAL-ALIGN: top">Display</span>
		  <span class="v7bbold" style="width:90px;VERTICAL-ALIGN: top">Order</span>
		  <span class="v7bbold" style="width:60px;VERTICAL-ALIGN: top">Remove</span>
		</td>
	      </tr>

              <xsl:call-template name="Attribute">
                <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
                <xsl:with-param name="columnNum" select="'1'"/>
                <xsl:with-param name="name" select="$a1"/>
                <xsl:with-param name="dTotal" select="'true'"/>
                <xsl:with-param name="dFName" select="'true'"/>
              </xsl:call-template>

              <xsl:call-template name="Attribute">
                <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
                <xsl:with-param name="columnNum" select="'2'"/>
                <xsl:with-param name="name" select="$a2"/>
                <xsl:with-param name="dTotal" select="'true'"/>
                <xsl:with-param name="dFName" select="'true'"/>
              </xsl:call-template>

<!--
              <xsl:apply-templates select="../Model/Session/AdHocReport/TopAttributes/Attribute">
                <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              </xsl:apply-templates>  
-->
  	    </table>
	  </div>
	</div>
      </TD>
    </tr>
  </table>

</xsl:template>

<!--
<xsl:template match="Attribute">
  <xsl:param name="imgBaseUrl" select="''"/>

    <xsl:variable name="columnNum" select="@id"/>
    <xsl:variable name="name" select="Name"/>
    <xsl:variable name="dTotal" select="@displayTotal"/>
    <xsl:variable name="dFName" select="@displayFullName"/>

    <xsl:variable name="row" select="(position() mod 2)"/>
-->
<xsl:template name="Attribute">
  <xsl:param name="imgBaseUrl" select="''"/>
  <xsl:param name="columnNum" select="''"/>
  <xsl:param name="name" select="''"/>
  <xsl:param name="dTotal" select="''"/>
  <xsl:param name="dFName" select="''"/>

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
        <span class="v7b" style="width:25px;VERTICAL-ALIGN: top"><xsl:value-of select="$columnNum"/></span>
        <span class="v7b" style="width:125px;VERTICAL-ALIGN: top"><xsl:value-of select="$name"/></span>
        <span class="v7b" style="width:30px;VERTICAL-ALIGN: top">
          <input type="checkbox" name="displayTotal{$columnNum}">
            <xsl:if test="$dTotal = 'true'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
        </span>
        <span class="v7b" style="width:60px;VERTICAL-ALIGN: top">
          <input type="checkbox" name="x" checked="checked"/>
        </span>
        <span class="v7b" style="width:130px;VERTICAL-ALIGN: top">
                <select name="display" size="1">
              <option value="0">Name</option>
              <option value="1">Name/Alias</option>
              <option value="2">Alias/Name</option>
              <option value="3">Alias</option>
              <option value="3">Shortest</option>
                </select>
<!--
          <input type="checkbox" name="displayFullName{$columnNum}">
            <xsl:if test="$dFName = 'true'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
-->
        </span>
        <span class="v7b" style="width:90px;VERTICAL-ALIGN: top">
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;UP&#160;</font>
          </a>&#160;
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;DOWN&#160;</font>
          </a>
        </span>
        <span class="v7b" style="width:60px;VERTICAL-ALIGN: top">
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;X&#160;</font>
          </a>&#160;
        </span>  
       </td>
     </tr>

</xsl:template>

</xsl:stylesheet>
