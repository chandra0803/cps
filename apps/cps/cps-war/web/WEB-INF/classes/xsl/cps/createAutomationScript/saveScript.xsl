<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.2 $
$Log: saveScript.xsl,v $
Revision 1.2  2004/10/12 20:35:20  zz0qx3
create automation

Revision 1.1  2004/10/12 20:28:35  zz0qx3
create automation


-->


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
	<TD style="HEIGHT: 22px" colSpan="2">Save Script</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD style="HEIGHT: 27px" vAlign="top" align="right">Script Name:&#160;</TD>
	<TD align="left" vAlign="top" ><input type="text" size="20" name="sourceFile"/>
          &#160;
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;SAVE SCRIPT&#160;</font>
          </a>
        </TD>
      </TR>

    </tbody>
  </TABLE> 
</xsl:template>

</xsl:stylesheet>
