
/**
 *
 * Class: UserRolesFactory
 *
 * This is a generated extension Class for modification.
 **/

package com.delphi.gfad.cps.db.gen;

import org.apache.commons.logging.*;


/** 
This class provides a subclass for the implementation base factory.  
All factory extentions should be done in this class.    
The UserRoles business object encapsulates access to the set of Users Roles in CPS.  
  
All public methods and objects are static, so no instance object is necessary.
*/

public class UserRolesFactory extends UserRolesFactoryImplBase 
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(UserRolesFactory.class);

  private static UserRolesFactory _instance = new UserRolesFactory();

  /**
  * Protected no-arg Business Object constructor.  Since these factories are stateless, 
  * the factories can be accessed as singletons.
  */
  protected UserRolesFactory()
  {
    super();
  }

  public static UserRolesFactory getInstance()
  {
    return _instance;
  }
}
