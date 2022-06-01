/**
 * MainServlet
 *
 * $Revision: 1.5 $
 * $Log: MainServlet.java,v $
 * Revision 1.5  2004/11/24 20:39:38  vz86k2
 * update
 *
 * Revision 1.4  2004/11/24 19:52:24  vz86k2
 * update exception handling
 *
 * Revision 1.3  2004/08/30 19:08:13  vz86k2
 * update
 *
 * Revision 1.2  2004/08/23 20:29:46  vz86k2
 * update
 *
 * Revision 1.1  2004/08/18 15:51:15  vz86k2
 * check in
 *
 *
 */

package com.delphi.gfad.coreframework.servlet;

import java.io.*;
import java.beans.Beans;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;
import org.xml.sax.InputSource;

import org.apache.xalan.xsltc.compiler.XSLTC;
import org.apache.xalan.xsltc.compiler.SourceLoader;
 
import org.apache.commons.logging.*;

//import com.delphi.gfad.coreframework.db.*;
import com.delphi.gfad.coreframework.control.*;
import com.delphi.gfad.coreframework.util.*;

public class MainServlet extends HttpServlet
{
  public static final String PDF_CONTENT = "application/pdf";
  public static final String EXCEL_CONTENT = "application/vnd.ms-excel";
  public static final String XML_CONTENT = "text/xml; charset=UTF-8";
  public static final String HTML_CONTENT = "text/html; charset=UTF-8";
  public static final String SVG_CONTENT = "application/svg";

  private static final int DEFAULT_MAX_POST_SIZE = 4 * 1024 * 1024;  // 4 Meg

  public static final String SESSION_USER_PROFILE_KEY = "UserProfile";
  public static final String SESSION_USER_ROLES_KEY = "UserRoles";
  public static final String SESSION_NAVIGATION_FRAGMENT_KEY = "NavigationFragment";
  public static final String SESSION_TABS_FRAGMENT_KEY = "TabsFragment";
  public static final String SESSION_DOCUMENT_KEY = "Document";
  public static final String REQUEST_ERROR_MESSAGE_KEY = "ErrorMessage";
  public static final String REQUEST_MULTIPART_FILENAMES_KEY = "MultipartRequestFilenames";
  public static final String REQUEST_MULTIPART_FILES_KEY = "MultipartRequestFiles";
  public static final String REQUEST_MULTIPART_ERRORS_KEY = "MultipartRequestErrors";
  public static final String REQUEST_TARGET_URL_KEY = "TargetUrl";
  public static final String REQUEST_CONTENT_TYPE_KEY = "ContentType";
  public static final String REQUEST_DISABLE_PAGE_CACHING_KEY = "DisablePageCaching";
  public static final String REQUEST_EXPIRE_PAGE_KEY = "ExpirePage";
  public static final String REQUEST_DOM_SOURCE_KEY = "DOMSource";
  public static final String REQUEST_TRANSFORM_PARAM_KEYS_KEY = "TransformParamKeys";
  public static final String REQUEST_TRANSFORM_PARAM_VALUES_KEY = "TransformParamValues";
  public static final String REQUEST_TRANSFORM_OUTPUT_PROPERTIES_KEY = "TransformOutputProperties";
  public static final String CONTEXT_CONFIG_USER_PROFILE_IMPL_KEY = "UserProfileImpl";
  public static final String CONTEXT_CONFIG_NAVIGATION_KEY = "Navigation";
  public static final String CONTEXT_CONFIG_TABS_KEY = "Tabs";

  private RequestMappingFactory requestMappingFactory;
  private ServletContext servletContext;

  private static Hashtable transletIndex = new Hashtable();
  private TransformerFactory tFactory = null;

  private static Log log = LogFactory.getLog(MainServlet.class);

  private boolean useTranslets;
  private String requestMappings = "request-mappings.xml";
  private String dependentStyleSheets = "";
  private String defaultHandler = "com.delphi.gfad.coreframework.control.BaseHandler";
  private String fopConfigFile = "";
  private String transletClassDir = "";
  private String handlerPath = "";
  private boolean displayDOM = false;

  public void init(ServletConfig config) throws ServletException
  {

    System.setProperty("javax.xml.transform.TransformerFactory",
                       "org.apache.xalan.xsltc.trax.TransformerFactoryImpl");

    if (log.isInfoEnabled()) 
      log.info("Initializing MainServlet.");

    servletContext = config.getServletContext();

    String initParamVal = config.getInitParameter("RequestMappings");
    if (initParamVal != null)
      requestMappings = initParamVal;

    initParamVal = config.getInitParameter("UseTranslets");
    if (initParamVal != null)
    {
      if (initParamVal.toUpperCase().equals("ON") | initParamVal.toUpperCase().equals("TRUE"))
       useTranslets = true;
    }

    initParamVal = config.getInitParameter("DependentStyleSheets");
    if (initParamVal != null)
    {
      dependentStyleSheets = initParamVal;
    }

    initParamVal = config.getInitParameter("DefaultHandler");
    if (initParamVal != null)
    {
      defaultHandler = initParamVal;
    }

    initParamVal = config.getInitParameter("FOPConfigFile");
    if (initParamVal != null)
    {
      fopConfigFile = initParamVal;
    }

    initParamVal = config.getInitParameter("UserProfileImpl");
    if (initParamVal != null)
    {
      servletContext.setAttribute(this.CONTEXT_CONFIG_USER_PROFILE_IMPL_KEY,initParamVal);
    }
    else
    {
      servletContext.setAttribute(this.CONTEXT_CONFIG_USER_PROFILE_IMPL_KEY,"com.delphi.gfad.coreframework.control.UserProfileDefaultImpl");
    }

    initParamVal = config.getInitParameter("Navigation");
    if (initParamVal != null)
    {
      servletContext.setAttribute(this.CONTEXT_CONFIG_NAVIGATION_KEY,initParamVal);
    }
    else
    {
      servletContext.setAttribute(this.CONTEXT_CONFIG_NAVIGATION_KEY,"navigation.xml");
    }

    initParamVal = config.getInitParameter("Tabs");
    if (initParamVal != null)
    {
      servletContext.setAttribute(this.CONTEXT_CONFIG_TABS_KEY,initParamVal);
    }
    else
    {
      servletContext.setAttribute(this.CONTEXT_CONFIG_TABS_KEY,"allTabs.xml");
    }

    initParamVal = config.getInitParameter("TransletClassDir");
    if (initParamVal != null)
    {
      transletClassDir = initParamVal;
    }

    initParamVal = config.getInitParameter("HandlerPath");
    if (initParamVal != null)
    {
      handlerPath = initParamVal;
    }

    initParamVal = config.getInitParameter("DisplayDOM");
    if (initParamVal != null)
    {
      if (initParamVal.toUpperCase().equals("ON") | initParamVal.toUpperCase().equals("TRUE"))
       displayDOM = true;
    }

    Enumeration params = config.getInitParameterNames();
    while(params.hasMoreElements())
    {
      String paramName = (String)params.nextElement();

      if (paramName.startsWith("Screen"))
      {
        String paramValue = config.getInitParameter(paramName);
        servletContext.setAttribute(paramName,paramValue);      
//        if (log.isInfoEnabled()) 
//          log.info("Setting ServletContext Attribute: "+paramName+", value: "+paramValue);
      }
    } 
    
    if (log.isInfoEnabled()) 
    {
      log.info("Real Path: "+servletContext.getRealPath("/"));
      log.info("Request Mappings file: "+requestMappings);
      log.info("Use Translets: "+useTranslets);
      log.info("Dependent Style Sheets: "+dependentStyleSheets);
      log.info("Default Handler: "+defaultHandler);
      log.info("FOP Config File: "+fopConfigFile);
      log.info("UserProfile Impl: "+servletContext.getAttribute(this.CONTEXT_CONFIG_USER_PROFILE_IMPL_KEY));
      log.info("Navigation: "+servletContext.getAttribute(this.CONTEXT_CONFIG_NAVIGATION_KEY));
      log.info("Translet Class Directory: "+transletClassDir);
    } 

    InputStream reqMapStream = servletContext.getResourceAsStream(requestMappings);
    if (reqMapStream == null)
    {
      try
      {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        reqMapStream = classLoader.getResourceAsStream(requestMappings);
      }
      catch(java.util.MissingResourceException ex)
      {
        if (log.isErrorEnabled()) 
          log.error("Error loading request mappings file...");
        throw new ServletException("Error loading request mappings file: "+requestMappings);
      }
    }

    requestMappingFactory = new RequestMappingFactory(reqMapStream);
    Enumeration mapEnum = requestMappingFactory.getAllMappings().elements();
    int cnt = 0;
    while (mapEnum.hasMoreElements())
    {
      RequestMapping rm = (RequestMapping) mapEnum.nextElement();
      if (log.isInfoEnabled()) 
        log.info("Request Mapping["+cnt+"]:\n"+rm);
      cnt++;
    }

    tFactory = TransformerFactory.newInstance();

    if (useTranslets)
    {
      tFactory.setURIResolver(new ServletResourceResolver());

      StringTokenizer st = new StringTokenizer(dependentStyleSheets,",");
      while(st.hasMoreTokens())
      {
        compileTranslet(st.nextToken());
      }

      // loop through the stylesheets and compile them
      mapEnum = requestMappingFactory.getAllMappings().elements();

      while (mapEnum.hasMoreElements())
      {
        RequestMapping rm = (RequestMapping) mapEnum.nextElement();
        String[] stylesheets = rm.getXsltStyleSheets();
        for(int i=0; i<stylesheets.length; i++)
        {
          compileTranslet(stylesheets[i]);
        }
      }
    }  
    if (log.isInfoEnabled()) 
      log.info("Completed MainServlet Initialization.");
  }

  private String getClassName(String stylesheet)
  {
    return stylesheet.replace('/','_').substring(0,stylesheet.length()-4);
  }

  private synchronized void compileTranslet(String stylesheet)
  {
    if (stylesheet != null)
    {
      try
      {
        InputStream xslInputStream = servletContext.getResourceAsStream("xsl/"+stylesheet);
        if (xslInputStream == null)
        {
          try
          {
            ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
            xslInputStream = classLoader.getResourceAsStream("xsl/"+stylesheet);
          }
          catch(java.util.MissingResourceException ex)
          {
          }
        }  

        if (xslInputStream == null)
        {
          if (log.isErrorEnabled()) 
            log.error("*** Non Fatal error loading xsl resource: "+stylesheet);
        }
        else
        {
          long startTime = System.currentTimeMillis();

          tFactory.setAttribute("translet-name", stylesheet);
          //tFactory.setAttribute("enable-inlining", Boolean.FALSE);
          //tFactory.setAttribute("generate-translet", Boolean.TRUE);
          //tFactory.setAttribute("auto-translet", Boolean.TRUE);
          //tFactory.setAttribute("package-name", "compiledStylesheetsGenerated");
          //tFactory.setAttribute("destination-directory", "c:\\projects\\gbscommon\\gfad\\apps\\atm\\atm-war\\WEB-INF\\classes");

          Templates translet = tFactory.newTemplates(new StreamSource(xslInputStream));
          transletIndex.put(stylesheet,translet);

          if (log.isInfoEnabled()) 
            log.info("Compiled translet for "+stylesheet+" in: "+(System.currentTimeMillis()-startTime)+" milliseconds.");
        }
        xslInputStream.close();
      }
      catch (Exception e)
      {
        if (log.isErrorEnabled()) 
          log.error("Failed Compiling Translet: "+stylesheet,e);
      }
    }
  }

  public void doPost(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException
  {
    doGet(request, response);
  }

  public HttpServletRequest handleMultipartRequest(HttpServletRequest request) throws ServletException, Exception
  {
    MultipartRequestWrapper wrappedRequest;

    if (log.isDebugEnabled()) 
      log.debug("Detected MULTIPART/FORM-DATA request.");

    int length = request.getContentLength();
    if(length > DEFAULT_MAX_POST_SIZE)
    {
      throw new ServletException("Posted content length of "+length+" exceeds limit of "+DEFAULT_MAX_POST_SIZE);
    }

    wrappedRequest = new MultipartRequestWrapper(request,DEFAULT_MAX_POST_SIZE);
    if(!wrappedRequest.isParseOk())
    {
      String[] errors = wrappedRequest.getParseErrors();
      if (log.isDebugEnabled()) 
      {  
        for(int i = 0; i < errors.length; i++)
        {
          log.debug("MULTIPART/FORM-DATA Parse Error #"+i+" :"+errors[i]);
        }
      }  
    request.setAttribute(this.REQUEST_MULTIPART_ERRORS_KEY,errors);
// TODO       throw new ServletException("Error parsing multipart form data.");
    }
    if (log.isDebugEnabled()) 
    {  
      log.debug("Assigning request to MultipartRequestWrapper.");
    }
    request.setAttribute(this.REQUEST_MULTIPART_FILENAMES_KEY,wrappedRequest.getRequestFileNames());
    request.setAttribute(this.REQUEST_MULTIPART_FILES_KEY,wrappedRequest.getRequestFiles());
    return wrappedRequest.getHttpServletRequest();
  }

  public RequestMapping getRequestMapping(HttpSession currentHttpSession, UserProfile userProfile, HttpServletRequest request)
  {
    if ((currentHttpSession == null) || (userProfile == null))
    {
      return requestMappingFactory.getUnauthorizedDefaultRequestMapping();
    }

    String targetUrl = (String)request.getAttribute(this.REQUEST_TARGET_URL_KEY);

    if (log.isInfoEnabled()) 
    {  
      log.info("Target Url: "+targetUrl);
    }

    RequestMapping mapping = requestMappingFactory.getRequestMapping(targetUrl);
    if (mapping == null)
    {
      mapping = requestMappingFactory.getAuthorizedDefaultRequestMapping();
    }

    String[] roles = userProfile.getRoles();
	log.info("~~~~ROLES: "+roles.toString()); //Sundar

    boolean allowed = false;

    for(int i=0; i<roles.length; i++)
    {
      if (mapping.isAuthorized(roles[i].toUpperCase()))
      {
        allowed = true;
		log.info("~~~~ALLOWED: "+allowed); //Sundar
        break;
      }
    }

    if (!allowed)
    {
      if (log.isInfoEnabled()) 
      {  
        log.info("Failed granting access to user: "+userProfile+" for access to: "+mapping);
      }
      request.setAttribute(this.REQUEST_ERROR_MESSAGE_KEY,"Denied user access to protected application resource.");
      return requestMappingFactory.getErrorDefaultRequestMapping();
    }
    else
    {
      return mapping;
    }
  }

  private void handleRequest(RequestMapping requestMapping, HttpServletRequest request) throws Exception
  {
    String contentType = null;
    String handlerClass = requestMapping.getHandlerClass();

    if (handlerClass == null) 
      handlerClass = defaultHandler;

    if (log.isInfoEnabled()) 
    {  
      log.info("Handle Request "+requestMapping.getUrl()+", handler: "+handlerClass);
    }

    RequestHandler handler = (RequestHandler)Class.forName(handlerClass).newInstance();
    handler.setServletContext(servletContext);
    handler.setUrl(requestMapping.getUrl());
    handler.setDisplayDOM(displayDOM);
    handler.processRequest(request);
  }

  public String parseUrl(String uri, String handlerPath)
  {
    StringBuffer sb = new StringBuffer();
    boolean ignore = true; 
    StringTokenizer st = new StringTokenizer(uri,"/");
    while(st.hasMoreTokens())
    {
      String val = st.nextToken();
      if (!ignore)
      {
        sb.append("/").append(val);
      }
      else if (val.equals(handlerPath))
      {
        ignore = false;
      }
    }
    return sb.toString();
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
  {
    try
    {
      processDoGet(request,response);
    }
    catch(Exception ex)
    {
      if (log.isErrorEnabled()) 
        log.error("Handling Error and returning unformatted error");

      String errorMessage = (String)request.getAttribute(this.REQUEST_ERROR_MESSAGE_KEY); 

      StringBuffer sb = new StringBuffer();
      sb.append("<HTML><HEAD><TITLE>Exception</TITLE></HEAD><BODY>An Exception occured in the application.  Please contact application support.</BODY></HTML>");
      sb.append("<!--");
      sb.append("Error Message: ").append(errorMessage);
      sb.append("Exception: ").append(ex);
      sb.append("--!>");

      byte[] content = sb.toString().getBytes();

      response.setContentLength(content.length);
      response.getOutputStream().write(content);
      response.getOutputStream().flush();
    } 
  }

  public void processDoGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, Exception
  {
    UserProfile userProfile = null;
    RequestMapping requestMapping = null;

    if (log.isInfoEnabled()) 
      log.info("\n-------------- doGet --------------------------------\n");

    String handlerTargetUrl = parseUrl(request.getRequestURI(),handlerPath);    
    request.setAttribute(this.REQUEST_TARGET_URL_KEY,handlerTargetUrl);

    if (request.getContentType() != null)
    {
      if (request.getContentType().toLowerCase().startsWith("multipart/form-data"))
      {
        try
        {
          request = handleMultipartRequest(request);
        }
        catch(Exception ex)
        { 
          if (log.isErrorEnabled())           
            log.error("Caught Exception on multi-part: "+ex);
          request.setAttribute(this.REQUEST_ERROR_MESSAGE_KEY,"Error handling multipart/form-data request: "+ex.toString());
          request.setAttribute(this.REQUEST_TARGET_URL_KEY,requestMappingFactory.getErrorDefaultRequestMapping().getUrl());
        }
      }
    }
   
    while(true)
    {
      HttpSession currentHttpSession = request.getSession(false);
      if (currentHttpSession != null)
      {
        userProfile = (UserProfile)currentHttpSession.getAttribute(this.SESSION_USER_PROFILE_KEY);
      }
      String previousHandlerTargetUrl = (String)request.getAttribute(this.REQUEST_TARGET_URL_KEY);
      requestMapping = getRequestMapping(currentHttpSession, userProfile, request);     
      request.setAttribute(this.REQUEST_CONTENT_TYPE_KEY,requestMapping.getContentType());

      try
      {  
        handleRequest(requestMapping,request);
      }
      catch(Exception exx)
      {
        if (log.isErrorEnabled()) 
          log.error("Caught Exception handling request: "+exx);
        request.setAttribute(this.REQUEST_ERROR_MESSAGE_KEY,"Error handling request: "+exx.toString());
        request.setAttribute(this.REQUEST_TARGET_URL_KEY,requestMappingFactory.getErrorDefaultRequestMapping().getUrl());
      }

      String nextHandlerTargetUrl = (String)request.getAttribute(this.REQUEST_TARGET_URL_KEY);

      if (nextHandlerTargetUrl.equals(previousHandlerTargetUrl))
        break;
    }

    String contentType = (String)request.getAttribute(this.REQUEST_CONTENT_TYPE_KEY);
    if (contentType == null)
      contentType = requestMapping.getContentType();

    response.setContentType(contentType);

    String param = (String)request.getAttribute(this.REQUEST_DISABLE_PAGE_CACHING_KEY);
    if (param != null)
    {
      if (param.toUpperCase().equals("TRUE") || param.toUpperCase().equals("ON"))
      {  
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
      }
    }
    param = (String)request.getAttribute(this.REQUEST_EXPIRE_PAGE_KEY);
    if (param != null)
    {
      response.setHeader("Expires", param);
    }

    String dispatchUrl = requestMapping.getDispatchUrl();

    if (dispatchUrl != null)
    {
      if (log.isInfoEnabled()) 
      {  
        log.info("Dispatching to Url: "+dispatchUrl);
      } 
      RequestDispatcher rd = servletContext.getRequestDispatcher(dispatchUrl);
      rd.forward(request,response);
      return;
    }
    else
    {
      Source transformSource = null; 

      String domSourceUrl = requestMapping.getDomSourceUrl();
      if (domSourceUrl != null)
      {
        if (log.isInfoEnabled()) 
        {  
          log.info("Loading Transform Source: "+domSourceUrl);
        } 
        InputStream xmlInputStream = servletContext.getResourceAsStream(domSourceUrl);
        if (xmlInputStream == null)
        {
          try
          {
            ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
            xmlInputStream = classLoader.getResourceAsStream(domSourceUrl);
          }
          catch(java.util.MissingResourceException ex)
          {
            if (log.isInfoEnabled()) 
              log.info("Failed loading source: "+domSourceUrl+", "+ex);
          }
        }  
        transformSource = (Source)new StreamSource(xmlInputStream);
      }
      else
      {
        if (log.isInfoEnabled()) 
        {  
          log.info("Using Request DOM as Transform Source.");
        } 
        transformSource = (Source)request.getAttribute(this.REQUEST_DOM_SOURCE_KEY);
      }

      ByteArrayOutputStream buffer = null;

      if (useTranslets)
      {
        if (log.isInfoEnabled()) 
          log.info("Transforming using translet.");

        try
        {
          String[] stylesheets = requestMapping.getXsltStyleSheets();
          for(int i=0; i<stylesheets.length; i++)
          {
            long start = System.currentTimeMillis();
            buffer = new ByteArrayOutputStream(8096);

            if (log.isInfoEnabled()) 
            {
              log.info("Transforming using translet for stylesheet: "+stylesheets[i]);
            } 

            Templates translet = (Templates)transletIndex.get(stylesheets[i]);

            if (translet != null)
            {
              Transformer t = translet.newTransformer();
              t.setOutputProperty("indent" , "no");

              String[] paramKeys = (String[])request.getAttribute(this.REQUEST_TRANSFORM_PARAM_KEYS_KEY);
              if (paramKeys != null) 
              {
                String[] paramValues = (String[])request.getAttribute(this.REQUEST_TRANSFORM_PARAM_VALUES_KEY);
                for(int j=0; j<paramKeys.length; j++)
                {
                  t.setParameter(paramKeys[j],paramValues[j]);
                }
              }
              java.util.Properties outputProperties = (java.util.Properties)request.getAttribute(this.REQUEST_TRANSFORM_OUTPUT_PROPERTIES_KEY);
              if (outputProperties != null)
                t.setOutputProperties(outputProperties);

              t.transform(transformSource, new StreamResult(buffer));
              buffer.flush();
            }
            else
            {
              log.info("Error translet not found for stylesheet: "+stylesheets[i]);
            }
  
            long done = System.currentTimeMillis() - start;
            if (log.isInfoEnabled()) 
              log.info("Executed Translet: "+getClassName(stylesheets[i])+" in "+done+"milliseconds.");

            ByteArrayInputStream inputBuffer = new ByteArrayInputStream(buffer.toByteArray());
            transformSource = new StreamSource(inputBuffer);
          }
        }
        catch(Exception ex)
        {
          if (log.isErrorEnabled()) 
            log.error("Failed transforming using translet: ",ex);
          request.setAttribute(this.REQUEST_ERROR_MESSAGE_KEY,"Error transforming using tranlet: "+ex.toString());
          throw ex;
        }
      }
      else
      {
        try
        {
          String[] stylesheets = requestMapping.getXsltStyleSheets();
          for(int i=0; i<stylesheets.length; i++)
          {
            long start = System.currentTimeMillis();
            buffer = new ByteArrayOutputStream(8096);
            InputStream xslInputStream = servletContext.getResourceAsStream("xsl/"+stylesheets[i]);
            if (xslInputStream == null)
            {
              ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
              xslInputStream = classLoader.getResourceAsStream("xsl/"+stylesheets[i]);
            }  

            Transformer t = tFactory.newTransformer(new StreamSource(xslInputStream));

            String[] paramKeys = (String[])request.getAttribute(this.REQUEST_TRANSFORM_PARAM_KEYS_KEY);
            if (paramKeys != null) 
            {
              String[] paramValues = (String[])request.getAttribute(this.REQUEST_TRANSFORM_PARAM_VALUES_KEY);
              for(int j=0; j<paramKeys.length; j++)
              {
                t.setParameter(paramKeys[j],paramValues[j]);
              }
            }
            java.util.Properties outputProperties = (java.util.Properties)request.getAttribute(this.REQUEST_TRANSFORM_OUTPUT_PROPERTIES_KEY);
            if (outputProperties != null)
              t.setOutputProperties(outputProperties);
 
            t.transform(transformSource,new StreamResult(buffer));
            buffer.flush();
            long done = System.currentTimeMillis() - start;
            if (log.isInfoEnabled()) 
            {  
              log.info("Executed Transformation Stylesheet: "+stylesheets[i]+" in "+done+"milliseconds.");
            } 
            ByteArrayInputStream inputBuffer = new ByteArrayInputStream(buffer.toByteArray());
            transformSource = new StreamSource(inputBuffer);
          }
        }
        catch(Exception ex)
        {
          if (log.isErrorEnabled()) 
            log.error("Failed transforming.",ex);
          request.setAttribute(this.REQUEST_ERROR_MESSAGE_KEY,"Error transforming using XSLT: "+ex.toString());
          throw ex;
        }
      }

      if (requestMapping.isFopPostProcess())
      {
        if (log.isInfoEnabled()) 
        {  
          log.info("Executing FOP Process");
        } 
        try
        {
          ByteArrayInputStream inputBuffer = new ByteArrayInputStream(buffer.toByteArray());
          ByteArrayOutputStream outputBuffer = new ByteArrayOutputStream(8096);

          InputStream fopOtionsInputStream = servletContext.getResourceAsStream(fopConfigFile);
          if (fopOtionsInputStream == null)
          {
            ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
            fopOtionsInputStream = classLoader.getResourceAsStream(fopConfigFile);
          }  
          org.apache.fop.apps.Options userConfig = new org.apache.fop.apps.Options(fopOtionsInputStream);

          org.apache.fop.apps.Driver driver = new org.apache.fop.apps.Driver(new org.xml.sax.InputSource(inputBuffer),outputBuffer);
          org.apache.avalon.framework.logger.Logger logger = new org.apache.avalon.framework.logger.ConsoleLogger(org.apache.avalon.framework.logger.ConsoleLogger.LEVEL_INFO);
          org.apache.fop.messaging.MessageHandler.setScreenLogger(logger);
          driver.setLogger(logger);

          if (contentType.equals(PDF_CONTENT))
          {
            driver.setRenderer(org.apache.fop.apps.Driver.RENDER_PDF);
          }
          else if (contentType.equals(XML_CONTENT))
          {
            driver.setRenderer(org.apache.fop.apps.Driver.RENDER_XML);
          }
          else if (contentType.equals(HTML_CONTENT))
          {
            driver.setRenderer(org.apache.fop.apps.Driver.RENDER_TXT);
          }
          else if (contentType.equals(SVG_CONTENT))
          {
            driver.setRenderer(org.apache.fop.apps.Driver.RENDER_SVG);
          }
          driver.run();

          byte[] content = outputBuffer.toByteArray();
          response.setContentLength(content.length);
          response.getOutputStream().write(content);
          response.getOutputStream().flush();
        }
        catch(Exception ex)
        {
          request.setAttribute(this.REQUEST_ERROR_MESSAGE_KEY,"Error running FOP process: "+ex.toString());
          throw ex;
        }   
      }
      else
      {
        byte[] content = buffer.toByteArray();

        if (log.isInfoEnabled()) 
          log.info("Output Results from buffer w/ length: "+content.length);

        response.setContentLength(content.length);
        response.getOutputStream().write(content);
        response.getOutputStream().flush();
      }
      return;      
    }
  }

  /**
   * Used to allow xls import and include to load stylesheets from war classpath.
   */
  public class XSLSourceResolver implements SourceLoader
  {
    public InputSource loadSource(java.lang.String href,java.lang.String context,XSLTC xsltc)
    {
      String stylesheet = null;
      int l = href.lastIndexOf("./");

      if (l > 0)
        stylesheet = href.substring(l+2,href.length());
      else
        stylesheet = href;

      InputStream xslInputStream = servletContext.getResourceAsStream("xsl/"+stylesheet);
      if (xslInputStream == null)
      {
        try
        {
          ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
          xslInputStream = classLoader.getResourceAsStream("xsl/"+stylesheet);
        }
        catch(java.util.MissingResourceException ex)
        {
        }
      }  
      return new InputSource(xslInputStream);
    }
  }

  /**
   * Used to make <xsl:include> access the xsl files from the .war deployment file
   */
  public class ServletResourceResolver implements URIResolver
  {
    public Source resolve(String href, String base) throws TransformerException
    {
      String stylesheet = null;
      int l = href.lastIndexOf("./");

      if (l > 0)
        stylesheet = href.substring(l+2,href.length());
      else
        stylesheet = href;

      InputStream xslInputStream = servletContext.getResourceAsStream("xsl/"+stylesheet);
      if (xslInputStream == null)
      {
        try
        {
          ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
          xslInputStream = classLoader.getResourceAsStream("xsl/"+stylesheet);
        }
        catch(java.util.MissingResourceException ex)
        {
        }
      }  
      return new StreamSource(xslInputStream);
    }
  }
}
