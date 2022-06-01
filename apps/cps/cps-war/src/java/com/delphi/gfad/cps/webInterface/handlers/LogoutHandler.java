
package com.delphi.gfad.cps.webInterface.handlers;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletContext;

import org.w3c.dom.Element;
import org.w3c.dom.Document;

import com.delphi.gfad.coreframework.handlers.BaseHandler;
import com.delphi.gfad.coreframework.servlet.MainServlet;
import com.delphi.gfad.coreframework.control.UserProfile;

import org.apache.commons.logging.*;

/**
 * 
 *
*/
public class LogoutHandler extends BaseHandler
{
  private static Log log = LogFactory.getLog(LogoutHandler.class);

  public LogoutHandler()
  {
    super();
  }

  /**
   * processRequest
   *
   */
  public void processRequest(HttpServletRequest request) throws java.lang.Exception
  {
    if (log.isInfoEnabled()) 
    {  
      log.info("LogoutHandler -> remove session.");
    }


    HttpSession session = request.getSession(false);
    if (session != null)
    {
      session.setAttribute(MainServlet.SESSION_USER_PROFILE_KEY,null);
      session.invalidate(); 
    }

    request.setAttribute(MainServlet.REQUEST_TARGET_URL_KEY,"/login");
    

    super.processRequest(request);

  }

  /**
   * processScreen
   *
   */
  public void processScreen(Element screen) throws Exception
  {
  }

  /**
   * processModel
   *
   */
  public void processModel(Element model) throws Exception
  {
  }

  /**
   * processView
   *
   */
  public void processView(Element view) throws Exception
  {
  }

}
