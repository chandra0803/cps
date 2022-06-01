<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:java="http://xml.apache.org/xslt/java" version="1.0">

  <xsl:output method="html" indent="yes"/>


<xsl:template name="gridStyle">
  <xsl:param name="rowHeaderWidth" select="''"/>
  <xsl:param name="cellWidth"      select="''"/>
  <xsl:param name="cellHeight"     select="''"/>
  <xsl:param name="sliderWidth"    select="''"/>
  <xsl:param name="cellBorderPad"  select="''"/>
  <xsl:param name="rowHeaderWidthCalculated"     select="''"/>
  <xsl:param name="columnHeaderHeightCalculated" select="''"/>

<style type="text/css">


body, html, table {
	margin: 0px;
	padding: 0px;
	overflow: hidden;
} 


.grid-main {
	position: relative; 
	overflow: hidden;
	width: 100%;
	height: 100%;
	cursor: default;
}


.grid-data {
	position: absolute;
	overflow: hidden;
	top: 0px;
	left: 0px;
	width: 100%;
	height: 100%;
	padding: <xsl:value-of select="$columnHeaderHeightCalculated"/>px 0px 0px <xsl:value-of select="$rowHeaderWidthCalculated"/>px;
	z-index: 1;
}


.grid-top {
	position: absolute;
	overflow: hidden;
	white-space: nowrap;
	background-color: #99CCCC;
	top: 0px;
	left: 0px;
	width: 100%;
	height: <xsl:value-of select="$columnHeaderHeightCalculated"/>px;
	padding: 0px 0px 0px <xsl:value-of select="$rowHeaderWidthCalculated"/>px;
	z-index: 2;
}

.grid-left {
  border: 0px none white;
	position: absolute;
	overflow: hidden;
	background-color: #99CCCC;
	top: 0px;
	left: 0px;
	width: <xsl:value-of select="$rowHeaderWidthCalculated"/>px;
	height: 100%;
	padding: <xsl:value-of select="$columnHeaderHeightCalculated"/>px 0px 0px 0px;
	text-align: center;
	z-index: 2;
}

.grid-corner {
	background-color: #99CCCC;
	border: inset 1px solid black;
	position: absolute;
	overflow: hidden;
	top: 0px;
	left: 0px;
	width: <xsl:value-of select="$rowHeaderWidthCalculated"/>px;
	height: <xsl:value-of select="$columnHeaderHeightCalculated"/>px;
	z-index: 3;
}


.grid-bars {
	position: absolute;
	overflow: scroll;
	top: 0px;
	left: 0px;
	width: 100%;
	height: 100%;
	padding: 0px;
	z-index: 4;
}

.grid-row {
	overflow-y: hidden;
	white-space: nowrap;
	width: 100%;
	height: <xsl:value-of select="$cellHeight"/>px; 
  border: 0px none white;
  margin: 0px;
  padding: 0px;

}

.grid-cell {
  margin: 0px;
	display: inline;
	overflow: hidden;
	text-overflow: ellipsis;
	width: <xsl:value-of select="$cellWidth"/>px;
	height: <xsl:value-of select="$cellHeight"/>px; 
	padding: 0px 0px 0px 0px;
	border: inset 1px solid black;
        font-family:verdana,arial,geneva,helvetica,helv;
        font-size:10pt;
        text-decoration:none;
        color:#000000;
        vertical-align: middle;
}



.grid-left-cell {
  margin: 0px;
	display: inline;
	overflow: hidden;
	text-overflow: ellipsis;
	width: <xsl:value-of select="$rowHeaderWidth"/>px;
	height: <xsl:value-of select="$cellHeight"/>px; 
	padding: 0px 0px 0px 0px;
	border: inset 1px solid black;
        font-family:verdana,arial,geneva,helvetica,helv;
        font-size:10pt;
        text-decoration:none;
        color:#000000;
        vertical-align: middle;
}

.grid-box-no-padding {
  border: 0px none white;
  margin: 0px;
  padding: 0px;
	position: relative;
	top: 0px;
	left: 0px;
}

.grid-fixed-table {
	table-layout: fixed;
  border: 0px none white;
  margin: 0px;
  padding: 0px;
	position: relative;
	top: 0px;
	left: 0px;
}

.grid-text-input {
  border: 0px none white;
  margin: 0px;
  padding: 0px;
  height: 100%;
  width: 100%;
        font-family:verdana,arial,geneva,helvetica,helv;
        font-size:10pt;
        text-decoration:none;
        color:#000000;
        vertical-align: middle;
}

.grid-radio-input {
  border: 0px none white;
  margin: 0px;
  padding: 0px;
        font-family:verdana,arial,geneva,helvetica,helv;
        font-size:10pt;
        text-decoration:none;
        color:#000000;
        vertical-align: middle;
}

</style>

</xsl:template>

</xsl:stylesheet>
