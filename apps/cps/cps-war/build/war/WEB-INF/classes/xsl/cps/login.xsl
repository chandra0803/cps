<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.1 $

$Log: login.xsl,v $
Revision 1.1  2004/09/24 17:03:42  vz86k2
check in

Revision 1.3  2004/09/07 20:34:31  vz86k2
update

Revision 1.2  2004/08/25 22:40:36  vz86k2
update

Revision 1.1  2004/07/23 19:17:41  vz86k2
check in


-->

<xsl:template name="LocalScript">
  <script type="text/javascript" language="javascript">

    function pageLoaded()
    {
    }

    function login()
    {
      document.formA.action="home.xml";
      document.formA.submit();
    }

  </script>

  <input type="hidden" name="command" value="login"/>

</xsl:template>

<xsl:template match="View">
  <xsl:param name="imgBaseUrl" select="''"/>

  <table width="235" BORDER="0" align="center">
    <tr>
      <TD><img height="100" src="{$imgBaseUrl}/clear.gif"/></TD>
    </tr>
    <tr>
      <td>
        <table BORDER="0" bgcolor="#616161">
          <tr><td colspan="3">
            <table BORDER="0" CELLSPACING="6" CELLPADDING="0" vspace="0" hspace="0">
  	      <tr>
                <td><font class="v8w">LOGIN:</font></td>
                <td><input class="header" type="text" name="uid"/></td>
              </tr>
              <tr>
                <td><font class="v8w">PASSWORD:</font></td>
                <td><input class="header" type="password" name="pwd"/></td>
              </tr>
            </table>
            </td>
          </tr>    
          <tr>
            <td width="33%"></td>
            <td>
            <DIV class="button">
              <A href="javascript:login()"><center><font class="v8w">&#160;LOGIN&#160;</font></center></A>
            </DIV>
            </td>
            <td width="33%"></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <TD><img height="100" src="{$imgBaseUrl}/clear.gif"/></TD>
    </tr>

  </table>

</xsl:template>

</xsl:stylesheet>
