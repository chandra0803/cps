/**
 *
 * UserProfile
 *
 * Interface for a user profile object for accessing roles.
 *
 * $Revision: 1.2 $
 * $Log: UserProfile.java,v $
 * Revision 1.2  2004/08/23 20:30:48  vz86k2
 * update
 *
 * Revision 1.1  2004/08/18 15:52:08  vz86k2
 * check in
 *
 *
 */
package com.delphi.gfad.coreframework.control;

import java.util.*;

public interface UserProfile
{
  public void setUid(String uid);
  public String getUid();
  public String[] getRoles();
  public void addRole(String role);
  public void removeRole(String role);
  public String getUserName();
  public boolean isRolesModified();
  public void resetModified();
  public String toString();
}

