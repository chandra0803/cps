/*
 *
 * $Id: OTConnection.java,v 1.2 2004/11/19 15:23:25 zz0qx3 Exp $
 * $Revision: 1.2 $
 * $Log: OTConnection.java,v $
 * Revision 1.2  2004/11/19 15:23:25  zz0qx3
 * added 1.4 required methods
 *
 * Revision 1.1  2004/08/23 20:30:25  vz86k2
 * check in
 *
 *
 */

package com.delphi.gfad.coreframework.db;

import java.sql.*;
import java.util.*;

public class OTConnection implements java.sql.Connection
{
  private Connection conn;
  private Hashtable preparedStatements;
  private Hashtable callableStatements;
  private boolean cacheStatements = false;





  public OTConnection(Connection conn)
  {
    this.conn = conn;
    preparedStatements = new Hashtable();
    callableStatements = new Hashtable();
  }

  public void setCacheStatements(boolean value)
  {
    cacheStatements = value;
  }

  public boolean getCacheStatements()
  {
    return cacheStatements;
  }

  public Statement createStatement() throws SQLException
  {
    return conn.createStatement();
  }

  public PreparedStatement prepareStatement(String sql) throws SQLException
  {
    if (cacheStatements)
    {
      PreparedStatement stmt = (PreparedStatement)preparedStatements.get(sql);
      if ( stmt == null )
      {
        stmt = new OTPreparedStatement(conn.prepareStatement(sql),cacheStatements);
        preparedStatements.put(sql,stmt);
      }
      return stmt;
    }
    else
    {
      return conn.prepareStatement(sql);
    }
  }

  public CallableStatement prepareCall(String sql) throws SQLException
  {
    if (cacheStatements)
    {
      CallableStatement stmt = (CallableStatement)callableStatements.get(sql);
      if ( stmt == null )
      {
        stmt = conn.prepareCall(sql);
        callableStatements.put(sql,stmt);
      }
      return stmt;
    }
    else
    {
      return conn.prepareCall(sql);
    }
  }

  public String nativeSQL(String sql) throws SQLException
  {
    return conn.nativeSQL(sql);
  }

  public void setAutoCommit(boolean autoCommit) throws SQLException
  {
    conn.setAutoCommit(autoCommit);
  }

  public boolean getAutoCommit() throws SQLException
  {
    return conn.getAutoCommit();
  }

  public void commit() throws SQLException
  {
    conn.commit();
  }

  public void rollback() throws SQLException
  {
    conn.rollback();
  }

  public void close() throws SQLException
  {
    conn.close();
  }

  public boolean isClosed() throws SQLException
  {
    return conn.isClosed();
  }

  public DatabaseMetaData getMetaData() throws SQLException
  {
    return conn.getMetaData();
  }

  public void setReadOnly(boolean readOnly) throws SQLException
  {
    conn.setReadOnly(readOnly);
  }

  public boolean isReadOnly() throws SQLException
  {
    return conn.isReadOnly();
  }

  public void setCatalog(String catalog) throws SQLException
  {
    conn.setCatalog(catalog);
  }

  public String getCatalog() throws SQLException
  {
    return conn.getCatalog();
  }

  public void setTransactionIsolation(int level) throws SQLException
  {
    conn.setTransactionIsolation(level);
  }

  public int getTransactionIsolation() throws SQLException
  {
    return conn.getTransactionIsolation();
  }

  public SQLWarning getWarnings() throws SQLException
  {
    return conn.getWarnings();
  }

  public void clearWarnings() throws SQLException
  {
    conn.clearWarnings();
  }

  // JDBC 2.0

  public Statement createStatement(int resultSetType, int resultSetConcurrency) throws SQLException
  {
    return conn.createStatement(resultSetType, resultSetConcurrency);
  }

  public PreparedStatement prepareStatement(String sql, int resultSetType, int resultSetConcurrency) throws SQLException
  {
    return conn.prepareStatement(sql, resultSetType, resultSetConcurrency);
  }

  public CallableStatement prepareCall(String sql, int resultSetType, int resultSetConcurrency) throws SQLException
  {
    return conn.prepareCall(sql, resultSetType, resultSetConcurrency);
  }

  public java.util.Map getTypeMap() throws SQLException
  {
    return conn.getTypeMap();
  }

  public void setTypeMap(java.util.Map map) throws SQLException
  {
    conn.setTypeMap(map);
  }


  // java 1.4 extensions
  // java 1.4 is not yet supported
  public void setHoldability(int holdability)
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }

  public int getHoldability()
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }


  public Savepoint setSavepoint()
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }

  public Savepoint setSavepoint(String name)
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }

  public void rollback(Savepoint savepoint)
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }
  public void releaseSavepoint(Savepoint savepoint)
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }

  public Statement createStatement(int resultSetType,
  int resultSetConcurrency,
  int resultSetHoldability)
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }
  public PreparedStatement prepareStatement(String sql,
  int resultSetType,
  int resultSetConcurrency,
  int resultSetHoldability)
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }

  public CallableStatement prepareCall(String sql,
  int resultSetType,
  int resultSetConcurrency,
  int resultSetHoldability)
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }

  public PreparedStatement prepareStatement(String sql,
  int autoGeneratedKeys)
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }

  public PreparedStatement prepareStatement(String sql,
  int[] columnIndexes)
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }

  public PreparedStatement prepareStatement(String sql,
  String[] columnNames)
  throws SQLException
  {
  throw new SQLException("Not Implemented");
  }
  //


}

