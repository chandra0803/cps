<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="D:/CPS/cps-war/web/WEB-INF/classes/xsl/screen.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.3 $

$Log: selectFile.xsl,v $
Revision 1.3  2004/11/04 16:58:53  zz0qx3
mass update 11/4

Revision 1.2  2004/10/05 18:30:26  zz0qx3
export file prototype


-->

<xsl:variable name="javaScriptBaseUrl" select="Screen/Model/Entity/JavaScriptBaseUrl"/>
<xsl:variable name="htmlBaseUrl" select="Screen/Model/Entity/HtmlBaseUrl"/>

<xsl:template name="LocalScript">

  <script type="text/javascript" language="javascript" src="{$javaScriptBaseUrl}/calendar.js"></script>

  <script type="text/javascript" language="javascript">

    function pageLoaded()
    {
    }

    function popupCalendar(dateField, evnt)
    {
      var w=(screen.width/2)-105;
      var h=(screen.height/2)-115;
      setDateField(dateField);
 
      var properties = "left=" + (evnt.screenX + 20);
      properties += ",top=" + (evnt.screenY + 1);
      properties += 'dependent=yes,width=210,height=230,screenX='+h+',screenY='+w+',titlebar=yes'
      top.newWin = window.open('<xsl:value-of select="$htmlBaseUrl"/>/calendar.html','cal', properties);
      top.newWin.focus();
    }

  </script>

</xsl:template>

<xsl:template match="View">
  <xsl:param name="imgBaseUrl" select="''"/>


  <xsl:variable name="userName" select="../Model/Session/SelectFileCriteria/@userid"/>
  <xsl:variable name="role" select="../Model/Session/SelectFileCriteria/@roleid"/>
  <xsl:variable name="currentFromDt" select="../Model/Session/SelectFileCriteria/@comment"/>


  <TABLE id="Table1" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <tbody>
      
      <TR>
	<TD style="HEIGHT: 22px" colSpan="5"></TD>
      </TR>
      <TR>
    <TD style="WIDTH: 80px" vAlign="top" align="left"><font class="v7aquaABoldItalic">Add User</font></TD>
  
	</TR>
<TR><TD>&#160;</TD></TR>

      <TR>
	<TD style="WIDTH: 60px" vAlign="top" align="right">User  Name:&#160;</TD>
	<TD vAlign="top"><input name="filename" type="text" style="width:232px;" value="{$userName}"/></TD>

      </TR>

      <TR>
	<TD style="WIDTH: 60px" vAlign="top" align="right">Role:&#160;</TD>
	<TD vAlign="top">

		<select name="pageNumRows" onchange="changeRowsPerPage()" language="javascript" id="rowsPerPage">
    		  <option value="Admin">Admin</option>
    		  <option value="Scripting">Scripting</option>
    		  <option value="OnLine">OnLine</option>
	
		</select>&#160;
        </TD>

	
      </TR>
     <TR>
       <TD  align="right">
         <span class="v7b" style="width:70px;VERTICAL-ALIGN: top">
        <a class="button" >
          <font class="v8w">&#160;Add User&#160;</font>
        </a>
	</span>
        </TD>
    </TR>

      
      <TR>
	<TD style="HEIGHT: 22px" colSpan="5"></TD>

      </TR>

    </tbody>
  </TABLE>

    <xsl:call-template name="Results">
      <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
      <xsl:with-param name="cStartRowId" select="../Model/Session/ResultSetPagingManager/@cStartRowId"/>
      <xsl:with-param name="cEndRowId" select="../Model/Session/ResultSetPagingManager/@cEndRowId"/>
      <xsl:with-param name="nRows" select="../Model/Session/ResultSetPagingManager/@nRows"/>
      <xsl:with-param name="cPageNumRows" select="../Model/Session/ResultSetPagingManager/@cPageNumRows"/>
      <xsl:with-param name="firstB" select="../Model/Session/ResultSetPagingManager/@firstB"/>
      <xsl:with-param name="lastB" select="../Model/Session/ResultSetPagingManager/@lastB"/>
      <xsl:with-param name="nextB" select="../Model/Session/ResultSetPagingManager/@nextB"/>
      <xsl:with-param name="prevB" select="../Model/Session/ResultSetPagingManager/@prevB"/>
    </xsl:call-template>
  
</xsl:template>

<xsl:template name="Results">
  <xsl:param name="imgBaseUrl" select="''"/>
  <xsl:param name="cStartRowId" select="1"/>
  <xsl:param name="cEndRowId" select="1"/>
  <xsl:param name="nRows" select="1"/>
  <xsl:param name="cPageNumRows" select="10"/>
  <xsl:param name="firstB" select="'false'"/>
  <xsl:param name="lastB" select="'false'"/>
  <xsl:param name="nextB" select="'false'"/>
  <xsl:param name="prevB" select="'false'"/>

  <table id="tblResults" class="tbllb" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <TD><font class="v7aquaABoldItalic">Available Users</font></TD>
    </tr>
    <tr>
      <TD valign="top" align="left">
        <TABLE id="Table1" border="0" class="tbllb" cellspacing="0" style="PADDING-RIGHT: 0px;PADDING-LEFT: 0px;PADDING-BOTTOM: 0px;PADDING-TOP: 0px">
	  <tbody>
	    <TR>
              <TD align="center" valign="top" nowrap="true">
                <xsl:if test="$firstB = 'true'">
                  <a class="button" href="javascript:selectPage('firstPage')">
                    <font class="v8w">&#160;&lt;&lt; First Page&#160;</font></a>&#160;
                </xsl:if>
                <xsl:if test="$prevB = 'true'">
                  <a class="button" href="javascript:selectPage('prevPage')">
	            <font class="v8w">&#160;&lt; Previous Page&#160;</font></a>&#160;
                </xsl:if>
                <font class="v7b">Displaying range&#160;</font>
                <b><span id="paging_lblBegin"><xsl:value-of select="$cStartRowId"/></span></b><font class="v7b">&#160;to&#160;</font>
                <b><span id="paging_lblEnd"><xsl:value-of select="$cEndRowId"/></span></b><font class="v7b">&#160;of&#160;</font>
                <b><span id="paging_lblCount"><xsl:value-of select="$nRows"/></span></b><font class="v7b">&#160;records.&#160;&#160;</font>
		<span id="paging_lblPageNumber" class="v7b">Number of Record per Page:</span>
		<select name="pageNumRows" onchange="changeRowsPerPage()" language="javascript" id="rowsPerPage">
    		  <option value="10">10</option>
    		  <option value="20">20</option>
    		  <option value="30">30</option>
    		  <option value="40">40</option>
    		  <option value="50">50</option>
		</select>&#160;

                  <a class="button" href="javascript:selectPage('nextPage')">
                    <font class="v8w">&#160;Save &#160;</font></a>&#160;

              </TD>		
	    </TR>
	  </tbody>
        </TABLE>
      </TD>
    </tr>
    <tr>
      <TD valign="top" align="left">   
	<div id="d1" style=" OVERFLOW-Y: scroll; OVERFLOW: scroll; WIDTH: 650px; HEIGHT: 250px">
	  <div id="d2" style=" OVERFLOW:visible; WIDTH:840px">
	    <table id="dtlResults" cellspacing="0" cellpadding="3" rules="cols" bordercolor="#999999" border="1" style="color:Black;background-color:White;border-color:#999999;border-width:1px;border-style:Solid;border-collapse:collapse;">
	      <tr>
		<td style="color:White;background-color:LightGrey;font-weight:bold;">
		  <span class="v7bbold" style="width:160px;VERTICAL-ALIGN: top">Action</span>
		<!--  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Userid</span>-->
		  <span class="v7bbold" style="width:200px;VERTICAL-ALIGN: top">User</span>
		  <span class="v7bbold" style="width:250px;VERTICAL-ALIGN: top">Role</span>

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
  </table>

</xsl:template>

<xsl:template match="File">
  <xsl:param name="imgBaseUrl" select="''"/>

    <xsl:variable name="userid" select="userid"/>
    <xsl:variable name="roleid" select="roleid"/>
    <xsl:variable name="netid" select="netid"/>
   <xsl:variable name="Comment" select="comment"/>

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
        <a class="button" href="javascript:copy('{$userid}')">
          <font class="v8w">&#160;DELETE&#160;</font>
        </a>
        </span><!-- displaying  values -->
<!--        <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$userid"/></span> -->
        <span class="v7b" style="width:200px;VERTICAL-ALIGN: top">
	<input name="username" type="text" style="width:62px;" value="{$netid}"/></span>
        <span class="v7b" style="width:250px;VERTICAL-ALIGN: top">
<select name="pageNumRows" onchange="changeRowsPerPage()" language="javascript" id="roleid">
    		  <option value="Admin">Admin</option>
    		  <option value="Scripting">Scripting</option>
    		  <option value="OnLine">OnLine</option>
<!-- <option><xsl:value-of select="$Comment"/></option>-->
</select></span> 

       </td>
     </tr>

</xsl:template>

</xsl:stylesheet>
