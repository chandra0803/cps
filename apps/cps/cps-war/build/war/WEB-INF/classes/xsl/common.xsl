<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:java="http://xml.apache.org/xslt/java" version="1.0">

<xsl:output method="html" indent="yes"/>

<!-- 

$Revision: 1.1 $

$Log: common.xsl,v $
Revision 1.1  2004/09/24 17:02:51  vz86k2
check in

Revision 1.2  2004/08/25 22:39:58  vz86k2
update

Revision 1.1  2004/07/23 19:17:09  vz86k2
check in

Revision 1.11  2003/01/14 22:59:52  czgrdr
Fixed Comments.


-->

<xsl:variable name="formBaseUrl" select="'/webedi/go'"/>

<xsl:variable name="infImgBasePath" select="'/webedi/www/inf/images/'"/>
<xsl:variable name="helpImgBasePath" select="'/webedi/www/help/images/'"/>

<xsl:template name="Border">
  <xsl:param name="template" select="''"/>
  <xsl:param name="topContent" select="''"/>
  <xsl:param name="content" select="''"/>
  <xsl:param name="bottomContent" select="''"/>
  <xsl:param name="color"/>
  <xsl:param name="colorName"/>

      <table border="0" cellpadding="0" cellspacing="0">
        <TR>
          <td align="right" valign="top" rowspan="2" colspan="2"><img height="8" width="8" src="{$infImgBasePath}top-left-{$colorName}-corner.gif"/></td>
          <td width="10" bgcolor="#000000"><img height="1" width="1" src="{$infImgBasePath}clear.gif"/></td>
          <td width="8" valign="top" align="right" rowspan="2" colspan="2"><img height="8" width="8" src="{$infImgBasePath}top-right-{$colorName}-corner.gif"/></td>
        </TR>
        <TR>
          <TD width="50" bgcolor="{$color}"><IMG height="7" width="1" src="{$infImgBasePath}clear.gif"/></TD>
        </TR>

	<!-- top content row -->        
        <xsl:if test="$topContent != ''">
        <TR>
          <TD width="1" bgcolor="#000000"><IMG height="1" width="1" src="{$infImgBasePath}clear.gif"/></TD>
          <TD width="7" bgcolor="{$color}"><IMG height="1" width="7" src="{$infImgBasePath}clear.gif"/></TD>
          <TD align="center" bgcolor="{$color}">

	   <xsl:copy-of select="$topContent" />	
		
          </TD>
          <TD width="7" bgcolor="{$color}"><IMG height="1" width="7" src="{$infImgBasePath}clear.gif"/></TD>
          <TD width="1" bgcolor="#000000"><IMG height="1" width="1" src="{$infImgBasePath}clear.gif"/></TD>
        </TR>
        </xsl:if>

	<!-- main content row -->        
        
        <TR>
          <TD width="1" bgcolor="#000000"><IMG height="1" width="1" src="{$infImgBasePath}clear.gif"/></TD>
          <TD width="7" bgcolor="{$color}"><IMG height="1" width="7" src="{$infImgBasePath}clear.gif"/></TD>
          <TD align="center" bgcolor="{$color}">

          <xsl:if test="$template != ''">
          	<xsl:apply-templates select="$template"/>
          </xsl:if>
	   <xsl:copy-of select="$content" />	
		
          </TD>
          <TD width="7" bgcolor="{$color}"><IMG height="1" width="7" src="{$infImgBasePath}clear.gif"/></TD>
          <TD width="1" bgcolor="#000000"><IMG height="1" width="1" src="{$infImgBasePath}clear.gif"/></TD>
        </TR>
        
	<!-- bottom content row -->        
        <xsl:if test="$bottomContent != ''">
        <TR>
          <TD width="1" bgcolor="#000000"><IMG height="1" width="1" src="{$infImgBasePath}clear.gif"/></TD>
          <TD width="7" bgcolor="{$color}"><IMG height="1" width="7" src="{$infImgBasePath}clear.gif"/></TD>
          <TD align="center" bgcolor="{$color}">

	   <xsl:copy-of select="$bottomContent" />	
		
          </TD>
          <TD width="7" bgcolor="{$color}"><IMG height="1" width="7" src="{$infImgBasePath}clear.gif"/></TD>
          <TD width="1" bgcolor="#000000"><IMG height="1" width="1" src="{$infImgBasePath}clear.gif"/></TD>
        </TR>
        </xsl:if>
        <TR>
          <TD align="right" valign="bottom" rowspan="2" colspan="2"><IMG height="8" width="8" src="{$infImgBasePath}low-left-{$colorName}-corner.gif"/></TD>
          <TD width="50" bgcolor="{$color}"><IMG height="6" width="1" src="{$infImgBasePath}clear.gif"/></TD>
          <TD align="right" valign="bottom" rowspan="2" colspan="2"><IMG height="8" width="8" src="{$infImgBasePath}low-right-{$colorName}-corner.gif"/></TD>
        </TR>
        <TR>
          <TD width="50" bgcolor="#000000"><IMG height="2" width="1" src="{$infImgBasePath}clear.gif"/></TD>
        </TR>
      </table>

</xsl:template>

<xsl:template name="StandardDialog">
	<xsl:param name="content" />
	<xsl:param name="title" />
	<xsl:param name="DivID" />
	<xsl:param name="apply" />
	<xsl:param name="label" />
	<xsl:param name="useSubmit" select="'true'"/>
	<xsl:param name="cancel" />

	<xsl:call-template name="Border">
		<xsl:with-param name="content">
			<xsl:call-template name="Border">
				<xsl:with-param name="content" select="$content">
				</xsl:with-param>
				<xsl:with-param name="color" select="'#E4BD99'"/>
				<xsl:with-param name="colorName" select="'tan2'"/>
			</xsl:call-template>
		</xsl:with-param>
		<xsl:with-param name="color" select="'#FFFFFF'"/>
		<xsl:with-param name="colorName" select="'white'"/>
		<xsl:with-param name="topContent">
			<font class="v8nocolor">
				<b><xsl:copy-of select="$title" /></b><p/>
			</font>
		</xsl:with-param>
		<xsl:with-param name="bottomContent">
			<xsl:call-template name="StandardDialogButtons">
				<xsl:with-param name="DivID" select="$DivID"/>
				<xsl:with-param name="apply" select="$apply"/>
				<xsl:with-param name="label" select="$label"/>
				<xsl:with-param name="useSubmit" select="$useSubmit"/>
				<xsl:with-param name="cancel" select="$cancel"/>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>

</xsl:template>

<xsl:template name="StandardDialogButtons">
	<xsl:param name="DivID" select="''"/>
        <xsl:param name="apply" select="''"/>
        <xsl:param name="label" select="''"/>
        <xsl:param name="cancel" select="''"/>
        <xsl:param name="useSubmit" select="'true'"/>

	<table border="0" cellpadding="5" cellspacing="0" width="100%">
		<tr>
			<td bgcolor="#FFFFFF" align="center">
				&#160;
    			        <input>
				<!-- Please leave this button as a submit button -Andrew -->
			        <xsl:choose>
                                  <xsl:when test="$useSubmit = 'true'">
                                    <xsl:attribute name="type">
			               <xsl:value-of select="'submit'"/>
			            </xsl:attribute>    			            
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:attribute name="type">
			               <xsl:value-of select="'button'"/>
			            </xsl:attribute>    			            
                                  </xsl:otherwise>                                
			        </xsl:choose>

			        <xsl:choose>
			         <xsl:when test="$label != ''">
			            <xsl:attribute name="value">
			             <xsl:value-of select="$label"/>
			            </xsl:attribute>
			         </xsl:when>
			         <xsl:when test="$label = ''">
			            <xsl:attribute name="value">
			             <xsl:value-of select="'Apply'"/>
			            </xsl:attribute>
			         </xsl:when>   
			        </xsl:choose>
			
			        <xsl:if test="$apply != ''">
			          <xsl:attribute name="onClick">
			            <xsl:value-of select="$apply"/>;
			          </xsl:attribute>
			        </xsl:if>
			        </input>
			</td>
			<td bgcolor="#FFFFFF" align="center">
				<input type="button" name="cancelButton" value="Cancel">
					<xsl:if test="$DivID != ''">
					<xsl:attribute name="onClick"><xsl:value-of select="$DivID"/>.style.left=1180;
					<xsl:value-of select="$DivID"/>.style.visibility='hidden';
         				<xsl:value-of select="$cancel"/>;
        				<xsl:if test="$cancel != ''"><xsl:value-of select="$cancel"/></xsl:if>
					</xsl:attribute>
					</xsl:if>
				</input>
			</td>
		</tr>
	</table>
</xsl:template>

<xsl:template name="Option">
  <xsl:param name="entry" select="''"/>
  <xsl:param name="desc" select="''"/>
  <xsl:param name="selected" select="''"/>
  <xsl:param name="selectValue" select="''"/>

  <xsl:choose>
    <xsl:when test="$selectValue=$entry">
     <option value="{$entry}" selected="selected" visible="true"><xsl:value-of select="$desc"/></option>
    </xsl:when>
    <xsl:otherwise>
     <option value="{$entry}"><xsl:value-of select="$desc"/></option>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="TimeInput">
	<xsl:param name="inputName" select="''"/>
  <xsl:param name="tabIndex" select="'NONE'"/>

        <xsl:param name="defaultHour" select="''"/>
        <xsl:param name="defaultMinute" select="''"/>
        <xsl:param name="defaultAmPm" select="''"/>
        
    <select type="select" name="{$inputName}-HH" value="" size="1" class="v8b">
     <xsl:if test="$tabIndex != 'NONE'"><xsl:attribute name="tabIndex"><xsl:value-of select="$tabIndex"/></xsl:attribute></xsl:if>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'01'"/>
		<xsl:with-param name="desc" select="'1'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'02'"/>
		<xsl:with-param name="desc" select="'2'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'03'"/>
		<xsl:with-param name="desc" select="'3'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'04'"/>
		<xsl:with-param name="desc" select="'4'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'05'"/>
		<xsl:with-param name="desc" select="'5'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'06'"/>
		<xsl:with-param name="desc" select="'6'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'07'"/>
		<xsl:with-param name="desc" select="'7'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'08'"/>
		<xsl:with-param name="desc" select="'8'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'09'"/>
		<xsl:with-param name="desc" select="'9'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'10'"/>
		<xsl:with-param name="desc" select="'10'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'11'"/>
		<xsl:with-param name="desc" select="'11'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'12'"/>
		<xsl:with-param name="desc" select="'12'"/>
		<xsl:with-param name="selectValue" select="$defaultHour"/>
	    </xsl:call-template>
          </select> 
	  :
          <select type="select" name="{$inputName}-MM" value="" size="1"  class="v8b">
     <xsl:if test="$tabIndex != 'NONE'"><xsl:attribute name="tabIndex"><xsl:value-of select="$tabIndex + 1"/></xsl:attribute></xsl:if>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'00'"/>
		<xsl:with-param name="desc" select="'00'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'01'"/>
		<xsl:with-param name="desc" select="'01'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'02'"/>
		<xsl:with-param name="desc" select="'02'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'03'"/>
		<xsl:with-param name="desc" select="'03'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'04'"/>
		<xsl:with-param name="desc" select="'04'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'05'"/>
		<xsl:with-param name="desc" select="'05'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'06'"/>
		<xsl:with-param name="desc" select="'06'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'07'"/>
		<xsl:with-param name="desc" select="'07'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'08'"/>
		<xsl:with-param name="desc" select="'08'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'09'"/>
		<xsl:with-param name="desc" select="'09'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'10'"/>
		<xsl:with-param name="desc" select="'10'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'11'"/>
		<xsl:with-param name="desc" select="'11'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'12'"/>
		<xsl:with-param name="desc" select="'12'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'13'"/>
		<xsl:with-param name="desc" select="'13'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'14'"/>
		<xsl:with-param name="desc" select="'14'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'15'"/>
		<xsl:with-param name="desc" select="'15'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'16'"/>
		<xsl:with-param name="desc" select="'16'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'17'"/>
		<xsl:with-param name="desc" select="'17'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'18'"/>
		<xsl:with-param name="desc" select="'18'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'19'"/>
		<xsl:with-param name="desc" select="'19'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'20'"/>
		<xsl:with-param name="desc" select="'20'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'21'"/>
		<xsl:with-param name="desc" select="'21'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'2'"/>
		<xsl:with-param name="desc" select="'22'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'23'"/>
		<xsl:with-param name="desc" select="'23'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'24'"/>
		<xsl:with-param name="desc" select="'24'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'25'"/>
		<xsl:with-param name="desc" select="'25'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'26'"/>
		<xsl:with-param name="desc" select="'26'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'27'"/>
		<xsl:with-param name="desc" select="'27'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'28'"/>
		<xsl:with-param name="desc" select="'28'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'29'"/>
		<xsl:with-param name="desc" select="'29'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'30'"/>
		<xsl:with-param name="desc" select="'30'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'31'"/>
		<xsl:with-param name="desc" select="'31'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'32'"/>
		<xsl:with-param name="desc" select="'32'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'33'"/>
		<xsl:with-param name="desc" select="'33'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'34'"/>
		<xsl:with-param name="desc" select="'34'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'35'"/>
		<xsl:with-param name="desc" select="'35'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'36'"/>
		<xsl:with-param name="desc" select="'36'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'37'"/>
		<xsl:with-param name="desc" select="'37'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'38'"/>
		<xsl:with-param name="desc" select="'38'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'39'"/>
		<xsl:with-param name="desc" select="'39'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'40'"/>
		<xsl:with-param name="desc" select="'40'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'41'"/>
		<xsl:with-param name="desc" select="'41'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'42'"/>
		<xsl:with-param name="desc" select="'42'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'43'"/>
		<xsl:with-param name="desc" select="'43'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'44'"/>
		<xsl:with-param name="desc" select="'44'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'45'"/>
		<xsl:with-param name="desc" select="'45'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'46'"/>
		<xsl:with-param name="desc" select="'46'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'47'"/>
		<xsl:with-param name="desc" select="'47'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'48'"/>
		<xsl:with-param name="desc" select="'48'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'49'"/>
		<xsl:with-param name="desc" select="'49'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'50'"/>
		<xsl:with-param name="desc" select="'50'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'51'"/>
		<xsl:with-param name="desc" select="'51'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'52'"/>
		<xsl:with-param name="desc" select="'52'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'53'"/>
		<xsl:with-param name="desc" select="'53'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'54'"/>
		<xsl:with-param name="desc" select="'54'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'55'"/>
		<xsl:with-param name="desc" select="'55'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'56'"/>
		<xsl:with-param name="desc" select="'56'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'57'"/>
		<xsl:with-param name="desc" select="'57'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'58'"/>
		<xsl:with-param name="desc" select="'58'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'59'"/>
		<xsl:with-param name="desc" select="'59'"/>
		<xsl:with-param name="selectValue" select="$defaultMinute"/>
	    </xsl:call-template>
	  </select>
          <select type="select" name="{$inputName}-AM" value="" size="1"  class="v8b">
     <xsl:if test="$tabIndex != 'NONE'"><xsl:attribute name="tabIndex"><xsl:value-of select="$tabIndex + 2"/></xsl:attribute></xsl:if>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'AM'"/>
		<xsl:with-param name="desc" select="'AM'"/>
		<xsl:with-param name="selectValue" select="$defaultAmPm"/>
	    </xsl:call-template>
	    <xsl:call-template name="Option">
		<xsl:with-param name="entry" select="'PM'"/>
		<xsl:with-param name="desc" select="'PM'"/>
		<xsl:with-param name="selectValue" select="$defaultAmPm"/>
	    </xsl:call-template>
          </select>
	
</xsl:template>

<xsl:template match="Links">
        <TABLE border="0" cellpadding="5" cellspacing="0" width="100%">
          <TR align="center"><TD>
            <xsl:apply-templates select="Link"/>
          </TD></TR>
        </TABLE>
</xsl:template>


<xsl:template match="p | ul | ol | li | b | i">
  <xsl:copy>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="SupportingDocuments">

        <TABLE border="0" cellpadding="5" cellspacing="0" width="100%">
          <xsl:apply-templates select="Document"/>
        </TABLE>

</xsl:template>

<xsl:template match="Document">
  <TR>
    <TD valign="center" width="20"><IMG src="{$infImgBasePath}bluebutton.gif"/></TD>
    <TD align="left"><font class="v8nocolor"><a href="{@href}" target="doc{position()}"><xsl:apply-templates/></a></font></TD>
  </TR> 
</xsl:template>

<xsl:template name="WhiteTop">

  <TR>
    <td align="right" valign="top" rowspan="2" colspan="2"><img height="8" width="8" src="{$infImgBasePath}top-left-white-corner.gif"/></td>
    <td width="200" bgcolor="#000000"><img height="1" width="1" src="{$infImgBasePath}clear.gif"/></td>
    <td width="8" valign="top" align="right" rowspan="2" colspan="2"><img height="8" width="8" src="{$infImgBasePath}top-right-white-corner.gif"/></td>
    <td width="6" rowspan="5"><img height="1" width="6" src="{$infImgBasePath}clear.gif"/></td>
    <td width="50" valign="middle" rowspan="5"></td>
  </TR>
  <TR>
    <TD width="50" bgcolor="#FFFFFF"><IMG height="7" width="1" src="{$infImgBasePath}clear.gif"/></TD>
  </TR>
</xsl:template>

<xsl:template name="WhiteBottom">

  <TR>
    <TD align="right" valign="bottom" rowspan="2" colspan="2"><IMG height="8" width="8" src="{$infImgBasePath}low-left-white-corner.gif"/></TD>
    <TD width="50" bgcolor="#FFFFFF"><IMG height="6" width="1" src="{$infImgBasePath}clear.gif"/></TD>
    <TD align="right" valign="bottom" rowspan="2" colspan="2"><IMG height="8" width="8" src="{$infImgBasePath}low-right-white-corner.gif"/></TD>
  </TR>
  <TR>
    <TD width="50" bgcolor="#000000"><IMG height="2" width="1" src="{$infImgBasePath}clear.gif"/></TD>
  </TR>
</xsl:template>

<xsl:template name="StandardTabHeader">
	<xsl:param name="title" />
	<xsl:param name="width" />
	<xsl:param name="content" />
         
  <TABLE border="0" cellpadding="0" cellspacing="0" width="{$width}">
  <TR> 
    <TD><img src="{$infImgBasePath}clear.gif" height="2"/></TD>
  </TR>
  <TR>
    <td align="left"><font class="v10blueA"><b><xsl:value-of select="$title"/></b></font></td>
    <td align="right"><img src="{$infImgBasePath}version.gif" border="1"/></td>
  </TR>
  </TABLE>

  <HR/>

  <TABLE border="0" cellpadding="0" cellspacing="0" width="{$width}">
  <TR> 
    <td align="left"><font class="v8b"><xsl:value-of select="$content"/></font></td>
  </TR>
  <TR> 
    <TD><img src="{$infImgBasePath}clear.gif" height="8"/></TD>
  </TR>
  </TABLE>

</xsl:template>

<xsl:template name="RemoveLeadingZeros">
	<xsl:param name="sourceString"/>
    <xsl:choose>
        <xsl:when test="substring($sourceString,1,1) = 0">
          <xsl:call-template name="RemoveLeadingZeros">
            <xsl:with-param name="sourceString" select="substring($sourceString,2)"/>
          </xsl:call-template>
        </xsl:when> 
        <xsl:otherwise><xsl:value-of select="$sourceString"/></xsl:otherwise> 
    </xsl:choose> 
</xsl:template>


</xsl:stylesheet>
