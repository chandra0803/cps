
package com.delphi.gfad.cps.webInterface.handlers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletContext;

import org.w3c.dom.Element;

import com.delphi.gfad.coreframework.handlers.BaseHandler;
import com.delphi.gfad.coreframework.servlet.MainServlet;
import com.delphi.gfad.coreframework.control.UserProfile;

import org.apache.commons.logging.*;

/**
 * 
 *
*/
public class HomeHandler extends BaseHandler
{
  private static Log log = LogFactory.getLog(HomeHandler.class);

  public HomeHandler()
  {
    super();
  }

  /**
   * processScreen
   *
   */
  public void processScreen(Element screen) throws Exception
  {
    if (log.isInfoEnabled()) 
    {  
      log.info("HomeHandler -> ");
    }
  }
}
