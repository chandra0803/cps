<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.1 $
$Log: selectFiles.xsl,v $
Revision 1.1  2004/10/25 13:23:18  zz0qx3
tweaks for allocation

Revision 1.2  2004/10/19 18:35:43  zz0qx3
added edit template

Revision 1.1  2004/10/14 21:15:56  zz0qx3
added component groups, other tweaks

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
	<TD style="HEIGHT: 22px" colSpan="2">Select Files</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD style="HEIGHT: 27px" vAlign="top" align="right">Source File:&#160;</TD>
	<TD align="left" vAlign="top" ><input type="text" size="20" name="sourceFile"/>
          &#160;
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;SELECT FILE&#160;</font>
          </a>
        </TD>
      </TR>

      <TR>
	<TD style="HEIGHT: 27px" vAlign="top" align="right">Allocation File:&#160;</TD>
	<TD align="left" vAlign="top" ><input type="text" size="20" name="sourceFile"/>
          &#160;
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;SELECT FILE&#160;</font>
          </a>
          &#160;&#160;
          <a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;SELECT COMPONENT GROUP&#160;</font>
          </a>
        </TD>
      </TR>

      <TR>
	<TD style="HEIGHT: 27px" vAlign="top" align="right"><a class="button" href="javascript:selectSourceFile()">
            <font class="v8w">&#160;CONTINUE&#160;</font>
          </a></TD>
	<TD align="left" vAlign="top" >&#160;
        </TD>
      </TR>


    </tbody>
  </TABLE> 
</xsl:template>

</xsl:stylesheet>
