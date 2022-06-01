

/**
 *
 * Class: SelectFileFactoryImplBase
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
using the subclass SelectFileFactory.
The Users business object encapsulates access to the set of CPS File Select.  
  
SQL Statements used are as follows<blink>:</blink><p>
<table border="1">
<tr><th>Action</th><th>SQL</th><th>Parameters</th></tr>
<tr><td>Fetch FileInfo</td><td><code>SELECT T2.FILE_ID, T2.DT_CREATE, T2.TXT_FILE_NAME, T2.COMMENTS FROM CPS_USER T1, CPS_FILE T2 WHERE T1.USER_ID = T2.USER_ID AND T1.NET_ID = ? ORDER BY T2.TXT_FILE_NAME</code></td><td>netid </td></tr>

</table>
*/
public class SelectFileFactoryImplBase
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(SelectFileFactoryImplBase.class);

  /**
  * Defines the name of this class as a public static string.  Used for logging statements.
  */
  public static String CNAME = SelectFileFactoryImplBase.class.getName();

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


  protected String fetchFileInfoSQL = "SELECT T2.FILE_ID, T2.DT_CREATE, T2.TXT_FILE_NAME, T2.COMMENTS FROM CPS_USER T1, CPS_FILE T2 WHERE T1.USER_ID = T2.USER_ID AND T1.NET_ID = ? ORDER BY T2.TXT_FILE_NAME";


  /**
  * Protected no-arg Business Object constructor.  
  */
  protected SelectFileFactoryImplBase()
  {

  }


  /**
  * An empty method, since none of the fetches in this factory are cached.

  */
  public void setCaching(boolean caching)
  {

  }

  /**
  * Returns false.

  */
  public boolean getCaching()
  {
    return false;

  }

  /**
  * Returns null.

  */
  public HashMap getCache()
  {
    return null;

  }

  /**
  * An empty method, since none of the fetches in this factory are cached.

  */
  protected void clearCache()
  {

  }



  public SelectFile[] processResults( Connection conn, Vector v ) throws Exception
  {
    // NOTE: This method is only valid when using the fetchAll() method.
    // Override this method in the extending class for the appropriate business logic.
    SelectFile[] results = new SelectFile[v.size()];
    v.copyInto(results);
    return results;
  }

  public SelectFile processRecord( Connection conn, SelectFile obj ) throws Exception
  {
    // Override this method in the extending class for the appropriate business logic.
    return obj;
  }


  /**
  * This method fetches SelectFile objects.

  * This fetch method does not implement caching, so results are guarenteed fresh.
  * @see  #fetchFileInfoDOM( Connection conn, , String netid )
  * @see  #fetchFileInfoDOM( Connection conn, org.w3c.dom.Document doc, String netid )

  */
  public SelectFile[] fetchFileInfo( Connection conn, String netid ) 
    throws Exception
  {
    return fetchFileInfo(conn,netid, true);
  } 
  
  
  
  protected SelectFile[] fetchFileInfo( Connection conn, String netid, boolean shouldCache) 
    throws Exception
  {
    SelectFile[] results = null;

    log.debug("FETCH: "+CNAME+", sql: "+fetchFileInfoSQL);

    Vector v = new Vector();

    PreparedStatement ps = conn.prepareStatement(fetchFileInfoSQL);
    ps.setString(1,netid);

    java.sql.ResultSet rs = ps.executeQuery();

    while (rs.next())
    {
      SelectFile rec = new SelectFile();
      rec.setId(new Long(rs.getLong(1)));
      if (rs.wasNull())
        rec.setId(null);
      rec.setDt(rs.getDate(2));
      if (rs.wasNull())
        rec.setDt(null);
      rec.setName(rs.getString(3));
      if (rs.wasNull())
        rec.setName(null);
      rec.setComment(rs.getString(4));
      if (rs.wasNull())
        rec.setComment(null);


      Object obj = processRecord(conn,rec);
      if ( obj != null )
        v.addElement(obj);

    }

    rs.close();
    ps.close();

    results = processResults(conn,v);

    return results;
  }


  /**
  * This method fetches SelectFile objects as an XML DOM.

  * This fetch method does not implement caching, so results are guarenteed fresh.

  * @see  #fetchFileInfo( Connection conn, , String netid )

  * @see  #fetchFileInfoDOM( Connection conn, org.w3c.dom.Document doc, String netid )
  */
  public org.w3c.dom.Element fetchFileInfoDOM( Connection conn, String netid ) throws Exception
  {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document document = builder.newDocument();
    return fetchFileInfoDOM(conn, document, netid);
  }

  public javax.xml.transform.dom.DOMSource fetchFileInfoDOMSource( Connection conn, String netid ) throws Exception
  {
    javax.xml.transform.dom.DOMSource dom = null;
    dom = new javax.xml.transform.dom.DOMSource(fetchFileInfoDOM(conn, netid));
    return dom;
  } 

  public org.w3c.dom.Element processFileInfoDOM( Connection conn, org.w3c.dom.Element root, org.w3c.dom.Document doc ) throws Exception
  {
    // NOTE: This method is only valid when using the fetchDOM() method.
    // Override this method in the extending class for the appropriate business logic.
    return root;
  }

  public org.w3c.dom.Element processFileInfoElement( Connection conn, org.w3c.dom.Element e, org.w3c.dom.Document doc ) throws Exception
  {
    // Override this method in the extending class for the appropriate business logic.
    return e;
  }


  /**
  * This method fetches SelectFile objects as an XML DOM.

  * This fetch method does not implement caching, so results are guarenteed fresh.

  * @see  #fetchFileInfo( Connection conn, , String netid )

  * @see  #fetchFileInfoDOM( Connection conn, , String netid )
  */
  public org.w3c.dom.Element fetchFileInfoDOM( Connection conn, org.w3c.dom.Document doc, String netid ) throws Exception
  {
    org.w3c.dom.Element results = null;


    log.debug("FETCH: "+CNAME+", sql: "+fetchFileInfoSQL);

    SelectFile[] _res = fetchFileInfo(conn,netid, false);

    Element root = (Element)doc.createElement("SelectFileResultSet");
    root.setAttribute("size",""+_res.length);

    for (int i=0; i<_res.length; i++)
    {
      Element SelectFileElem = (Element)_res[i].getElement(doc);

      Element e = processFileInfoElement(conn, SelectFileElem, doc);
      if ( e != null )
      {
        e.setAttribute("rowId",""+i);
        root.appendChild(e);
      }
    }

    results = processFileInfoDOM(conn,root,doc);

  
    return results;
  }


}
