
package com.delphi.gfad.coreframework.control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletContext;

/**
 * This class is the base interface to request handlers on the
 * web tier.
 *
*/
public interface RequestHandler extends java.io.Serializable 
{
  public void setUrl(String url);
  public void setServletContext(ServletContext context);
  public void doStart(HttpServletRequest request);
  public void processRequest(HttpServletRequest request) throws java.lang.Exception;
  public void doEnd(HttpServletRequest request);
  public void setDisplayDOM(boolean displayDOM);
}
