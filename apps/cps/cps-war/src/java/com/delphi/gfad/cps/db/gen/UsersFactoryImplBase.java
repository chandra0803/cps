

/**
 *
 * Class: UsersFactoryImplBase
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
using the subclass UsersFactory.
The Users business object encapsulates access to the set of Users in CPS.  
  
SQL Statements used are as follows<blink>:</blink><p>
<table border="1">
<tr><th>Action</th><th>SQL</th><th>Parameters</th></tr>
<tr><td>Fetch UsersByNetId</td><td><code>SELECT t1.USER_ID, t1.NET_ID FROM CPS_USER t1 WHERE t1.NET_ID = ? AND ISACTIVE='Y'</code></td><td>net_Id </td></tr>

</table>
*/
public class UsersFactoryImplBase
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(UsersFactoryImplBase.class);

  /**
  * Defines the name of this class as a public static string.  Used for logging statements.
  */
  public static String CNAME = UsersFactoryImplBase.class.getName();

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


  protected String fetchUsersByNetIdSQL = "SELECT t1.USER_ID, t1.NET_ID FROM CPS_USER t1 WHERE t1.NET_ID = ? AND ISACTIVE='Y'";

  protected  javax.xml.parsers.DocumentBuilderFactory dFactory = null;
  protected  javax.xml.parsers.DocumentBuilder dBuilder = null;

  protected static HashMap cache;
  protected static boolean cachingEnabled = true; 


  /**
  * Protected no-arg Business Object constructor.  
  */
  protected UsersFactoryImplBase()
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

  protected Users[] getUsersByNetIdCachedObjects( String net_Id )
    throws Exception
  {
    Users[] result = null;
    StringBuffer sb = new StringBuffer();
    sb.append("UsersByNetId-Users-");
    
      sb.append(""+net_Id);

    FactoryCacheContainer cc = (FactoryCacheContainer)getCache().get(sb.toString());

    if (cc != null)
    {
      if (cc.isValid())
        result = (Users[])cc.getPayload();
      else
      {
        getCache().remove(sb.toString());
        log.debug("expiring cache element with key: " + sb.toString());
      }
    }
    return result;
  }

  protected void cacheUsersByNetIdObjects(Users[] results ,String net_Id) 
  {
    try
    {
      FactoryCacheContainer cc = new FactoryCacheContainer(results, EXPIRES_INTERVAL_MILLIS);
      StringBuffer sb = new StringBuffer();
      sb.append("UsersByNetId-Users-");
      
      sb.append(""+net_Id);
      getCache().put(sb.toString(),cc);
      log.info("(a) Cache size now: " + getCache().size());
    }
    catch(Exception e)
    {
      log.error("Failed Caching ResultSet", e);
      //throw e;
    }
  }


  protected org.w3c.dom.Element getCachedUsersByNetIdDOM(org.w3c.dom.Document doc,String net_Id ) throws Exception
  {
    StringBuffer sb = new StringBuffer();
    sb.append("UsersByNetId-Users-DOM-");
    
      sb.append(""+net_Id);

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

  protected void cacheUsersByNetIdDOM( org.w3c.dom.Element results,String net_Id) 
  {
    try
    {
      org.w3c.dom.Document cacheDoc = getNewCacheDoc();
      FactoryCacheContainer cc = new FactoryCacheContainer((org.w3c.dom.Element)cacheDoc.importNode(results, true), cacheDoc, EXPIRES_INTERVAL_MILLIS);
      StringBuffer sb = new StringBuffer();
      sb.append("UsersByNetId-Users-DOM-");
      
      sb.append(""+net_Id);
      getCache().put(sb.toString(),cc);
      log.info("(b) Cache size now: " + getCache().size());
    }
    catch(Exception e)
    {
      log.error("Failed Caching ResultSet", e);
      //throw e;
    }
  }



  public Users[] processResults( Connection conn, Vector v ) throws Exception
  {
    // NOTE: This method is only valid when using the fetchAll() method.
    // Override this method in the extending class for the appropriate business logic.
    Users[] results = new Users[v.size()];
    v.copyInto(results);
    return results;
  }

  public Users processRecord( Connection conn, Users obj ) throws Exception
  {
    // Override this method in the extending class for the appropriate business logic.
    return obj;
  }


  /**
  * This method fetches Users objects.

  * First an attempt is made to locate the results in the cache.  If the results aren't located, the
  * fetch is performed and the results are saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.
  * @see  #fetchUsersByNetIdDOM( Connection conn, , String net_Id )
  * @see  #fetchUsersByNetIdDOM( Connection conn, org.w3c.dom.Document doc, String net_Id )

  */
  public Users[] fetchUsersByNetId( Connection conn, String net_Id ) 
    throws Exception
  {
    return fetchUsersByNetId(conn,net_Id, true);
  } 
  
  
  
  protected Users[] fetchUsersByNetId( Connection conn, String net_Id, boolean shouldCache) 
    throws Exception
  {
    Users[] results = null;

    results = getUsersByNetIdCachedObjects(net_Id);
    if (results != null)
    {
      log.info("fetchUsersByNetId Returning Cached ResultSet. size: " + results.length);
      return results;
    }

    log.debug("FETCH: "+CNAME+", sql: "+fetchUsersByNetIdSQL);

    Vector v = new Vector();

    PreparedStatement ps = conn.prepareStatement(fetchUsersByNetIdSQL);
    ps.setString(1,net_Id);

    java.sql.ResultSet rs = ps.executeQuery();

    while (rs.next())
    {
      Users rec = new Users();
      rec.setUserId(new Long(rs.getLong(1)));
      if (rs.wasNull())
        rec.setUserId(null);
      rec.setNetId(rs.getString(2));
      if (rs.wasNull())
        rec.setNetId(null);


      Object obj = processRecord(conn,rec);
      if ( obj != null )
        v.addElement(obj);

    }

    rs.close();
    ps.close();

    results = processResults(conn,v);

    if (shouldCache)
      cacheUsersByNetIdObjects(results,net_Id);

    return results;
  }


  /**
  * This method fetches Users objects as an XML DOM.

  * First an attempt is made to locate the DOM in the cache.  If the results aren't located, the
  * fetch is performed and the DOM is saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.

  * @see  #fetchUsersByNetId( Connection conn, , String net_Id )

  * @see  #fetchUsersByNetIdDOM( Connection conn, org.w3c.dom.Document doc, String net_Id )
  */
  public org.w3c.dom.Element fetchUsersByNetIdDOM( Connection conn, String net_Id ) throws Exception
  {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document document = builder.newDocument();
    return fetchUsersByNetIdDOM(conn, document, net_Id);
  }

  public javax.xml.transform.dom.DOMSource fetchUsersByNetIdDOMSource( Connection conn, String net_Id ) throws Exception
  {
    javax.xml.transform.dom.DOMSource dom = null;
    dom = new javax.xml.transform.dom.DOMSource(fetchUsersByNetIdDOM(conn, net_Id));
    return dom;
  } 

  public org.w3c.dom.Element processUsersByNetIdDOM( Connection conn, org.w3c.dom.Element root, org.w3c.dom.Document doc ) throws Exception
  {
    // NOTE: This method is only valid when using the fetchDOM() method.
    // Override this method in the extending class for the appropriate business logic.
    return root;
  }

  public org.w3c.dom.Element processUsersByNetIdElement( Connection conn, org.w3c.dom.Element e, org.w3c.dom.Document doc ) throws Exception
  {
    // Override this method in the extending class for the appropriate business logic.
    return e;
  }


  /**
  * This method fetches Users objects as an XML DOM.

  * First an attempt is made to locate the DOM in the cache.  If the results aren't located, the
  * fetch is performed and the DOM is saved in the cache for future use.
  * The results of this fetch are not guarenteed to be in sync with the database.

  * @see  #fetchUsersByNetId( Connection conn, , String net_Id )

  * @see  #fetchUsersByNetIdDOM( Connection conn, , String net_Id )
  */
  public org.w3c.dom.Element fetchUsersByNetIdDOM( Connection conn, org.w3c.dom.Document doc, String net_Id ) throws Exception
  {
    org.w3c.dom.Element results = null;

    results = getCachedUsersByNetIdDOM(doc,net_Id);
    if (results != null)
    {
      log.info("fetchUsersByNetIdDOM Returning Cached Result");
      return results;
    }


    log.debug("FETCH: "+CNAME+", sql: "+fetchUsersByNetIdSQL);

    Users[] _res = fetchUsersByNetId(conn,net_Id, false);

    Element root = (Element)doc.createElement("UsersResultSet");
    root.setAttribute("size",""+_res.length);

    for (int i=0; i<_res.length; i++)
    {
      Element UsersElem = (Element)_res[i].getElement(doc);

      Element e = processUsersByNetIdElement(conn, UsersElem, doc);
      if ( e != null )
      {
        e.setAttribute("rowId",""+i);
        root.appendChild(e);
      }
    }

    results = processUsersByNetIdDOM(conn,root,doc);

  
    cacheUsersByNetIdDOM(results,net_Id);
  
    return results;
  }


}
