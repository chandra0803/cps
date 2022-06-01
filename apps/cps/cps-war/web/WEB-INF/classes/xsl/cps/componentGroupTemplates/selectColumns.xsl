<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.1 $

$Log: selectColumns.xsl,v $
Revision 1.1  2004/10/14 21:15:56  zz0qx3
added component groups, other tweaks


-->

<xsl:variable name="javaScriptBaseUrl" select="Screen/Model/Entity/JavaScriptBaseUrl"/>
<xsl:variable name="htmlBaseUrl" select="Screen/Model/Entity/HtmlBaseUrl"/>


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
	      <TD style="HEIGHT: 22px" colSpan="2">Select Template Columns</TD>
      </TR>
    </thead>
    <tbody>
<tr>
<td align="center" valign="top">
Select Component Columns<p/>
  <select name="fileType" style="width:200px;"  multiple="true" size="6">
    <xsl:call-template name="ColumnSelectedOption">
      <xsl:with-param name="attributes" select="ColumnSelectedResultSet/ColumnSelected[@selected='no']"/>
    </xsl:call-template>
  </select> &#160;
<p/>
<a class="button" href="javascript:addAttributes()">
  <font class="v8w">&#160;ADD COMPONENT(S)&#160;</font>
</a>
<p/>

  <table border="1">
        <xsl:call-template name="ColumnSelected">
          <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
          <xsl:with-param name="attributes" select="ColumnSelectedResultSet/ColumnSelected[@selected='component']"/>
        </xsl:call-template>
  </table>
</td>

<td align="center" valign="top">
Select Match Columns<p/>
  <select name="fileType" style="width:200px;"  multiple="true" size="6">
    <xsl:call-template name="ColumnSelectedOption">
      <xsl:with-param name="attributes" select="ColumnSelectedResultSet/ColumnSelected[@selected='no']"/>
    </xsl:call-template>
  </select> &#160;
<p/>
<a class="button" href="javascript:addAttributes()">
  <font class="v8w">&#160;ADD MATCH(ES)&#160;</font>
</a>
<p/>

  <table border="1">
        <xsl:call-template name="ColumnSelected">
          <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
          <xsl:with-param name="attributes" select="ColumnSelectedResultSet/ColumnSelected[@selected='match']"/>
        </xsl:call-template>
  </table>



</td>
</tr>
<tr>
<td colspan="2" height="27px" >&#160;</td></tr>


<tr>
<td colspan="2" align="center">
<a class="button" href="javascript:next()">
<font class="v8w">&#160;NEXT&#160;</font>
</a>
</td>
</tr>

    
    </tbody>
  </TABLE> 
</xsl:template>


<xsl:template name="ColumnSelectedOption">
  <xsl:param name="attributes" select="/.."/>

  <xsl:for-each select="$attributes">
    <option value="{id}"><xsl:value-of select="lname"/></option>
  </xsl:for-each>
</xsl:template>



<xsl:template name="ColumnSelected">
  <xsl:param name="imgBaseUrl" select="''"/>
  <xsl:param name="attributes" select="/.."/>

    <tr>
      <td class="TableHeader">
        <span class="v7bbold" style="width:120px;VERTICAL-ALIGN: top">Name</span>
        <span class="v7bbold" style="width:110px;VERTICAL-ALIGN: top">Display</span>
        <span class="v7bbold" style="width:50px;VERTICAL-ALIGN: top">Delete</span>
        <span class="v7bbold" style="width:110px;VERTICAL-ALIGN: top">Sort</span>
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
        <span class="v7b" style="width:110px;VERTICAL-ALIGN: top">
            <select name="attribute" size="1">
              <option value="0">Name</option>
              <option value="1">Name/Alias</option>
              <option value="2">Alias/Name</option>
              <option value="3">Alias</option>
            </select>

        </span>
        <span class="v7b" style="width:50px;VERTICAL-ALIGN: top"><img alt="delete" src="{$imgBaseUrl}/buttons/delete.gif" border="0"/></span>
        <span class="v7b" style="width:110px;VERTICAL-ALIGN: top"><a class="button" href="javascript:selectSourceFile()"><font class="v8w">&#160;DOWN&#160;</font></a>&#160;<a class="button" href="javascript:selectSourceFile()"><font class="v8w">&#160;UP&#160;</font></a></span>

       </td>
     </tr>
  </xsl:for-each>

</xsl:template>




</xsl:stylesheet>
