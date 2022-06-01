<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:include href="boCommon.xsl"/>

<xsl:output method="text" indent="no" media-type="text/plain"/>

<xsl:variable name="classExtension" select="'FactoryImplBase'"/>
<xsl:variable name="sequenceBased">
  <xsl:choose>
    <xsl:when test="((count(/BusinessObject/Columns/Column[@isPk = 'true']) > 1) or (/BusinessObject/@insertUsesSequence = 'false') or (/BusinessObject/@childTable = 'true'))">false</xsl:when>
    <xsl:otherwise>true</xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:template match="BusinessObject">
<xsl:variable name="className" select='concat(@name,$classExtension)'/>
<xsl:variable name="boClassName" select="@name"/>
<xsl:variable name="cacheOk">
  <xsl:choose>
  <xsl:when test="(((/BusinessObject/Columns/Column[@javaType = 'CLOB']) or (/BusinessObject/Columns/Column[@javaType = 'BLOB'])) and (not(/BusinessObject/@lazyDereference = 'false')))">false</xsl:when>
  <xsl:otherwise>true</xsl:otherwise>
  </xsl:choose>
</xsl:variable>

/**
 *
 * Class: <xsl:value-of select="$className"/>
 *
 * This is a generated Class. Do not modify directly.
 * Other classes are provided for extending this class.
 **/

package <xsl:value-of select="@package"/>;

import com.delphi.gfad.coreframework.db.*;

import java.sql.*;
import java.util.*;
import java.math.BigDecimal;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
// required for CLOB/BLOB insert/update code
import oracle.sql.*;
import org.apache.commons.logging.*;

/** 
This class is the implementation base factory, and should be extended (if necessary)
using the subclass <xsl:value-of select="concat(/BusinessObject/@name,'Factory')"/>.
<xsl:value-of select="/BusinessObject/Overview"/>
SQL Statements used are as follows&lt;blink&gt;:&lt;/blink&gt;&lt;p&gt;
&lt;table border="1"&gt;
&lt;tr&gt;&lt;th&gt;Action&lt;/th&gt;&lt;th&gt;SQL&lt;/th&gt;&lt;th&gt;Parameters&lt;/th&gt;&lt;/tr&gt;
<xsl:for-each select="/BusinessObject/Queries/Fetch"><xsl:if test="@forSelect = 'true'">&lt;tr&gt;&lt;td&gt;Fetch <xsl:value-of select="@name"/>&lt;/td&gt;&lt;td&gt;&lt;code&gt;<xsl:value-of select="normalize-space(SQL)"/>&lt;/code&gt;&lt;/td&gt;&lt;td&gt;<xsl:for-each select="Parameters/Parameter"><xsl:if test="position() > 1"><xsl:text>, </xsl:text></xsl:if><xsl:value-of select="@name"/></xsl:for-each><xsl:text> </xsl:text>&lt;/td&gt;&lt;/tr&gt;
</xsl:if>
<xsl:if test="@forUpdate = 'true'">&lt;tr&gt;&lt;td&gt;Fetch <xsl:value-of select="@name"/> FOR UPDATE&lt;/td&gt;&lt;td&gt;&lt;code&gt;<xsl:value-of select="normalize-space(SQL)"/> FOR UPDATE&lt;/code&gt;&lt;/td&gt;&lt;td&gt;<xsl:for-each select="Parameters/Parameter"><xsl:if test="position() > 1"><xsl:text>, </xsl:text></xsl:if><xsl:value-of select="@name"/></xsl:for-each>&lt;/td&gt;&lt;/tr&gt;
</xsl:if>
</xsl:for-each>
<xsl:if test="/BusinessObject/@transTable">
&lt;tr&gt;&lt;td&gt;Lock Table SQL&lt;/td&gt;&lt;td&gt;&lt;code&gt;LOCK TABLE <xsl:value-of select="/BusinessObject/@transTable"/> IN EXCLUSIVE MODE&lt;/code&gt;&lt;/td&gt;&lt;td&gt;&lt;i&gt;N/A&lt;/i&gt;&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;Insert <xsl:value-of select="@name"/> SQL&lt;/td&gt;&lt;td&gt;&lt;code&gt;INSERT INTO <xsl:value-of select="/BusinessObject/@transTable"/>(<xsl:for-each select="/BusinessObject/Columns/Column"><xsl:if test="position() > 1"><xsl:text>, </xsl:text></xsl:if><xsl:value-of select="@columnName"/></xsl:for-each>) VALUES (<xsl:for-each select="/BusinessObject/Columns/Column"><xsl:if test="position() > 1"><xsl:text>, </xsl:text></xsl:if><xsl:choose><xsl:when test="@value"><xsl:value-of select="@value"/></xsl:when><xsl:otherwise>?</xsl:otherwise></xsl:choose></xsl:for-each>)&lt;/code&gt;&lt;/td&gt;&lt;td&gt;<xsl:value-of select="$boClassName"/>&lt;/td&gt;&lt;/tr&gt;
<xsl:if test="$sequenceBased = 'true'">&lt;tr&gt;&lt;td&gt;Next Id SQL&lt;/td&gt;&lt;td&gt;&lt;code&gt;SELECT <xsl:value-of select="/BusinessObject/@transTable"/>_SEQUENCE.NEXTVAL FROM DUAL&lt;/code&gt;&lt;/td&gt;&lt;td&gt;&lt;i&gt;N/A&lt;/i&gt;&lt;/td&gt;&lt;/tr&gt;</xsl:if>
&lt;tr&gt;&lt;td&gt;Update <xsl:value-of select="$boClassName"/> SQL&lt;/td&gt;&lt;td&gt;&lt;code&gt;UPDATE <xsl:value-of select="/BusinessObject/@transTable"/> SET <xsl:for-each select="/BusinessObject/Columns/Column[((@javaType != 'CLOB') and (@javaType != 'BLOB'))]"><xsl:if test="position() > 1"><xsl:text>, </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each> WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each>&lt;/code&gt;&lt;/td&gt;&lt;td&gt;<xsl:value-of select="$boClassName"/> (Selected For Update)&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;Delete <xsl:value-of select="$boClassName"/> SQL&lt;/td&gt;&lt;td&gt;&lt;code&gt;DELETE FROM <xsl:value-of select="/BusinessObject/@transTable"/> WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each>&lt;/code&gt;&lt;/td&gt;&lt;td&gt;<xsl:value-of select="$boClassName"/> (Selected For Update)&lt;/td&gt;&lt;/tr&gt;
<xsl:for-each select="/BusinessObject/Columns/Column[@javaType = 'CLOB']">
&lt;tr&gt;&lt;td&gt;Select <xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template> CLOB For Update SQL&lt;/td&gt;&lt;td&gt;&lt;code&gt;SELECT <xsl:value-of select="@columnName"/> FROM <xsl:value-of select="/BusinessObject/@transTable"/> WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each> FOR UPDATE&lt;/code&gt;&lt;/td&gt;&lt;td&gt;<xsl:value-of select="$boClassName"/> ID&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;Update <xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template> CLOB SQL&lt;/td&gt;&lt;td&gt;&lt;code&gt;UPDATE <xsl:value-of select="/BusinessObject/@transTable"/> SET <xsl:value-of select="@columnName"/> = ? WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each>&lt;/code&gt;&lt;/td&gt;&lt;td&gt;<xsl:value-of select="$boClassName"/> ID&lt;/td&gt;&lt;/tr&gt;
</xsl:for-each>
<xsl:for-each select="/BusinessObject/Columns/Column[@dbType = 'BLOB']">
&lt;tr&gt;&lt;td&gt;Select <xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template> BLOB For Update SQL&lt;/td&gt;&lt;td&gt;&lt;code&gt;SELECT <xsl:value-of select="@columnName"/> FROM <xsl:value-of select="/BusinessObject/@transTable"/> WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each> FOR UPDATE&lt;/code&gt;&lt;/td&gt;&lt;td&gt;<xsl:value-of select="$boClassName"/> ID&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;Update <xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template> BLOB SQL&lt;/td&gt;&lt;td&gt;&lt;code&gt;UPDATE <xsl:value-of select="/BusinessObject/@transTable"/> SET <xsl:value-of select="@columnName"/> = ? WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each>&lt;/code&gt;&lt;/td&gt;&lt;td&gt;<xsl:value-of select="$boClassName"/> ID&lt;/td&gt;&lt;/tr&gt;
</xsl:for-each>
</xsl:if>
&lt;/table&gt;
*/
public class <xsl:value-of select="$className"/>
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(<xsl:value-of select="$className"/>.class);

  /**
  * Defines the name of this class as a public static string.  Used for logging statements.
  */
  public static String CNAME = <xsl:value-of select="$className"/>.class.getName();

  /**
  * Defines the life for cached objects.
  */
  protected long EXPIRES_INTERVAL_MILLIS = 5L * (60L * 1000L); // default five minutes

    // note this is a compromise, i would rather have the SQL be static (and final).  
    // see ProductsViewFactory.javaext for context
    // it's not ideal to be replacing the sql for a method like this, it won't cache right for example, and it's not clean.
    // the preferred long term solution would be to provide every factory impl 
    // base with a single generic object fetch that takes dynamic SQL as a parameter,
    // or extend the XML to allow declaring an arbitrary number of parameterized 
    // methods for dynamic sql possibly with different parameters (for dynamic prepared statements) and/or
    // return types.
    // this needs to be resolved before 1.0 ships.


<xsl:for-each select="/BusinessObject/Queries/Fetch"><xsl:if test="@forSelect = 'true'">  protected String fetch<xsl:value-of select="@name"/>SQL = "<xsl:value-of select="normalize-space(SQL)"/>";
</xsl:if>
<xsl:if test="@forUpdate = 'true'">  protected String fetch<xsl:value-of select="@name"/>ForUpdateSQL = "<xsl:value-of select="normalize-space(SQL)"/> FOR UPDATE";
</xsl:if>
</xsl:for-each>
<xsl:if test="/BusinessObject/@transTable">  protected final String lockSQL = "LOCK TABLE <xsl:value-of select="/BusinessObject/@transTable"/> IN EXCLUSIVE MODE";
  protected String insertSQL = "INSERT INTO <xsl:value-of select="/BusinessObject/@transTable"/>(<xsl:for-each select="/BusinessObject/Columns/Column"><xsl:if test="position() > 1">, </xsl:if><xsl:value-of select="@columnName"/></xsl:for-each>) VALUES (<xsl:for-each select="/BusinessObject/Columns/Column"><xsl:if test="position() > 1">, </xsl:if><xsl:choose><xsl:when test="@value"><xsl:value-of select="@value"/></xsl:when><xsl:otherwise>?</xsl:otherwise></xsl:choose></xsl:for-each>)";
<xsl:if test="$sequenceBased = 'true'">  protected String nextIdSQL = "SELECT <xsl:value-of select="/BusinessObject/@transTable"/>_SEQUENCE.NEXTVAL FROM DUAL";</xsl:if>
<xsl:for-each select="/BusinessObject/Columns/Column[@javaType = 'CLOB']">
  protected String select<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>CLOBForUpdateSQL = "SELECT <xsl:value-of select="@columnName"/> FROM <xsl:value-of select="/BusinessObject/@transTable"/> WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each> FOR UPDATE";
  protected String update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>CLOBSQL = "UPDATE <xsl:value-of select="/BusinessObject/@transTable"/> SET <xsl:value-of select="@columnName"/> = ? WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each>";
  protected String update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>ClearCLOBSQL = "UPDATE <xsl:value-of select="/BusinessObject/@transTable"/> SET <xsl:value-of select="@columnName"/> = EMPTY_CLOB() WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each>";
</xsl:for-each>
<xsl:for-each select="/BusinessObject/Columns/Column[@dbType = 'BLOB']">
  protected String select<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>BLOBForUpdateSQL = "SELECT <xsl:value-of select="@columnName"/> FROM <xsl:value-of select="/BusinessObject/@transTable"/> WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each> FOR UPDATE";
  protected String update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>BLOBSQL = "UPDATE <xsl:value-of select="/BusinessObject/@transTable"/> SET <xsl:value-of select="@columnName"/> = ? WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each>";
  protected String update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>ClearBLOBSQL = "UPDATE <xsl:value-of select="/BusinessObject/@transTable"/> SET <xsl:value-of select="@columnName"/> = EMPTY_BLOB() WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each>";
</xsl:for-each>
  protected String updateSQL = "UPDATE <xsl:value-of select="/BusinessObject/@transTable"/> SET <xsl:for-each select="/BusinessObject/Columns/Column[((@javaType != 'CLOB') and (@javaType != 'BLOB') and (not(@isPk='true')))]"><xsl:if test="position() > 1">, </xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each> WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each>";
  protected String deleteSQL = "DELETE FROM <xsl:value-of select="/BusinessObject/@transTable"/> WHERE <xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']"><xsl:if test="position() > 1"><xsl:text> AND </xsl:text></xsl:if><xsl:value-of select="@columnName"/> = ?</xsl:for-each>";
</xsl:if>
<xsl:if test="/BusinessObject/Queries/Fetch[@useCache = 'true']">
  protected  javax.xml.parsers.DocumentBuilderFactory dFactory = null;
  protected  javax.xml.parsers.DocumentBuilder dBuilder = null;

  protected static HashMap cache;
  protected static boolean cachingEnabled = true; 
</xsl:if>

  /**
  * Protected no-arg Business Object constructor.  
  */
  protected <xsl:value-of select="$className"/>()
  {
<xsl:if test="/BusinessObject/Queries/Fetch[@useCache = 'true']">
    if (cache == null)
    {
      synchronized (CNAME)
      {
        if (cache == null)
        {
          cache = new HashMap();
<xsl:if test="/BusinessObject/@transTable">
          DBCacheManager.registerCache("<xsl:value-of select="/BusinessObject/@transTable"/>", getCache());
</xsl:if>
<xsl:for-each select="/BusinessObject/Dependencies/Table">
          DBCacheManager.registerCache("<xsl:value-of select="@name"/>", getCache());
</xsl:for-each>
        }
      }
    }
</xsl:if>
  }


  /**
<xsl:choose>
<xsl:when test="/BusinessObject/Queries/Fetch[@useCache = 'true']">
  * Enables or disables factory-wide caching for Fetch methods that support caching.
  * Disabling caching has the side effect of clearing the cache.
</xsl:when>
<xsl:otherwise>  * An empty method, since none of the fetches in this factory are cached.
</xsl:otherwise>
</xsl:choose>
  */
  public void setCaching(boolean caching)
  {
<xsl:if test="/BusinessObject/Queries/Fetch[@useCache = 'true']">    cachingEnabled = caching;
    if (!cachingEnabled)
      clearCache();
</xsl:if>
  }

  /**
<xsl:choose>
<xsl:when test="/BusinessObject/Queries/Fetch[@useCache = 'true']">  * Returns the current status of caching on this Factory.
</xsl:when>
<xsl:otherwise>  * Returns false.
</xsl:otherwise>
</xsl:choose>
  */
  public boolean getCaching()
  {
<xsl:choose>
<xsl:when test="/BusinessObject/Queries/Fetch[@useCache = 'true']">    return cachingEnabled;
</xsl:when>
<xsl:otherwise>    return false;
</xsl:otherwise>
</xsl:choose>
  }

  /**
<xsl:choose>
<xsl:when test="/BusinessObject/Queries/Fetch[@useCache = 'true']">  * Returns a reference to the cache for this factory as a HashMap object.
</xsl:when>
<xsl:otherwise>  * Returns null.
</xsl:otherwise>
</xsl:choose>
  */
  public HashMap getCache()
  {
<xsl:choose>
<xsl:when test="/BusinessObject/Queries/Fetch[@useCache = 'true']">    return cache;
</xsl:when>
<xsl:otherwise>    return null;
</xsl:otherwise></xsl:choose>
  }

  /**
<xsl:choose>
<xsl:when test="/BusinessObject/Queries/Fetch[@useCache = 'true']">  * Removes all entries in the cache for this factory.
</xsl:when>
<xsl:otherwise>  * An empty method, since none of the fetches in this factory are cached.
</xsl:otherwise>
</xsl:choose>
  */
  protected void clearCache()
  {
<xsl:if test="/BusinessObject/Queries/Fetch[@useCache = 'true']">    if ( cache != null )
      cache.clear();
</xsl:if>
  }

<xsl:if test="/BusinessObject/Queries/Fetch[@useCache = 'true']">
  protected org.w3c.dom.Document getNewCacheDoc ()
    throws Exception
  {
    if (dBuilder == null)
    {
      try
      {
        dFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
        dBuilder = dFactory.newDocumentBuilder();
      }
      catch (Exception e)
      {
        log.error("got exception building document builder:", e);
        throw e;
      }
    }

    try
    {
      return dBuilder.newDocument();
    }
    catch (Exception e)
    {
      log.error("got exception building document:", e);
      throw e;
    }
  }
</xsl:if>

<xsl:for-each select="/BusinessObject/Queries/Fetch[@useCache = 'true']">
<xsl:variable name="resultType">
  <xsl:choose>
    <xsl:when test="@result = 'obj'">
      <xsl:value-of select = '$boClassName'/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select = '@result'/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:if test="$cacheOk = 'true'">
  protected <xsl:value-of select="$resultType"/>[] get<xsl:value-of select="@name"/>CachedObjects( <xsl:call-template name="BuildKey"/> )
    throws Exception
  {
    <xsl:value-of select="$resultType"/>[] result = null;
    StringBuffer sb = new StringBuffer();
    sb.append("<xsl:value-of select="@name"/>-<xsl:value-of select="$resultType"/>-");
    <xsl:call-template name="BuildKeyString"/>

    FactoryCacheContainer cc = (FactoryCacheContainer)getCache().get(sb.toString());

    if (cc != null)
    {
      if (cc.isValid())
        result = (<xsl:value-of select="$resultType"/>[])cc.getPayload();
      else
      {
        getCache().remove(sb.toString());
        log.debug("expiring cache element with key: " + sb.toString());
      }
    }
    return result;
  }

  protected void cache<xsl:value-of select="@name"/>Objects(<xsl:value-of select="$resultType"/>[] results <xsl:if test="Parameters/Parameter">,</xsl:if> <xsl:call-template name="BuildKey"/>) 
  {
    try
    {
      FactoryCacheContainer cc = new FactoryCacheContainer(results, EXPIRES_INTERVAL_MILLIS);
      StringBuffer sb = new StringBuffer();
      sb.append("<xsl:value-of select="@name"/>-<xsl:value-of select="$resultType"/>-");
      <xsl:call-template name="BuildKeyString"/>
      getCache().put(sb.toString(),cc);
      log.info("(a) Cache size now: " + getCache().size());
    }
    catch(Exception e)
    {
      log.error("Failed Caching ResultSet", e);
      //throw e;
    }
  }
</xsl:if>

  protected org.w3c.dom.Element getCached<xsl:value-of select="@name"/>DOM(org.w3c.dom.Document doc<xsl:if test="Parameters/Parameter">,</xsl:if> <xsl:call-template name="BuildKey"/> ) throws Exception
  {
    StringBuffer sb = new StringBuffer();
    sb.append("<xsl:value-of select="@name"/>-<xsl:value-of select="$resultType"/>-DOM-");
    <xsl:call-template name="BuildKeyString"/>

    FactoryCacheContainer cc = (FactoryCacheContainer)getCache().get(sb.toString());

    org.w3c.dom.Element result = null;

    if (cc != null)
    {
      if (cc.isValid())
        result = (org.w3c.dom.Element)doc.importNode((org.w3c.dom.Element)cc.getPayload(), true);
      else
      {
        getCache().remove(sb.toString());
        log.debug("expiring cache element with key: " + sb.toString());
      }
    }
    return result;
  } 

  protected void cache<xsl:value-of select="@name"/>DOM( org.w3c.dom.Element results<xsl:if test="Parameters/Parameter">,</xsl:if> <xsl:call-template name="BuildKey"/>) 
  {
    try
    {
      org.w3c.dom.Document cacheDoc = getNewCacheDoc();
      FactoryCacheContainer cc = new FactoryCacheContainer((org.w3c.dom.Element)cacheDoc.importNode(results, true), cacheDoc, EXPIRES_INTERVAL_MILLIS);
      StringBuffer sb = new StringBuffer();
      sb.append("<xsl:value-of select="@name"/>-<xsl:value-of select="$resultType"/>-DOM-");
      <xsl:call-template name="BuildKeyString"/>
      getCache().put(sb.toString(),cc);
      log.info("(b) Cache size now: " + getCache().size());
    }
    catch(Exception e)
    {
      log.error("Failed Caching ResultSet", e);
      //throw e;
    }
  }

</xsl:for-each>

  public <xsl:value-of select="$boClassName"/>[] processResults( Connection conn, Vector v ) throws Exception
  {
    // NOTE: This method is only valid when using the fetchAll() method.
    // Override this method in the extending class for the appropriate business logic.
    <xsl:value-of select="$boClassName"/>[] results = new <xsl:value-of select="$boClassName"/>[v.size()];
    v.copyInto(results);
    return results;
  }

  public <xsl:value-of select="$boClassName"/> processRecord( Connection conn, <xsl:value-of select="$boClassName"/> obj ) throws Exception
  {
    // Override this method in the extending class for the appropriate business logic.
    return obj;
  }

<xsl:for-each select="/BusinessObject/Queries/Fetch">
<xsl:variable name="resultType">
  <xsl:choose>
    <xsl:when test="@result = 'obj'">
      <xsl:value-of select = '$boClassName'/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select = '@result'/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:variable>
<xsl:if test="@forSelect = 'true'">
  /**
  * This method fetches <xsl:value-of select="$resultType"/> objects.
<xsl:if test="@forUpdate = 'true'">
  * If updatable objects are required, you chould use the "ForUpdate" version of this method.
</xsl:if>
<xsl:choose>
<xsl:when test="((@useCache = 'true') and ($cacheOk = 'true'))">
  * First an attempt is made to locate the results in the cache.  If the results aren't located, the
  * fetch is performed and the results are saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.
</xsl:when>
<xsl:otherwise>
  * This fetch method does not implement caching, so results are guarenteed fresh.
</xsl:otherwise>
</xsl:choose>
<xsl:if test="@forUpdate = 'true'">  * @see  #fetch<xsl:value-of select="@name"/>ForUpdate( Connection conn<xsl:call-template name="BuildFetch"/> ) 
</xsl:if>
<xsl:if test="@result = 'obj'">  * @see  #fetch<xsl:value-of select="@name"/>DOM( Connection conn, <xsl:call-template name="BuildFetch"/> )
  * @see  #fetch<xsl:value-of select="@name"/>DOM( Connection conn, org.w3c.dom.Document doc<xsl:call-template name="BuildFetch"/> )
</xsl:if>
  */
  public <xsl:value-of select="$resultType"/>[] fetch<xsl:value-of select="@name"/>( Connection conn<xsl:call-template name="BuildFetch"/> ) 
    throws Exception
  {
    return fetch<xsl:value-of select="@name"/>(conn<xsl:if test="Parameters/Parameter">,</xsl:if> <xsl:call-template name="PassFetchKey"/>, true);
  } 
  
  
  
  protected <xsl:value-of select="$resultType"/>[] fetch<xsl:value-of select="@name"/>( Connection conn<xsl:call-template name="BuildFetch"/>, boolean shouldCache) 
    throws Exception
  {
    <xsl:value-of select="$resultType"/>[] results = null;
<xsl:if test="((@useCache = 'true') and ($cacheOk = 'true'))">
    results = get<xsl:value-of select="@name"/>CachedObjects(<xsl:call-template name="PassFetchKey"/>);
    if (results != null)
    {
      log.info("fetch<xsl:value-of select="@name"/> Returning Cached ResultSet. size: " + results.length);
      return results;
    }
</xsl:if>
    log.debug("FETCH: "+CNAME+", sql: "+fetch<xsl:value-of select="@name"/>SQL);

    Vector v = new Vector();

    PreparedStatement ps = conn.prepareStatement(fetch<xsl:value-of select="@name"/>SQL);
<xsl:call-template name="SetParameters"/>
    java.sql.ResultSet rs = ps.executeQuery();

    while (rs.next())
    {
<xsl:choose>
<xsl:when test="@result = 'obj'">
<xsl:text>      </xsl:text><xsl:value-of select="$resultType"/> rec = new <xsl:value-of select="$resultType"/>();
<xsl:call-template name="SetRecordColumns"/>

      Object obj = processRecord(conn,rec);
      if ( obj != null )
        v.addElement(obj);
</xsl:when>
<xsl:otherwise>
<xsl:text>      </xsl:text><xsl:value-of select="$resultType"/> rec = <xsl:if test="(($resultType = 'Integer') or ($resultType = 'Long') or ($resultType = 'Double') or ($resultType = 'Float'))">new <xsl:value-of select="$resultType"/>(</xsl:if>rs.get<xsl:choose><xsl:when test="$resultType = 'Integer'">Int</xsl:when><xsl:otherwise><xsl:value-of select="$resultType"/></xsl:otherwise></xsl:choose>(1)<xsl:if test="(($resultType = 'Integer') or ($resultType = 'Long') or ($resultType = 'Double') or ($resultType = 'Float'))">)</xsl:if>;

      if (rs.wasNull())
        rec = null;
      v.addElement(rec);
</xsl:otherwise>
</xsl:choose>
    }

    rs.close();
    ps.close();
<xsl:choose>
<xsl:when test="@result = 'obj'">
    results = processResults(conn,v);
</xsl:when>
<xsl:otherwise>
    results = new <xsl:value-of select="$resultType"/>[v.size()];
    v.copyInto(results);
</xsl:otherwise>
</xsl:choose>
<xsl:if test="((@useCache = 'true') and ($cacheOk = 'true'))">
    if (shouldCache)
      cache<xsl:value-of select="@name"/>Objects(results<xsl:if test="Parameters/Parameter">,</xsl:if> <xsl:call-template name="PassFetchKey"/>);
</xsl:if>
    return results;
  }

<xsl:if test="@result = 'obj'">
  /**
  * This method fetches <xsl:value-of select="$resultType"/> objects as an XML DOM.
<xsl:choose>
<xsl:when test="((@useCache = 'true') and ($cacheOk = 'true'))">
  * First an attempt is made to locate the DOM in the cache.  If the results aren't located, the
  * fetch is performed and the DOM is saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.
</xsl:when>
<xsl:otherwise>
  * This fetch method does not implement caching, so results are guarenteed fresh.
</xsl:otherwise>
</xsl:choose>
  * @see  #fetch<xsl:value-of select="@name"/>( Connection conn, <xsl:call-template name="BuildFetch"/> )
<xsl:if test="@forUpdate = 'true'">  * @see  #fetch<xsl:value-of select="@name"/>ForUpdate( Connection conn<xsl:call-template name="BuildFetch"/> ) 
</xsl:if>
  * @see  #fetch<xsl:value-of select="@name"/>DOM( Connection conn, org.w3c.dom.Document doc<xsl:call-template name="BuildFetch"/> )
  */
  public org.w3c.dom.Element fetch<xsl:value-of select="@name"/>DOM( Connection conn<xsl:call-template name="BuildFetch"/> ) throws Exception
  {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document document = builder.newDocument();
    return fetch<xsl:value-of select="@name"/>DOM(conn, document<xsl:call-template name="BuildPass"/>);
  }

  public javax.xml.transform.dom.DOMSource fetch<xsl:value-of select="@name"/>DOMSource( Connection conn<xsl:call-template name="BuildFetch"/> ) throws Exception
  {
    javax.xml.transform.dom.DOMSource dom = null;
    dom = new javax.xml.transform.dom.DOMSource(fetch<xsl:value-of select="@name"/>DOM(conn<xsl:call-template name="BuildPass"/>));
    return dom;
  } 

  public org.w3c.dom.Element process<xsl:value-of select="@name"/>DOM( Connection conn, org.w3c.dom.Element root, org.w3c.dom.Document doc ) throws Exception
  {
    // NOTE: This method is only valid when using the fetchDOM() method.
    // Override this method in the extending class for the appropriate business logic.
    return root;
  }

  public org.w3c.dom.Element process<xsl:value-of select="@name"/>Element( Connection conn, org.w3c.dom.Element e, org.w3c.dom.Document doc ) throws Exception
  {
    // Override this method in the extending class for the appropriate business logic.
    return e;
  }


  /**
  * This method fetches <xsl:value-of select="$resultType"/> objects as an XML DOM.
<xsl:choose>
<xsl:when test="@useCache = 'true'">
  * First an attempt is made to locate the DOM in the cache.  If the results aren't located, the
  * fetch is performed and the DOM is saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.
</xsl:when>
<xsl:otherwise>
  * This fetch method does not implement caching, so results are guarenteed fresh.
</xsl:otherwise>
</xsl:choose>
  * @see  #fetch<xsl:value-of select="@name"/>( Connection conn, <xsl:call-template name="BuildFetch"/> )
<xsl:if test="@forUpdate = 'true'">  * @see  #fetch<xsl:value-of select="@name"/>ForUpdate( Connection conn<xsl:call-template name="BuildFetch"/> ) 
</xsl:if>
  * @see  #fetch<xsl:value-of select="@name"/>DOM( Connection conn, <xsl:call-template name="BuildFetch"/> )
  */
  public org.w3c.dom.Element fetch<xsl:value-of select="@name"/>DOM( Connection conn, org.w3c.dom.Document doc<xsl:call-template name="BuildFetch"/> ) throws Exception
  {
    org.w3c.dom.Element results = null;
<xsl:if test="@useCache = 'true'">
    results = getCached<xsl:value-of select="@name"/>DOM(doc<xsl:if test="Parameters/Parameter">,</xsl:if><xsl:call-template name="PassFetchKey"/>);
    if (results != null)
    {
      log.info("fetch<xsl:value-of select="@name"/>DOM Returning Cached Result");
      return results;
    }
</xsl:if>

    log.debug("FETCH: "+CNAME+", sql: "+fetch<xsl:value-of select="@name"/>SQL);

    <xsl:value-of select="$resultType"/>[] _res = fetch<xsl:value-of select="@name"/>(conn<xsl:if test="Parameters/Parameter">,</xsl:if> <xsl:call-template name="PassFetchKey"/>, false);

    Element root = (Element)doc.createElement("<xsl:value-of select="$boClassName"/>ResultSet");
    root.setAttribute("size",""+_res.length);

    for (int i=0; i&lt;_res.length; i++)
    {
      Element <xsl:value-of select="$boClassName"/>Elem = (Element)_res[i].getElement(doc);

      Element e = process<xsl:value-of select="@name"/>Element(conn, <xsl:value-of select="$boClassName"/>Elem, doc);
      if ( e != null )
      {
        e.setAttribute("rowId",""+i);
        root.appendChild(e);
      }
    }

    results = process<xsl:value-of select="@name"/>DOM(conn,root,doc);

  <xsl:if test="@useCache = 'true'">
    cache<xsl:value-of select="@name"/>DOM(results<xsl:if test="Parameters/Parameter">,</xsl:if> <xsl:call-template name="PassFetchKey"/>);
  </xsl:if>
    return results;
  }
</xsl:if>
</xsl:if>

<xsl:if test="@forUpdate = 'true'">
  /**
  * This method fetches <xsl:value-of select="$resultType"/> objects for update.  If
  * autoCommit is enabled on this connection, it will be disabled.  The caller must ensure that
  * the connection is committed or rolled back in this call scope to prevent unnecessary locking.
  * This fetch method does not implement caching, so results are guarenteed fresh.
<xsl:if test="@forSelect = 'true'">  * @see  #fetch<xsl:value-of select="@name"/>( Connection conn<xsl:call-template name="BuildFetch"/> ) 
</xsl:if>
<xsl:if test="@result = 'obj'">  * @see  #fetch<xsl:value-of select="@name"/>DOM( Connection conn, <xsl:call-template name="BuildFetch"/> )
  * @see  #fetch<xsl:value-of select="@name"/>DOM( Connection conn, org.w3c.dom.Document doc<xsl:call-template name="BuildFetch"/> )
</xsl:if>
  */
  public <xsl:value-of select="$resultType"/>[] fetch<xsl:value-of select="@name"/>ForUpdate( Connection conn<xsl:call-template name="BuildFetch"/> ) 
    throws Exception
  {
    <xsl:value-of select="$resultType"/>[] results = null;

    log.debug("FETCH FOR UPDATE: " + CNAME + ", sql: "+fetch<xsl:value-of select="@name"/>ForUpdateSQL);

    Vector v = new Vector();

    conn.setAutoCommit(false);
    
    PreparedStatement ps = conn.prepareStatement(fetch<xsl:value-of select="@name"/>ForUpdateSQL);
<xsl:call-template name="SetParameters"/>
    java.sql.ResultSet rs = ps.executeQuery();

    while (rs.next())
    {
<xsl:choose>
<xsl:when test="@result = 'obj'">
<xsl:text>      </xsl:text><xsl:value-of select="$resultType"/> rec = new <xsl:value-of select="$resultType"/>();
<xsl:call-template name="SetRecordColumns"/>
     rec.setSelectedForUpdate(true);

     Object obj = processRecord(conn,rec);
     if ( obj != null )
       v.addElement(obj);
</xsl:when>
<xsl:otherwise>
<xsl:text>      </xsl:text><xsl:value-of select="$resultType"/> rec = new <xsl:value-of select="$resultType"/>(rs.get<xsl:choose><xsl:when test="$resultType = 'Integer'">Int</xsl:when><xsl:otherwise><xsl:value-of select="$resultType"/></xsl:otherwise></xsl:choose>(1));
      if (rs.wasNull())
        rec = null;
      v.addElement(rec);
</xsl:otherwise>
</xsl:choose>
    }

    rs.close();
    ps.close();
<xsl:choose>
<xsl:when test="@result = 'obj'">
    results = processResults(conn,v);
</xsl:when>
<xsl:otherwise>
    results = new <xsl:value-of select="$resultType"/>[v.size()];
    v.copyInto(results);
</xsl:otherwise>
</xsl:choose>
    return results;
  }

</xsl:if>



</xsl:for-each>


<xsl:if test="/BusinessObject/@transTable">
<xsl:if test="/BusinessObject/@getOrCreate">
  /**
  * This method finds the Id of an existing <xsl:value-of select="$boClassName"/> and returns it, or creates 
  * and inserts a new <xsl:value-of select="$boClassName"/> if one does not exist.  The Factory underlying Insert method is used to create
  * the record.  Tables involved are locked prior to select to insure no insert race condition can exist.
  * This method does not implement caching, so results are guarenteed fresh.
  */
  public <xsl:value-of select="/BusinessObject/Columns/Column[@isPk = 'true']/@javaType"/> getOrCreate<xsl:value-of select="$boClassName"/>Id( Connection conn<xsl:for-each select="/BusinessObject/Columns/Column[(not(@value)) and (not(@isPk))]"><xsl:text>, </xsl:text><xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@objectName"/></xsl:for-each>) 
    throws Exception
  {
    PreparedStatement ps  = null;
    java.sql.ResultSet rs = null;
    boolean autoCommitSetting  = false;

    <xsl:value-of select="$boClassName"/> result[];

    try
    {
      result = fetch<xsl:value-of select="$boClassName"/>(conn<xsl:for-each select="/BusinessObject/Columns/Column[(not(@value)) and (not(@isPk))]"><xsl:text>, </xsl:text><xsl:value-of select="@objectName"/></xsl:for-each>);

      if ((result == null) || (result.length &lt; 1))
      {
        try
        {
          autoCommitSetting = conn.getAutoCommit();
          conn.setAutoCommit(false);

          // obtain a lock and see if the row is still missing
          log.debug("Execute LOCK: " + lockSQL);

          ps = conn.prepareStatement(lockSQL);
          ps.execute();
          ps.close();

          result = fetch<xsl:value-of select="$boClassName"/>(conn<xsl:for-each select="/BusinessObject/Columns/Column[(not(@value)) and (not(@isPk))]"><xsl:text>, </xsl:text><xsl:value-of select="@objectName"/></xsl:for-each>);

          if ((result != null) &amp;&amp; (result.length &gt; 0))
          {
            log.debug("Got table lock, part was created in another thread after lock");
          }
          else
          {
            log.debug("Got table lock, part not yet created");
            // row is still not there so create it
            // create a new <xsl:value-of select="$boClassName"/><xsl:text>
            </xsl:text>
            <xsl:value-of select="$boClassName"/> obj = new <xsl:value-of select="$boClassName"/>();
<xsl:call-template name="SetObjColumns"/>
            insert(conn, obj, true);
          }
        }
        finally
        {
          // restore orig autocommit
          if (autoCommitSetting)
            conn.setAutoCommit(true);
        }

        // now try the query again to get the newly generated id
        // do not cache the result as it is not committed
        result = fetch<xsl:value-of select="$boClassName"/>(conn<xsl:for-each select="/BusinessObject/Columns/Column[(not(@value)) and (not(@isPk))]"><xsl:text>, </xsl:text><xsl:value-of select="@objectName"/></xsl:for-each>, false);

        if ((result == null) || (result.length &lt; 1))
        {
          throw new Exception("Couldn't create new <xsl:value-of select="$boClassName"/> with parameters:\n " <xsl:for-each select="/BusinessObject/Columns/Column[(not(@value)) and (not(@isPk))]"><xsl:text> + "\t</xsl:text><xsl:value-of select="@objectName"/>: "<xsl:text> + </xsl:text><xsl:value-of select="@objectName"/>+ "\n"</xsl:for-each>);
        }
      }
    }
    catch( Exception ex )
    {
      log.error("Business Object Caught Exception ", ex);
      throw ex;
    }

    return result[0].get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="/BusinessObject/Columns/Column[@isPk = 'true']/@objectName"/></xsl:call-template>();
  }
</xsl:if>

<xsl:if test="/BusinessObject/@transTable">
  public void lockTransTable(Connection conn)
     throws Exception
  {
    PreparedStatement ps = null;
    conn.setAutoCommit(false);
      
    // lock table
    ps = conn.prepareStatement(lockSQL);
    ps.execute();
    ps.close();
  }
</xsl:if>

  /**
  * This method inserts a result of type <xsl:value-of select="$boClassName"/>.  Insert tables are locked prior to insert.  This method also clears the factory-wide cache, if one exists.
  */
  public void insert(Connection conn, <xsl:value-of select="$boClassName"/> obj)
    throws Exception
  {
    insert(conn, obj, false);
  }
  
  public void insert(Connection conn, <xsl:value-of select="$boClassName"/> obj, boolean locked)
    throws Exception
  {
    PreparedStatement ps = null;
    ResultSet rs = null;
<xsl:if test="$sequenceBased = 'true'">
    <xsl:value-of select="/BusinessObject/Columns/Column[@isPk = 'true']/@javaType"/> rowId = null;
</xsl:if>

    // autocommit to off
    boolean autoCommitSetting = conn.getAutoCommit();
    try
    {
      conn.setAutoCommit(false);
      
<xsl:if test="$sequenceBased = 'true'">
      if (obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="/BusinessObject/Columns/Column[@isPk = 'true']/@objectName"/></xsl:call-template>() == null)
      {
        log.debug("Fetching new <xsl:value-of select="/BusinessObject/Columns/Column[@isPk = 'true']/@objectName"/> value");

        if (!locked)
        {
          // lock table
          ps = conn.prepareStatement(lockSQL);
          ps.execute();
          ps.close();
        }

        // select next row Id
        log.debug("Select Next Id: "+nextIdSQL);
        log.debug("Object: "+obj.toString());
        ps = conn.prepareStatement(nextIdSQL);
        rs = ps.executeQuery();
        if (rs.next())
        {
          rowId = <xsl:choose><xsl:when test="/BusinessObject/Columns/Column[@isPk = 'true']/@javaType = 'Long'">new Long(</xsl:when><xsl:when test="/BusinessObject/Columns/Column[@isPk = 'true']/@javaType = 'Integer'">new Integer(</xsl:when><xsl:when test="/BusinessObject/Columns/Column[@isPk = 'true']/@javaType = 'Float'">new Float(</xsl:when><xsl:when test="/BusinessObject/Columns/Column[@isPk = 'true']/@javaType = 'Double'">new Double(</xsl:when></xsl:choose>rs.get<xsl:choose><xsl:when test="/BusinessObject/Columns/Column[@isPk = 'true']/@javaType = 'Integer'">Int</xsl:when><xsl:otherwise><xsl:value-of select="/BusinessObject/Columns/Column[@isPk = 'true']/@javaType"/></xsl:otherwise></xsl:choose>(1)<xsl:if test="((/BusinessObject/Columns/Column[@isPk = 'true']/@javaType = 'Long') or (/BusinessObject/Columns/Column[@isPk = 'true']/@javaType = 'Integer') or (/BusinessObject/Columns/Column[@isPk = 'true']/@javaType = 'Float') or (/BusinessObject/Columns/Column[@isPk = 'true']/@javaType = 'Double'))">)</xsl:if>;
          
          if (rs.wasNull())
            rowId = null;
        }
        rs.close();
        ps.close();

        if (rowId == null)
        {
          throw new Exception("Select new sequence value returned NULL");
        }
        obj.set<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="/BusinessObject/Columns/Column[@isPk = 'true']/@objectName"/></xsl:call-template>(rowId);
      }
      else
        log.debug("Using existing <xsl:value-of select="/BusinessObject/Columns/Column[@isPk = 'true']/@objectName"/> value: " + obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="/BusinessObject/Columns/Column[@isPk = 'true']/@objectName"/></xsl:call-template>());
</xsl:if>

      // call insert sql
      log.debug("Execute INSERT: "+insertSQL);
      ps = conn.prepareStatement(insertSQL);
<xsl:call-template name="SetInsertFromObj"/>
      ps.execute();
      ps.close();

<xsl:if test="/BusinessObject/Columns/Column[@javaType = 'CLOB']">
      CLOB newCLOB = null;
      PreparedStatement ps2 = null;
<xsl:for-each select="/BusinessObject/Columns/Column[@javaType = 'CLOB']">

      if (obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Modified())
      {
        log.debug("selecting clob <xsl:value-of select="@objectName"/> for update: " + select<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>CLOBForUpdateSQL);

        ps = conn.prepareStatement(select<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>CLOBForUpdateSQL);
<xsl:call-template name="SetPKFromObj"/>
        rs = ps.executeQuery();

        if (rs.next())
        {
          newCLOB = (oracle.sql.CLOB)rs.getObject(1);

          if (!rs.wasNull())
          {
            // update the clob value
            java.io.Writer clobWriter = newCLOB.getCharacterOutputStream();
            clobWriter.write(obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>String());
            clobWriter.flush();
            clobWriter.close();

            // save the clob
            log.debug("updating clob <xsl:value-of select="@objectName"/>: " + update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>CLOBSQL);

            ps2 = conn.prepareStatement(update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>CLOBSQL);
            ps2.setObject(1, newCLOB.toJdbc());
<xsl:call-template name="SetPKFromObj"><xsl:with-param name="offset" select="'1'"/><xsl:with-param name="stmt" select="'ps2'"/></xsl:call-template>

            ps2.execute();
            ps2.close();
          }
          else
          {
            log.error("Select new clob for update failed, returned null clob (not inserted properly?)");
            throw new Exception("Select new clob for update failed, returned null clob (not inserted properly?)");
          }
        }
        else
        {
          log.error("Select new clob for update failed, returned empty result set");
          throw new Exception("Select new clob for update failed, returned empty result set");
        }
        rs.close();
        ps.close();
      }
</xsl:for-each>

<!-- Handle BLOBs -->
</xsl:if>
<xsl:if test="/BusinessObject/Columns/Column[@dbType = 'BLOB']">
      BLOB newBLOB = null;
      PreparedStatement ps3 = null;
<xsl:for-each select="/BusinessObject/Columns/Column[@dbType = 'BLOB']">
      if (obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Modified())
      {
        log.debug("selecting blob <xsl:value-of select="@objectName"/> for update: " + select<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>BLOBForUpdateSQL);

        ps = conn.prepareStatement(select<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>BLOBForUpdateSQL);
<xsl:call-template name="SetPKFromObj"/>
        rs = ps.executeQuery();

        if (rs.next())
        {
          newBLOB = (oracle.sql.BLOB)rs.getObject(1);

          if (!rs.wasNull())
          {
            // update the blob value
            java.io.OutputStream blobOS = newBLOB.getBinaryOutputStream();
            blobOS.write(obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Bytes());
            blobOS.flush();
            blobOS.close();

            // save the blob
            log.debug("updating blob <xsl:value-of select="@objectName"/>: " + update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>BLOBSQL);

            ps2 = conn.prepareStatement(update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>BLOBSQL);
            ps2.setObject(1, newBLOB.toJdbc());
            
<xsl:call-template name="SetPKFromObj"><xsl:with-param name="offset" select="'1'"/><xsl:with-param name="stmt" select="'ps2'"/></xsl:call-template>

            ps2.execute();
            ps2.close();
          }
          else
          {
            log.error("Select new blob for update failed, returned null blob (not inserted properly?)");
            //throw new ;
          }
        }
        else
        {
          log.error("Select new blob for update failed, returned empty result set");
          //throw new ;
        }
        rs.close();
        ps.close();
      }
</xsl:for-each>
</xsl:if>
    }
    finally
    {
      // restore autocommit
      if (autoCommitSetting)
        conn.setAutoCommit(true);
      DBCacheManager.clearCachesForTableKey("<xsl:value-of select="/BusinessObject/@transTable"/>");
    }
  }

  /**
  * This method updates a result of type <xsl:value-of select="$boClassName"/>.  Object must have been selected for update, 
  * or NotSelectedForUpdateException is thrown.  This method also clears the factory-wide cache, if one exists.
  */
  public void update(Connection conn, <xsl:value-of select="$boClassName"/> obj)
    throws Exception
  {
    PreparedStatement ps = null;
    ResultSet rs = null;
    int rows = 0;

    // assert mutable
    // this assures the row was selected for update
    if (! obj.getSelectedForUpdate())
    {
      log.error("Update called for immutable object.");
      throw new NotSelectedForUpdateException("Update called for immutable object (should have been selected for update)");
    }
    
    boolean autoCommitSetting = conn.getAutoCommit();
    try
    {
      conn.setAutoCommit(false);
      // call update sql
      log.debug("Execute UPDATE: "+updateSQL);
      ps = conn.prepareStatement(updateSQL);
<xsl:call-template name="SetUpdateFromObj"/>
      ps.execute();
      ps.close();

<xsl:if test="/BusinessObject/Columns/Column[@javaType = 'CLOB']">
      CLOB newCLOB = null;
      PreparedStatement ps2 = null;
<xsl:for-each select="/BusinessObject/Columns/Column[@javaType = 'CLOB']">
      if (obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Modified())
      {
        log.debug("emptying existing value for clob <xsl:value-of select="@objectName"/>: " + update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>ClearCLOBSQL);

        ps = conn.prepareStatement(update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>ClearCLOBSQL);

<xsl:call-template name="SetPKFromObj"/>

        rows = ps.executeUpdate();
        ps.close();

        if (rows > 0)
        {
          log.debug("empty existing value for clob <xsl:value-of select="@objectName"/> succeeded (" + rows + ")");
        }
        else
        {
          log.error("Empty clob before update failed, returned zero rows altered");
          throw new Exception("Empty clob before update failed, returned zero rows altered");
        }

        // get clob <xsl:value-of select="@objectName"/> and write to it
        ps = conn.prepareStatement(select<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>CLOBForUpdateSQL);
<xsl:call-template name="SetPKFromObj"/>
        rs = ps.executeQuery();

        if (rs.next())
        {
          newCLOB = (oracle.sql.CLOB)rs.getObject(1);

          if (!rs.wasNull())
          {
            // update the clob value
            java.io.Writer clobWriter = newCLOB.getCharacterOutputStream();
            clobWriter.write(obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>String());
            clobWriter.flush();
            clobWriter.close();

            // save the clob
            ps2 = conn.prepareStatement(update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>CLOBSQL);
            ps2.setObject(1, newCLOB.toJdbc());

<xsl:call-template name="SetPKFromObj"><xsl:with-param name="offset" select="'1'"/><xsl:with-param name="stmt" select="'ps2'"/></xsl:call-template>

            ps2.execute();
            ps2.close();
          }
          else
          {
            log.error("Select new clob for update failed, returned null clob (not inserted properly?)");
            throw new Exception("Select new clob for update failed, returned null clob (not inserted properly?)");
          }
        }
        else
        {
          log.error("Select new clob for update failed, returned empty result set");
          throw new Exception("Select new clob for update failed, returned empty result set");
        }
        rs.close();
        ps.close();
      }
</xsl:for-each>
</xsl:if>

<xsl:if test="/BusinessObject/Columns/Column[@javaType = 'BLOB']">
      BLOB newBLOB = null;
      PreparedStatement ps3 = null;
<xsl:for-each select="/BusinessObject/Columns/Column[@javaType = 'BLOB']">
      if (obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Modified())
      {
        log.debug("emptying existing value for blob <xsl:value-of select="@objectName"/>: " + update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>ClearBLOBSQL);

        ps = conn.prepareStatement(update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>ClearBLOBSQL);

<xsl:call-template name="SetPKFromObj"/>

        rows = ps.executeUpdate();
        ps.close();

        if (rows > 0)
        {
          log.debug("empty existing value for blob <xsl:value-of select="@objectName"/> succeeded (" + rows + ")");
        }
        else
        {
          log.error("Empty blob before update failed, returned zero rows altered");
          throw new Exception("Empty blob before update failed, returned zero rows altered");
        }

        // get blob <xsl:value-of select="@objectName"/> and write to it
        ps = conn.prepareStatement(select<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>BLOBForUpdateSQL);
<xsl:call-template name="SetPKFromObj"/>
        rs = ps.executeQuery();

        if (rs.next())
        {
          newBLOB = (oracle.sql.BLOB)rs.getObject(1);

          if (!rs.wasNull())
          {
            // update the blob value
            java.io.OutputStream blobWriter = newBLOB.getBinaryOutputStream();
            blobWriter.write(obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>Bytes());
            blobWriter.flush();
            blobWriter.close();

            // save the clob
            ps3 = conn.prepareStatement(update<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>BLOBSQL);
            ps3.setObject(1, newBLOB.toJdbc());

<xsl:call-template name="SetPKFromObj"><xsl:with-param name="offset" select="'1'"/><xsl:with-param name="stmt" select="'ps3'"/></xsl:call-template>

            ps3.execute();
            ps3.close();
          }
          else
          {
            log.error("Select new blob for update failed, returned null blob (not inserted properly?)");
            throw new Exception("Select new blob for update failed, returned null blob (not inserted properly?)");
          }
        }
        else
        {
          log.error("Select new blob for update failed, returned empty result set");
          throw new Exception("Select new blob for update failed, returned empty result set");
        }
        rs.close();
        ps.close();
      }
</xsl:for-each>
</xsl:if>
    
    
    }
    finally
    {
      // restore autocommit
      if (autoCommitSetting)
        conn.setAutoCommit(true);
      DBCacheManager.clearCachesForTableKey("<xsl:value-of select="/BusinessObject/@transTable"/>");
    }
  }

  /**
  * This method deletes a result of type <xsl:value-of select="$boClassName"/>.  Object must have been selected for update, 
  * or NotSelectedForUpdateException is thrown.
  */
  public void delete(Connection conn, <xsl:value-of select="$boClassName"/> obj)
    throws Exception
  {
    PreparedStatement ps = null;

    // assert mutable
    // this assures the row was selected for update
    if (! obj.getSelectedForUpdate())
    {
      log.error("Delete called for immutable object.");
      throw new NotSelectedForUpdateException("Delete called for immutable object (should have been selected for update)");
    }

    try
    {
      ps = conn.prepareStatement(deleteSQL);
<xsl:call-template name="SetPKFromObj"/>
      ps.execute();
      ps.close();
    }
    finally
    {
      DBCacheManager.clearCachesForTableKey("<xsl:value-of select="/BusinessObject/@transTable"/>");
    }
  }
</xsl:if>

}
</xsl:template>

<xsl:template name="SetRecordColumns">
<xsl:for-each select="/BusinessObject/Columns/Column"><xsl:text>      </xsl:text>rec.set<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>(<xsl:choose><xsl:when test="@javaType = 'CLOB'">(oracle.sql.CLOB)</xsl:when><xsl:when test="@javaType = 'BLOB'">(oracle.sql.BLOB)</xsl:when><xsl:when test="@javaType = 'Long'">new Long(</xsl:when><xsl:when test="@javaType = 'Integer'">new Integer(</xsl:when><xsl:when test="@javaType = 'Float'">new Float(</xsl:when><xsl:when test="@javaType = 'Double'">new Double(</xsl:when></xsl:choose>rs.get<xsl:choose><xsl:when test="((@javaType = 'CLOB') or (@javaType = 'BLOB'))">Object</xsl:when><xsl:when test="@javaType = 'Integer'">Int</xsl:when><xsl:otherwise><xsl:value-of select="@javaType"/></xsl:otherwise></xsl:choose>(<xsl:value-of select="position()"/>)<xsl:if test="((@javaType = 'Long') or (@javaType = 'Integer') or (@javaType = 'Float') or (@javaType = 'Double'))">)</xsl:if>);
<xsl:text>      </xsl:text>if (rs.wasNull())
<xsl:text>        </xsl:text>rec.set<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>(null);
</xsl:for-each> 
</xsl:template>

<xsl:template name="SetObjColumns">
<xsl:for-each select="/BusinessObject/Columns/Column[((not(@value)) and (not(@isPk)))]">            obj.set<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>(<xsl:value-of select="@objectName"/>);
</xsl:for-each> 
</xsl:template>

<xsl:template name="SetParameters">
<xsl:for-each select="Parameters/Parameter"><xsl:variable name="paramName" select="@name"/>    ps.set<xsl:choose><xsl:when test="@javaType = 'Integer'">Int</xsl:when><xsl:otherwise><xsl:value-of select="@javaType"/></xsl:otherwise></xsl:choose>(<xsl:value-of select="position()"/>,<xsl:value-of select="@name"/><xsl:choose><xsl:when test="@javaType = 'Long'">.longValue()</xsl:when><xsl:when test="@javaType = 'Integer'">.intValue()</xsl:when><xsl:when test="@javaType = 'Float'">.floatValue()</xsl:when><xsl:when test="@javaType = 'Double'">.doubleValue()</xsl:when></xsl:choose>);
</xsl:for-each> 
</xsl:template>

<xsl:template name="SetInsertFromObj">
<xsl:for-each select="/BusinessObject/Columns/Column[((@javaType != 'CLOB') and (@javaType != 'BLOB') and (not(@value)))]">      
      if (obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>() != null)
        ps.set<xsl:choose><xsl:when test="@javaType = 'Integer'">Int</xsl:when><xsl:otherwise><xsl:value-of select="@javaType"/></xsl:otherwise></xsl:choose>(<xsl:value-of select="position()"/>,              
              obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>()<xsl:choose><xsl:when test="@javaType = 'Long'">.longValue()</xsl:when><xsl:when test="@javaType = 'Integer'">.intValue()</xsl:when><xsl:when test="@javaType = 'Float'">.floatValue()</xsl:when><xsl:when test="@javaType = 'Double'">.doubleValue()</xsl:when></xsl:choose>);
      else
        ps.setNull(<xsl:value-of select="position()"/>, Types.<xsl:value-of select="@dbType"/>);
</xsl:for-each> 
</xsl:template>

<xsl:template name="SetUpdateFromObj">
<xsl:for-each select="/BusinessObject/Columns/Column[((@javaType != 'CLOB') and (@javaType != 'BLOB') and (not(@isPk='true')))]">      if (obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>() != null)
        ps.set<xsl:choose><xsl:when test="@javaType = 'Integer'">Int</xsl:when><xsl:otherwise><xsl:value-of select="@javaType"/></xsl:otherwise></xsl:choose>(<xsl:value-of select="position()"/>,obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>()<xsl:choose><xsl:when test="@javaType = 'Long'">.longValue()</xsl:when><xsl:when test="@javaType = 'Integer'">.intValue()</xsl:when><xsl:when test="@javaType = 'Float'">.floatValue()</xsl:when><xsl:when test="@javaType = 'Double'">.doubleValue()</xsl:when></xsl:choose>);
      else
        ps.setNull(<xsl:value-of select="position()"/>, Types.<xsl:value-of select="@dbType"/>);
</xsl:for-each> 
<xsl:call-template name="SetPKFromObj"><xsl:with-param name="offset" select="count(/BusinessObject/Columns/Column[((@javaType != 'CLOB') and (@javaType != 'BLOB') and (not(@isPk='true')))])"/></xsl:call-template>
</xsl:template>

<xsl:template name="SetPKFromObj">
<xsl:param name="offset" select="'0'"/>
<xsl:param name="stmt" select="'ps'"/>
<xsl:for-each select="/BusinessObject/Columns/Column[@isPk = 'true']">
      if (obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>() != null)
        <xsl:value-of select="$stmt"/>.set<xsl:choose><xsl:when test="@javaType = 'Integer'">Int</xsl:when><xsl:otherwise><xsl:value-of select="@javaType"/></xsl:otherwise></xsl:choose>(<xsl:value-of select="position() + $offset"/>,obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@objectName"/></xsl:call-template>()<xsl:choose><xsl:when test="@javaType = 'Long'">.longValue()</xsl:when><xsl:when test="@javaType = 'Integer'">.intValue()</xsl:when><xsl:when test="@javaType = 'Float'">.floatValue()</xsl:when><xsl:when test="@javaType = 'Double'">.doubleValue()</xsl:when></xsl:choose>);
      else
        <xsl:value-of select="$stmt"/>.setNull(<xsl:value-of select="position() + $offset"/>, Types.<xsl:value-of select="@dbType"/>);
</xsl:for-each>
</xsl:template>

<xsl:template name="BuildFetch">
<xsl:for-each select="Parameters/Parameter"><xsl:variable name="paramName" select="@name"/>, <xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@name"/></xsl:for-each>
</xsl:template>

<xsl:template name="BuildPass">
<xsl:for-each select="Parameters/Parameter">, <xsl:value-of select="@name"/></xsl:for-each>
</xsl:template>


<xsl:template name="BuildKey">
<xsl:for-each select="Parameters/Parameter"><xsl:variable name="paramName" select="@name"/><xsl:if test="position() > 1">, </xsl:if><xsl:value-of select="@javaType"/><xsl:text> </xsl:text><xsl:value-of select="@name"/></xsl:for-each>
</xsl:template>

<xsl:template name="PassFetchKey">
<xsl:for-each select="Parameters/Parameter"><xsl:if test="position() > 1">, </xsl:if><xsl:value-of select="@name"/></xsl:for-each>
</xsl:template>

<xsl:template name="BuildKeyString">
<xsl:for-each select="Parameters/Parameter">
<xsl:if test="position() > 1">
      sb.append("-");</xsl:if>
      sb.append(""+<xsl:value-of select="@name"/>);</xsl:for-each>
</xsl:template>


<xsl:template name="BuildKeyStringFromObj">
<xsl:for-each select="Parameters/Parameter">
<xsl:if test="position() > 1">      sb.append("-");</xsl:if>      sb.append(""+obj.get<xsl:call-template name="UpperCaseFirstLetter"><xsl:with-param name="sourceString" select="@name"/></xsl:call-template>());</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
