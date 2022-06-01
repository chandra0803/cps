
/**
 *
 * Class: SelectFileFactory
 *
 * This is a generated extension Class for modification.
 **/

package com.delphi.gfad.cps.db.gen;

import org.apache.commons.logging.*;


/** 
This class provides a subclass for the implementation base factory.  
All factory extentions should be done in this class.    
The Users business object encapsulates access to the set of CPS File Select.  
  
All public methods and objects are static, so no instance object is necessary.
*/

public class SelectFileFactory extends SelectFileFactoryImplBase 
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(SelectFileFactory.class);

  private static SelectFileFactory _instance = new SelectFileFactory();

  /**
  * Protected no-arg Business Object constructor.  Since these factories are stateless, 
  * the factories can be accessed as singletons.
  */
  protected SelectFileFactory()
  {
    super();
  }

  public static SelectFileFactory getInstance()
  {
    return _instance;
  }
}
