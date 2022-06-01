<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:import href="../commonCriteria.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.4 $

$Log: selectCriteria.xsl,v $
Revision 1.4  2004/11/05 14:45:36  zz0qx3
changes post 11/4 review

Revision 1.3  2004/11/04 16:58:53  zz0qx3
mass update 11/4

Revision 1.2  2004/10/25 20:50:49  zz0qx3
added filtering

Revision 1.1  2004/10/25 13:23:18  zz0qx3
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
    <tr>
      <td  style="height: 7px;">&#160;</td>
    </tr>


    </tbody>
  </TABLE>

  <table id="tblResults" class="tbllb" width="100%" border="0" cellpadding="0" cellspacing="0">

   <tr>
      <TD valign="top"><font class="v7aquaABoldItalic">Match Attributes</font></TD>
      <TD valign="top"><font class="v7aquaABoldItalic">Add Attributes</font></TD>
    </tr>

    <tr>
      <TD valign="middle" align="left">
          <select name="fileType" multiple="true" size="3" style="width:200px;">
            <xsl:call-template name="PivotAttributeOption">
              <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              <xsl:with-param name="attributes" select="PivotAttributeResultSet/PivotAttribute[@selected='matchRemain']"/>
            </xsl:call-template>
          </select> &#160;
          <a class="button" href="javascript:selectAll()">
            <font class="v8w">&#160;ADD&#160;</font>
          </a>
      </TD>
      <TD valign="middle" align="left">
          <select name="fileType" multiple="true" size="3" style="width:200px;">
            <xsl:call-template name="PivotAttributeOption">
              <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              <xsl:with-param name="attributes" select="PivotAttributeResultSet/PivotAttribute[@selected='allocRemain']"/>
            </xsl:call-template>
          </select> &#160;
          <a class="button" href="javascript:selectAll()">
            <font class="v8w">&#160;ADD&#160;</font>
          </a>
      </TD>
    </tr>

    <tr>
      <td colspan="3" style="height: 3px;">&#160;</td>
    </tr>

 
    <tr valign="top">

      <td valign="top">
      <table border="1">
            <xsl:call-template name="PivotAttributeSelected">
              <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              <xsl:with-param name="attributes" select="PivotAttributeResultSet/PivotAttribute[@selected='matchSelected']"/>
            </xsl:call-template>
      </table>
      </td>

      <td valign="top">
      <table border="1">
            <xsl:call-template name="PivotAttributeSelected">
              <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              <xsl:with-param name="delete" select="'Y'"/>
              <xsl:with-param name="attributes" select="PivotAttributeResultSet/PivotAttribute[@selected='allocSelected']"/>
            </xsl:call-template>
      </table>
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
        <span class="v7bbold" style="width:120px;VERTICAL-ALIGN: top">Name</span>
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
        <span class="v7b" style="width:120px;VERTICAL-ALIGN: top"><xsl:value-of select="$longName"/></span>
        <span class="v7b" style="width:50px;VERTICAL-ALIGN: top"><img alt="delete" src="{$imgBaseUrl}/buttons/delete.gif" border="0"/></span>
       </td>
     </tr>
  </xsl:for-each>

</xsl:template>


</xsl:stylesheet>
