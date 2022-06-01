<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
  <xsl:import href="style.xsl"/>
  <xsl:import href="common.xsl"/>

  <xsl:output method="html" indent="yes"/>

<!-- 

$Revision: 1.1 $

$Log: floatingWin.xsl,v $
Revision 1.1  2004/11/04 16:58:54  zz0qx3
mass update 11/4

Revision 1.2  2004/09/29 13:30:07  vz86k2
update

Revision 1.1  2004/09/24 17:02:50  vz86k2
check in

Revision 1.5  2004/09/07 20:33:57  vz86k2
update

Revision 1.4  2004/08/31 22:02:56  vz86k2
update

Revision 1.3  2004/08/25 22:42:23  vz86k2
check in

Revision 1.2  2004/08/23 20:25:41  vz86k2
update

Revision 1.1  2004/07/23 19:17:09  vz86k2
check in


-->


<xsl:template match="/">
  <xsl:apply-templates select="Screen"/>
</xsl:template>



<xsl:template match="Screen">

  <xsl:variable name="imgBaseUrl" select="Model/Entity/ImgBaseUrl"/>
  <xsl:variable name="relUrl" select="Model/Entity/RelUrl"/>

  <html>
  <head>
    <title>
      <xsl:value-of select="Model/Request/Title"/>
    </title>
  <xsl:call-template name="Style"/>
    <LINK href="../style/Styles.css" type="text/css" rel="stylesheet"/>
  </head>
  <body bgcolor="#99CCCC" marginwidth="0" marginheight="0" leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" onUnload="localPageUnloaded();" onLoad="pageLoaded();">
    
    <form name="formA" action="{$relUrl}/home" method="post">
    <xsl:if test="@enctype = 'multipart/form-data'">
      <xsl:attribute name="ENCTYPE"><xsl:text>multipart/form-data</xsl:text>
      </xsl:attribute>
    </xsl:if>

    <script type="text/javascript" language="javascript">

      function localPageUnloaded()
      {      
        if (window.pageUnloaded != null)
          pageUnloaded();
      }

    </script>

  <xsl:call-template name="LocalScript"/>


      <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" class="tbllb">
        <TR><TD>
      <xsl:if test="ValidationErrors/Error">
        <TABLE class="etbllb" cellSpacing="0" cellPadding="0" width="100%" border="0">
          <TR>
            <TD><font class="v8redA">Form Errors:</font></TD>
          </TR>
          <xsl:for-each select="ValidationErrors/Error">
            <TR>
              <TD><font class="v8redA"> 
                <xsl:if test="position() != last()">        
                  <xsl:value-of select="position()"/>. 
                </xsl:if>
              <xsl:value-of select="."/></font></TD>
            </TR>
          </xsl:for-each>
        </TABLE>
      </xsl:if>
        </TD></TR>
        <TR><TD>
      <xsl:apply-templates select="View">
        <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
      </xsl:apply-templates> 
        </TD></TR>
      </TABLE>
  </form>
  </body>
  </html>
</xsl:template>

  <xsl:template name="LocalScript">
  </xsl:template>

<!--
**********
**********  BANNER
**********
-->

  <xsl:template name="Banner">
    <xsl:param name="uid" select="'UID'"/>
    <xsl:param name="imgBaseUrl" select="''"/>
    <xsl:param name="relUrl" select="''"/>

    <TABLE border="0" cellpadding="0" cellspacing="0" bgcolor="#535252" width="100%">
      <tr>
      <td width="100%">&#160;</td>
      <td nowrap="true" valign="middle" align="right"></td>

      <xsl:for-each select="Model/Session/UserTabs/BannerTabSet/Tab">  
   
        <td nowrap="true" valign="middle" align="right">
          <a style="text-decoration:none">
            <xsl:attribute name="href">
              <xsl:choose>
                <xsl:when test="@tabsUrl = 'true'">
                  <xsl:value-of select="@Url"/>
                </xsl:when>
                <xsl:otherwise> 
                  <xsl:value-of select="concat($relUrl,'/',@Url)"/>
                </xsl:otherwise> 
              </xsl:choose>
            </xsl:attribute>
            <FONT class="v6w"><b>&#160;&#160;<xsl:value-of select="@Name"/>&#160;&#160;</b></FONT>
          </a>
        </td>

        <xsl:if test="position() != last()"> 
          <td nowrap="true" valign="middle" align="right">
            <img src="{$imgBaseUrl}/screen/vertDivider.gif"/>
          </td>
        </xsl:if>
  
      </xsl:for-each> 

<!--
      <td nowrap="true" valign="middle" align="right">
        <a href="{$relUrl}/home" style="text-decoration:none">
        <FONT class="v6w"><b>&#160;&#160;ATM HOME&#160;&#160;</b></FONT>
        </a>
      </td>
      <td nowrap="true" valign="middle" align="right">
      <img src="{$imgBaseUrl}/screen/vertDivider.gif"/>
      </td>
      <td nowrap="true" valign="middle" align="right">
        <a href="{$relUrl}/logout" style="text-decoration:none">
        <FONT class="v6w"><b>&#160;&#160;LOG OUT&#160;&#160;</b></FONT>
        </a>
      </td>
      <td nowrap="true" valign="middle" align="right">
      <img src="{$imgBaseUrl}/screen/vertDivider.gif"/>
      </td>
      <td nowrap="true" valign="middle" align="right">
        <a href="http://www.delphi.com" style="text-decoration:none">
        <FONT class="v6w"><b>&#160;&#160;DELPHI HOME&#160;&#160;</b></FONT>
        </a>
      </td>
      <td nowrap="true" valign="middle" align="right">
      <img src="{$imgBaseUrl}/screen/vertDivider.gif"/>
      </td>
      <td nowrap="true" valign="middle" align="right">
        <a href="{$relUrl}/home" style="text-decoration:none">
        <FONT class="v6w"><b>&#160;&#160;ABOUT ATM&#160;&#160;</b></FONT>
        </a>
      </td>
-->
      </tr>
    </TABLE>
    <TABLE border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" width="100%">
      <TR>
        <TD>
          <Img src="{$imgBaseUrl}/screen/delphi_top_logo.gif"/>
        </TD>
        <TD align="right" valign="middle" width="100%" nowrap="true">
        <xsl:if test="$uid"> 
          <FONT class="v7b">
            <b>USER ID:&#160;&#160;<xsl:value-of select="$uid"/></b>
          </FONT>
        </xsl:if>
        </TD>
        <TD>
          <Img src="{$imgBaseUrl}/clear.gif" width="70" height="1"/>
        </TD>
      </TR>
      <TR>
      <TD colspan="4" bgcolor="#FE0000" height="2"><img alt="" height="2" width="1" src="{$imgBaseUrl}/screen/redline_pixel.gif"/></TD>
      </TR>
    </TABLE>
  </xsl:template>


<!--
**********
**********  TABS
**********
-->

  <xsl:template match="UserTabs">
    <xsl:param name="imgBaseUrl" select="''"/>
    <xsl:param name="relUrl" select="''"/>

    <TABLE width="100%" border="0" cellpadding="0" cellspacing="0"  bgcolor="#616161">
      <TR valign="middle">
        <xsl:variable name="numTabs" select="count(TabSet/Tab)"/>
        <xsl:choose>
          <xsl:when test="$numTabs &gt; 8">
            <TD width="195">
              <img src="{$imgBaseUrl}/clear.gif" width="195" height="30"/>
            </TD>   
          </xsl:when>
          <xsl:otherwise>
            <TD width="195">
              <img src="{$imgBaseUrl}/clear.gif" width="195" height="26"/>
            </TD>
          </xsl:otherwise>
        </xsl:choose>
        
        <TD align="left" valign="middle" nowrap="true">
        <xsl:for-each select="TabSet/Tab">
          <xsl:if test="position()=8">
          <BR/>
          </xsl:if>
          <xsl:if test="position()=16">
          <BR/>
          </xsl:if>
          <img src="{$imgBaseUrl}/screen/menuSquare.gif"/>
          <img src="{$imgBaseUrl}/clear.gif" width="4" height="1"/>
          <xsl:variable name="url" select="concat(../../TabSet/@Url,@Url)"/>
           <xsl:choose>
            <xsl:when test="@currentTab = 'true'">
              <xsl:choose>
                <xsl:when test="@href='false'">
                  <FONT class="v7w">
                  <b><xsl:value-of select="@Name"/></b>
                  </FONT>
                </xsl:when>
                <xsl:otherwise>
                  <a href="{$url}" style="text-decoration:none">
                  <FONT class="v7w">
                  <b><xsl:value-of select="@Name"/></b>
                  </FONT>
                  </a>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="@href='false'">
                  <FONT class="v7greyA">
                  <b><xsl:value-of select="@Name"/></b>
                  </FONT>
                </xsl:when>
                <xsl:otherwise>
                  <a href="{$url}" style="text-decoration:none">
                  <FONT class="v7greyA">
                  <b><xsl:value-of select="@Name"/></b>
                  </FONT>
                  </a>
                </xsl:otherwise>
              </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          <img src="{$imgBaseUrl}/clear.gif" width="8" height="1"/>
          </xsl:for-each>
        </TD>
      </TR>
    </TABLE>
  </xsl:template>

</xsl:stylesheet>
