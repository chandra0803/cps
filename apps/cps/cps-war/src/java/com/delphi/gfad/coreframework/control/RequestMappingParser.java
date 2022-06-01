/**
 *
 * RequestMappingParser
 *
 * Parses request mapping file
 *
 * $Revision: 1.2 $
 * $Log: RequestMappingParser.java,v $
 * Revision 1.2  2004/08/18 16:45:52  vz86k2
 * update - fix getting dom source
 *
 * Revision 1.1  2004/08/18 15:52:09  vz86k2
 * check in
 *
 *
 */
package com.delphi.gfad.coreframework.control;

import org.xml.sax.InputSource;
import org.w3c.dom.Element;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;

import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;
import org.xml.sax.SAXException;

// jaxp 1.0.1 imports
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;

import java.io.*;
import java.util.*;

import org.apache.commons.logging.*;

/**
 * This class provides the data bindings for the screendefinitions.xml
 * and the requestmappings.xml file.
 * The data obtained is maintained by the ScreenFlowManager
 */

public class RequestMappingParser
{
  private static Log log = LogFactory.getLog(RequestMappingParser.class);

  // constants
  public static final String URL_MAPPING = "url-mapping";
  public static final String URL = "url";
  public static final String REQUEST_HANDLER_CLASS = "request-handler-class";
  public static final String XSLT_STYLESHEET = "xslt-stylesheet";
  public static final String DISPATCH_TO = "request-dispatch-url";
  public static final String ROLE_MAPPING = "role-mapping";
  public static final String FOP_POST_PROCESS = "fop-post-process";
  public static final String AUTHORIZED_DEFAULT = "authorized-default";
  public static final String UNAUTHORIZED_DEFAULT = "unauthorized-default";
  public static final String ERROR_DEFAULT = "error-default";
  public static final String DOM_SOURCE_URL = "dom-source-url";
  public static final String CONTENT_TYPE = "content-type";

  public static final String DEFAULT_CONTENT_TYPE = "text/html; charset=UTF-8";

  public static final String KEY = "key";
  public static final String VALUE= "value";
  public static final String DIRECT="direct";
  public static final String SCREEN= "screen";
  public static final String SCREEN_NAME = "screen-name";
  public static final String PARAMETER = "parameter";

  private RequestMapping authorizedDefaultRequestMapping = null;
  private RequestMapping unauthorizedDefaultRequestMapping = null;
  private RequestMapping errorDefaultRequestMapping = null;

  public RequestMappingParser()
  { 
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

  public Hashtable loadRequestMappings(InputStream mappingFileStream)
  {
    if (log.isInfoEnabled()) 
      log.info("Loading request mappings...");
    Element root = loadDocument(mappingFileStream);
    return getRequestMappings(root);
  }

  public Element loadDocument(InputStream mappingFileStream)
  {
    Document doc = null;
    try
    {
      InputSource xmlInp = new InputSource(mappingFileStream);

      DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
      DocumentBuilder parser = docBuilderFactory.newDocumentBuilder();
      doc = parser.parse(xmlInp);
      Element root = doc.getDocumentElement();
      //root.normalize();
      return root;
    }
    catch (SAXParseException err)
    {
      if (log.isErrorEnabled()) 
        log.error("Parsing error, line: "+err.getLineNumber()+", uri: "+err.getSystemId()+", message: "+err.getMessage(), err);
    }
    catch (SAXException e)
    {
      if (log.isErrorEnabled()) 
        log.error("Caught SAXException", e);
    }
    catch (java.net.MalformedURLException mfx)
    {
      if (log.isErrorEnabled()) 
        log.error("Caught MalformedURLException", mfx);
    }
    catch (java.io.IOException e)
    {
      if (log.isErrorEnabled()) 
        log.error("Caught IOException", e);
    }
    catch (Exception pce)
    {
      if (log.isErrorEnabled()) 
        log.error("Caught Exception", pce);
    }
    return null;
  }

  private static String getSubTagAttribute(Element root, String tagName, String subTagName, String attribute)
  {
    String returnString = "";
    NodeList list = root.getElementsByTagName(tagName);
    for (int loop = 0; loop < list.getLength(); loop++)
    {
      Node node = list.item(loop);
      if (node != null)
      {
        NodeList  children = node.getChildNodes();
        for (int innerLoop =0; innerLoop < children.getLength(); innerLoop++)
        {
          Node  child = children.item(innerLoop);
          if ((child != null) && (child.getNodeName() != null) && child.getNodeName().equals(subTagName))
          {
            if (child instanceof Element)
            {
              return((Element)child).getAttribute(attribute);
            }
          }
        } // end inner loop
      }
    }
    return returnString;
  }

  public Hashtable getRequestMappings(Element root)
  {
    Hashtable urlMappings = new Hashtable();
    NodeList list = root.getElementsByTagName(URL_MAPPING);

    for (int loop = 0; loop < list.getLength(); loop++)
    {
      Node node = list.item(loop);

      String temp = null;
      String url = "";
      boolean fopPostProcess = false;
      boolean authorizedDefault = false;
      boolean unauthorizedDefault = false;
      boolean errorDefault = false;
      String contentType = DEFAULT_CONTENT_TYPE; 
      String handlerClass = null;
      String dispatchTo = null;
      String domSourceUrl = null;
      ArrayList xlstStyleSheetList = null;
      ArrayList rolesList = null;

      Element element = ((Element)node);
      url = element.getAttribute(URL);
      fopPostProcess = (new Boolean(element.getAttribute(FOP_POST_PROCESS))).booleanValue();
      authorizedDefault = (new Boolean(element.getAttribute(AUTHORIZED_DEFAULT))).booleanValue();
      unauthorizedDefault = (new Boolean(element.getAttribute(UNAUTHORIZED_DEFAULT))).booleanValue();
      errorDefault = (new Boolean(element.getAttribute(ERROR_DEFAULT))).booleanValue();

      temp = element.getAttribute(CONTENT_TYPE);
      if ((temp != null) && (temp.length() > 0))
      {
        contentType = temp; 
      }

      // get all the xslt style sheets
      NodeList children = element.getElementsByTagName(XSLT_STYLESHEET);
      xlstStyleSheetList = new ArrayList(children.getLength());
      for (int i = 0; i < children.getLength(); i++)
      {
        xlstStyleSheetList.add(((Element)children.item(i)).getAttribute("value"));
      }

      // get all the roles
      children = element.getElementsByTagName(ROLE_MAPPING);
      rolesList = new ArrayList(children.getLength());
      for (int i = 0; i < children.getLength(); i++)
      {
        rolesList.add(((Element)children.item(i)).getAttribute("value"));
      }

      // get dom source
      children = element.getElementsByTagName(DOM_SOURCE_URL);
      if (children.getLength() > 0)
        domSourceUrl = ((Element)children.item(0)).getAttribute("value");

      handlerClass = getSubTagValue(node, REQUEST_HANDLER_CLASS);
      dispatchTo = getSubTagValue(node, DISPATCH_TO);

      RequestMapping mapping = new RequestMapping(url, handlerClass, dispatchTo, xlstStyleSheetList, rolesList, fopPostProcess, authorizedDefault, unauthorizedDefault, errorDefault, domSourceUrl, contentType);

      if ((authorizedDefaultRequestMapping == null) && (authorizedDefault))
        authorizedDefaultRequestMapping = mapping;

      if ((unauthorizedDefaultRequestMapping == null) && (unauthorizedDefault))
        unauthorizedDefaultRequestMapping = mapping;

      if ((errorDefaultRequestMapping == null) && (errorDefault))
        errorDefaultRequestMapping = mapping;

      if (!urlMappings.containsKey(url))
      {
        urlMappings.put(url, mapping);
      }
      else
      {
        if (log.isErrorEnabled()) 
          log.error("*** Non Fatal errror, url: "+url+" is defined more than once in request mappings file.");
      }
    }

    if (authorizedDefaultRequestMapping == null)
    {
      if (log.isErrorEnabled()) 
        log.error("*** Non Fatal error, authorized default request mapping is undefined.");
    }
    if (unauthorizedDefaultRequestMapping == null)
    {
      if (log.isErrorEnabled()) 
        log.error("*** Non Fatal error, unauthorized default request mapping is undefined.");
    }
    if (errorDefaultRequestMapping == null)
    {
      if (log.isErrorEnabled()) 
        log.error("*** Non Fatal error, error default request mapping is undefined.");
    }

    return urlMappings;
  }

  public static String getSubTagValue(Node node, String subTagName)
  {
    String returnString = null;
    if (node != null)
    {
      NodeList  children = node.getChildNodes();
      for (int innerLoop =0; innerLoop < children.getLength(); innerLoop++)
      {
        Node  child = children.item(innerLoop);
        if ((child != null) && (child.getNodeName() != null) && child.getNodeName().equals(subTagName))
        {
          Node grandChild = child.getFirstChild();
          if (grandChild.getNodeValue() != null) return grandChild.getNodeValue();
        }
      } // end inner loop
    }
    return returnString;
  }

  public static String getSubTagValue(Element root, String tagName, String subTagName)
  {
    String returnString = "";
    NodeList list = root.getElementsByTagName(tagName);
    for (int loop = 0; loop < list.getLength(); loop++)
    {
      Node node = list.item(loop);
      if (node != null)
      {
        NodeList  children = node.getChildNodes();
        for (int innerLoop =0; innerLoop < children.getLength(); innerLoop++)
        {
          Node  child = children.item(innerLoop);
          if ((child != null) && (child.getNodeName() != null) && child.getNodeName().equals(subTagName))
          {
            Node grandChild = child.getFirstChild();
            if (grandChild.getNodeValue() != null) return grandChild.getNodeValue();
          }
        } // end inner loop
      }
    }
    return returnString;
  }

  public static String getTagValue(Element root, String tagName)
  {
    String returnString = "";
    NodeList list = root.getElementsByTagName(tagName);
    for (int loop = 0; loop < list.getLength(); loop++)
    {
      Node node = list.item(loop);
      if (node != null)
      {
        Node child = node.getFirstChild();
        if ((child != null) && child.getNodeValue() != null) return child.getNodeValue();
      }
    }
    return returnString;
  }
}

