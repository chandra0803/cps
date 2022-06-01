<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xml.apache.org/fop/extensions" >
<xsl:decimal-format NaN="" />
<xsl:output method="xml" encoding="ISO-8859-1"></xsl:output>

<!--<xsl:strip-space elements="row"></xsl:strip-space>-->

<xsl:attribute-set name="bt">
  <xsl:attribute name="border-top-color">black</xsl:attribute>
  <xsl:attribute name="border-top-style">solid</xsl:attribute>
  <xsl:attribute name="border-top-width">1pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="bl">
  <xsl:attribute name="border-left-color">black</xsl:attribute>
  <xsl:attribute name="border-left-style">solid</xsl:attribute>
  <xsl:attribute name="border-left-width">1pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="br">
  <xsl:attribute name="border-right-color">black</xsl:attribute>
  <xsl:attribute name="border-right-style">solid</xsl:attribute>
  <xsl:attribute name="border-right-width">1pt</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="bb">
  <xsl:attribute name="border-bottom-color">black</xsl:attribute>
  <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
  <xsl:attribute name="border-bottom-width">1pt</xsl:attribute>
</xsl:attribute-set>

<xsl:template match="Report">

  <xsl:variable name="titleRight" select="'CPS Application'"/>
  <xsl:variable name="title" select="'GM SUV GMT-36X Forecast'"/>
  <xsl:variable name="col1Title" select="'cva'"/>
  <xsl:variable name="col1Width" select="'80pt'"/>
  <xsl:variable name="col2Title" select="'vppc'"/>
  <xsl:variable name="col2Width" select="'80pt'"/>
  <xsl:variable name="col3Title" select="'brand'"/>
  <xsl:variable name="col3Width" select="'80pt'"/>
  <xsl:variable name="col4Title" select="'engnm'"/>
  <xsl:variable name="col4Width" select="'80pt'"/>
  <xsl:variable name="col5Title" select="'2003'"/>
  <xsl:variable name="col5Width" select="'60pt'"/>
  <xsl:variable name="col6Title" select="'2004'"/>
  <xsl:variable name="col6Width" select="'60pt'"/>
  <xsl:variable name="col7Title" select="'2005'"/>
  <xsl:variable name="col7Width" select="'60pt'"/>
  <xsl:variable name="col8Title" select="'2006'"/>
  <xsl:variable name="col8Width" select="'60pt'"/>

  <xsl:variable name="colHeaderFontSz" select="'8pt'"/>
  <xsl:variable name="colFontSz" select="'6pt'"/>
  <xsl:variable name="titleFontSz" select="'12pt'"/>

  <xsl:variable name="fopImgBaseUrl" select="''"/>

  <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <fo:layout-master-set >
      <fo:simple-page-master page-width="8.5in" page-height="11in" master-name="Section1-rest" margin-top="24.0pt" margin-bottom="24.0pt" margin-left="24.0pt" margin-right="24.0pt" >
        <fo:region-before extent="40.0pt" ></fo:region-before>
        <fo:region-after extent="30.0pt" ></fo:region-after>
        <fo:region-body margin-top="40.0pt" margin-bottom="30.0pt"></fo:region-body>
      </fo:simple-page-master>
      <fo:page-sequence-master master-name="Section1-ps">
        <fo:repeatable-page-master-reference master-reference="Section1-rest"></fo:repeatable-page-master-reference>
      </fo:page-sequence-master>
    </fo:layout-master-set>
    <fo:page-sequence master-reference="Section1-ps">

      <fo:static-content flow-name="xsl-region-before">
        <fo:table table-layout="fixed" >
          <fo:table-column column-number="1" column-width="185pt" ></fo:table-column>
          <fo:table-column column-number="2" column-width="185pt" ></fo:table-column>
          <fo:table-column column-number="3" column-width="185pt" ></fo:table-column>

          <fo:table-body font-size="{$titleFontSz}" font-weight="bold">
            <fo:table-row vertical-align="middle">
              <fo:table-cell>
                <fo:external-graphic src="url(../../../../../../images/report/delphi_report_logo.gif)"/>
              </fo:table-cell>
              <fo:table-cell text-align="center">
                <fo:block>
                  <xsl:value-of select="$title"/>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right">
                <fo:block>
                  <xsl:value-of select="$titleRight"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>  
      </fo:static-content>

      <fo:static-content flow-name="xsl-region-after">
        <fo:block text-align="center" font-size="10pt" line-height="14pt" >page <fo:page-number/></fo:block>
      </fo:static-content>

      <fo:flow flow-name="xsl-region-body">
        <fo:table table-layout="fixed" border-collapse="separate" border-separation="0pt">
          <fo:table-column column-number="1" column-width="{$col1Width}" ></fo:table-column>
          <fo:table-column column-number="2" column-width="{$col2Width}" ></fo:table-column>
          <fo:table-column column-number="3" column-width="{$col3Width}" ></fo:table-column>
          <fo:table-column column-number="4" column-width="{$col4Width}" ></fo:table-column>
          <fo:table-column column-number="5" column-width="{$col5Width}" ></fo:table-column>
          <fo:table-column column-number="6" column-width="{$col6Width}" ></fo:table-column>
          <fo:table-column column-number="7" column-width="{$col7Width}" ></fo:table-column>
          <fo:table-column column-number="8" column-width="{$col8Width}" ></fo:table-column>
                        
          <fo:table-header background-color="#CFCFCF" font-size="{$colHeaderFontSz}" font-weight="bold">
            <fo:table-row text-align="center" vertical-align="sub" >
              <fo:table-cell number-columns-spanned="8" xsl:use-attribute-sets="bt bl br">
                <fo:block padding-before="2pt" margin-right="2pt" >Volumes</fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row text-align="center" vertical-align="sub" >
              <fo:table-cell number-columns-spanned="4" xsl:use-attribute-sets="bt bl br">
                <fo:block padding-before="2pt" margin-right="2pt" >Attributes</fo:block>
              </fo:table-cell>
              <fo:table-cell number-columns-spanned="4" xsl:use-attribute-sets="bt br">
                <fo:block padding-before="2pt" margin-right="2pt" >Model Run</fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row text-align="center" >
              <fo:table-cell xsl:use-attribute-sets="bt bl bb">
                <fo:block padding-before="2pt" margin-left="2pt"><xsl:value-of select="$col1Title"/></fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="bt bl bb">
                <fo:block padding-before="2pt" margin-left="2pt"><xsl:value-of select="$col2Title"/></fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="bt bl bb">
                <fo:block padding-before="2pt" margin-left="2pt"><xsl:value-of select="$col3Title"/></fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="bt bl bb">
                <fo:block padding-before="2pt" margin-left="2pt"><xsl:value-of select="$col4Title"/></fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="bt bl bb">
                <fo:block padding-before="2pt" margin-left="2pt"><xsl:value-of select="$col5Title"/></fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="bt bl bb">
                <fo:block padding-before="2pt" margin-left="2pt"><xsl:value-of select="$col6Title"/></fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="bt bl bb">
                <fo:block padding-before="2pt" margin-left="2pt"><xsl:value-of select="$col7Title"/></fo:block>
              </fo:table-cell>
              <fo:table-cell xsl:use-attribute-sets="bt bl bb br">
                <fo:block padding-before="2pt" margin-left="2pt"><xsl:value-of select="$col8Title"/></fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-header>                    
          <fo:table-body font-size="{$colFontSz}" >
            <xsl:choose>
              <xsl:when test="/descendant::ReportData/cva">
                <xsl:apply-templates select="/descendant::ReportData/cva"></xsl:apply-templates>
              </xsl:when>
              <xsl:otherwise>
                <fo:table-row text-align="left" height="14pt">
                  <fo:table-cell number-columns-spanned="7" text-align="left" xsl:use-attribute-sets="bl bb br">
                    <fo:block padding-before="2pt" margin-left="2pt">
                      No Data Found.
                    </fo:block>
                  </fo:table-cell>
                </fo:table-row>
              </xsl:otherwise>
            </xsl:choose>

            <fo:table-row text-align="center" height="2pt" >
              <fo:table-cell number-columns-spanned="8" xsl:use-attribute-sets="bt">
                <fo:block padding-before="2pt" margin-right="2pt" ></fo:block>
              </fo:table-cell>
            </fo:table-row>


          </fo:table-body>
        </fo:table>
      </fo:flow>
    </fo:page-sequence>
  </fo:root>
</xsl:template>

<xsl:template match="cva">
  <xsl:apply-templates select="vppc">
    <xsl:with-param name="cva" select="name"/>
  </xsl:apply-templates>
</xsl:template>
 
<xsl:template match="vppc">
  <xsl:param name="cva" select="''"/>

  <xsl:apply-templates select="brand">
    <xsl:with-param name="cva" select="$cva"/>
    <xsl:with-param name="vppc" select="name"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="brand">
  <xsl:param name="cva" select="''"/>
  <xsl:param name="vppc" select="''"/>

  <xsl:apply-templates select="engnm">
    <xsl:with-param name="cva" select="$cva"/>
    <xsl:with-param name="vppc" select="$vppc"/>
    <xsl:with-param name="brand" select="name"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="engnm">
  <xsl:param name="cva" select="''"/>
  <xsl:param name="vppc" select="''"/>
  <xsl:param name="brand" select="''"/>

  <fo:table-row text-align="left" height="14pt">

    <fo:table-cell text-align="left" xsl:use-attribute-sets="bl">
      <fo:block margin-left="2pt" margin-right="2pt" padding-before="2pt">
        <xsl:value-of select="$cva"/>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell xsl:use-attribute-sets="bl">
      <fo:block margin-left="2pt" margin-right="2pt" padding-before="2pt">
        <xsl:value-of select="$vppc"/>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell xsl:use-attribute-sets="bl">
      <fo:block margin-left="2pt" margin-right="2pt" padding-before="2pt">
        <xsl:value-of select="$brand"/>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell xsl:use-attribute-sets="bl br">
      <fo:block margin-left="2pt" margin-right="2pt" padding-before="2pt">
        <xsl:value-of select="name"/>
      </fo:block>
    </fo:table-cell>                

    <xsl:for-each select="modrn">
      <fo:table-cell xsl:use-attribute-sets="br">
        <fo:block margin-left="2pt" margin-right="2pt" text-align="right"  padding-before="2pt">
          <xsl:value-of select="vol"/>
        </fo:block>
      </fo:table-cell>
    </xsl:for-each>

  </fo:table-row>

</xsl:template>

</xsl:stylesheet>

