<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:java="http://xml.apache.org/xslt/java" xmlns:xsli="XSLTTabInclude" extension-element-prefixes="xsli" version="1.0">
	<xsl:param name="request" select="java:javax.servlet.http.HttpServletRequest"/>
	<xsl:param name="response" select="java:javax.servlet.http.HttpServletResponse"/>
	<lxslt:component prefix="xsli" functions="urlInclude inRole getCurrentPage">
		<lxslt:script lang="javaclass" src="com.objecttek.www.inf.xsl.extensions.XSLTTabInclude"/>
	</lxslt:component>
<xsl:output method="xml" omit-xml-declaration="no" version="1.0" encoding="UTF-8"/>

<!-- 

$Revision: 1.1 $

$Log: permissions.xsl,v $
Revision 1.1  2004/09/29 14:33:16  vz86k2
check in

Revision 1.1  2004/07/23 19:17:09  vz86k2
check in

Revision 1.2  2003/01/14 22:59:52  czgrdr
Fixed Comments.


-->

<xsl:variable name="userRoles" select="xsli:getValue($request, 'roles')"/>
<xsl:template match="/">
  <xsl:copy>
    <xsl:apply-templates select="@*" />
    <xsl:apply-templates select="child::*" />
  </xsl:copy>
</xsl:template>

<xsl:template match="*">
 <xsl:if test="not(role-mapping)  or role-mapping[@role = 'Any'] or role-mapping[xsli:hasPermission($request, @role)]">
  <xsl:copy>
     <xsl:apply-templates select="@*" />
           <xsl:apply-templates select="child::*" />

  </xsl:copy>
  </xsl:if>
</xsl:template>


<xsl:template match="@*">
  <xsl:copy-of select="." />
</xsl:template>

</xsl:stylesheet>
