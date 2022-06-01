<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.4 $

$Log: defineCriteria.xsl,v $
Revision 1.4  2004/10/25 17:41:43  zz0qx3
updates

Revision 1.3  2004/10/19 18:35:43  zz0qx3
added edit template

Revision 1.2  2004/10/15 14:50:05  zz0qx3
checkpoint

Revision 1.1  2004/10/14 21:15:56  zz0qx3
added component groups, other tweaks

 
-->

<xsl:variable name="javaScriptBaseUrl" select="Screen/Model/Entity/JavaScriptBaseUrl"/>
<xsl:variable name="htmlBaseUrl" select="Screen/Model/Entity/HtmlBaseUrl"/>


<xsl:template name="LocalScript">
  <script type="text/javascript" language="javascript">

    function pageLoaded()
    {
      document.all['editDiv'].style.posLeft  = 600;
      document.all['editDiv'].style.posTop = 250;
    }

    function showEditDiv(currentVal, cellName)
    {
      document.getElementById('valueEditField').value = currentVal
      document.all['editDiv'].style.visibility  = 'visible';
    }
    function hideEditDiv()
    {
      document.all['editDiv'].style.visibility  = 'hidden';
    }


  </script>


</xsl:template>

<xsl:template match="View">
  <xsl:param name="imgBaseUrl" select="''"/>

  <TABLE id="Table1" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px">&#160;</TD>
      </TR>
    </thead>

     <tbody>
      <TR> 
	<TD  style="HEIGHT: 27px" vAlign="top" align="left">
  <a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;BACK&#160;</font></a>&#160;&#160;
  <a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;DELETE SELECTED&#160;</font></a>&#160;&#160;
  <a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;APPLY CHANGES&#160;</font></a>&#160;&#160;
  
  <a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;SAVE&#160;</font></a>&#160;&#160;
  </TD>
      </TR>
    </tbody>
  </TABLE>

<span id="editDiv" class="absoluteHidden">
<form id="editDivForm" name="editDivForm" action="/" method="post">
<table cellspacing="1" callpadding="1" border="1" style="background-color: #99CCCC; width:150px; height:75px; align: center;">
<tr>
  <td class="TableHeader"><i>Edit Cell Value</i></td>
</tr>
<tr>
  <td><center>
    <input type="text" name="valueEditField" value="123" length="25"/><br/>&#160;<br/>
<a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;APPLY&#160;</font></a>&#160;&#160;
<a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;CANCEL&#160;</font></a>
  </center></td>
</tr>
</table>
    </form>
</span>

  <xsl:variable name="sliderWidth" select="14"/>
  <xsl:variable name="deleteColumnWidth" select="24"/>
  <xsl:variable name="tableWidth" select="$deleteColumnWidth + sum(ColumnHeaderResultSet[@row='2']/ColumnHeader/width)"/>
  <xsl:variable name="headerWidth" select="$sliderWidth + $tableWidth"/>
  <xsl:variable name="headerHeight" select="count(ColumnHeaderResultSet) * 25"/>

  <table  style="background-color: #99CCCC; width:{$headerWidth}px; height:500px" border="0" cellpadding="0" cellspacing="0">
    
    <tr style="width: {$headerWidth}px; height: 500px;">
      <TD style="width: {$headerWidth}px; height: 500px;">

          <div id="columnHeaders" style="VERTICAL-ALIGN: bottom; OVERFLOW-Y: hidden; OVERFLOW: hidden; width:{$tableWidth}px; height:{$headerHeight}px">
            <table id="grid" style="VERTICAL-ALIGN: bottom;" width="100%" border="1" cellpadding="0" cellspacing="0">
            
          <xsl:apply-templates select="ColumnHeaderResultSet">
            <xsl:with-param name="sliderWidth" select="$sliderWidth"/>
            <xsl:with-param name="deleteColumnWidth" select="$deleteColumnWidth"/>
          </xsl:apply-templates>
            
            </table>
          </div>

          <div id="chart" style="background-color: #ffffff; OVERFLOW-X: hidden; OVERFLOW: scroll; width:{$headerWidth}px; height:500px">
            <table id="grid"  width="{$headerWidth}px" border="1" cellpadding="0" cellspacing="0">

    <tr style="height: 25px;">
      <TD class="TableHeader" style="width: {$deleteColumnWidth}px;">&#160;</TD>
      <TD class="TableHeader" style="width: 50px;"><a class="button" href="javascript:hideEditDiv()"><font class="v8w">&#160;ADD&#160;</font></a></TD>
      
      <xsl:for-each select="ColumnHeaderResultSet[position() = last()]/ColumnHeader[position() > 1]">
      <xsl:variable name="colWidth">
        <xsl:choose>
          <xsl:when test="position() = last()"><xsl:value-of select="width "/></xsl:when>
          <xsl:otherwise><xsl:value-of select="width"/></xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
        <TD style="width: {$colWidth}px;"><input type="text" size="7"/></TD>
      </xsl:for-each>
    </tr>


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
      <TD class="TableHeader" style="width: {$deleteColumnWidth}px;">&#160;</TD>
      <xsl:apply-templates select="ColumnHeader"/>
      <!-- <TD class="TableHeader" style="width: {$sliderWidth}px;">&#160;</TD> -->
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
      <TD class="TableHeader" style="width: {$deleteColumnWidth}px;"><input type="checkbox"/></TD>
      <TD class="TableHeader" style="width: 50px;"><xsl:value-of select="position()"/></TD>

      <xsl:apply-templates select="col">
        <xsl:with-param name="sliderWidth" select="$sliderWidth"/>
      </xsl:apply-templates>

    </tr>
</xsl:template>

<xsl:template match="col">
  <xsl:param name="imgBaseUrl" select="''"/>
  <xsl:param name="sliderWidth" select="''"/>

  <xsl:variable name="colPos" select="position() + 1"/>

  <xsl:variable name="width" select="../../../ColumnHeaderResultSet[@row = '2']/ColumnHeader[$colPos]/width"/>
  <xsl:variable name="cellWidth">
    <xsl:choose>
      <xsl:when test="position() = last()"><xsl:value-of select="$width + $sliderWidth"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="$width"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <TD style="width: {$cellWidth}px;" ondblclick="javascript:showEditDiv('{.}', 'Y');"><xsl:value-of select="."/>&#160;</TD>
</xsl:template>

</xsl:stylesheet>
