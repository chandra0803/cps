/**
 *
 * RequestMapping
 *
 * Holds the data for mapping of url to handlers and roles as read from the request mappings
 * file by the RequestMappingFactory.
 *
 * $Revision: 1.1 $
 * $Log: RequestMapping.java,v $
 * Revision 1.1  2004/08/18 15:52:09  vz86k2
 * check in
 *
 *
 */
package com.delphi.gfad.coreframework.control;

import java.util.*;

public class RequestMapping implements java.io.Serializable 
{
  private String url;
  private String handlerClass;
  private String dispatchUrl;
  private ArrayList xsltStyleSheets; // array list of Strings
  private ArrayList roleMappings; // array list of Strings
  private boolean fopPostProcess = false;
  private boolean authorizedDefault = false;
  private boolean unauthorizedDefault = false;
  private boolean errorDefault = false;
  private String domSourceUrl;
  private String contentType;

  public RequestMapping (String url,
                         String handlerClass,
                         String dispatchUrl,
                         ArrayList xsltStyleSheets,
                         ArrayList roleMappings,
                         boolean fopPostProcess,
                         boolean authorizedDefault,
                         boolean unauthorizedDefault,
                         boolean errorDefault,
                         String domSourceUrl,
                         String contentType)
  {
    this.url = url;
    this.handlerClass = handlerClass;
    this.dispatchUrl = dispatchUrl;
    this.xsltStyleSheets = xsltStyleSheets;
    this.roleMappings = roleMappings;
    this.fopPostProcess = fopPostProcess;
    this.authorizedDefault = authorizedDefault;
    this.unauthorizedDefault = unauthorizedDefault;
    this.errorDefault = errorDefault;
    this.domSourceUrl = domSourceUrl;
    this.contentType = contentType;
  }

  public String getUrl()
  {
    return url;
  }

  public String getHandlerClass()
  {
    return handlerClass;
  }

  public String getDispatchUrl()
  {
    return dispatchUrl;
  }

  public String[] getXsltStyleSheets()
  {
    return (String[])xsltStyleSheets.toArray(new String[0]);
  }

  public String[] getRoleMappings()
  {
    return (String[])roleMappings.toArray(new String[0]);
  }

  public boolean isFopPostProcess()
  {
    return fopPostProcess;
  }

  public boolean isAuthorizedDefault()
  {
    return authorizedDefault;
  }

  public boolean isUnauthorizedDefault()
  {
    return unauthorizedDefault;
  }

  public boolean isErrorDefault()
  {
    return errorDefault;
  }

  public String getDomSourceUrl()
  {
    return domSourceUrl;
  }

  public String getContentType()
  {
    return contentType;
  }

  public boolean isAuthorized(String role)
  {
    if (role == null) return false;

    if (roleMappings.contains("ANY") || roleMappings.contains("Any") || roleMappings.contains(role.toUpperCase()))
    {
      return true;
    }

    return false;
  }

  public String toString()
  {
    return "RequestMapping: {url=" + url + ", " +
           " handlerClass=" + handlerClass + ", " +
           " dispatchUrl=" + dispatchUrl + ", " +
           " xsltStyleSheets=" + xsltStyleSheets + ", " +
           " roleMappings=" + roleMappings + ", " +
           " fopPostProcess=" + fopPostProcess + ", " +
           " authorizedDefault=" + authorizedDefault + ", " +
           " unauthorizedDefault=" + unauthorizedDefault + ", " +
           " errorDefault=" + errorDefault + ", " +
           " domSourceUrl=" + domSourceUrl + ", " +
           " contentType=" + contentType + "}";
  }

  public boolean equals(Object o)
  {
    if (!(o instanceof RequestMapping)) return false;

    if (this.url.equals(((RequestMapping)o).getUrl())) return true;

    return false;
  }
}

