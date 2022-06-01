<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">

  <xsl:output method="html" indent="yes"/>
	<xsl:variable name="topMostMenu" select="111"/>
	<xsl:variable name="menuWidth" select="203"/>

  <xsl:template match="UserNavigation">
    <xsl:param name="imgBaseUrl" select="''"/>
    <xsl:param name="relUrl" select="''"/>

    <TABLE width="195" border="0" cellpadding="0" cellspacing="0" bgcolor="#7B7B7B">
      <TR>
        <TD height="100%" valign="TOP" align="left">
          <table width="195" border="0" cellpadding="0" cellspacing="0" bgcolor="#7B7B7B">
            <xsl:apply-templates select="Menu">
              <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              <xsl:with-param name="relUrl" select="$relUrl"/>
            </xsl:apply-templates> 

            <TR>
              <TD colspan="3">
                <img src="{$imgBaseUrl}/clear.gif" width="1" height="1"/> 
              </TD>
            </TR>
          </table>
          </TD>
        </TR>
      </TABLE>
  </xsl:template>
	
  <xsl:template match="Menu">
    <xsl:param name="imgBaseUrl" select="''"/>
    <xsl:param name="relUrl" select="''"/>

    <TR>
      <TD height="25" valign="center" align="right">
      <img src="{$imgBaseUrl}/screen/menuArrow.gif"/> 
      </TD>
      <TD height="25" valign="center" align="right">
      <img src="{$imgBaseUrl}/clear.gif" width="5" height="0"/> 
      </TD>
      <TD bgcolor="#7B7B7B" height="20" valign="center" align="left">
      <FONT class="v10aquaB"> 
      <b><xsl:value-of select="@heading"/></b>
      </FONT> 
      </TD>
    </TR>
    <TR>
      <TD colspan="3"><img src="{$imgBaseUrl}/screen/horizDivider.gif" width="188" height="5"/></TD>
    </TR>
    <xsl:apply-templates select="Item">
      <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
      <xsl:with-param name="relUrl" select="$relUrl"/>
    </xsl:apply-templates> 

    <TR>
      <TD colspan="3">
        <img src="{$imgBaseUrl}/clear.gif" width="1" height="20"/> 
      </TD>
    </TR>

  </xsl:template>


  <xsl:template match="Item">
    <xsl:param name="imgBaseUrl" select="''"/>
    <xsl:param name="relUrl" select="''"/>

    <TR> 
        <TD height="22" valign="center" align="right">
        <img src="{$imgBaseUrl}/screen/menuSquare.gif"/> 
        </TD>
        <TD height="22" valign="center" align="right">
        <img src="{$imgBaseUrl}/clear.gif" width="5" height="0"/> 
        </TD>
        <TD>
        <xsl:choose>
        <xsl:when test="@href != ''">
          <a href="{$relUrl}/{@href}" color="white" style="text-decoration:none">
          <xsl:if test="@target != ''">
            <xsl:attribute name="target">
              <xsl:value-of select="@target"/>
            </xsl:attribute>    			            
          </xsl:if>
          <font class="v7w">
          <b>
          <xsl:value-of select="@name"/>
          </b></font>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <font class="v7w"> <b>
          <xsl:value-of select="@name"/>
          </b>
          </font>
        </xsl:otherwise>
        </xsl:choose>
        </TD>
    </TR>
  </xsl:template>

</xsl:stylesheet>
