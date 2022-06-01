package com.delphi.gfad.coreframework.servlet;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;
import javax.servlet.*;

import org.apache.commons.logging.*;

/**
 * @author Steve Malson
 */
public class RedirectServlet extends HttpServlet
{
  private static Log log = LogFactory.getLog(RedirectServlet.class);
  private static javax.servlet.ServletContext servletContext = null;
  private String redirectUrl = "login"; 

  public void init(ServletConfig config) throws ServletException
  {
    super.init(config);

    servletContext = config.getServletContext();

    String redirect = getInitParameter("RedirectUrl");
    if (redirect != null)
      redirectUrl = redirect;

    if (log.isInfoEnabled()) 
    {
      log.info("** RedirectServlet: redirectUrl = "+redirectUrl);
    }
  }

  public void doPost(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException
  {
    doGet(request, response);
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
  {
    RequestDispatcher rd = servletContext.getRequestDispatcher(redirectUrl);
    if (rd != null)
    {
      rd.forward(request,response);
    }
    else
    {
      if (log.isErrorEnabled()) 
      {
        log.error("** RedirectServlet: Error redirecting to: "+redirectUrl);
      }
    }
  }
}
