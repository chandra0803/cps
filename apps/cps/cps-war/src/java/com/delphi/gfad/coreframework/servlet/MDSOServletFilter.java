/**
 * MDSOServletFilter
 *
 * $Revision: 1.1 $
 * $Log: MDSOServletFilter.java,v $
 * Revision 1.1  2004/08/18 15:51:14  vz86k2
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

public class MDSOServletFilter implements javax.servlet.Filter
{
  private static Log log = LogFactory.getLog(MDSOServletFilter.class);
  private FilterConfig filterConfig = null;
  private String defaultRemoteUser = "Guest";
  private boolean debug = false;
  private boolean initialized = false;

  public MDSOServletFilter()
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
      log.info("*** Initialize MDSO Servlet Filter: "+filterConfig.getFilterName());
      log.info("*** Debug: "+filterConfig.getInitParameter("Debug"));
      log.info("*** DefaultRemoteUser: "+filterConfig.getInitParameter("DefaultRemoteUser"));
    }

    this.filterConfig = filterConfig;
    String initVal = filterConfig.getInitParameter("Debug");
    if ( initVal != null)
    {
      if ( initVal.equals("ON") || initVal.equals("true") )
      {
        debug = true;
      }
    }

    initVal = filterConfig.getInitParameter("DefaultRemoteUser");
    if ( initVal != null)
    {
      defaultRemoteUser = initVal;
    }
  }

  public void destroy() 
  {
    this.filterConfig = null;
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

    String remoteUser = (String)((HttpServletRequest)request).getSession().getAttribute("REMOTE_USER");
    if (remoteUser == null)
    {
      remoteUser = defaultRemoteUser;
    }

    if (debug)
    {
      if (log.isInfoEnabled()) 
        log.info("****** MDSOFilter Start: REMOTE_USER = "+remoteUser+" URL = "+((HttpServletRequest)request).getRequestURL()+" SESSION = "+((HttpServletRequest)request).getRequestedSessionId());
      startTime = System.currentTimeMillis();
    }
/*
    if (request instanceof weblogic.servlet.internal.ServletRequestImpl)
    {
      ArrayList headers = (ArrayList)((weblogic.servlet.internal.ServletRequestImpl)request).getHeaderNamesArrayList();
      ArrayList headerValues = (ArrayList)((weblogic.servlet.internal.ServletRequestImpl)request).getHeaderValuesArrayList();

      headers.add("REMOTE_USER");
      headerValues.add(remoteUser.getBytes()); 
      ((weblogic.servlet.internal.ServletRequestImpl)request).setHeaderArrayList(headers,headerValues);
    }
*/
    chain.doFilter(request, response);

    if (debug)
    {
      double delta = (System.currentTimeMillis() - startTime) / 1000.0; 
      if (log.isInfoEnabled()) 
        log.info("****** MDSOFilter End: Seconds: "+delta+" SESSION = "+((HttpServletRequest)request).getRequestedSessionId());
    }
  }
}
