/**
 * MDSOServletFilter
 *
 * $Revision: 1.1 $
 * $Log: ADServletFilter.java,v $
 * Revision 1.1  2004/08/18 15:51:15  vz86k2
 * check in
 *
 *
 *
 *
 */

package com.delphi.gfad.coreframework.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.Enumeration;
import java.util.ArrayList;

import org.apache.commons.logging.*;

public class ADServletFilter implements javax.servlet.Filter
{
  private static Log log = LogFactory.getLog(ADServletFilter.class);
  private FilterConfig filterConfig = null;
  private boolean debug = false;
  private boolean initialized = false;
  private boolean enableADAuth = false;
  private String redirectUrl = "login"; 

  public ADServletFilter()
  {
  }

  public FilterConfig getFilterConfig()
  {
    return filterConfig;
  }

  public void setFilterConfig(FilterConfig _filterConfig)
  {
    filterConfig = _filterConfig;
  }

  public void init(FilterConfig filterConfig) throws ServletException
  {
    if (log.isInfoEnabled()) 
    {
      log.info("*** Initialize AD Servlet Filter: "+filterConfig.getFilterName());
      log.info("*** Debug: "+filterConfig.getInitParameter("Debug"));
      log.info("*** Enable AD Authentication: "+filterConfig.getInitParameter("EnableADAuth"));
      log.info("*** RedirectUrl: "+filterConfig.getInitParameter("RedirectUrl"));
    }

    this.filterConfig = filterConfig;

    String redirect = filterConfig.getInitParameter("RedirectUrl");
    if (redirect != null)
      redirectUrl = redirect;

    String initVal = filterConfig.getInitParameter("Debug");
    if ( initVal != null)
    {
      if ( initVal.equals("ON") || initVal.equals("true") )
      {
        debug = true;
      }
    }

    initVal = filterConfig.getInitParameter("EnableADAuth");
    if ( initVal != null)
    {
      if ( initVal.equals("ON") || initVal.equals("true") )
      {
        enableADAuth = true;
      }
    }
  }

  public void destroy() 
  {
    this.filterConfig = null;
  }

  public boolean authenticate(String uid, String pwd)
  {
    return false;
  }

  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException 
  {
    if (!initialized)
    {
      init(filterConfig);
      initialized = true;
    }
     
    long startTime = 0;

    if (filterConfig == null)
      return;

    if (debug)
    {
      if (log.isInfoEnabled()) 
        log.info("****** MDSOFilter Start: URL = "+((HttpServletRequest)request).getRequestURL()+" SESSION = "+((HttpServletRequest)request).getRequestedSessionId());
      startTime = System.currentTimeMillis();
    }

    String uid = request.getParameter("uid");
    String pwd = request.getParameter("pwd");

    boolean authenticated = false;
    boolean failed = false;

    if (enableADAuth)
    {
      HttpSession s = ((HttpServletRequest)request).getSession(true);     

      // step 1: look for already authenticated session.
      if (s.getAttribute("ADAuthUser") != null)
      {
        authenticated = true;
      }  

      // step 2: check for login request.      
      if ((uid != null) && (pwd != null) && (!authenticated))
      {
        if (authenticate(uid,pwd))
        {
          s.setAttribute("ADAuthUser",uid);
          s.setAttribute("ADAuthUserStatus","Passed");
          authenticated = true; 
        }
        else
        {
          s.setAttribute("ADAuthUserStatus","Failed");
        }
      }
    }
    else // guest mode
    {
      HttpSession s = ((HttpServletRequest)request).getSession(true);     

      // step 1: look for already authenticated session.
      if (s.getAttribute("ADAuthUser") != null)
      {
        authenticated = true;
      }  

      // step 2: check for login request.      
      if ((uid != null) && (pwd != null) && (!authenticated))
      {
        s.setAttribute("ADAuthUser","Guest");
        s.setAttribute("ADAuthUserStatus","Passed");
        authenticated = true; 
      }
    }

    if (authenticated)
    {
      chain.doFilter(request, response);
    }
    else
    {
      RequestDispatcher rd = filterConfig.getServletContext().getRequestDispatcher(redirectUrl);
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

    if (debug)
    {
      double delta = (System.currentTimeMillis() - startTime) / 1000.0; 
      if (log.isInfoEnabled()) 
        log.info("****** MDSOFilter End: Seconds: "+delta+" SESSION = "+((HttpServletRequest)request).getRequestedSessionId());
    }
  }
}
