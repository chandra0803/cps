<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="text" indent="no" media-type="text/plain"/>

<xsl:template name="UpperCaseFirstLetter">
	<xsl:param name="sourceString"/>
  <xsl:variable name="lowerCase" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:variable name="upperCase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:value-of select="translate(substring($sourceString,1,1), $lowerCase, $upperCase)"/><xsl:value-of select="substring($sourceString,2)"/>
</xsl:template>


</xsl:stylesheet>
