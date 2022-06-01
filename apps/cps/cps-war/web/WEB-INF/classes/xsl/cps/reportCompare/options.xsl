<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.1 $

$Log: options.xsl,v $
Revision 1.1  2004/11/04 16:58:51  zz0qx3
mass update 11/4

Revision 1.3  2004/10/21 13:34:04  vz86k2
update

Revision 1.2  2004/10/06 20:26:11  vz86k2
update

Revision 1.1  2004/10/05 21:10:40  vz86k2
check in

Revision 1.1  2004/09/24 17:03:42  vz86k2
check in

Revision 1.1  2004/07/23 19:17:42  vz86k2
check in

Revision 1.23  2003/09/26 14:12:28  zz0qx3
changed wording

Revision 1.22  2003/09/26 13:05:01  zz0qx3
specified vendor issue

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
	<TD style="HEIGHT: 22px">Display Options</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
        <TD style="HEIGHT: 27px">Select Display Data:&#160;
            <select name="dataType" size="1">
              <option value="0">A/B/Variance</option>
              <option value="1">Variance Only</option>
            </select>
        </TD>
      </TR>
      <TR>
        <TD style="HEIGHT: 18px"/>
      </TR>
      <TR>
        <TD>
          Positive Value:&#160;<input type="text" size="20" value="+"/>
        </TD>
      </TR>    
      <TR>
        <TD>
          Negative Value:&#160;<input type="text" size="20" value="-"/>
        </TD>
      </TR>    
      <TR>
        <TD>
          Zero Value:&#160;<input type="text" size="20" value="Zero"/>
        </TD>
      </TR>    
      <TR>
        <TD>
          Blank Value:&#160;<input type="text" size="20" value=""/>
        </TD>
      </TR>    
    </tbody>
  </TABLE> 

  <TABLE cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <tbody>
      <TR>
        <TD colspan="2" style="HEIGHT: 11px"/>
      </TR>
      <TR>
	<TD colspan="2" style="HEIGHT: 27px" vAlign="top" align="center">
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;PREV&#160;</font>
          </a>&#160;
          <a class="button" href="javascript:next()">
            <font class="v8w">&#160;NEXT&#160;</font>
          </a>
        </TD>
      </TR>
      <TR>
        <TD colspan="2" style="HEIGHT: 11px"/>
      </TR>
    </tbody>
  </TABLE>  

</xsl:template>

</xsl:stylesheet>
