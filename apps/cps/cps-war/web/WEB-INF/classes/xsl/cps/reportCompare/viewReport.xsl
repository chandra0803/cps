<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../floatingWin.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.2 $

$Log: viewReport.xsl,v $
Revision 1.2  2004/11/05 14:45:38  zz0qx3
changes post 11/4 review

Revision 1.1  2004/11/04 16:58:51  zz0qx3
mass update 11/4

Revision 1.10  2004/10/28 15:40:42  zz0qx3
updates

Revision 1.9  2004/10/19 13:39:15  zz0qx3
updates post review

Revision 1.8  2004/10/13 20:25:16  zz0qx3
chpt

Revision 1.7  2004/10/12 20:28:36  zz0qx3
create automation

Revision 1.6  2004/10/11 17:15:35  zz0qx3
chpr

Revision 1.4  2004/10/08 18:51:59  zz0qx3
chpt without grid code

Revision 1.3  2004/10/07 15:24:00  zz0qx3
CHPT including grid sample (initial)

Revision 1.2  2004/10/06 18:15:02  zz0qx3
checkpt

Revision 1.1  2004/10/06 14:04:54  zz0qx3
Path corrections

Revision 1.2  2004/10/05 18:30:25  zz0qx3
export file prototype

Revision 1.1  2004/09/24 17:04:42  vz86k2
check in

Revision 1.1  2004/07/23 19:17:41  vz86k2
check in


-->

<xsl:variable name="javaScriptBaseUrl" select="Screen/Model/Entity/JavaScriptBaseUrl"/>
<xsl:variable name="htmlBaseUrl" select="Screen/Model/Entity/HtmlBaseUrl"/>


<xsl:template name="LocalScript">
  <script type="text/javascript" language="javascript">

    function pageLoaded()
    {

    }

    function showEditDiv(currentVal, cellName)
    {
    }
    function hideEditDiv()
    {
    }

    function showPercentDiv()
    {
    }
    function hidePercentDiv()
    {
    }


  </script>
</xsl:template>



<xsl:template match="View">
  <xsl:param name="imgBaseUrl" select="''"/>

<table bgcolor="#99CCCC" height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
<tr><td>File A</td><td>File B</td><td>Variance</td></tr>

<tr><td><xsl:apply-templates select="Grid[@id='1']"><xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/></xsl:apply-templates ></td><td><xsl:apply-templates   select="Grid[@id='2']"><xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/></xsl:apply-templates></td><td><xsl:apply-templates   select="Grid[@id='3']"><xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/></xsl:apply-templates></td></tr>

<tr height="40px"><td>Note: the grid component above should not have scroll bars for each grid, rather the grids should scroll together with a single row header on the left</td><td>&#160;</td><td>&#160;</td></tr>
</table>
</xsl:template>


<xsl:template match="Grid">
  <xsl:param name="imgBaseUrl" select="''"/>

  <xsl:variable name="sliderWidth" select="14"/>
  <xsl:variable name="deleteColumnWidth" select="24"/>
  <xsl:variable name="tableWidth" select="$deleteColumnWidth + sum(ColumnHeaderResultSet[@row='1']/ColumnHeader/width)"/>
  <xsl:variable name="headerWidth" select="$sliderWidth + $tableWidth"/>
  <xsl:variable name="headerHeight" select="count(ColumnHeaderResultSet) * 25"/>

  <table  style="background-color: #99CCCC; width:{$headerWidth}px; height:300px" border="0" cellpadding="0" cellspacing="0">
    
    <tr style="width: {$headerWidth}px; height: 300px;">
      <TD style="width: {$headerWidth}px; height: 300px;">

          <div id="columnHeaders" style="VERTICAL-ALIGN: bottom; OVERFLOW-Y: hidden; OVERFLOW: hidden; width:{$tableWidth}px; height:{$headerHeight}px">
            <table id="grid" style="VERTICAL-ALIGN: bottom;" width="100%" border="1" cellpadding="0" cellspacing="0">
            
          <xsl:apply-templates select="ColumnHeaderResultSet">
            <xsl:with-param name="sliderWidth" select="$sliderWidth"/>
            <xsl:with-param name="deleteColumnWidth" select="$deleteColumnWidth"/>
          </xsl:apply-templates>
            
            </table>
          </div>

          <div id="chart" style="background-color: #ffffff; OVERFLOW-X: hidden; OVERFLOW: scroll; width:{$headerWidth}px; height:300px">
            <table id="grid"  width="{$headerWidth}px" border="1" cellpadding="0" cellspacing="0">

              <xsl:apply-templates select="ComponentDetailResultSet/ComponentDetail">
                <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
                <xsl:with-param name="sliderWidth" select="$sliderWidth"/>
                <xsl:with-param name="deleteColumnWidth" select="$deleteColumnWidth"/>
              </xsl:apply-templates>
            </table>
          </div>
      </TD>
    </tr>
  </table>
</xsl:template>





<xsl:template match="ColumnHeaderResultSet">
  <xsl:param name="imgBaseUrl" select="''"/>
  <xsl:param name="sliderWidth" select="''"/>
  <xsl:param name="deleteColumnWidth" select="''"/>

    <tr style="height: 25px;">
      <xsl:apply-templates select="ColumnHeader"/>
    </tr>
</xsl:template>


<xsl:template match="ColumnHeader">
  <xsl:param name="imgBaseUrl" select="''"/>

  <xsl:variable name="width" select="width"/>
  <TD class="TableHeader" style="width: {$width}px;">
    <xsl:attribute name="colspan"><xsl:value-of select="span"/></xsl:attribute>
    <xsl:value-of select="text"/>&#160;
  </TD>
</xsl:template>


<xsl:template match="ComponentDetail">
  <xsl:param name="imgBaseUrl" select="''"/>
  <xsl:param name="sliderWidth" select="''"/>
  <xsl:param name="deleteColumnWidth" select="''"/>

    <tr style="height: 25px;">
      <xsl:apply-templates select="col">
        <xsl:with-param name="sliderWidth" select="$sliderWidth"/>
      </xsl:apply-templates>
    </tr>
</xsl:template>

<xsl:template match="col">
  <xsl:param name="imgBaseUrl" select="''"/>
  <xsl:param name="sliderWidth" select="''"/>

  <xsl:variable name="colPos" select="position() "/>

  <xsl:variable name="width" select="../../../ColumnHeaderResultSet[@row = '1']/ColumnHeader[$colPos]/width"/>
  <xsl:variable name="cellWidth">
    <xsl:choose>
      <xsl:when test="position() = last()"><xsl:value-of select="$width + $sliderWidth"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$width"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <TD style="width: {$cellWidth}px;" ondblclick="javascript:showEditDiv('{.}', 'Y');"><xsl:value-of select="."/>&#160;</TD>
</xsl:template>
















</xsl:stylesheet>
