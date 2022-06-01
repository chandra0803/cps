
package com.delphi.gfad.coreframework.control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletContext;

/**
 * This class is the default implementation of the RequestHandler
 *
*/
public abstract class RequestHandlerDefaultImpl implements RequestHandler 
{
  protected ServletContext context;
  protected String url;
  protected boolean displayDOM;

  public void setServletContext(ServletContext context) 
  {
    this.context  = context;
  }

  public void setUrl(String url)
  {
    this.url = url;
  }

  /**
   * getUrl
   *
   */
  public String getUrl()
  {
    return url;
  }

  public void setDisplayDOM(boolean dispayDOM)
  {
    this.displayDOM = displayDOM;
  }

  /**
   * getDisplayDOM
   *
   */
  public boolean getDisplayDOM()
  {
    return displayDOM;
  }

  public void doStart(HttpServletRequest request)
  {
  }

  public void doEnd(HttpServletRequest request)
  {
  }

  public abstract void processRequest(HttpServletRequest request) throws java.lang.Exception;
}
