<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" version="1.0">
<xsl:import href="../../screen.xsl"/>
<xsl:import href="../commonCriteria.xsl"/>
<xsl:output method="html" indent="yes"/>

<!--
$Revision: 1.5 $

$Log: viewData.xsl,v $
Revision 1.5  2004/11/05 18:59:20  zz0qx3
changes post 11/4 review

Revision 1.4  2004/10/27 21:02:22  zz0qx3
changes this week

Revision 1.3  2004/10/20 15:28:01  vz86k2
update based on prototype review

Revision 1.2  2004/09/29 13:31:05  vz86k2
update

Revision 1.1  2004/09/24 17:04:22  vz86k2
check in

Revision 1.1  2004/07/23 19:17:41  vz86k2
check in


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

  <xsl:variable name="fileName" select="../Model/Session/CurrentFile/File/name"/>
  <xsl:variable name="fileDt" select="../Model/Session/CurrentFile/File/dt"/>
  <xsl:variable name="fileType" select="../Model/Session/CurrentFile/File/type"/>
  <xsl:variable name="fileComment" select="../Model/Session/CurrentFile/File/comment"/>

  <xsl:variable name="cStartRowId" select="../Model/Session/ResultSetPagingManager/@cStartRowId"/>
  <xsl:variable name="cEndRowId" select="../Model/Session/ResultSetPagingManager/@cEndRowId"/>
  <xsl:variable name="nRows" select="../Model/Session/ResultSetPagingManager/@nRows"/>
  <xsl:variable name="cPageNumRows" select="../Model/Session/ResultSetPagingManager/@cPageNumRows"/>
  <xsl:variable name="firstB" select="../Model/Session/ResultSetPagingManager/@firstB"/>
  <xsl:variable name="lastB" select="../Model/Session/ResultSetPagingManager/@lastB"/>
  <xsl:variable name="nextB" select="../Model/Session/ResultSetPagingManager/@nextB"/>
  <xsl:variable name="prevB" select="../Model/Session/ResultSetPagingManager/@prevB"/>



  <TABLE id="Table1" cellSpacing="0" cellPadding="0" height="100%" width="100%" border="0" class="tbllb">
    <thead>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="2">Current File</TD>
      </TR>
    </thead>
    <tbody>
      <TR>
	<TD  width="75px" vAlign="top" align="right">Name:&#160;</TD>
	<TD align="left" vAlign="top" ><xsl:value-of select="$fileName"/></TD>
      </TR>
      <TR>
	<TD  vAlign="top" align="right">Date:&#160;</TD>
	<TD vAlign="top" ><xsl:value-of select="$fileDt"/></TD>
      </TR>
      <TR>
	<TD vAlign="top" align="right">Comment:&#160;</TD>
	<TD vAlign="top" ><xsl:value-of select="$fileComment"/></TD>
      </TR>
      <TR>
	<TD  vAlign="top" align="right">Author:&#160;</TD>
	<TD vAlign="top" ><xsl:value-of select="'vz86k2'"/></TD>
      </TR>
      <TR>
	<TD style="HEIGHT: 22px" colSpan="2">&#160;</TD>
      </TR>
     </tbody>
  </TABLE>




      <xsl:call-template name="Criteria">
        <xsl:with-param name="addSectionTitle" select="'Select Filter Criteria'"/>
        <xsl:with-param name="tableSectionTitle" select="'Filter Criteria'"/>
      </xsl:call-template>



  <table id="tblResults" class="tbllb" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <TD><font class="v7aquaABoldItalic">File Data</font></TD>
    </tr>
    <tr>
      <TD valign="top" align="left">
        <TABLE id="Table1" border="0" class="tbllb" cellspacing="0" style="PADDING-RIGHT: 0px;PADDING-LEFT: 0px;PADDING-BOTTOM: 0px;PADDING-TOP: 0px">
	  <tbody>
	    <TR>
              <TD align="center" valign="top" nowrap="true">
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
		</select>&#160;<br/>
                  <a class="button" href="javascript:selectPage('firstPage')">
                    <font class="v8w">&#160;&lt;&lt; First Page&#160;</font></a>&#160;
                  <a class="button" href="javascript:selectPage('prevPage')">
	            <font class="v8w">&#160;&lt; Previous Page&#160;</font></a>&#160;

                  <a class="button" href="javascript:selectPage('nextPage')">
                    <font class="v8w">&#160;Next Page &gt;&gt;&#160;</font></a>&#160;
                  <a class="button" href="javascript:selectPage('lastPage')">
	            <font class="v8w">&#160;Last Page &gt;&#160;</font></a>&#160;<br/>
                 <a class="button" href="javascript:selectPage('lastPage')">
	            <font class="v8w">&#160;Delete Selected&#160;</font></a>&#160;
                 <a class="button" href="javascript:selectPage('lastPage')">
	            <font class="v8w">&#160;Save&#160;</font></a>&#160;
                 <a class="button" href="javascript:selectPage('lastPage')">
	            <font class="v8w">&#160;Copy Selected&#160;</font></a>&#160;
              </TD>		
	    </TR>
	  </tbody>
        </TABLE>
      </TD>
    </tr>
    <tr>
      <TD valign="top" align="left">   
	<div id="d1" style=" OVERFLOW-Y: scroll; OVERFLOW: scroll; WIDTH: 650px; HEIGHT: 250px">
	  <div id="d2" style=" OVERFLOW:visible; WIDTH:1125px">
	    <table id="dtlResults" cellspacing="0" cellpadding="3" rules="cols" bordercolor="#999999" border="1" style="color:Black;background-color:White;border-color:#999999;border-width:1px;border-style:Solid;border-collapse:collapse;">
	      <tr>
		<td style="color:White;background-color:LightGrey;font-weight:bold;">
		  <span class="v7bbold" style="width:25px;VERTICAL-ALIGN: top">&#160;</span>
		  <span class="v7bbold" style="width:25px;VERTICAL-ALIGN: top">#</span>
		  <span class="v7bbold" style="width:50px;VERTICAL-ALIGN: top">CVA</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">DRI Model Range</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">DRI Model Variant</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">DRI Platform</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">DRI Production Brand</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">DRI Vehicle Manufacturer</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Marketing Area</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Model Run</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Vehicle Type</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Year</span>
		  <span class="v7bbold" style="width:100px;VERTICAL-ALIGN: top">Volume</span>
		</td>
	      </tr>
              <xsl:apply-templates select="FileDataResultSet/FileData">
                <xsl:with-param name="imgBaseUrl" select="$imgBaseUrl"/>
              </xsl:apply-templates>  
  	    </table>
	  </div>
	</div>
      </TD>
    </tr>
  </table>

</xsl:template>

<xsl:template match="FileData">
  <xsl:param name="imgBaseUrl" select="''"/>

    <xsl:variable name="id" select="id"/>
    <xsl:variable name="cva" select="cva"/>
    <xsl:variable name="driModelRange" select="rng"/>
    <xsl:variable name="driModelVariant" select="var"/>
    <xsl:variable name="driPlatform" select="plat"/>
    <xsl:variable name="driProdBRand" select="brnd"/>
    <xsl:variable name="driVehMan" select="man"/>
    <xsl:variable name="marketArea" select="area"/>
    <xsl:variable name="modelRun" select="run"/>
    <xsl:variable name="vehType" select="type"/>
    <xsl:variable name="year" select="yr"/>
    <xsl:variable name="volume" select="vol"/>

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
	  <span class="v7b" style="width:25px;VERTICAL-ALIGN: top"><input type="checkbox"/></span>
	  <span class="v7b" style="width:25px;VERTICAL-ALIGN: top"><xsl:value-of select="$id"/></span>
	  <span class="v7b" style="width:50px;VERTICAL-ALIGN: top"><xsl:value-of select="$cva"/></span>
	  <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$driModelRange"/></span>
	  <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$driModelVariant"/></span>
	  <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$driPlatform"/></span>
	  <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$driProdBRand"/></span>
	  <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$driVehMan"/></span>
	  <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$marketArea"/></span>
	  <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$modelRun"/></span>
	  <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$vehType"/></span>
	  <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$year"/></span>
	  <span class="v7b" style="width:100px;VERTICAL-ALIGN: top"><xsl:value-of select="$volume"/></span>
       </td>
     </tr>

</xsl:template>


</xsl:stylesheet>
