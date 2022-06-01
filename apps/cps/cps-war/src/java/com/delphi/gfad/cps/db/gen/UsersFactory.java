
/**
 *
 * Class: UsersFactory
 *
 * This is a generated extension Class for modification.
 **/

package com.delphi.gfad.cps.db.gen;

import org.apache.commons.logging.*;


/** 
This class provides a subclass for the implementation base factory.  
All factory extentions should be done in this class.    
The Users business object encapsulates access to the set of Users in CPS.  
  
All public methods and objects are static, so no instance object is necessary.
*/

public class UsersFactory extends UsersFactoryImplBase 
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(UsersFactory.class);

  private static UsersFactory _instance = new UsersFactory();

  /**
  * Protected no-arg Business Object constructor.  Since these factories are stateless, 
  * the factories can be accessed as singletons.
  */
  protected UsersFactory()
  {
    super();
  }

  public static UsersFactory getInstance()
  {
    return _instance;
  }
}
