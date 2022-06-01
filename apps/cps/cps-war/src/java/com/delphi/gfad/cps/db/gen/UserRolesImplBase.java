
/**
 *
 * Class: UserRolesImplBase
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
The UserRoles business object encapsulates access to the set of Users Roles in CPS.  
  
This class is the implementation base object, and should be extended (if necessary)
using the subclass UserRoles.
*/
public class UserRolesImplBase
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(UserRolesImplBase.class);
  public static int BUFFER_LENGTH = 4096;

  private Long roleId;
  private String role;
 
  private boolean selectedForUpdate;

  public UserRolesImplBase()
  {
    setSelectedForUpdate(false);
  }
  public void setRoleId( Long roleId )

  {
    this.roleId = roleId;

  }

  public Long getRoleId()
  {
    return roleId;
  }
  public void setRole( String role )

  {
    this.role = role;

  }

  public String getRole()
  {
    return role;
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
      sb.append("Long roleId = ");
    sb.append(getRoleId()) ;
    sb.append("\n");
    sb.append("String role = ");
    sb.append(getRole()) ;
    sb.append("\n");
 
    sb.append("selectedForUpdate = ");
    sb.append(selectedForUpdate) ;
    sb.append("\n");
    return sb.toString();
  }

  public org.w3c.dom.Element getElement(org.w3c.dom.Document doc) 
    throws SQLException
  {
    org.w3c.dom.Element node = (org.w3c.dom.Element)doc.createElement("UserRoles");
    String temp = null;

    if (getRoleId() != null)
    {
      temp = ""+getRoleId();
      node.setAttribute("roleId", temp);
      //Logger.debug(CNAME, "roleId = " + temp);
    }
    if (getRole() != null)
    {
      temp = ""+getRole();
      node.setAttribute("role", temp);
      //Logger.debug(CNAME, "role = " + temp);
    }
   

    return node;
  }




}
