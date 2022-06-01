<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="text" indent="no" media-type="text/plain"/>

<xsl:include href="boCommon.xsl"/>

<xsl:variable name="classExtension" select="'ImplBase'"/>

<xsl:template match="/">
<xsl:variable name="className" select='concat(/BusinessObject/@name,$classExtension)'/>
<xsl:variable name="boClassName" select="/BusinessObject/@name"/>
/**
 *
 * Class: <xsl:value-of select="$className"/>
 *
 * This is a generated Class. Do not modify directly.
 * Subclasses are provided for extending this class.
 **/

package <xsl:value-of select="/BusinessObject/@package"/>;

import java.io.*;
import java.sql.*;
import oracle.sql.*;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.apache.commons.logging.*;

/** 
<xsl:value-of select="/BusinessObject/Overview"/>
This class is the implementation base object, and should be extended (if necessary)
using the subclass <xsl:value-of select="$boClassName"/>.
*/
public class <xsl:value-of select="$className"/>
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(<xsl:value-of select="$className"/>.class);
  public static int BUFFER_LENGTH = 4096;

<xsl:call-template name="Variables"/>
  public <xsl:value-of select="$className"/>()
  {
    setSelectedForUpdate(false);
  }
<xsl:call-template name="GetSetMethods"/>

  public String toString()
  {
    StringBuffer sb = new StringBuffer();
  <xsl:for-each select="/BusinessObject/Columns/Column">    sb.append("<xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@objectName"/> = ");
    sb.append(get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>()) ;
    sb.append("\n");
<xsl:if test="@javaType = 'CLOB'">
    sb.append("boolean <xsl:value-of select="@objectName"/>Modified = ");
    sb.append(get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Modified()) ;
    sb.append("\n");
<xsl:if test="(/BusinessObject/@lazyDereference = 'false')">
    sb.append("String <xsl:value-of select="@objectName"/>String = ");
    sb.append(get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>String()) ;
    sb.append("\n");
</xsl:if>
</xsl:if>
<xsl:if test="@javaType = 'BLOB'">
    sb.append("boolean <xsl:value-of select="@objectName"/>Modified = ");
    sb.append(get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Modified()) ;
    sb.append("\n");
<xsl:if test="(/BusinessObject/@lazyDereference = 'false')">
    sb.append("bytes[] <xsl:value-of select="@objectName"/>Bytes length is ");
    if (get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Bytes() != null)
    {
      sb.append(get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Bytes().length) ;
    }
    else
    {
      sb.append("(byte array is null)");
    }
    sb.append("\n");
</xsl:if>
</xsl:if>
</xsl:for-each> 
    sb.append("selectedForUpdate = ");
    sb.append(selectedForUpdate) ;
    sb.append("\n");
    return sb.toString();
  }

  public org.w3c.dom.Element getElement(org.w3c.dom.Document doc) 
    throws SQLException
  {
    org.w3c.dom.Element node = (org.w3c.dom.Element)doc.createElement("<xsl:value-of select="$boClassName"/>");
    String temp = null;

<xsl:choose>
<xsl:when test="/BusinessObject/@useXMLAttributes = 'true'">
  <xsl:call-template name="SetAttributes">
  <xsl:with-param name="className" select="$boClassName"/>
  </xsl:call-template>
</xsl:when>
<xsl:otherwise>
  <xsl:call-template name="SetElements">
  <xsl:with-param name="className" select="$boClassName"/>
  </xsl:call-template>
</xsl:otherwise>
</xsl:choose>   

    return node;
  }


<xsl:if test="/BusinessObject/Columns/Column[@javaType = 'BLOB']">
  /**
  * Reads a BLOB object and returns an array of bytes.
  **/
  private byte[] getBlobByteArray(BLOB b) throws SQLException
  {
    InputStream is = null;
    byte [] result = null;
    int len;
    byte [] buf = new byte[BUFFER_LENGTH];

    try 
    {
      is = b.getBinaryStream();
      ByteArrayOutputStream baos = new java.io.ByteArrayOutputStream();

      while ((len = is.read(buf)) > 0)
      {
        baos.write(buf, 0, len);
      }

      result = baos.toByteArray();
      baos.close();
    }
    catch (java.io.IOException ioe) 
    {
      throw new SQLException("Unable to read binary stream: " + ioe.toString());
    }
    finally
    {
      try
      {
        if (is != null)
          is.close();
      }
      catch (java.io.IOException ioe)
      {
        Logger.error(CNAME, "Unable to close binary stream", ioe);
      }
    }

    return result;
  }
</xsl:if>

<xsl:if test="/BusinessObject/Columns/Column[@javaType = 'CLOB']">
  /**
  * Reads a CLOB object and returns a String.
  **/

  private String getClobString(oracle.sql.CLOB c)
    throws SQLException
  {
    String result = null;
    Reader r = null;

    try 
    {
      if (c != null)
      {
        r = c.getCharacterStream();
        StringWriter sw = new StringWriter();
        int len = 0;
        char buff[] = new char[BUFFER_LENGTH];

        while ((len = r.read(buff, 0, BUFFER_LENGTH)) > 0)
        {
          sw.write(buff, 0, len);
        }
        
        result = sw.toString();
      }
    }
    catch (java.io.IOException ioe) 
    {
      throw new SQLException("Unable to read character stream: " + ioe.toString());
    }
    finally
    {
      try
      {
        if (r != null)
          r.close();
      }
      catch (java.io.IOException ioe)
      {
        Logger.error(CNAME, "Unable to close reader", ioe);
      }
    }

    return result;
  }
</xsl:if>

}
</xsl:template>

<xsl:template name="Variables">
<xsl:for-each select="/BusinessObject/Columns/Column">  private <xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@objectName"/>;
<xsl:if test="@javaType = 'CLOB'">  private String <xsl:value-of select="@objectName"/>String = null;
  private boolean <xsl:value-of select="@objectName"/>Modified = false;
</xsl:if>
<xsl:if test="@javaType = 'BLOB'">  private byte[] <xsl:value-of select="@objectName"/>Bytes = null;
  private boolean <xsl:value-of select="@objectName"/>Modified = false;
</xsl:if>
</xsl:for-each> 
  private boolean selectedForUpdate;
</xsl:template>

<xsl:template name="GetSetMethods">
<xsl:for-each select="/BusinessObject/Columns/Column">
<xsl:text>  </xsl:text><xsl:choose><xsl:when test="((@javaType = 'CLOB') or (@javaType = 'BLOB'))">protected</xsl:when><xsl:otherwise>public</xsl:otherwise></xsl:choose> void set<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>( <xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@objectName"/> )
<xsl:if test="((/BusinessObject/@lazyDereference = 'false') and ((@javaType = 'CLOB') or (@javaType = 'BLOB')))">    throws SQLException</xsl:if>
  {
    this.<xsl:value-of select="@objectName"/> = <xsl:value-of select="@objectName"/>;
<xsl:if test="(/BusinessObject/@lazyDereference = 'false')">
<xsl:if test="@javaType = 'CLOB'">
      <xsl:value-of select="@objectName"/>String = getClobString(<xsl:value-of select="@objectName"/>);
</xsl:if>
<xsl:if test="@javaType = 'BLOB'">
      <xsl:value-of select="@objectName"/>Bytes = getBlobByteArray(<xsl:value-of select="@objectName"/>);
</xsl:if>
</xsl:if>
  }

  public <xsl:value-of select="@javaType"/> get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>()
  {
    return <xsl:value-of select="@objectName"/>;
  }
<xsl:if test="@javaType = 'CLOB'">
  public void set<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>String( String<xsl:text> </xsl:text><xsl:value-of select="@objectName"/>String )
  {
    this.<xsl:value-of select="@objectName"/>String = <xsl:value-of select="@objectName"/>String;
    <xsl:value-of select="@objectName"/>Modified = true;
  }

  public String get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>String()
<xsl:if test="((not(/BusinessObject/@lazyDereference = 'false')) and ((@javaType = 'CLOB') or (@javaType = 'BLOB')))">    throws SQLException</xsl:if>
  {
<xsl:if test="(not(/BusinessObject/@lazyDereference = 'false'))">
    if (( <xsl:value-of select="@objectName"/> != null) &amp;&amp; (<xsl:value-of select="@objectName"/>String == null) &amp;&amp; (!<xsl:value-of select="@objectName"/>Modified))
    {
      <xsl:value-of select="@objectName"/>String = getClobString(<xsl:value-of select="@objectName"/>);
    }
</xsl:if>
    return <xsl:value-of select="@objectName"/>String;
  }

  public boolean get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Modified()
  {
    return <xsl:value-of select="@objectName"/>Modified;
  }
</xsl:if>
<xsl:if test="@javaType = 'BLOB'">
  public void set<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Bytes( byte[]<xsl:text> </xsl:text><xsl:value-of select="@objectName"/>Bytes )
  {
    this.<xsl:value-of select="@objectName"/>Bytes = <xsl:value-of select="@objectName"/>Bytes;
    <xsl:value-of select="@objectName"/>Modified = true;
  }

  public byte[] get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Bytes()
<xsl:if test="((not(/BusinessObject/@lazyDereference = 'false')) and ((@javaType = 'CLOB') or (@javaType = 'BLOB')))">    throws SQLException</xsl:if>
  {
<xsl:if test="(not(/BusinessObject/@lazyDereference = 'false'))">
    if (( <xsl:value-of select="@objectName"/> != null) &amp;&amp; (<xsl:value-of select="@objectName"/>Bytes == null) &amp;&amp; (!<xsl:value-of select="@objectName"/>Modified))
    {
      <xsl:value-of select="@objectName"/>Bytes = getBlobByteArray(<xsl:value-of select="@objectName"/>);
    }
</xsl:if>
    return <xsl:value-of select="@objectName"/>Bytes;
  }

  public boolean get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Modified()
  {
    return <xsl:value-of select="@objectName"/>Modified;
  }
</xsl:if>
</xsl:for-each> 
  protected void setSelectedForUpdate(boolean selectedForUpdate)
  {
    this.selectedForUpdate = selectedForUpdate;
  }
  
  public boolean getSelectedForUpdate()
  {
    return selectedForUpdate;
  }
</xsl:template>

<xsl:template name="SetAttributes">
  <xsl:param name="className" select="''"/>
<xsl:for-each select="/BusinessObject/Columns/Column">
<xsl:text>    </xsl:text>if (get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template><xsl:choose><xsl:when test="@javaType = 'CLOB'">String</xsl:when><xsl:when test="@javaType = 'BLOB'">Bytes</xsl:when></xsl:choose>() != null)
<xsl:text>    </xsl:text>{
<xsl:text>      </xsl:text>temp = ""+get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template><xsl:choose><xsl:when test="@javaType = 'CLOB'">String</xsl:when><xsl:when test="@javaType = 'BLOB'">Bytes</xsl:when></xsl:choose>();
<xsl:text>      </xsl:text>node.setAttribute("<xsl:value-of select="@objectName"/>", temp);
<xsl:text>      </xsl:text>//Logger.debug(CNAME, "<xsl:value-of select="@objectName"/> = " + temp);
<xsl:text>    </xsl:text>}
</xsl:for-each> 
</xsl:template>

<xsl:template name="SetElements">
  <xsl:param name="className" select="''"/>
    Element element = null;
<xsl:for-each select="/BusinessObject/Columns/Column">
<xsl:text>    </xsl:text>if (get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template><xsl:choose><xsl:when test="@javaType = 'CLOB'">String</xsl:when><xsl:when test="@javaType = 'BLOB'">Bytes</xsl:when></xsl:choose>() != null)
<xsl:text>    </xsl:text>{
<xsl:text>      </xsl:text>temp = ""+get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template><xsl:choose><xsl:when test="@javaType = 'CLOB'">String</xsl:when><xsl:when test="@javaType = 'BLOB'">Bytes</xsl:when></xsl:choose>();
<xsl:text>      </xsl:text>element = (Element)doc.createElement("<xsl:value-of select="@objectName"/>");
<xsl:choose>
<xsl:when test="((@javaType = 'CLOB') and (@isXml = 'true'))"><xsl:text>      </xsl:text>element.appendChild(doc.importNode(com.jdm.util.XMLUtils.getDOM(temp).getDocumentElement(), true));
</xsl:when>
<xsl:otherwise><xsl:text>      </xsl:text>element.appendChild((org.w3c.dom.Text)doc.createTextNode(temp));
</xsl:otherwise>
</xsl:choose>
<xsl:text>      </xsl:text>node.appendChild(element);
<xsl:text>      </xsl:text>//Logger.debug(CNAME, "<xsl:value-of select="@objectName"/> = " + temp);
<xsl:text>    </xsl:text>}
</xsl:for-each> 
</xsl:template>

</xsl:stylesheet>
