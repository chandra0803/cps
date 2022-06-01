/**
 * BaseHandler
 *
 * $Revision: 1.12 $
 * $Log: BaseHandler.java,v $
 * Revision 1.12  2004/12/01 22:23:10  vz86k2
 * update
 *
 * Revision 1.11  2004/11/23 20:07:58  zz0qx3
 * changes to support non-staticv DB classes
 *
 * Revision 1.10  2004/11/22 17:42:23  vz86k2
 * update to use jBoss connection pool
 *
 * Revision 1.9  2004/09/14 20:36:46  vz86k2
 * update
 *
 * Revision 1.8  2004/09/08 20:18:18  vz86k2
 * update
 *
 * Revision 1.7  2004/09/07 20:37:19  vz86k2
 * update
 *
 * Revision 1.6  2004/08/31 22:00:11  vz86k2
 * update
 *
 * Revision 1.5  2004/08/30 19:08:03  vz86k2
 * update
 *
 * Revision 1.4  2004/08/25 22:38:21  vz86k2
 * update
 *
 * Revision 1.3  2004/08/23 22:08:04  vz86k2
 * re-add connection pool access
 *
 * Revision 1.2  2004/08/23 20:29:55  vz86k2
 * update
 *
 * Revision 1.1  2004/08/18 15:51:47  vz86k2
 * check in
 *
 *
 *
 **/

package com.delphi.gfad.coreframework.handlers;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletContext;
import com.delphi.gfad.coreframework.control.RequestHandlerDefaultImpl;
import com.delphi.gfad.coreframework.control.RequestHandler;
import com.delphi.gfad.coreframework.control.UserProfile;

import com.delphi.gfad.coreframework.servlet.MainServlet;
import com.delphi.gfad.coreframework.servlet.MultipartRequestWrapper;

import java.io.*;
import java.util.Vector;
import java.util.Enumeration;
import java.util.StringTokenizer;
import javax.servlet.http.HttpSession;

// Imported DOM classes
import org.w3c.dom.Document;
import org.w3c.dom.DocumentFragment;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Element;

import org.apache.commons.logging.*;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/**
 * BaseHandler
 *
 */
public class BaseHandler extends RequestHandlerDefaultImpl implements RequestHandler
{
  public static final String PDF_CONTENT = "application/pdf";
  public static final String EXCEL_CONTENT = "application/vnd.ms-excel";
  public static final String XML_CONTENT = "text/xml; charset=UTF-8";
  public static final String HTML_CONTENT = "text/html; charset=UTF-8";

  private static Log log = LogFactory.getLog(BaseHandler.class);

  protected String basePath = "";
  protected HttpServletRequest request;
  protected Document document;
  private String contentType = null;
  private ServletContext servletContext;

  protected Connection connection;
  protected UserProfile userProfile;
  protected String[] rolesArray = new String[0];

  protected Vector validationErrors = new Vector();

  protected DataSource jdbcFactory;

  /**
   * BaseHandler
   *
   */
  public BaseHandler()
  {
  }

  /**
   * setServletContext
   *
   */
  public void setServletContext(ServletContext servletContext)
  {
    this.servletContext = servletContext;
  }

  /**
   * getServletContext
   *
   */
  public ServletContext getServletContext()
  {
    return servletContext;
  }

  /**
   * setRolesArray
   *
   */
  private void setRolesArray(String[] roles)
  {
    this.rolesArray = roles;
  }

  /**
   * setRequest
   *
   */
  protected void setRequest(HttpServletRequest request)
  {
    this.request = request;
  }

  /**
   * getRequest
   *
   */
  public HttpServletRequest getRequest()
  {
    return request;
  }

  /**
   * setConnection
   *
   */
  protected void setConnection(Connection conn)
  {
    this.connection = conn;
  }

  /**
   * getConnection
   *
   */
  protected Connection getConnection()
  {
    return connection;
  }

  /**
   * getValidationErrors
   *
   */
  protected Vector getValidationErrors()
  {
    return validationErrors;
  }

  /**
   * setUserProfile
   *
   */
  protected void setUserProfile(UserProfile profile)
  {
    this.userProfile = profile;
  }

  /**
   * getUserProfile
   *
   */
  protected UserProfile getUserProfile()
  {
    return userProfile;
  }

  /**
   * setDocument
   *
   */
  protected void setDocument(Document doc)
  {
    this.document = doc;
  }

  /**
   * getDocument
   *
   */
  public Document getDocument()
  {
    return document;
  }

  /**
   * setContentType
   *
   */
  public void setContentType(String type)
  {
    this.contentType = type;
  }

  /**
   * getContentType
   *
   */
  public String getContentType()
  {
    return this.contentType;
  }

  /**
   * getElement
   *
   */
  protected org.w3c.dom.Element getElement(String elementName)
  {
    return (org.w3c.dom.Element)document.createElement(elementName);
  }

  /**
   * processRequest
   *
   */
  public void processRequest(HttpServletRequest request) throws java.lang.Exception
  {
    if (log.isInfoEnabled())
      log.info("-- BaseHandler processRequest()");

    Connection conn = null;

    try
    {

//      conn = com.delphi.gfad.coreframework.db.ConnectionPool.getConnection("WEB-APP");

      InitialContext c = null;   
      if (jdbcFactory == null)
      {
        c = new InitialContext();

        String jdbcContext = (String)getServletContext().getAttribute("JDBC-CONTEXT");
        if (jdbcContext == null)
          jdbcContext = "java:OracleDS";

        if (log.isInfoEnabled())
          log.info("-- BaseHandler using JDBC-CONTEXT: "+jdbcContext);

        jdbcFactory = (DataSource)c.lookup(jdbcContext);
      }

      conn = jdbcFactory.getConnection();

      HttpSession httpSession = request.getSession(false);

      Document xmlDoc = null;
      if (httpSession != null)
      {
        xmlDoc = (Document)httpSession.getAttribute(MainServlet.SESSION_DOCUMENT_KEY);
      }

      if (xmlDoc == null)
      {
        javax.xml.parsers.DocumentBuilderFactory dFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
        javax.xml.parsers.DocumentBuilder dBuilder = dFactory.newDocumentBuilder();
        xmlDoc = dBuilder.newDocument();
        if (httpSession != null)
        {
          httpSession.setAttribute(MainServlet.SESSION_DOCUMENT_KEY,xmlDoc);
        }
      }

      // clear session document.
      NodeList children = xmlDoc.getChildNodes();
      for(int i=0; i < children.getLength(); i++)
      {
        Node node = children.item(i);
        if (node.getNodeName().equals("Screen"))
        {
          xmlDoc.removeChild(node);
          break;
        }
      }

      org.w3c.dom.Element root = (org.w3c.dom.Element)xmlDoc.createElement("Screen");
      xmlDoc.appendChild(root);

      String redirMessage;
      if ((httpSession != null) && ((redirMessage = (String)httpSession.getAttribute("redirectMessage")) != null))
      {
        org.w3c.dom.Element redirMessElem = (org.w3c.dom.Element)xmlDoc.createElement("RedirectMessage");
        redirMessElem.setAttribute("text", redirMessage);
        root.appendChild(redirMessElem);
      }
      String infoMessage;
      if ((httpSession != null) && ((infoMessage = (String)httpSession.getAttribute("infoMessage")) != null))
      {
        org.w3c.dom.Element infoMessElem = (org.w3c.dom.Element)xmlDoc.createElement("InfoMessage");
        infoMessElem.setAttribute("text", infoMessage);
        root.appendChild(infoMessElem);
        httpSession.removeAttribute("infoMessage");
      }

      org.w3c.dom.Element model = (org.w3c.dom.Element)xmlDoc.createElement("Model");
      root.appendChild(model);

      org.w3c.dom.Element modelRequest = (org.w3c.dom.Element)xmlDoc.createElement("Request");
      model.appendChild(modelRequest);

      org.w3c.dom.Element session = (org.w3c.dom.Element)xmlDoc.createElement("Session");
      model.appendChild(session);

      UserProfile userProfile = null;
      if (httpSession != null)  
        userProfile = (UserProfile)httpSession.getAttribute(MainServlet.SESSION_USER_PROFILE_KEY);

      if (userProfile != null)
      {
        org.w3c.dom.Element profile = (org.w3c.dom.Element)xmlDoc.createElement("UserProfile");
        profile.setAttribute("uid",""+userProfile.getUid());
        profile.setAttribute("name",""+userProfile.getUserName());

        rolesArray = userProfile.getRoles();
        org.w3c.dom.Element roles = (org.w3c.dom.Element)xmlDoc.createElement("Roles");
        for(int i=0; i<rolesArray.length; i++)
        {
          org.w3c.dom.Element role = (org.w3c.dom.Element)xmlDoc.createElement("Role");
          role.setAttribute("name",rolesArray[i]);
          roles.appendChild(role);
        }
        profile.appendChild(roles);
        session.appendChild(profile);
      }

      org.w3c.dom.Element entity = (org.w3c.dom.Element)xmlDoc.createElement("Entity");
      model.appendChild(entity);

      org.w3c.dom.Element view = (org.w3c.dom.Element)xmlDoc.createElement("View");
      root.appendChild(view);

      org.w3c.dom.Element control = (org.w3c.dom.Element)xmlDoc.createElement("Control");
      root.appendChild(control);

      setRequest(request);
      setConnection(conn);
      setUserProfile(userProfile);
      setDocument(xmlDoc);

      if (userProfile != null)
      {
        boolean reset = userProfile.isRolesModified();
        userProfile.resetModified();
        if (log.isInfoEnabled()) 
          log.info("-- Reset Navigation: "+reset);
        appendUserNavigation(session,reset);
        appendUserTabs(session,reset);
        selectTabset(session);
      }
      else
      {
        if (log.isInfoEnabled()) 
          log.info("-- Null UserProfile, not loading User Navigation.");
        // append tabs for banner...  
        appendUserTabs(session,true);
      }
 
      populateDefaults(root);

      processScreen(root);

      processSession(session);

      processModel(model);

      processModelRequest(modelRequest);

      processView(view);

      processControl(control); 

      // end extending code here

      // append validation errors...

      org.w3c.dom.Element errorsElement = (org.w3c.dom.Element)xmlDoc.createElement("ValidationErrors");
      root.appendChild(errorsElement);

      for(int i=0; i<validationErrors.size(); i++)
      {
        org.w3c.dom.Element elem = (org.w3c.dom.Element)xmlDoc.createElement("Error");
        errorsElement.appendChild(elem);
        String err = (String)validationErrors.elementAt(i);
        if (err != null)
        {
          elem.appendChild(xmlDoc.createTextNode(err));
        }
      }

      // display dom
      if (log.isDebugEnabled()) 
      {
        log.debug("-- BaseHandler generated DOM.");
        //if (displayDOM)
          log.debug("-- DOM:\n"+com.delphi.gfad.coreframework.util.XMLUtils.serialize(root));
      }

      if (displayDOM)
        log.info("-- DOM:\n"+com.delphi.gfad.coreframework.util.XMLUtils.serialize(root));

      javax.xml.transform.dom.DOMSource dom = new javax.xml.transform.dom.DOMSource(root);
      request.setAttribute(MainServlet.REQUEST_DOM_SOURCE_KEY ,dom);
     }
    finally
    {
      if ( conn != null )
      {
        try
        {
          conn.close();
        }
        catch (Exception e)
        {
          log.error("-- Caught exception closing connection: ", e );
        }
  
/*    
        try
        {
          try
          {
            conn.commit();
            conn.setAutoCommit(true);
          }
          catch (Exception e)
          {
            log.error("-- Caught exception resetting autocommit", e );
          }
            com.delphi.gfad.coreframework.db.ConnectionPool.putConnection("WEB-APP",conn);
        }
        catch ( Exception e )
        {
          log.error("-- Unable to return database connection to Pool", e );
        }
*/
      }
    }
    if (log.isInfoEnabled()) 
      log.info("-- BaseHandler: processRequest() done ----->");
  }

  /**
   * populateDefaults
   *
   */
  public void populateDefaults(Element screen) throws Exception
  {
    Document xmlDoc = getDocument();

    Enumeration params = getServletContext().getAttributeNames();
    while(params.hasMoreElements())
    {
      String paramName = (String)params.nextElement();

      if (paramName.startsWith("Screen"))
      {
        String paramValue = (String)getServletContext().getAttribute(paramName);
        StringTokenizer st = new StringTokenizer(paramName,".");
        Element positionElement = screen;
        while(st.hasMoreTokens())
        {
          String elementName = st.nextToken();
          if (!elementName.equals("Screen"))
          {
            NodeList list = positionElement.getChildNodes();
            boolean found = false;
            for(int i=0; i < list.getLength(); i++)
            {
              Node node = list.item(i);
              if ((node.getNodeType() == org.w3c.dom.Node.ELEMENT_NODE) && node.getNodeName().equals(elementName))
              {
                positionElement = (Element)node;
                found = true;
              }         
            }
            if (!found)  
            {
              org.w3c.dom.Element elem = (org.w3c.dom.Element)xmlDoc.createElement(elementName);
              positionElement.appendChild(elem);
              positionElement = elem;
            }
          } 
        }
        positionElement.appendChild(xmlDoc.createTextNode(paramValue));
      }
    }    
  }

  /**
   * doStart
   *
   */
  public void doStart(HttpServletRequest request)
  {
  }

  /**
   * doEnd
   *
   */
  public void doEnd(HttpServletRequest request)
  {
  }

  /**
   * processScreen
   *
   */
  public void processScreen(Element screen) throws Exception
  {
  }

  /**
   * processSession
   *
   */
  public void processSession(Element session) throws Exception
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
   * processModelRequest
   *
   */
  public void processModelRequest(Element modelRequest) throws Exception
  {
  }

  /**
   * processView
   *
   */
  public void processView(Element view) throws Exception
  {
  }

  /**
   * processControl
   *
   */
  public void processControl(Element control) throws Exception
  {
  }

  /**
   * appendNavigation
   *
   */
  private void appendUserNavigation(Element session, boolean reset) throws Exception
  {
    String navigationFileName = (String)servletContext.getAttribute(MainServlet.CONTEXT_CONFIG_NAVIGATION_KEY);
    if (log.isInfoEnabled()) 
      log.info("-- Appending Navigation from file: "+navigationFileName);

    appendFragment(navigationFileName, MainServlet.SESSION_NAVIGATION_FRAGMENT_KEY, session, true, reset);
  }

  /**
   * appendTabs
   *
   */
  private void appendUserTabs(Element session, boolean reset) throws Exception
  {
    String tabFileName = (String)servletContext.getAttribute(MainServlet.CONTEXT_CONFIG_TABS_KEY);
    if (log.isInfoEnabled()) 
      log.info("-- Appending Tab from file: "+tabFileName);

    appendFragment(tabFileName, MainServlet.SESSION_TABS_FRAGMENT_KEY, session, true, reset);
  }

  private void selectTabset(Element session) throws Exception
  {
    String url = getUrl();
    if (url.length() > 0)
      url = url.substring(1,url.length());
  
    // filter out specific tab set and set current page.
    int pathIndex = url.lastIndexOf("/");
    int lastIndex = pathIndex + 1;
    if (lastIndex > url.length())
      lastIndex = url.length();
    String tabSetUrl = "";
    String tabUrl = "";
    if (pathIndex > 0)
    {
      tabSetUrl = url.substring(0,lastIndex);
      tabUrl = url.substring(lastIndex,url.length());
    }
    else
    {
      tabUrl = url;
    }

    if (log.isInfoEnabled()) 
    {
      log.info("-- Select TabSet  url: "+url+", tabSetUrl: "+tabSetUrl+", tabUrl: "+tabUrl);
    }

    NodeList list = session.getElementsByTagName("UserTabs");
    if (list.getLength() > 0)
    {
      Element tabs = (Element)list.item(0);
      NodeList tabSetsList = tabs.getChildNodes();
      Vector tabSetsToRemove = new Vector();

      for(int i=0; i < tabSetsList.getLength(); i++)
      {
        Node node = tabSetsList.item(i);
        if ((node.getNodeType() == org.w3c.dom.Node.ELEMENT_NODE) && (node.getNodeName().equals("TabSet")))
        {
          if (((Element)node).getAttribute("Url").equals(tabSetUrl))
          {
            NodeList tabsList = node.getChildNodes();
            for(int j=0; j < tabsList.getLength(); j++)
            {
              Node tabNode = tabsList.item(j);
              if ((tabNode.getNodeType() == org.w3c.dom.Node.ELEMENT_NODE) && (tabNode.getNodeName().equals("Tab")))
              {
                if (((Element)tabNode).getAttribute("Url").equals(tabUrl))
                {
                  ((Element)tabNode).setAttribute("currentTab","true");
                }
              }
            }
            filterChildNodesByRoles(node);
          }
          else
          {
            tabSetsToRemove.addElement(node);
          }
        }
      }

      for(int i=0; i< tabSetsToRemove.size(); i++)
      {
        tabs.removeChild(((Node)tabSetsToRemove.elementAt(i)));
      }
    }
  }

  protected void appendFragment(String resourcePath, String fragmentKey, Element targetElem, boolean applyRoleFilter, boolean resetCache) throws javax.xml.parsers.ParserConfigurationException, java.io.FileNotFoundException, java.lang.Exception
  {
    DocumentFragment savedFrag = null;
    Node fragNode = null;

    Document sessionDocument = getDocument();
    HttpSession httpSession = getRequest().getSession(false);

    if (httpSession != null)
    {
      if (resetCache)
      {
        httpSession.removeAttribute(fragmentKey);
      }
      else
      {
        savedFrag = (DocumentFragment)httpSession.getAttribute(fragmentKey);
      }
    }
   
    if (savedFrag == null)
    {
      InputStream xmlInputStream = getServletContext().getResourceAsStream(resourcePath);
      if (xmlInputStream == null)
      {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        xmlInputStream = classLoader.getResourceAsStream(resourcePath);
      } 

      InputStreamReader xmlReader = new InputStreamReader(xmlInputStream);
      DOMParser parser = new DOMParser();
      savedFrag = sessionDocument.createDocumentFragment();
      Element fragElem = sessionDocument.createElement(fragmentKey + "Container");
      parser.parseAppend(fragElem,xmlReader);
      savedFrag.appendChild(fragElem.getFirstChild());

      if (applyRoleFilter)
      {
        // step 2: filter out  nodes not in users roles
        NodeList list = savedFrag.getChildNodes();
        if (list.getLength() > 0)
        {
          filterChildNodesByRoles(list.item(0));
        }
      }
      if (httpSession != null)
        httpSession.setAttribute(fragmentKey,savedFrag);
    }

    fragNode = targetElem.getOwnerDocument().importNode(savedFrag,true);
    targetElem.appendChild(fragNode);
  }

  /**
   * filterChildNodesByRoles
   *
   */
  private void filterChildNodesByRoles(Node n) throws Exception
  {
    NodeList list = n.getChildNodes();
    Vector removeItemNodes = new Vector();

    for(int i=0; i < list.getLength(); i++)
    {
      Node node = list.item(i);
      if (node.getNodeType() == org.w3c.dom.Node.ELEMENT_NODE)
      {
        if (!isAllowed(node))
        {
          removeItemNodes.addElement(node);
        }
      }
    }

    for(int i=0; i< removeItemNodes.size(); i++)
    {
      n.removeChild(((Node)removeItemNodes.elementAt(i)));
    }

    list = n.getChildNodes();
    for(int i=0; i < list.getLength(); i++)
    {
      Node node = list.item(i);
      if (node.getNodeType() == org.w3c.dom.Node.ELEMENT_NODE)
      {
        filterChildNodesByRoles(node);
      }
    }
  }

  /**
   * isAllowed
   *
   */
  private boolean isAllowed(Node n) throws Exception
  {
    boolean allowed = false;

    NodeList nodeRolesList = n.getChildNodes();
    Vector removeRoleNodes = new Vector();

    for(int i=0; i < nodeRolesList.getLength(); i++)
    {
      Node roleNode = nodeRolesList.item(i);
      if ((roleNode.getNodeType() == org.w3c.dom.Node.ELEMENT_NODE) && (roleNode.getNodeName().equals("role-mapping")))
      {
        String roleString = ((Element)roleNode).getAttribute("role");
        if (roleString.toUpperCase().equals("ANY"))
          allowed = true;
        else
        {
          for(int j=0; j < rolesArray.length; j++)
          {
            if (roleString.equals(rolesArray[j]))
            {
              allowed = true;
              break;
            }
          }
        }
        removeRoleNodes.addElement(roleNode);
      }
    }

    for(int i=0; i< removeRoleNodes.size(); i++)
    {
      n.removeChild(((Node)removeRoleNodes.elementAt(i)));
    }
    return allowed;
  }

  /**
   * main
   *
   */
  public static void main(String[] args) throws Exception
  {
/*
    javax.xml.parsers.DocumentBuilderFactory dFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
    javax.xml.parsers.DocumentBuilder dBuilder = dFactory.newDocumentBuilder();

    org.w3c.dom.Document xmlDoc = dBuilder.newDocument();
    org.w3c.dom.Element root = (org.w3c.dom.Element)xmlDoc.createElement("Presentation");
    xmlDoc.appendChild(root);

    String[] roles = new String[] {"Admin"};
    String url = "webedi/delfor/view-delfors";
    BaseHandler b = new BaseHandler();
    b.setUrl(url);
    b.setRolesArray(roles);
    b.processPresentation(root);
*/
  }
}


