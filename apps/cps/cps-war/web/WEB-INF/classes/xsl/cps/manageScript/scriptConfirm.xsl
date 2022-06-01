<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.1 $
$Log: scriptConfirm.xsl,v $
Revision 1.1  2004/10/18 17:40:26  zz0qx3
Checkpoint prior to making post-review changes

Revision 1.2  2004/10/13 14:19:24  zz0qx3
no message

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
	<TD style="HEIGHT: 42px">Review &amp; Confirm</TD>
      </TR>
    </thead>
    <tbody>
      <TR>

	<TD style="HEIGHT: 42px" vAlign="top" align="left">File Loaded:&#160;127 Lines Found
</TD>
      </TR>

<tr>
	<TD style="HEIGHT: 42px" vAlign="top" align="left" >File Comments:&#160;<input type="text" size="20" name="sourceFile" value="none"/>
          &#160;
        </TD>
</tr>

<tr>
	<TD  style="HEIGHT: 42px" vAlign="top" align="left">
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;SAVE SCRIPT&#160;</font>
          </a>
        </TD>
</tr>

    </tbody>
  </TABLE> 
</xsl:template>

</xsl:stylesheet>
