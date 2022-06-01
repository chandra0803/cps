<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.2 $
$Log: scriptOverview.xsl,v $
Revision 1.2  2004/10/28 15:40:42  zz0qx3
updates

Revision 1.1  2004/10/18 17:40:27  zz0qx3
Checkpoint prior to making post-review changes

Revision 1.3  2004/10/14 21:15:56  zz0qx3
added component groups, other tweaks

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
	<TD style="HEIGHT: 22px">Manage Script Files</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	      <TD style="HEIGHT: 27px" vAlign="top" align="left">&#160;
          </TD>
      </TR>

      <TR>
	      <TD style="HEIGHT: 27px" vAlign="bottom" align="left">
          Upload New Script File<br/>
          <input name="file" type="file" size="40"/>&#160;&#160;<a class="button" href="javascript:upload('1');">
          <font class="v8w">&#160;UPLOAD&#160;</font>
        </a>
          </TD>
      </TR>
      <TR>
	      <TD style="HEIGHT: 27px" vAlign="top" align="left">&#160;
          </TD>
      </TR>

      <TR>
	      <TD style="HEIGHT: 22px">Select Existing Script File</TD>
      </TR>


<TR><TD>
      <TABLE  cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
      <TR>

	<TD style="WIDTH: 60px" vAlign="top" align="right">File Name:&#160;</TD>
	<TD vAlign="top" colspan="2"><input name="filename" type="text" style="width:232px;" value="01-05-2004"/></TD>
        <TD></TD>
      </TR>
      <TR>
	<TD style="WIDTH: 60px" vAlign="top" align="right">From Date:&#160;</TD>
	<TD vAlign="top">
          <input name="fromDt" value="10-05-2004" type="text" class="PlainSmallText" style="width:80px;" size="11" maxlength="11">
          </input>
            <a onClick="popupCalendar(document.formA.fromDt, event); return false;" href="#">
              <img src="{$imgBaseUrl}/buttons/calendar.gif" width="24" height="24" border="0" align="absmiddle"/>
            </a>
        </TD>

	<TD style="WIDTH: 60px" vAlign="top" align="right">To Date:&#160;</TD>
	<TD vAlign="top">
          <input name="toDt" value="" type="text" class="PlainSmallText" style="width:80px;" size="11" maxlength="11">
          </input>
            <a onClick="popupCalendar(document.formA.toDt, event); return false;" href="#">
              <img src="{$imgBaseUrl}/buttons/calendar.gif" width="24" height="24" border="0" align="absmiddle"/>
            </a>
        </TD>
        <TD width="40%">
          <a class="button" href="javascript:go()">
          <font class="v8w">&#160;GO&#160;</font></a>
        </TD>
        <TD width="40%"></TD>
      </TR>
      </TABLE>
</TD></TR>
      <TR>
	      <TD style="HEIGHT: 27px" vAlign="top" align="left">&#160;
          </TD>
      </TR>


    <tr>
      <TD valign="top" align="left">   
	<div id="d1" style=" OVERFLOW-Y: scroll; OVERFLOW: scroll; WIDTH: 650px; HEIGHT: 250px">
	  <div id="d2" style=" OVERFLOW:visible; WIDTH:840px">
	    <table id="dtlResults" cellspacing="0" cellpadding="3" rules="cols" bordercolor="#999999" border="1" style="color:Black;background-color:White;border-color:#999999;border-width:1px;border-style:Solid;border-collapse:collapse;">
	      <tr>
		<td style="color:White;background-color:LightGrey;font-weight:bold;">
		  <span class="v7bbold" style="width:160px;VERTICAL-ALIGN: top">Details</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Date</span>
		  <span class="v7bbold" style="width:200px;VERTICAL-ALIGN: top">Name</span>
		  <span class="v7bbold" style="width:250px;VERTICAL-ALIGN: top">Comment</span>
		</td>
	      </tr>
              <xsl:apply-templates select="FileResultSet/File">
                <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              </xsl:apply-templates>  
  	    </table>
	  </div>
	</div>
      </TD>
    </tr>



    </tbody>
  </TABLE> 
</xsl:template>



<xsl:template match="File">
  <xsl:param name="imgBaseUrl" select="''"/>

    <xsl:variable name="fileId" select="id"/>
    <xsl:variable name="fileDate" select="dt"/>
    <xsl:variable name="fileName" select="name"/>
    <xsl:variable name="fileType" select="type"/>
    <xsl:variable name="fileComment" select="comment"/>

    <xsl:variable name="row" select="(position() mod 2)"/>

    <tr>
      <td>
        <xsl:attribute name="style">
          <xsl:choose>
            <xsl:when test="$row = 0">
              <xsl:value-of select="'background-color:#CCCCCC;'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'background-color:#FFFFFF'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <span class="v7b" style="width:160px;VERTICAL-ALIGN: top">
        <a class="button" href="javascript:details('{$fileId}')">
          <font class="v8w">&#160;VIEW&#160;</font>
        </a>&#160;
        <a class="button" href="javascript:delete('{$fileId}')">
          <font class="v8w">&#160;DELETE&#160;</font>
        </a>&#160;
        <a class="button" href="javascript:copy('{$fileId}')">
          <font class="v8w">&#160;COPY&#160;</font>
        </a>
        </span>
        <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$fileDate"/></span>
        <span class="v7b" style="width:200px;VERTICAL-ALIGN: top"><xsl:value-of select="$fileName"/></span>
        <span class="v7b" style="width:250px;VERTICAL-ALIGN: top"><xsl:value-of select="$fileComment"/></span>
       </td>
     </tr>

</xsl:template>


</xsl:stylesheet>
