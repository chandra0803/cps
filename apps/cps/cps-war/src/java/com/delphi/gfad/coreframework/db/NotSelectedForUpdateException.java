
package com.delphi.gfad.coreframework.db;

public class NotSelectedForUpdateException extends Exception
{
  public NotSelectedForUpdateException()
  {
    super();
  }

  public NotSelectedForUpdateException(String msg)
  {
    super(msg);
  }
}
