/**
 *
 * UserProfileDefaultImpl
 *
 * Class for a user profile object for accessing roles.
 *
 * $Revision: 1.2 $
 * $Log: UserProfileDefaultImpl.java,v $
 * Revision 1.2  2004/08/23 20:30:47  vz86k2
 * update
 *
 * Revision 1.1  2004/08/18 15:52:08  vz86k2
 * check in
 *
 *
 */
package com.delphi.gfad.coreframework.control;

import java.util.*;

public class UserProfileDefaultImpl implements UserProfile
{
  private String uid;
  private Vector roles;
  private String userName;
  private boolean rolesModified = false;

  public UserProfileDefaultImpl()
  {
    this.uid = "";
    roles = new Vector();
    roles.addElement(new String("Default"));
  }
 
  public UserProfileDefaultImpl(String uid)
  {
    this.uid = uid;
    roles = new Vector();
    roles.addElement(new String("Default"));
  }

  public void setUid(String uid)
  {
    this.uid = uid;
  }

  public String getUid()
  {
    return uid;
  }

  public String[] getRoles() 
  {
    String[] results = new String[roles.size()];
    roles.copyInto(results);
    return results;
  }

  public void addRole(String role)
  {
    roles.addElement(role);
    rolesModified = true;
  }

  public void removeRole(String role)
  {
    roles.remove(role);
    rolesModified = true;
  }

  public boolean isRolesModified()
  {
    return rolesModified;    
  }

  public void resetModified()
  {
    rolesModified = false;
  }

  public String getUserName()
  {
    return userName;
  }

  public String toString()
  {
    StringBuffer sb = new StringBuffer();
    sb.append("<UserProfileDefaultImpl uid=\""+uid+"\" roles=\""); 
    Iterator rolesIter = roles.iterator();
    boolean first = true;
    while (rolesIter.hasNext())
    {
      String role =(String)rolesIter.next();
      if (!first)
        sb.append(",");
      sb.append(role);
      first = false;
    }
    sb.append("\"/>");
    return sb.toString();
  }
}

