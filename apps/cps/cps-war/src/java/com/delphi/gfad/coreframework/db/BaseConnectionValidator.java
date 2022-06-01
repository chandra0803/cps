/**
 *  BaseConnectionValidator
 *
 * $Revision: 1.1 $
 * $Log: BaseConnectionValidator.java,v $
 * Revision 1.1  2004/08/23 20:30:26  vz86k2
 * check in
 *
 * Revision 1.2  2003/02/25 16:54:06  zz0qx3
 * changes to add connection validation to ot connection pool
 *
 * Revision 1.1  2003/02/24 20:58:50  zz0qx3
 * added connection validation class
 *
*/

package com.delphi.gfad.coreframework.db;

import java.lang.reflect.Method;
import java.sql.*;
import org.apache.commons.logging.*;

/*
** Provides a base implementation of Connection Validator, with no-op methods
*/
public class BaseConnectionValidator
{
  private static Log log = LogFactory.getLog(BaseConnectionValidator.class);

  public BaseConnectionValidator()
  {
  }


  public boolean validateConnection(java.sql.Connection conn)
    throws SQLException
  {
    return true;
  }

  public void markInvalidConnection(java.sql.Connection conn)
    throws SQLException
  {
    //
  }
}

