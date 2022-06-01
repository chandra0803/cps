/**
 * RequestMappingFactory
 *
 * Given a url string, returns the proper RequestMapping object
 *
 * $Revision: 1.1 $
 * $Log: RequestMappingFactory.java,v $
 * Revision 1.1  2004/08/18 15:52:09  vz86k2
 * check in
 *
 */
package com.delphi.gfad.coreframework.control;

import java.util.*;
import java.io.*;

import org.apache.commons.logging.*;

/**
 * This file looks at the Request URL and maps the request
 * to the page for the web-templating mechanism.
 */
public class RequestMappingFactory implements java.io.Serializable
{
  private static Log log = LogFactory.getLog(RequestMappingFactory.class);

  private RequestMapping authorizedDefaultRequestMapping = null;
  private RequestMapping unauthorizedDefaultRequestMapping = null;
  private RequestMapping errorDefaultRequestMapping = null;

  private Hashtable urlMappings;

  public RequestMappingFactory(InputStream mappingFileStream)
  {
    init(mappingFileStream);
  }

  public RequestMapping getAuthorizedDefaultRequestMapping()
  {
    return authorizedDefaultRequestMapping;
  }

  public RequestMapping getUnauthorizedDefaultRequestMapping()
  {
    return unauthorizedDefaultRequestMapping;
  }

  public RequestMapping getErrorDefaultRequestMapping()
  {
    return errorDefaultRequestMapping;
  }

  private void init(InputStream mappingFileStream)
  {
    RequestMappingParser parser = new RequestMappingParser();
    urlMappings = parser.loadRequestMappings(mappingFileStream);
    authorizedDefaultRequestMapping = parser.getAuthorizedDefaultRequestMapping();
    unauthorizedDefaultRequestMapping = parser.getUnauthorizedDefaultRequestMapping();
    errorDefaultRequestMapping = parser.getErrorDefaultRequestMapping();
  }

  public Hashtable getAllMappings()
  {
    return urlMappings;
  }

  public RequestMapping getRequestMapping(String urlPattern)
  {
    RequestMapping result = null;

    if (urlMappings != null)
    {
      result = (RequestMapping)urlMappings.get(urlPattern);
    }

    return result;
  }

  /**
   * Test main
   */
  public static void main( String [] pArgs )
  {
    RequestMappingFactory rmf;
    Hashtable mappings = null;

    try
    {
      rmf  = new RequestMappingFactory(new FileInputStream(pArgs[0]));
      mappings = rmf.getAllMappings();

      if (mappings != null)
      {
        Enumeration mappingEnum = mappings.elements();

        while (mappingEnum.hasMoreElements())
        {
          RequestMapping rm = (RequestMapping)mappingEnum.nextElement();
          log.debug("Found mapping: " + rm.toString());
        }
      }
      else
      {
        log.debug("No mappings found!");
      }
    }
    catch ( Exception e )
    {
      e.printStackTrace();
    }
  }
}

