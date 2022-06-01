/**
 *  JDMPoolConnectionValidator
 *
 * $Revision: 1.1 $
 * $Log: JDMPoolConnectionValidator.java,v $
 * Revision 1.1  2004/08/23 20:30:26  vz86k2
 * check in
 *
 * Revision 1.2  2003/05/09 12:46:29  zz0qx3
 * added query timeout
 *
 * Revision 1.1  2003/02/25 16:54:06  zz0qx3
 * changes to add connection validation to ot connection pool
 *
 *
*/

package com.delphi.gfad.coreframework.db;

import java.lang.reflect.Method;
import java.sql.*;
import org.apache.commons.logging.*;

/*
** Provides a base implementation of Connection Validator, with no-op methods
*/
public class JDMPoolConnectionValidator extends BaseConnectionValidator
{
  private static Log log = LogFactory.getLog(JDMPoolConnectionValidator.class);

  private static final String TEST_SQL = "select sysdate from dual";
  private static final int TEST_QUERY_TIMEOUT = 10; // seconds

  public JDMPoolConnectionValidator()
  {
  }


  public boolean validateConnection(java.sql.Connection conn)
    throws SQLException
  {
    boolean result = false;

    try
    {
      PreparedStatement ps = conn.prepareStatement(TEST_SQL);
      ps.setQueryTimeout(TEST_QUERY_TIMEOUT);

      log.debug("query timeout: " +  ps.getQueryTimeout());
      ps.execute();
      ps.close();
      log.debug("success, returning true");
      result = true;
    }
    catch (Exception e)
    {
      log.error("got exception testing connection", e);
      result = false;
    }

    return result;
  }

  public void markInvalidConnection(java.sql.Connection conn)
    throws SQLException
  {
    // no-op for pool connections
  }


}

