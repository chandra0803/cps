<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.1 $

$Log: home.xsl,v $
Revision 1.1  2004/09/24 17:03:42  vz86k2
check in

Revision 1.1  2004/07/23 19:17:41  vz86k2
check in


-->


<xsl:template name="LocalScript">
  <script type="text/javascript" language="javascript">

    function pageLoaded()
    {
<xsl:if test="RedirectMessage">
      alert('<xsl:value-of select="RedirectMessage/@text"/>');    
</xsl:if>
<xsl:if test="State/SuccessMessage">
      alert('<xsl:value-of select="State/SuccessMessage/@text"/>');    
</xsl:if>
    }

  </script>

</xsl:template>

<xsl:template match="View">
  <xsl:param name="imgBaseUrl" select="''"/>

      <TABLE width="80%" border="0" cellpadding="2" cellspacing="2">
        <TR>
  	      <TD colspan="4" height="35">&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="2" align="left" valign="bottom" nowrap="true"><font class="v10aquaA"><b>Welcome to the Delphi CPS Application</b></font></TD>
          <TD align="right" valign="top"><img src="{$imgBaseUrl}/screen/Tech_1709.jpg" border="0"/></TD>
        </TR>
	<TR>
  	      <TD colspan="4"><hr/></TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="3">
            <font class="v8b">
            Welcome to the Delphi CPS Application for volume planning.  The application will provide the following
            functionality based on your role:</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="3">
            <font class="v8b">
            1. On-Line analysis of volume estimates using a Pivot Table.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="3">
            <font class="v8b">
            2. Standard Data Manipulation tasks.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="3">
            <font class="v8b">
            3. Specialized Data Manipulation tasks including allocations and time series functions.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="3">
            <font class="v8b">
            4. Data Validation.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="3">
            <font class="v8b">
            5. Reporting functionality including Ad-Hoc, and template based reporting.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="3">
            <font class="v8b">
            6. File management functionality.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="3">
            <font class="v8b">
            7. Command Scripting capabilities.</font></TD>
          <TD>&#160;</TD>
        </TR>
        <TR>
          <TD width="15">&#160;</TD>
          <TD colspan="3">
            <font class="v8b">
            Please use the left navigation menu to utilize the application.</font></TD>
          <TD>&#160;</TD>
        </TR>

        <TR>
          <TD colspan="4" align="left"><HR/></TD>
          <TD>&#160;</TD>
        </TR>

        <TR>
  	  <TD colspan="4" height="35">&#160;</TD>
        </TR>

     </TABLE>

</xsl:template>

</xsl:stylesheet>
