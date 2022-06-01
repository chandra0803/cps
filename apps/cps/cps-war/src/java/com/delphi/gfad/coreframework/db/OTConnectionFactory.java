/*
 *
 * $Id: OTConnectionFactory.java,v 1.2 2004/08/23 22:07:45 vz86k2 Exp $
 * $Revision: 1.2 $
 * $Log: OTConnectionFactory.java,v $
 * Revision 1.2  2004/08/23 22:07:45  vz86k2
 * update
 *
 * Revision 1.1  2004/08/23 20:30:25  vz86k2
 * check in
 *
 *
 */

package com.delphi.gfad.coreframework.db;

import java.sql.*;
import java.util.*;

import org.apache.commons.logging.*;

public class OTConnectionFactory
{
  private static Log log = LogFactory.getLog(OTConnectionFactory.class);

  public static final String RESOURCE_BUNDLE_NAME = "connection-factory";

  public static final String CNAME = OTConnectionFactory.class.getName();
  private String CLASS_NAME = OTConnectionFactory.class.getName()+".";
  private String[] DB_NAMES;
  private String[] DRIVER_NAMES;
  private String[] URLS;
  private String[] USERS;
  private String[] PASSWORDS;
  private String[] POOL_SIZES;
  private String[] SCHEMAS;
  private String[] TIMEOUTS;
  private String[] RETRIES;
  private int[] retries;
  private long[] timeouts;
  private int[] sizes;
  private static String SET_SCHEMA_SQL = "set SCHEMA ?";
  private static String DB2_SCHEMA = null;
  private static long timeout = 6000; // 6 Seconds
  private static int retry = 3;
  private boolean cacheStatements = false;
  private boolean debug = true;
  private String[] NOTIFY_EMAILS;

  private Hashtable databases;

  public OTConnectionFactory()
  {
    ResourceBundle bundle = null;
    bundle = ResourceBundle.getBundle(RESOURCE_BUNDLE_NAME);
    if (bundle == null)
    {
      try
      {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        bundle = ResourceBundle.getBundle(RESOURCE_BUNDLE_NAME, Locale.getDefault(), classLoader);
      }
      catch(java.util.MissingResourceException ex)
      {
        if (log.isErrorEnabled()) 
          log.error("Error loading connection pool resource file: "+RESOURCE_BUNDLE_NAME);
      }
    }

    String value = bundle.getString(CLASS_NAME+"CacheStatements");
    if (value == null)
       cacheStatements = false;
    else if (value.toUpperCase().equals("TRUE"))
       cacheStatements = true;
    else
       cacheStatements = false;

    value = bundle.getString(CLASS_NAME+"Debug");
    if (value == null)
       debug = false;
    else if (value.toUpperCase().equals("TRUE"))
       debug = true;
    else
       debug = false;

    DB_NAMES = getResourceStrings(bundle,CLASS_NAME+"DatabaseName");
    DRIVER_NAMES = getResourceStrings(bundle,CLASS_NAME+"DriverName");
    URLS = getResourceStrings(bundle,CLASS_NAME+"Url");
    USERS = getResourceStrings(bundle,CLASS_NAME+"User");
    PASSWORDS = getResourceStrings(bundle,CLASS_NAME+"Password");
    POOL_SIZES = getResourceStrings(bundle,CLASS_NAME+"PoolSize");
    SCHEMAS = getResourceStrings(bundle,CLASS_NAME+"Schema");

    TIMEOUTS = getResourceStrings(bundle,CLASS_NAME+"Timeout");
    RETRIES = getResourceStrings(bundle,CLASS_NAME+"Retry");

    NOTIFY_EMAILS = getResourceStrings(bundle,CLASS_NAME+"Email");

    databases = new Hashtable();
    for(int i=0; i< DB_NAMES.length; i++)
    {
      databases.put(DB_NAMES[i],new Integer(i));
    }

    retries = new int[DB_NAMES.length];
    timeouts = new long[DB_NAMES.length];
    sizes = new int[DB_NAMES.length];

    for(int i=0; i< DB_NAMES.length; i++)
    {
      try
      {
        retries[i] = Integer.parseInt(RETRIES[i].trim());
        timeouts[i] = Long.parseLong(TIMEOUTS[i].trim())*1000; // Timeouts are in Sec. , code wants Milliseconds
        sizes[i] = Integer.parseInt(POOL_SIZES[i].trim());
      }
      catch(Exception ex)
      {
        retries[i] = retry;
        timeouts[i] = timeout;
      }
    }
  }

  public int getIndex(String databaseName) throws SQLException
  {
    try
    {
      return ((Integer)(databases.get(databaseName))).intValue();
    }
    catch( Exception ex )
    {
      throw new SQLException("Invalid Database Name: "+databaseName);
    }
  }

  public long getTimeout(int index) throws SQLException
  {
    try
    {
      return timeouts[index];
    }
    catch( Exception ex )
    {
      throw new SQLException("Invalid Database Index.");
    }
  }

  public int getRetries(int index) throws SQLException
  {
    try
    {
      return retries[index];
    }
    catch( Exception ex )
    {
      throw new SQLException("Invalid Database Index.");
    }
  }

  public String[] getNotifyEmails()
  {
    return NOTIFY_EMAILS;
  }

  public String getNotifyEmailsCD()
  {
    StringBuffer sb = new StringBuffer();
    for(int i=0; i<NOTIFY_EMAILS.length; i++)
    {
      if (i > 0)
        sb.append(",");

      sb.append(NOTIFY_EMAILS[i]);
    }
    return sb.toString();
  }

  public boolean getDebug()
  {
    return debug;
  }

  public Connection getConnection(String databaseName) throws SQLException
  {
    Connection conn = null;
    int index = getIndex(databaseName);

    log.info("******************************************************");
    log.info("** OTConnection: creating connection to "+databaseName);
    log.info("** Driver: "+DRIVER_NAMES[index]);
    log.info("** URL: "+URLS[index]);
    log.info("** SCHEMA: "+SCHEMAS[index]);
    log.info("** Timeout: "+TIMEOUTS[index]);
    log.info("** Retries: "+RETRIES[index]);
    log.info("** Cache Statements: "+cacheStatements);
    if ( URLS[index].startsWith("jdbc:db2"))
    {
      log.info("** IS DB2.");
    }
    log.info("******************************************************");

    try
    {
      Class.forName(DRIVER_NAMES[index]);
    }
    catch (ClassNotFoundException ex)
    {
      throw new SQLException("Unable to locate jdbc driver class: "+DRIVER_NAMES[index]);
    }

    conn = DriverManager.getConnection(URLS[index],USERS[index],PASSWORDS[index]);

    SQLWarning warning = conn.getWarnings();
    while (warning != null)
    {
      log.error("Warning: "+warning);
      warning = warning.getNextWarning();
    }

    // if db2 - set schema

    if ( URLS[index].startsWith("jdbc:db2"))
    {
      setSchema(conn,SCHEMAS[index]);
    }

    OTConnection otConn = new OTConnection(conn);
    otConn.setCacheStatements(cacheStatements);
    return otConn;
  }

  public void setSchema( Connection conn, String schema ) throws SQLException
  {
    if (schema != null)
    {
      PreparedStatement ps = conn.prepareStatement(SET_SCHEMA_SQL);
      ps.setString(1, schema);
      ps.executeQuery();
    }
  }

  public String[] getDatabaseNames()
  {
    return DB_NAMES;
  }

  public int getInitialNumConnections(int index) throws SQLException
  {
    try
    {
      return sizes[index];
    }
    catch( Exception ex )
    {
      throw new SQLException("Invalid Database Index.");
    }
  }

  public String[] getResourceStrings( ResourceBundle bundle, String name )
  {
    java.util.Vector v = new java.util.Vector();
    String prop = null;
    int i=0;
    prop = bundle.getString(name+"."+i);

    while ( prop != null )
    {
      v.addElement(prop);
      i++;
      try
      {
        prop = bundle.getString(name+"."+i);
      }
      catch(java.util.MissingResourceException ex)
      {
        prop = null;
      }
    }

    String[] result = new String[v.size()];
    v.copyInto(result);
    return result;
  }
}
