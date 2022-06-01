<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:java="http://xml.apache.org/xslt/java" version="1.0">
<xsl:import href="gridStyle.xsl"/>
<xsl:import href="gridScript.xsl"/>

<xsl:output method="html" indent="yes"/>

<!-- constants -->
<xsl:variable name="rowHeaderWidth" select="'100'"/>
<xsl:variable name="cellWidth"      select="'200'"/>
<xsl:variable name="cellHeight"     select="'32'"/>
<xsl:variable name="sliderWidth"    select="'22'"/>
<xsl:variable name="cellBorderPad"  select="'2'"/>



<xsl:template match="Grid">

<xsl:variable name="columnCount" select="count(Data/GridArray/GridRow[position() = 1]/cell)"/>
<xsl:variable name="rowCount" select="count(Data/GridArray/GridRow)"/>

<xsl:variable name="columnHeaderDepth" select="count(ColumnHeaders/GridArray/GridRow)"/>
<xsl:variable name="rowHeaderDepth" select="count(RowHeaders/GridArray/GridRow[position() = last()]/cell)"/>

<xsl:variable name="rowHeaderWidthCalculated"     select="($rowHeaderWidth * $rowHeaderDepth) + ($cellBorderPad * ($rowHeaderDepth + 1))"/>
<xsl:variable name="columnHeaderHeightCalculated" select="($cellHeight * $columnHeaderDepth) + ($cellBorderPad * ($columnHeaderDepth + 1))"/>

<xsl:call-template name="gridStyle">
  <xsl:with-param name="rowHeaderWidth"               select="$rowHeaderWidth"/>
  <xsl:with-param name="cellWidth"                    select="$cellWidth"/>
  <xsl:with-param name="cellHeight"                   select="$cellHeight"/>
  <xsl:with-param name="sliderWidth"                  select="$sliderWidth"/>
  <xsl:with-param name="cellBorderPad"                select="$cellBorderPad"/>
  <xsl:with-param name="rowHeaderWidthCalculated"     select="$rowHeaderWidthCalculated"/>
  <xsl:with-param name="columnHeaderHeightCalculated" select="$columnHeaderHeightCalculated"/>
</xsl:call-template>

<xsl:call-template name="gridScript">
  <xsl:with-param name="cellHeight"                   select="$cellHeight"/>
  <xsl:with-param name="cellWidth"                    select="$cellWidth"/>
  <xsl:with-param name="rowHeaderDepth"               select="$rowHeaderDepth"/>
  <xsl:with-param name="columnHeaderDepth"            select="$columnHeaderDepth"/>
  <xsl:with-param name="rowCount"                     select="$rowCount"/>
  <xsl:with-param name="columnCount"                  select="$columnCount"/>
  <xsl:with-param name="rowHeaderWidthCalculated"     select="$rowHeaderWidthCalculated"/>
  <xsl:with-param name="columnHeaderHeightCalculated" select="$columnHeaderHeightCalculated"/>
</xsl:call-template>


<!-- outside div -->
<div id="gridMain" class="grid-main" onresize="resizeScroll();">

	<!-- data grid div -->
  <xsl:apply-templates select="Data">
    <xsl:with-param name="rowCount"    select="$rowCount"/>
    <xsl:with-param name="columnCount" select="$columnCount"/>
  </xsl:apply-templates>
	
  <!-- top header div -->
  <xsl:apply-templates select="ColumnHeaders">
    <xsl:with-param name="rowCount"    select="$rowCount"/>
    <xsl:with-param name="columnCount" select="$columnCount"/>
  </xsl:apply-templates>

	<!-- left header div -->
  <xsl:apply-templates select="RowHeaders">
    <xsl:with-param name="rowCount"    select="$rowCount"/>
    <xsl:with-param name="columnCount" select="$columnCount"/>
  </xsl:apply-templates>

	<!-- left top corner div -->
	<div class="grid-corner" id="gridCorner"> </div>

	<!-- scroll bar div -->
	<div id="scrollDiv" class="grid-bars" onscroll="scrollAdj();" >
	  <img id="inlineClear" src="clear.gif" width="100%" height="100%"/>
	</div> 

</div>
</xsl:template>



<xsl:template match="Data">
  <xsl:param name="rowCount"    select="''"/>
  <xsl:param name="columnCount" select="''"/>

	<div class="grid-data" id="gridData">
	<table class="grid-fixed-table" id="tableData">

  <xsl:for-each select="GridArray/GridRow">
    <xsl:variable name="rowNumber" select="position()"/>
		<tr class="grid-row">
      <xsl:for-each select="cell">
        <xsl:variable name="colNumber" select="position()"/>
        <td class="grid-cell" >
          <xsl:choose>

            <xsl:when test="value/@type = 'select'">
              <xsl:call-template name="GridSelectElement">
                <xsl:with-param name="rowNumber" select="$rowNumber"/>
                <xsl:with-param name="colNumber" select="$colNumber"/>
              </xsl:call-template>
            </xsl:when>

            <xsl:otherwise>
              <input name="{@name}" id="{@name}" class="grid-text-input" type="text" value="{value}" onFocus="cellEnter('{$rowNumber}', '{$colNumber}', this);" onBlur="cellExit('{$rowNumber}', '{$colNumber}', this);" onkeydown="cellKeyPress('{$rowNumber}', '{$colNumber}', this);" onchange="cellChanged('{$rowNumber}', '{$colNumber}', this);">
                <xsl:if test="@readonly = 'true'">
                  <xsl:attribute name="readonly">true</xsl:attribute>
                </xsl:if>
                <xsl:if test="@disabled = 'true'">
                  <xsl:attribute name="disabled">true</xsl:attribute>
                </xsl:if>
              </input>
            </xsl:otherwise>
          
          </xsl:choose>
        </td>
        </xsl:for-each>
		</tr>
  </xsl:for-each>
	</table>
	</div>
</xsl:template>



<xsl:template match="ColumnHeaders">
  <xsl:param name="rowCount"    select="''"/>
  <xsl:param name="columnCount" select="''"/>

  <div class="grid-top" id="gridTop">
    <table class="grid-fixed-table"  id="tableTop">
      <xsl:for-each select="GridArray/GridRow">
        <tr class="grid-row">
          <xsl:for-each select="cell">
            <xsl:if test="@spanned = 'false'">
              <td class="grid-cell" style="width: {$cellWidth * @colSpan}" colspan="{@colSpan}" >
                <xsl:value-of select="value"/>
              </td>
            </xsl:if>
          </xsl:for-each>
        </tr>
      </xsl:for-each>
    </table>
	</div>
</xsl:template>



<xsl:template match="RowHeaders">
  <xsl:param name="rowCount"    select="''"/>
  <xsl:param name="columnCount" select="''"/>

  <!-- must correctly handle spanned header rows that have been paged -->
	<div class="grid-left" id="gridLeft" >
    <table class="grid-fixed-table"  id="tableLeft">
      <xsl:for-each select="GridArray/GridRow">
        <xsl:variable name="rowNumber" select="position()"/>
        <tr class="grid-row">
          <xsl:for-each select="cell">
            <xsl:variable name="calculatedSpan">
              <xsl:choose><xsl:when test="@rowSpan &lt; ($rowCount - $rowNumber + 1)"><xsl:value-of select="@rowSpan"/></xsl:when><xsl:otherwise><xsl:value-of select="($rowCount - $rowNumber + 1)"/></xsl:otherwise></xsl:choose>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="@spanned = 'false'">
                <td class="grid-left-cell" style="height: {$cellHeight * $calculatedSpan}" rowspan="{$calculatedSpan}">
                  <xsl:value-of select="value"/>
                </td>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="$rowNumber = '1'">
                  <td class="grid-left-cell" style="font-style: italic; height: {$cellHeight * (cell/@rowSpan - @spanOffset)}" rowspan="{(cell/@rowSpan - @spanOffset)}">
                    <xsl:value-of select="concat('(', cell/value, ' cont.)')"/>
                  </td>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </tr>
      </xsl:for-each>
    </table>
	</div>
</xsl:template>


<xsl:template name="GridSelectElement">
  <xsl:param name="rowNumber" select="''"/>
  <xsl:param name="colNumber" select="''"/>

      <xsl:choose>
      <xsl:when test="@readonly = 'true'">
        <xsl:value-of select="value/option[@selected = 'true']/@copy"/>
      </xsl:when>
      <xsl:otherwise>


<input name="{concat(@name, '-label')}" id="{concat(@name, '-label')}" type="text"  class="grid-text-input" style="padding: 2px 0px 0px 5px;" value="{value/option[@selected = 'true']/@copy}" onFocus="document.all[&#39;{@name}&#39;].runtimeStyle.display='inline'; this.runtimeStyle.display='none'; document.all[&#39;{@name}&#39;].focus(); "/>

  <select name="{@name}" id="{@name}" class="grid-text-input" onFocus="cellEnter('{$rowNumber}', '{$colNumber}', this);" style="display: none;" onBlur="this.runtimeStyle.display='none'; document.all[&#39;{concat(@name, '-label')}&#39;].value = this.options[this.selectedIndex].text; document.all[&#39;{concat(@name, '-label')}&#39;].runtimeStyle.display='inline';" onchange="cellChanged('{$rowNumber}', '{$colNumber}', this);">
    <xsl:if test="@readonly = 'true'">
      <xsl:attribute name="readonly">true</xsl:attribute>
    </xsl:if>
    <xsl:if test="@disabled = 'true'">
      <xsl:attribute name="disabled">true</xsl:attribute>
    </xsl:if>
    
    <xsl:for-each select="value/option">
      <option value="{@value}">
        <xsl:if test="@selected = 'true'">
          <xsl:attribute name="selected">true</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="@copy"/>
      </option>
    </xsl:for-each>
  </select>

      
      </xsl:otherwise>
      </xsl:choose>
  
  
  
</xsl:template>


</xsl:stylesheet>
 