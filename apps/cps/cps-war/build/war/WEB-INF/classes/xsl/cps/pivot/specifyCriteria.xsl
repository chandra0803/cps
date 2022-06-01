<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:import href="../commonCriteria.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.5 $

$Log: specifyCriteria.xsl,v $
Revision 1.5  2004/11/05 14:45:37  zz0qx3
changes post 11/4 review

Revision 1.4  2004/10/25 13:23:16  zz0qx3
tweaks for allocation

Revision 1.3  2004/10/13 20:25:15  zz0qx3
chpt

Revision 1.2  2004/10/06 18:01:24  zz0qx3
checkpt

Revision 1.1  2004/10/06 14:04:54  zz0qx3
Path corrections

Revision 1.2  2004/10/05 18:30:26  zz0qx3
export file prototype


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
	<TD style="HEIGHT: 22px">Select Pivot Table Criteria</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD vAlign="top">
          <a class="button" href="javascript:selectAll()">
            <font class="v8w">&#160;CONTINUE&#160;</font>
          </a>
        </TD> 
      </TR>

    </tbody>
  </TABLE>

  <table id="tblResults" class="tbllb" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <TD valign="top"><font class="v7aquaABoldItalic">Down</font></TD><TD valign="top"><font class="v7aquaABoldItalic">Across</font></TD>
    </tr>
    <tr>
      <TD valign="middle" align="left">
          <select name="fileType" size="1" style="height:27px;width:200px;">
            <xsl:call-template name="PivotAttributeOption">
              <xsl:with-param name="attributes" select="PivotAttributeResultSet/PivotAttribute[@selected='no']"/>
            </xsl:call-template>
          </select> &#160;
          <a class="button" href="javascript:selectAll()">
            <font class="v8w">&#160;ADD&#160;</font>
          </a>

      </TD>
      <TD valign="middle" align="left">
          <select name="fileType" size="1" style="height:27px;width:200px;">
            <xsl:call-template name="PivotAttributeOption">
              <xsl:with-param name="attributes" select="PivotAttributeResultSet/PivotAttribute[@selected='no']"/>
            </xsl:call-template>
          </select> &#160;
          <a class="button" href="javascript:selectAll()">
            <font class="v8w">&#160;ADD&#160;</font>
          </a>
      </TD>
    </tr>

    <tr>
      <td colspan="2" style="height: 27px;">&#160;</td>
    </tr>

    <tr valign="top">
      <td valign="top">
      <table border="1">
            <xsl:call-template name="PivotAttributeSelected">
              <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              <xsl:with-param name="attributes" select="PivotAttributeResultSet/PivotAttribute[@selected='down']"/>
            </xsl:call-template>
      </table>
      </td>

      <td valign="top">
      <table border="1">
            <xsl:call-template name="PivotAttributeSelected">
              <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              <xsl:with-param name="attributes" select="PivotAttributeResultSet/PivotAttribute[@selected='across']"/>
            </xsl:call-template>
      </table>
      </td>
    </tr>

    <tr>
      <td colspan="2" style="height: 27px;">&#160;</td>
    </tr>

    <tr>
      <td colspan="2" style="height: 27px;">

      <xsl:call-template name="Criteria">
        <xsl:with-param name="addSectionTitle" select="'Add Pivot Table Filter Criteria'"/>
        <xsl:with-param name="tableSectionTitle" select="'Filter Criteria'"/>
      </xsl:call-template>
    </td>
    </tr>


  </table>



</xsl:template>

<xsl:template name="PivotAttributeOption">
  <xsl:param name="attributes" select="/.."/>

  <xsl:for-each select="$attributes">
    <option value="{id}"><xsl:value-of select="lname"/></option>
  </xsl:for-each>
</xsl:template>


<xsl:template name="PivotAttributeSelected">
  <xsl:param name="imgBaseUrl" select="''"/>
  <xsl:param name="attributes" select="/.."/>

    <tr>
      <td class="TableHeader">
        <span class="v7bbold" style="width:150px;VERTICAL-ALIGN: top">Name</span>
        <span class="v7bbold" style="width:50px;VERTICAL-ALIGN: top"><img alt="Sigma" src="{$imgBaseUrl}/buttons/sigma.gif" border="0"/></span>
        <span class="v7bbold" style="width:110px;VERTICAL-ALIGN: top">Display</span>
        <span class="v7bbold" style="width:50px;VERTICAL-ALIGN: top">Delete</span>
       </td>
     </tr>


  <xsl:for-each select="$attributes">

    <xsl:variable name="columnNum" select="id"/>
    <xsl:variable name="shortName" select="sname"/>
    <xsl:variable name="longName" select="lname"/>

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
        <span class="v7b" style="width:150px;VERTICAL-ALIGN: top"><xsl:value-of select="$longName"/></span>
        <span class="v7b" style="width:50px;VERTICAL-ALIGN: top"><input type="checkbox" checked="true"/></span>
        <span class="v7b" style="width:110px;VERTICAL-ALIGN: top">
            <select name="attribute" size="1">
              <option value="0">Name</option>
              <option value="3">Alias</option>
            </select>

        </span>
        <span class="v7b" style="width:50px;VERTICAL-ALIGN: top"><img alt="delete" src="{$imgBaseUrl}/buttons/delete.gif" border="0"/></span>

       </td>
     </tr>
  </xsl:for-each>

</xsl:template>


</xsl:stylesheet>
