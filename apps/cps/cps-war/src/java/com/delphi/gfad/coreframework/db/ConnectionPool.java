/*
 *
 * $Id: ConnectionPool.java,v 1.1 2004/08/23 20:30:26 vz86k2 Exp $
 *
 */

package com.delphi.gfad.coreframework.db;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.lang.reflect.Method;

import org.apache.commons.logging.*;

public class ConnectionPool
{
  private static Log log = LogFactory.getLog(ConnectionPool.class);

  public static final String CNAME = ConnectionPool.class.getName();

  public static final String RESOURCE_BUNDLE_NAME = "connection-pool";

  public static final String PROP_USE_POOLING         = CNAME + ".useInternalPooling";
  public static final String PROP_SHRINK_POOL_MINUTES = CNAME + ".shrinkPoolMinutes";
  public static final String PROP_DEFAULT_AUTOCOMMIT  = CNAME + ".defaultAutoCommit";
  public static final String PROP_DRIVER_NAME         = CNAME + ".driverName";
  public static final String PROP_URL                 = CNAME + ".url";
  public static final String PROP_USER                = CNAME + ".user";
  public static final String PROP_PASSWORD            = CNAME + ".password";
  public static final String PROP_VALIDATOR_CLASS     = CNAME + ".validatorClass";

  public static final int MAX_CONNECTION_RETRYS = 3;

  private static ConnectionPool pool;
  private static Hashtable allConnections[];

  private OTConnectionFactory factory;
  private Stack[] stacks;
  private boolean debug;

  private boolean _isUsingInternalPooling = true;
  private boolean _defaultAutoCommit = true;
  private Driver _driver = null;
  private String _url = null;
  private int _shrinkPoolMinutes = -1;
  private BaseConnectionValidator _validator = null;

  private static Timer      _timer;
  private static PoolShrink _landShark;


  private ConnectionPool() throws SQLException
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

    // if property not set, default to true
    String value = bundle.getString(PROP_USE_POOLING);
    if (value == null)
       _isUsingInternalPooling = true;
    else if (value.toUpperCase().equals("TRUE"))
      _isUsingInternalPooling = true;
    else
      _isUsingInternalPooling = false;

    value = bundle.getString(PROP_DEFAULT_AUTOCOMMIT);
    if (value == null)
       _defaultAutoCommit = true;
    else if (value.toUpperCase().equals("TRUE"))
       _defaultAutoCommit = true;
    else
      _defaultAutoCommit = false;

    String valClassName = bundle.getString(PROP_VALIDATOR_CLASS);
    if ((valClassName != null) && (valClassName.length() > 0))
    {
      log.debug("attempting to load validator class: " + valClassName);
      try
      {
        _validator = (BaseConnectionValidator)Class.forName(valClassName).newInstance();
      }
      catch (Exception e)
      {
        log.error("Got exception loading validator" , e);
        throw new SQLException (e.toString());
      }
    }
    else
    {
      log.debug( "loading base validator class");
      _validator = new BaseConnectionValidator();
    }

    if ( _isUsingInternalPooling )
    {
      initInternalPooling();

      value = bundle.getString(PROP_SHRINK_POOL_MINUTES);
      if (value != null)
      {
        _shrinkPoolMinutes = Integer.parseInt(value.trim());

        if (_shrinkPoolMinutes > 0)
        {
          log.debug( "Pool shrink ENABLED, minutes: " + _shrinkPoolMinutes);
          _landShark         = this.new PoolShrink();
          _timer             = new Timer(true);  // timer is a daemon - do not prolong life of app

          int shrinkMillis = _shrinkPoolMinutes * 60 * 1000;
 
          _timer.schedule( _landShark,  shrinkMillis, shrinkMillis);
        }
        else
        {
          log.debug( "Pool shrink DISABLED, minutes: " + _shrinkPoolMinutes);
        }
      }
    }
    else
    {
      initExternalPooling(bundle);
    }

  }

  public boolean isUsingInternalPooling() { return _isUsingInternalPooling; }
  public boolean defaultAutoCommit() { return _defaultAutoCommit; }

  private void initExternalPooling(ResourceBundle bundle)  throws SQLException
  {
    log.debug( "initializing for externally managed connection pooling");

    // driver name
    String driverName = bundle.getString(PROP_DRIVER_NAME);
    if ( driverName == null )
    {
      String msg = "application property \"" + PROP_DRIVER_NAME + "\" not set";
      log.error(  msg );
      throw new SQLException( msg );
    }
    try
    {
      _driver = (Driver)Class.forName( driverName ).newInstance();
    }
    catch ( Exception e )
    {
      String msg = e.toString();
      log.error(  msg );
      throw new SQLException( msg );
    }

    // url
    _url = bundle.getString(PROP_URL);
    if ( _driver == null )
    {
      String msg = "application property \"" + PROP_URL + "\" not set";
      log.error(  msg );
      throw new SQLException( msg );
    }

  }

  private void initInternalPooling() throws SQLException
  {
    log.debug( "initializing for internally managed connection pooling");
      factory = new OTConnectionFactory();
      debug = factory.getDebug();
      String[] databaseNames = factory.getDatabaseNames();
      stacks = new Stack[databaseNames.length];
      allConnections = new Hashtable[databaseNames.length];

      for(int i=0; i<databaseNames.length; i++)
      {
        stacks[i] = new Stack();
        allConnections[i] = new Hashtable(50);

        int count = factory.getInitialNumConnections(i);
        try
        {
          // let the connects be created as needed up to max
          // we can do this due to the new test/retry code
          // no sense in grabbing 20 up front

          //for(int j=0; j<count; j++)
          //{

          // create one connection to get started, this 
          // verifies the connection info is OK
          if (count > 0)
            putConn(databaseNames[i],factory.getConnection(databaseNames[i]));
          //}
        }
        catch(Exception ex)
        {
          log.error( "<ConnectionPool(b)> ---- Caught Exception creating connection: ", ex);
          //ex.printStackTrace();
        }
      }
      if (debug)
      {
        log.debug( "************************************************");
        log.debug( "** Initial Connection Pools ");
        log.debug( "**");
        for(int i=0; i<databaseNames.length; i++)
        {
          try
          {
            log.debug( "**  "+databaseNames[i]+" Size: "+getNumFreeConn(databaseNames[i]));
          }
          catch( Exception ex )
          {
          }
        }
        log.debug( "**");
        log.debug( "************************************************");
      }
  }

  public static ConnectionPool getInstance() throws SQLException
  {
    if ( pool == null )
    {
      synchronized(ConnectionPool.class)
      {
        if ( pool == null )
        {
          pool = new ConnectionPool();
        }
      }
    }
    
    return pool;
  }

  public static Connection getConnection( String databaseName ) throws SQLException
  {
    return ConnectionPool.getInstance().getConn(databaseName);
  }

  private Connection getConn(String databaseName) throws SQLException
  {
    Connection result = null;
    int tries = 0;
    boolean isValid = false;

    if ( this._isUsingInternalPooling )
       result = this.getPoolConn(databaseName);
    else
      // I guess we are using connection from the driver directly... hopefully it is
      // a driver that manages connections internally
      result = getDriverConn();

    while ((! (isValid = _validator.validateConnection(result))) && (++tries < MAX_CONNECTION_RETRYS))
    {
      log.debug( "invalid connection for databaseName " +databaseName+ ", try " + tries);
      log.debug( "marking invalid:");
      _validator.markInvalidConnection(result);

      log.debug("replacing:");
      result = this.replaceConn(databaseName, result);
    }
  
    if (!isValid)
    {
      try
      {
        // try putting away the connection
        this.putConn(databaseName, result);
      }
      catch (Exception e)
      {
        // ignore
      }
      throw new SQLException("unable to create valid connection after " +tries+ " tries, giving up");
    }

    return result;
  }

  /**
   * Get a connection from the externally managed pool (directly from driver)
   */
  private Connection getDriverConn()
    throws SQLException
  {
    return _driver.connect(_url, null);
  }

  /**
   * Get a connection from the internally managed pool
   */
  private Connection getPoolConn( String databaseName ) throws SQLException
  {
    if (debug)
      log.debug("** GET CONNECTION "+databaseName+", "+System.currentTimeMillis()+", "+getNumFreeConn(databaseName));

    int index = factory.getIndex(databaseName);
    synchronized(stacks[index])
    {
      int tries = factory.getRetries(index);
      long timeout = factory.getTimeout(index);

      if (stacks[index].empty())
      {
        int count = factory.getInitialNumConnections(index);

        if (allConnections[index].size() < count)
        {
          try
          {
            putConn(databaseName, factory.getConnection(databaseName));
          }
          catch (Exception e)
          {
            log.error("Failed to replace connection", e);
          }
        }
      }

      while(stacks[index].empty())
      {
        if (debug)
          log.debug("** Connection Stack is Empty, try "+tries);
        try
        {
          stacks[index].wait(timeout); // wait for a new one
        }
        catch(Exception e1)
        {
          notify("ConnectionPool: "+databaseName+" stack has been interrupted.");
          throw new SQLException("ConnectioPool: Connection Interrupted.");
        }
        if(--tries < 1)
        {
          notify("ConnectionPool: "+databaseName+" has no free connections after "+factory.getRetries(index)+" tries @ "+factory.getTimeout(index)/1000+" Sec.");
          throw new SQLException("ConnectionPool: No Free Connections.");
        }
      }
      return (Connection)stacks[index].pop();
    }
  }

  public static void putConnection( String databaseName, Connection conn ) throws SQLException
  {
    ConnectionPool.getInstance().putConn(databaseName,conn);
  }

  /**
   * Put a connection back that was retrieved directly from the driver
   */
  private void putDriverConn( Connection conn ) throws SQLException
  {
    // just make sure the connection is closed
    conn.close();
  }

  /**
   * Put a connection back that was retreived from the internally managed pool
   */
  private void putPoolConn( String databaseName, Connection conn ) throws SQLException
  {
    int index = factory.getIndex(databaseName);

    if ( conn == null )
      return;

    if (!allConnections[index].contains(conn))
      allConnections[index].put(conn,conn);

    if (debug)
      log.debug("** PUT CONNECTION "+databaseName+", "+System.currentTimeMillis()+", "+getNumFreeConn(databaseName));

    if ( conn == null )
    {
      conn = factory.getConnection(databaseName);
    }

    synchronized( stacks[index] )
    {
      stacks[index].push( conn );
      stacks[index].notify();
    }
  }

  public void putConn( String databaseName, Connection conn ) throws SQLException
  {
    try
    {
      // assert
      if (_defaultAutoCommit)
        conn.commit();
      conn.setAutoCommit(_defaultAutoCommit);
    }
    catch (Exception e)
    {
      log.error("** PUT CONNECTION "+databaseName+", "+System.currentTimeMillis()+", got exception restoring autocommit, continuing", e);
    }

    if ( this._isUsingInternalPooling )
       putPoolConn( databaseName, conn );
    else
      putDriverConn( conn );
  }

  public int getNumFreeConn( String databaseName ) throws SQLException
  {
    int index = factory.getIndex(databaseName);
    synchronized( stacks[index] )
    {
      return stacks[index].size();
    }
  }

  public int getNumAllocConn( String databaseName ) throws SQLException
  {
    int index = factory.getIndex(databaseName);
    return allConnections[index].size();
  }

  public void addConnection( String databaseName ) throws SQLException
  {
    putConn(databaseName,factory.getConnection(databaseName));
  }

  public void pruneAllPools() throws SQLException
  {
    String[] databaseNames = factory.getDatabaseNames();

    for (int i=0; i<databaseNames.length; i++)
    {
      int index = factory.getIndex(databaseNames[i]);
      if (allConnections[index].size() > 0)
      {
        log.debug("Pruning pool " + databaseNames[i]);
        removeConnection(databaseNames[i]);
      }
      else
      {
        log.debug("NOT Pruning pool " + databaseNames[i]);
      }
    }
  }

  public void removeConnection( String databaseName ) throws SQLException
  {
    Connection conn = getConn(databaseName);
    int index = factory.getIndex(databaseName);

    if (allConnections[index].contains(conn))
      allConnections[index].remove(conn);

    conn.close();
  }

  protected Connection replaceConn(String databaseName, Connection conn) throws SQLException
  {
    Connection result = null;

    if (log.isDebugEnabled())
      log.debug("** REPLACE CONNECTION FOR " + databaseName);

    if ( this._isUsingInternalPooling )
      result = replacePoolConn( databaseName, conn );
    else
      result = replaceDriverConn(databaseName, conn);

    return result;
  }

  protected Connection replaceDriverConn(String databaseName, Connection conn) throws SQLException
  {
    log.debug("** REPLACE DRIVER CONNECTION");

    if (conn != null)
    {
      try
      {
        conn.close();
      }
      catch (Exception e)
      {
        //
      }
    }
    return getDriverConn();
  }

  protected Connection replacePoolConn(String databaseName, Connection conn) throws SQLException
  {
    log.debug("** REPLACE POOL CONNECTION");
    int index = factory.getIndex(databaseName);

    Connection newConnection = null;

    if (conn != null)
    {
      if (allConnections[index].contains(conn))
        allConnections[index].remove(conn);

      try
      {
        conn.close();
      }
      catch (Exception e)
      {
        //
      }
    }

    if (databaseName != null)
    {
      log.debug("** getting new connection from factory...");

      newConnection = factory.getConnection(databaseName);
      log.debug("** got new connection from factory");
    }
    else
      throw new SQLException("Database pool name was null, unable to replace connection");

    return newConnection;
  }

  public void notify(String msg)
  {
/*
    try
    {
      MailMan.sendMail("ConnectionPool@com.jdm.db",factory.getNotifyEmailsCD(),"Connection Pool Error",msg);
    }
    catch(Exception ex)
    {
      log.error("** Caught Exception Emailling", ex);
    }
*/
  }

  /* try to close every connection in every pool
     any given connection might already be closed, dropped etc,
     try to close it anyway
   */
  public static void shutdown()
  {
    for (int i=0; i<allConnections.length; i++)
    {
      Enumeration e = allConnections[i].elements();
      int cnt = 0;
      while(e.hasMoreElements())
      {
        cnt++;
        log.debug("ConnectionPool closing connection "+cnt);
        Connection c = (Connection)e.nextElement();
        try
        {
          c.close();
        }
        catch (Exception ex)
        {
          log.error("error closing connection", ex);
          //ex.printStackTrace(); // we tried our best
        }
      }
    }
  }


  /**
   * A task for removing pool connections periodically
   */
  class PoolShrink extends TimerTask
  {
    public PoolShrink()
    {
    }

    public void run()
    {
      try
      {
        ConnectionPool.getInstance().pruneAllPools();
      }
      catch (Exception e)
      {
        // don't allow any exceptions to kill this thread
        log.error("Pool Shrink got exception, ignoring", e);
      }
    }
  }



}


