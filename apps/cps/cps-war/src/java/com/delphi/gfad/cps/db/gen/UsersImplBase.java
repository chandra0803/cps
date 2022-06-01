
/**
 *
 * Class: UsersImplBase
 *
 * This is a generated Class. Do not modify directly.
 * Subclasses are provided for extending this class.
 **/

package com.delphi.gfad.cps.db.gen;

import java.io.*;
import java.sql.*;
import oracle.sql.*;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.apache.commons.logging.*;

/** 
The Users business object encapsulates access to the set of Users in CPS.  
  
This class is the implementation base object, and should be extended (if necessary)
using the subclass Users.
*/
public class UsersImplBase
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(UsersImplBase.class);
  public static int BUFFER_LENGTH = 4096;

  private Long userId;
  private String netId;
 
  private boolean selectedForUpdate;

  public UsersImplBase()
  {
    setSelectedForUpdate(false);
  }
  public void setUserId( Long userId )

  {
    this.userId = userId;

  }

  public Long getUserId()
  {
    return userId;
  }
  public void setNetId( String netId )

  {
    this.netId = netId;

  }

  public String getNetId()
  {
    return netId;
  }
 
  protected void setSelectedForUpdate(boolean selectedForUpdate)
  {
    this.selectedForUpdate = selectedForUpdate;
  }
  
  public boolean getSelectedForUpdate()
  {
    return selectedForUpdate;
  }


  public String toString()
  {
    StringBuffer sb = new StringBuffer();
      sb.append("Long userId = ");
    sb.append(getUserId()) ;
    sb.append("\n");
    sb.append("String netId = ");
    sb.append(getNetId()) ;
    sb.append("\n");
 
    sb.append("selectedForUpdate = ");
    sb.append(selectedForUpdate) ;
    sb.append("\n");
    return sb.toString();
  }

  public org.w3c.dom.Element getElement(org.w3c.dom.Document doc) 
    throws SQLException
  {
    org.w3c.dom.Element node = (org.w3c.dom.Element)doc.createElement("Users");
    String temp = null;

    if (getUserId() != null)
    {
      temp = ""+getUserId();
      node.setAttribute("userId", temp);
      //Logger.debug(CNAME, "userId = " + temp);
    }
    if (getNetId() != null)
    {
      temp = ""+getNetId();
      node.setAttribute("netId", temp);
      //Logger.debug(CNAME, "netId = " + temp);
    }
   

    return node;
  }




}
