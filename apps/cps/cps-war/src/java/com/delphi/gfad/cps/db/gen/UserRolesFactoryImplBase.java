

/**
 *
 * Class: UserRolesFactoryImplBase
 *
 * This is a generated Class. Do not modify directly.
 * Other classes are provided for extending this class.
 **/

package com.delphi.gfad.cps.db.gen;

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
using the subclass UserRolesFactory.
The UserRoles business object encapsulates access to the set of Users Roles in CPS.  
  
SQL Statements used are as follows<blink>:</blink><p>
<table border="1">
<tr><th>Action</th><th>SQL</th><th>Parameters</th></tr>
<tr><td>Fetch UserRolesByUserId</td><td><code>SELECT t1.ROLE_ID, t1.ROLE FROM CPS_USER_ROLE t1, CPS_USER_ROLE_TO_USER t2 WHERE t2.USER_ID = ? AND t11.ROLE_ID = t2.ROLE_ID</code></td><td>userId </td></tr>
<tr><td>Fetch UserRolesByNetId</td><td><code>SELECT t1.ROLE_ID, t1.ROLE FROM CPS_USER_ROLE t1, CPS_USER_ROLE_TO_USER t2, CPS_USER t3 WHERE t3.NET_ID = ? AND t2.USER_ID = t3.USER_ID AND t1.ROLE_ID = t2.ROLE_ID</code></td><td>NET_ID </td></tr>

</table>
*/
public class UserRolesFactoryImplBase
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(UserRolesFactoryImplBase.class);

  /**
  * Defines the name of this class as a public static string.  Used for logging statements.
  */
  public static String CNAME = UserRolesFactoryImplBase.class.getName();

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


  protected String fetchUserRolesByUserIdSQL = "SELECT t1.ROLE_ID, t1.ROLE FROM CPS_USER_ROLE t1, CPS_USER_ROLE_TO_USER t2 WHERE t2.USER_ID = ? AND t11.ROLE_ID = t2.ROLE_ID";
  protected String fetchUserRolesByNetIdSQL = "SELECT t1.ROLE_ID, t1.ROLE FROM CPS_USER_ROLE t1, CPS_USER_ROLE_TO_USER t2, CPS_USER t3 WHERE t3.NET_ID = ? AND t2.USER_ID = t3.USER_ID AND t1.ROLE_ID = t2.ROLE_ID";

  protected  javax.xml.parsers.DocumentBuilderFactory dFactory = null;
  protected  javax.xml.parsers.DocumentBuilder dBuilder = null;

  protected static HashMap cache;
  protected static boolean cachingEnabled = true; 


  /**
  * Protected no-arg Business Object constructor.  
  */
  protected UserRolesFactoryImplBase()
  {

    if (cache == null)
    {
      synchronized (CNAME)
      {
        if (cache == null)
        {
          cache = new HashMap();

        }
      }
    }

  }


  /**

  * Enables or disables factory-wide caching for Fetch methods that support caching.
  * Disabling caching has the side effect of clearing the cache.

  */
  public void setCaching(boolean caching)
  {
    cachingEnabled = caching;
    if (!cachingEnabled)
      clearCache();

  }

  /**
  * Returns the current status of caching on this Factory.

  */
  public boolean getCaching()
  {
    return cachingEnabled;

  }

  /**
  * Returns a reference to the cache for this factory as a HashMap object.

  */
  public HashMap getCache()
  {
    return cache;

  }

  /**
  * Removes all entries in the cache for this factory.

  */
  protected void clearCache()
  {
    if ( cache != null )
      cache.clear();

  }


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

  protected UserRoles[] getUserRolesByUserIdCachedObjects( Long userId )
    throws Exception
  {
    UserRoles[] result = null;
    StringBuffer sb = new StringBuffer();
    sb.append("UserRolesByUserId-UserRoles-");
    
      sb.append(""+userId);

    FactoryCacheContainer cc = (FactoryCacheContainer)getCache().get(sb.toString());

    if (cc != null)
    {
      if (cc.isValid())
        result = (UserRoles[])cc.getPayload();
      else
      {
        getCache().remove(sb.toString());
        log.debug("expiring cache element with key: " + sb.toString());
      }
    }
    return result;
  }

  protected void cacheUserRolesByUserIdObjects(UserRoles[] results ,Long userId) 
  {
    try
    {
      FactoryCacheContainer cc = new FactoryCacheContainer(results, EXPIRES_INTERVAL_MILLIS);
      StringBuffer sb = new StringBuffer();
      sb.append("UserRolesByUserId-UserRoles-");
      
      sb.append(""+userId);
      getCache().put(sb.toString(),cc);
      log.info("(a) Cache size now: " + getCache().size());
    }
    catch(Exception e)
    {
      log.error("Failed Caching ResultSet", e);
      //throw e;
    }
  }


  protected org.w3c.dom.Element getCachedUserRolesByUserIdDOM(org.w3c.dom.Document doc,Long userId ) throws Exception
  {
    StringBuffer sb = new StringBuffer();
    sb.append("UserRolesByUserId-UserRoles-DOM-");
    
      sb.append(""+userId);

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

  protected void cacheUserRolesByUserIdDOM( org.w3c.dom.Element results,Long userId) 
  {
    try
    {
      org.w3c.dom.Document cacheDoc = getNewCacheDoc();
      FactoryCacheContainer cc = new FactoryCacheContainer((org.w3c.dom.Element)cacheDoc.importNode(results, true), cacheDoc, EXPIRES_INTERVAL_MILLIS);
      StringBuffer sb = new StringBuffer();
      sb.append("UserRolesByUserId-UserRoles-DOM-");
      
      sb.append(""+userId);
      getCache().put(sb.toString(),cc);
      log.info("(b) Cache size now: " + getCache().size());
    }
    catch(Exception e)
    {
      log.error("Failed Caching ResultSet", e);
      //throw e;
    }
  }


  protected UserRoles[] getUserRolesByNetIdCachedObjects( String NET_ID )
    throws Exception
  {
    UserRoles[] result = null;
    StringBuffer sb = new StringBuffer();
    sb.append("UserRolesByNetId-UserRoles-");
    
      sb.append(""+NET_ID);

    FactoryCacheContainer cc = (FactoryCacheContainer)getCache().get(sb.toString());

    if (cc != null)
    {
      if (cc.isValid())
        result = (UserRoles[])cc.getPayload();
      else
      {
        getCache().remove(sb.toString());
        log.debug("expiring cache element with key: " + sb.toString());
      }
    }
    return result;
  }

  protected void cacheUserRolesByNetIdObjects(UserRoles[] results ,String NET_ID) 
  {
    try
    {
      FactoryCacheContainer cc = new FactoryCacheContainer(results, EXPIRES_INTERVAL_MILLIS);
      StringBuffer sb = new StringBuffer();
      sb.append("UserRolesByNetId-UserRoles-");
      
      sb.append(""+NET_ID);
      getCache().put(sb.toString(),cc);
      log.info("(a) Cache size now: " + getCache().size());
    }
    catch(Exception e)
    {
      log.error("Failed Caching ResultSet", e);
      //throw e;
    }
  }


  protected org.w3c.dom.Element getCachedUserRolesByNetIdDOM(org.w3c.dom.Document doc,String NET_ID ) throws Exception
  {
    StringBuffer sb = new StringBuffer();
    sb.append("UserRolesByNetId-UserRoles-DOM-");
    
      sb.append(""+NET_ID);

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

  protected void cacheUserRolesByNetIdDOM( org.w3c.dom.Element results,String NET_ID) 
  {
    try
    {
      org.w3c.dom.Document cacheDoc = getNewCacheDoc();
      FactoryCacheContainer cc = new FactoryCacheContainer((org.w3c.dom.Element)cacheDoc.importNode(results, true), cacheDoc, EXPIRES_INTERVAL_MILLIS);
      StringBuffer sb = new StringBuffer();
      sb.append("UserRolesByNetId-UserRoles-DOM-");
      
      sb.append(""+NET_ID);
      getCache().put(sb.toString(),cc);
      log.info("(b) Cache size now: " + getCache().size());
    }
    catch(Exception e)
    {
      log.error("Failed Caching ResultSet", e);
      //throw e;
    }
  }



  public UserRoles[] processResults( Connection conn, Vector v ) throws Exception
  {
    // NOTE: This method is only valid when using the fetchAll() method.
    // Override this method in the extending class for the appropriate business logic.
    UserRoles[] results = new UserRoles[v.size()];
    v.copyInto(results);
    return results;
  }

  public UserRoles processRecord( Connection conn, UserRoles obj ) throws Exception
  {
    // Override this method in the extending class for the appropriate business logic.
    return obj;
  }


  /**
  * This method fetches UserRoles objects.

  * First an attempt is made to locate the results in the cache.  If the results aren't located, the
  * fetch is performed and the results are saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.
  * @see  #fetchUserRolesByUserIdDOM( Connection conn, , Long userId )
  * @see  #fetchUserRolesByUserIdDOM( Connection conn, org.w3c.dom.Document doc, Long userId )

  */
  public UserRoles[] fetchUserRolesByUserId( Connection conn, Long userId ) 
    throws Exception
  {
    return fetchUserRolesByUserId(conn,userId, true);
  } 
  
  
  
  protected UserRoles[] fetchUserRolesByUserId( Connection conn, Long userId, boolean shouldCache) 
    throws Exception
  {
    UserRoles[] results = null;

    results = getUserRolesByUserIdCachedObjects(userId);
    if (results != null)
    {
      log.info("fetchUserRolesByUserId Returning Cached ResultSet. size: " + results.length);
      return results;
    }

    log.debug("FETCH: "+CNAME+", sql: "+fetchUserRolesByUserIdSQL);

    Vector v = new Vector();

    PreparedStatement ps = conn.prepareStatement(fetchUserRolesByUserIdSQL);
    ps.setLong(1,userId.longValue());

    java.sql.ResultSet rs = ps.executeQuery();

    while (rs.next())
    {
      UserRoles rec = new UserRoles();
      rec.setRoleId(new Long(rs.getLong(1)));
      if (rs.wasNull())
        rec.setRoleId(null);
      rec.setRole(rs.getString(2));
      if (rs.wasNull())
        rec.setRole(null);


      Object obj = processRecord(conn,rec);
      if ( obj != null )
        v.addElement(obj);

    }

    rs.close();
    ps.close();

    results = processResults(conn,v);

    if (shouldCache)
      cacheUserRolesByUserIdObjects(results,userId);

    return results;
  }


  /**
  * This method fetches UserRoles objects as an XML DOM.

  * First an attempt is made to locate the DOM in the cache.  If the results aren't located, the
  * fetch is performed and the DOM is saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.

  * @see  #fetchUserRolesByUserId( Connection conn, , Long userId )

  * @see  #fetchUserRolesByUserIdDOM( Connection conn, org.w3c.dom.Document doc, Long userId )
  */
  public org.w3c.dom.Element fetchUserRolesByUserIdDOM( Connection conn, Long userId ) throws Exception
  {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document document = builder.newDocument();
    return fetchUserRolesByUserIdDOM(conn, document, userId);
  }

  public javax.xml.transform.dom.DOMSource fetchUserRolesByUserIdDOMSource( Connection conn, Long userId ) throws Exception
  {
    javax.xml.transform.dom.DOMSource dom = null;
    dom = new javax.xml.transform.dom.DOMSource(fetchUserRolesByUserIdDOM(conn, userId));
    return dom;
  } 

  public org.w3c.dom.Element processUserRolesByUserIdDOM( Connection conn, org.w3c.dom.Element root, org.w3c.dom.Document doc ) throws Exception
  {
    // NOTE: This method is only valid when using the fetchDOM() method.
    // Override this method in the extending class for the appropriate business logic.
    return root;
  }

  public org.w3c.dom.Element processUserRolesByUserIdElement( Connection conn, org.w3c.dom.Element e, org.w3c.dom.Document doc ) throws Exception
  {
    // Override this method in the extending class for the appropriate business logic.
    return e;
  }


  /**
  * This method fetches UserRoles objects as an XML DOM.

  * First an attempt is made to locate the DOM in the cache.  If the results aren't located, the
  * fetch is performed and the DOM is saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.

  * @see  #fetchUserRolesByUserId( Connection conn, , Long userId )

  * @see  #fetchUserRolesByUserIdDOM( Connection conn, , Long userId )
  */
  public org.w3c.dom.Element fetchUserRolesByUserIdDOM( Connection conn, org.w3c.dom.Document doc, Long userId ) throws Exception
  {
    org.w3c.dom.Element results = null;

    results = getCachedUserRolesByUserIdDOM(doc,userId);
    if (results != null)
    {
      log.info("fetchUserRolesByUserIdDOM Returning Cached Result");
      return results;
    }


    log.debug("FETCH: "+CNAME+", sql: "+fetchUserRolesByUserIdSQL);

    UserRoles[] _res = fetchUserRolesByUserId(conn,userId, false);

    Element root = (Element)doc.createElement("UserRolesResultSet");
    root.setAttribute("size",""+_res.length);

    for (int i=0; i<_res.length; i++)
    {
      Element UserRolesElem = (Element)_res[i].getElement(doc);

      Element e = processUserRolesByUserIdElement(conn, UserRolesElem, doc);
      if ( e != null )
      {
        e.setAttribute("rowId",""+i);
        root.appendChild(e);
      }
    }

    results = processUserRolesByUserIdDOM(conn,root,doc);

  
    cacheUserRolesByUserIdDOM(results,userId);
  
    return results;
  }

  /**
  * This method fetches UserRoles objects.

  * First an attempt is made to locate the results in the cache.  If the results aren't located, the
  * fetch is performed and the results are saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.
  * @see  #fetchUserRolesByNetIdDOM( Connection conn, , String NET_ID )
  * @see  #fetchUserRolesByNetIdDOM( Connection conn, org.w3c.dom.Document doc, String NET_ID )

  */
  public UserRoles[] fetchUserRolesByNetId( Connection conn, String NET_ID ) 
    throws Exception
  {
    return fetchUserRolesByNetId(conn,NET_ID, true);
  } 
  
  
  
  protected UserRoles[] fetchUserRolesByNetId( Connection conn, String NET_ID, boolean shouldCache) 
    throws Exception
  {
    UserRoles[] results = null;

    results = getUserRolesByNetIdCachedObjects(NET_ID);
    if (results != null)
    {
      log.info("fetchUserRolesByNetId Returning Cached ResultSet. size: " + results.length);
      return results;
    }

    log.debug("FETCH: "+CNAME+", sql: "+fetchUserRolesByNetIdSQL);

    Vector v = new Vector();

    PreparedStatement ps = conn.prepareStatement(fetchUserRolesByNetIdSQL);
    ps.setString(1,NET_ID);

    java.sql.ResultSet rs = ps.executeQuery();

    while (rs.next())
    {
      UserRoles rec = new UserRoles();
      rec.setRoleId(new Long(rs.getLong(1)));
      if (rs.wasNull())
        rec.setRoleId(null);
      rec.setRole(rs.getString(2));
      if (rs.wasNull())
        rec.setRole(null);


      Object obj = processRecord(conn,rec);
      if ( obj != null )
        v.addElement(obj);

    }

    rs.close();
    ps.close();

    results = processResults(conn,v);

    if (shouldCache)
      cacheUserRolesByNetIdObjects(results,NET_ID);

    return results;
  }


  /**
  * This method fetches UserRoles objects as an XML DOM.

  * First an attempt is made to locate the DOM in the cache.  If the results aren't located, the
  * fetch is performed and the DOM is saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.

  * @see  #fetchUserRolesByNetId( Connection conn, , String NET_ID )

  * @see  #fetchUserRolesByNetIdDOM( Connection conn, org.w3c.dom.Document doc, String NET_ID )
  */
  public org.w3c.dom.Element fetchUserRolesByNetIdDOM( Connection conn, String NET_ID ) throws Exception
  {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document document = builder.newDocument();
    return fetchUserRolesByNetIdDOM(conn, document, NET_ID);
  }

  public javax.xml.transform.dom.DOMSource fetchUserRolesByNetIdDOMSource( Connection conn, String NET_ID ) throws Exception
  {
    javax.xml.transform.dom.DOMSource dom = null;
    dom = new javax.xml.transform.dom.DOMSource(fetchUserRolesByNetIdDOM(conn, NET_ID));
    return dom;
  } 

  public org.w3c.dom.Element processUserRolesByNetIdDOM( Connection conn, org.w3c.dom.Element root, org.w3c.dom.Document doc ) throws Exception
  {
    // NOTE: This method is only valid when using the fetchDOM() method.
    // Override this method in the extending class for the appropriate business logic.
    return root;
  }

  public org.w3c.dom.Element processUserRolesByNetIdElement( Connection conn, org.w3c.dom.Element e, org.w3c.dom.Document doc ) throws Exception
  {
    // Override this method in the extending class for the appropriate business logic.
    return e;
  }


  /**
  * This method fetches UserRoles objects as an XML DOM.

  * First an attempt is made to locate the DOM in the cache.  If the results aren't located, the
  * fetch is performed and the DOM is saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.

  * @see  #fetchUserRolesByNetId( Connection conn, , String NET_ID )

  * @see  #fetchUserRolesByNetIdDOM( Connection conn, , String NET_ID )
  */
  public org.w3c.dom.Element fetchUserRolesByNetIdDOM( Connection conn, org.w3c.dom.Document doc, String NET_ID ) throws Exception
  {
    org.w3c.dom.Element results = null;

    results = getCachedUserRolesByNetIdDOM(doc,NET_ID);
    if (results != null)
    {
      log.info("fetchUserRolesByNetIdDOM Returning Cached Result");
      return results;
    }


    log.debug("FETCH: "+CNAME+", sql: "+fetchUserRolesByNetIdSQL);

    UserRoles[] _res = fetchUserRolesByNetId(conn,NET_ID, false);

    Element root = (Element)doc.createElement("UserRolesResultSet");
    root.setAttribute("size",""+_res.length);

    for (int i=0; i<_res.length; i++)
    {
      Element UserRolesElem = (Element)_res[i].getElement(doc);

      Element e = processUserRolesByNetIdElement(conn, UserRolesElem, doc);
      if ( e != null )
      {
        e.setAttribute("rowId",""+i);
        root.appendChild(e);
      }
    }

    results = processUserRolesByNetIdDOM(conn,root,doc);

  
    cacheUserRolesByNetIdDOM(results,NET_ID);
  
    return results;
  }


}
