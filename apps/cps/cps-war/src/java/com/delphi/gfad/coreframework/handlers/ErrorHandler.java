
package com.delphi.gfad.coreframework.handlers;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletContext;

import org.w3c.dom.Element;
import org.w3c.dom.Document;

import com.delphi.gfad.coreframework.handlers.BaseHandler;
import com.delphi.gfad.coreframework.servlet.MainServlet;

import org.apache.commons.logging.*;

/**
 * 
 *
*/
public class ErrorHandler extends BaseHandler
{
  private static Log log = LogFactory.getLog(ErrorHandler.class);

  public ErrorHandler()
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
      log.info("ErrorHandler -> processRequest.");
    }

    String error = (String)request.getAttribute(MainServlet.REQUEST_ERROR_MESSAGE_KEY);

    String[] paramKeys = new String[1];
    paramKeys[0] = "errorMessage";

    String[] paramValues = new String[1];
    paramValues[0] = error;

    request.setAttribute(MainServlet.REQUEST_TRANSFORM_PARAM_KEYS_KEY,paramKeys);
    request.setAttribute(MainServlet.REQUEST_TRANSFORM_PARAM_VALUES_KEY,paramValues);

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
