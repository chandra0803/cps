<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:java="http://xml.apache.org/xslt/java" version="1.0">
<xsl:output method="html" indent="yes"/>

<!-- 

$Revision: 1.2 $

$Log: style.xsl,v $
Revision 1.2  2004/10/28 15:40:41  zz0qx3
updates

Revision 1.1  2004/09/24 17:02:50  vz86k2
check in

Revision 1.2  2004/09/07 20:34:03  vz86k2
update

Revision 1.1  2004/07/23 19:17:08  vz86k2
check in

Revision 1.13  2003/10/29 15:14:30  zz0qx3
chpt

Revision 1.12  2003/10/28 13:58:54  zz0qx3
fixed font size

Revision 1.11  2003/10/21 21:06:28  zz0qx3
checkpoint

Revision 1.10  2003/10/17 17:11:55  zz0qx3
checkpoint

Revision 1.9  2003/01/22 20:00:29  czgrdr
Added new style .x124 for use in <TD> tags of Excel views.

Revision 1.8  2003/01/21 21:51:24  kzcf04
Added v7red

Revision 1.7  2003/01/14 22:59:51  czgrdr
Fixed Comments.


-->

<xsl:template name="Style">

<STYLE>
.button
{
	background: #5599CC; 
	height: 10px; 
	border: 1px solid white;
	margin-top: 5px;
	text-decoration: none;
}

.xl24
{
        mso-number-format:"\@";
}

</STYLE>
</xsl:template>


</xsl:stylesheet>
