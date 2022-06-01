<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.2 $

$Log: downAttributes.xsl,v $
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

  <TABLE cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="2">Select Vertical Report Attributes</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD>
          <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
            <TR>
              <TD style="HEIGHT: 27px" align="left">Select Attributes:&#160;</TD>
            </TR>
            <TR>
              <TD>
            <select name="attribute" multiple="true" size="6">
              <option value="0">D-H Customer Code (dhcustcode)</option>
              <option value="1">D-H Customer Descriptions (dhcustdescr)</option>
              <option value="2">D-H Customer Part Number (dhcpn)</option>
              <option value="3">D-H Divisional Buyer Code (dhbuyercode)</option>
              <option value="4">D-H DPN Descriptions (dhdpndescr)</option>
              <option value="5">D-H xxx</option>
              <option value="6">D-H xxx</option>
              <option value="7">D-H xxx</option>
              <option value="8">D-H xxx</option>
              <option value="9">D-H xxx</option>
              <option value="10">D-H xxx</option>
              <option value="11">D-H xxx</option>
              <option value="12">D-H xxx</option>
              <option value="13">D-H xxx</option>
            </select>
              </TD>
            </TR>
            <TR>
              <TD style="HEIGHT: 32px" align="center">
          <a class="button" href="javascript:addAttributes()">
            <font class="v8w">&#160;ADD ATTRIBUTE(S)&#160;</font>
          </a>
              </TD>
            </TR>
          </TABLE>
        </TD>
	<TD>
          <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
            <TR>
              <TD style="HEIGHT: 27px" align="left">Report Attributes:&#160;</TD>
            </TR>
            <TR>
              <TD>
                <xsl:call-template name="table"/>
              </TD>
            </TR>
            <TR>
              <TD style="HEIGHT: 32px" align="center">
              <a class="button" href="javascript:addAttributes()">
                <font class="v8w">&#160;SELECT ALL&#160;</font>
              </a>&#160;
              <a class="button" href="javascript:addAttributes()">
                <font class="v8w">&#160;REMOVE SELECTED&#160;</font>
              </a>&#160;
              <a class="button" href="javascript:addAttributes()">
                <font class="v8w">&#160;SAVE OPTIONS&#160;</font>
              </a>
              </TD>
            </TR>
          </TABLE>
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

<xsl:template name="table">
  <xsl:param name="imgBaseUrl" select="''"/>

  <table id="tblResults" class="tbllb" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <TD valign="top" align="left">   
	<div id="d1" style=" OVERFLOW-Y: scroll; OVERFLOW: scroll; WIDTH: 375px; HEIGHT: 200px">
	  <div id="d2" style=" OVERFLOW:visible; WIDTH:425px">
	    <table id="dtlResults" cellspacing="0" cellpadding="3" rules="cols" bordercolor="#999999" border="1" style="color:Black;background-color:White;border-color:#999999;border-width:1px;border-style:Solid;border-collapse:collapse;">
	      <tr>
		<td style="color:White;background-color:LightGrey;font-weight:bold;">
		  <span class="v7bbold" style="width:35px;VERTICAL-ALIGN: top">Select</span>
		  <span class="v7bbold" style="width:25px;VERTICAL-ALIGN: top">#</span>
		  <span class="v7bbold" style="width:125px;VERTICAL-ALIGN: top">Attribute</span>
		  <span class="v7bbold" style="width:50px;VERTICAL-ALIGN: top">Display Total</span>
		  <span class="v7bbold" style="width:50px;VERTICAL-ALIGN: top">Display Full Name</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Order</span>
		</td>
	      </tr>
              <xsl:apply-templates select="../Model/Session/AdHocReport/TopAttributes/Attribute">
                <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              </xsl:apply-templates>  
  	    </table>
	  </div>
	</div>
      </TD>
    </tr>
  </table>

</xsl:template>

<xsl:template match="Attribute">
  <xsl:param name="imgBaseUrl" select="''"/>

    <xsl:variable name="columnNum" select="@id"/>
    <xsl:variable name="name" select="Name"/>
    <xsl:variable name="dTotal" select="@displayTotal"/>
    <xsl:variable name="dFName" select="@displayFullName"/>

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
        <span class="v7b" style="width:35px;VERTICAL-ALIGN: top"><input type="checkbox" name="edit{$columnNum}"/></span>
        <span class="v7b" style="width:25px;VERTICAL-ALIGN: top"><xsl:value-of select="$columnNum"/></span>
        <span class="v7b" style="width:125px;VERTICAL-ALIGN: top"><xsl:value-of select="$name"/></span>
        <span class="v7b" style="width:50px;VERTICAL-ALIGN: top">
          <input type="checkbox" name="displayTotal{$columnNum}">
            <xsl:if test="$dTotal = 'true'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
        </span>
        <span class="v7b" style="width:50px;VERTICAL-ALIGN: top">
          <input type="checkbox" name="displayFullName{$columnNum}">
            <xsl:if test="$dFName = 'true'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
        </span>
        <span class="v7b" style="width:100px;VERTICAL-ALIGN: top">
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;UP&#160;</font>
          </a>&#160;
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;DOWN&#160;</font>
          </a>
        </span>
       </td>
     </tr>

</xsl:template>

</xsl:stylesheet>
