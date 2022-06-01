/**
 *  ConnectionValidatorBase
 *
 * $Revision: 1.1 $
 * $Log: WebLogicPoolConnectionValidator.java,v $
 * Revision 1.1  2004/08/23 20:30:24  vz86k2
 * check in
 *
 * Revision 1.3  2003/02/25 16:54:07  zz0qx3
 * changes to add connection validation to ot connection pool
 *
 * Revision 1.2  2003/02/24 21:19:27  zz0qx3
 * tweaks
 *
 * Revision 1.1  2003/02/24 20:58:51  zz0qx3
 * added connection validation class
 *
*/

package com.delphi.gfad.coreframework.db;

import java.lang.reflect.Method;
import java.sql.*;
import org.apache.commons.logging.*;

/*
** Provides a weblogic conneciton pool Connection Validator
*/
public class WebLogicPoolConnectionValidator extends BaseConnectionValidator
{
  private static Log log = LogFactory.getLog(WebLogicPoolConnectionValidator.class);

  private static final String WL_CLASS_NAME = "weblogic.jdbc.pool.Connection";
  private static final String TEST_SQL      =   "select sysdate from dual";

  private static final int DRIVER_FAILED_SLEEP_MILLIS = 15000;

  public WebLogicPoolConnectionValidator()
  {
  }

  public boolean validateConnection(java.sql.Connection conn)
    throws SQLException
  {
    boolean result = false;

    try
    {
      PreparedStatement ps = conn.prepareStatement(TEST_SQL);
      ps.execute();
      ps.close();
      log.debug("success, returning true");
      result = true;
    }
    catch (Exception e)
    {
      log.error("got exception testing connection, refreshing", e);
      result = false;
    }

    return result;
  }


  public void markInvalidConnection(java.sql.Connection conn)
    throws SQLException
  {
    try
    {
      if (conn.getClass().getName().equals(WL_CLASS_NAME))
      {
        Class wlConnClass = Class.forName(WL_CLASS_NAME);
        Method refresh = wlConnClass.getMethod("refresh", new Class[0]);
        log.error("refreshing WL connection");
        refresh.invoke(conn, new Object[0]);
      }
      else
      {
        log.error("Connection is not " +
                       "instance of expected class (expected " + 
                       WL_CLASS_NAME +
                       " got " + 
                       conn.getClass().getName() + 
                       ")");
      }
    }
    catch (Exception e)
    {
      throw new SQLException("Exception " + 
                             e.toString() + 
                             " occurred while refreshing invalid WebLogic connection\n");
    }
  }
}

