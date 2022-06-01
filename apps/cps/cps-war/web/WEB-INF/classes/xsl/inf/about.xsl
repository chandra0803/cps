<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:java="http://xml.apache.org/xslt/java" xmlns:xsli="XSLTTabInclude" extension-element-prefixes="xsli" version="1.0">
<xsl:import href="screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!-- 

$Revision: 1.1 $

$Log: about.xsl,v $
Revision 1.1  2004/09/30 19:40:56  zz0qx3
importing Steve's latest

Revision 1.1  2004/07/23 19:18:26  vz86k2
check in

Revision 1.4  2004/06/28 18:30:19  zz0qx3
no message

Revision 1.3  2003/01/30 18:16:13  zz0qx3
changed include to import

Revision 1.2  2003/01/23 22:26:15  czgrdr
Changed links to open in new window.
Fixed Adobe Acrobat link to point to Acrobat Reader 5.0

Revision 1.1  2003/01/23 19:10:51  czgrdr
Initial revision.


-->



<xsl:template name="LocalScript">
<script type="text/javascript" language="javascript">
function pageLoaded()
{
}
</script>
</xsl:template>

<xsl:template match="Presentation">
  <TABLE width="80%" border="0" cellpadding="2" cellspacing="2">
    <tr>
      <td colspan="4" height="50">&#160;</td>
    </tr>
    <tr>
      <td width="15">&#160;</td>
      <td align="left" valign="bottom" nowrap="true"><font class="v10aquaA"><b>About WebEDI</b></font></td>
      <td width="20">&#160;</td>
    </tr>
    <tr>
      <td colspan="4"><hr/></td>
    </tr>
    <tr>
      <td width="15">&#160;</td>
      <td colspan="3">
         <font face="Arial" size="2">
         
           <p><b>Copyright</b></p>
            <p>Information contained in this site is the property of Delphi Corporation, we retain copyright on all text and graphic images.  

            This copyright is protected by the copyright laws of the United States and international treaty provisions.  You may print copies 

            of the information presented herein for your own personal use, however, any other use is prohibited without the express written 

            permission of Delphi.</p>
            
            <p>All information contained on this website is designed to be as comprehensive and factual as possible.  Delphi  reserves the 

            right, however, to make changes at any time, without notice.</p>
            
            <p><b>Privacy</b></p>
            
            <p>Delphi may collect and store information about your visit on an anonymous, aggregate basis.  This information may include the 

            time and length of your visit, the pages you looked at on our website, the PDF files you downloaded, and the site you were referred 

            to ours by.  We may also record the name of your Internet Service Provider.  This information is only used to measure activity on 

            our site and to develop ideas for improving our site.  We make no attempt to identify individual visitors of our site.  Delphi 

            sites requiring login may have different policies.</p>
            
            <p><b>Site Management</b></p>
            
            <p>If you have any questions regarding this site, please e-mail <a href="mailto:troy.webedi@delphi.com">troy.webedi@delphi.com</a>.</p>
            
            <p><b>Specifications</b></p>
            
            <p>This site is optimized for Netscape and Microsoft Internet Explorer browser versions 5.0 or higher.  You can download the latest 

            version of Netscape free <a href="http://home.netscape.com/computing/download/index.html?cp=hom02tdow" target="_blank">here</a>, and the latest 

            version of Microsoft Internet Explorer <a href="http://www.microsoft.com/downloads/search.aspx?displaylang=en" target="_blank">here</a>.  To view PDF files on this site you 

            will also need to download the <a href="http://www.adobe.com/products/acrobat/readermain.html" target="_blank">Adobe Acrobat Reader, version 5.0.</a>. </p>
                        
            <p>&#160;</p>
            
            <p>Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003 Delphi Corporation, Delphi Automotive Systems LLC and Delphi 

            Technologies, Inc.  All rights reserved.</p>
 
         </font></td>
    </tr>
  </TABLE>
  <xsl:apply-templates select="Results"/>
</xsl:template>

<xsl:template match="Results">  
</xsl:template>
  

</xsl:stylesheet>
