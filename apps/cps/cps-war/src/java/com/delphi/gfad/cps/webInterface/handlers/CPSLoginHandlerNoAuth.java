/**
 * CPSLoginHandlerNoAuth
 *
 *
 * $Revision: 1.1 $
 * $Log: CPSLoginHandlerNoAuth.java,v $
 * Revision 1.1  2005/02/15 18:55:10  zz0qx3
 * updates to illustrate DSI integration
 *
 *
 *
 */

package com.delphi.gfad.cps.webInterface.handlers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletContext;
import java.util.Vector;

import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Document;

import com.delphi.gfad.coreframework.handlers.BaseHandler;
import com.delphi.gfad.coreframework.servlet.MainServlet;
import com.delphi.gfad.coreframework.control.UserProfile;

import com.delphi.gfad.cps.db.gen.UserRolesFactory;
import com.delphi.gfad.cps.db.gen.UserRoles;

import com.delphi.gfad.cps.db.gen.UsersFactory;
import com.delphi.gfad.cps.db.gen.Users;

import org.apache.commons.logging.*;


/**
 * The CPSLoginHandlerNoAuth class handles user login into the application from the login screen.  The handler queries the database for 
 * the user's roles to complete the creation of the UserProfile Object.
 */
public class CPSLoginHandlerNoAuth extends BaseHandler
{
  /** Logging handle */
  private static Log log = LogFactory.getLog(CPSLoginHandlerNoAuth.class);
  /** Failed Message */
  public static String FAILED_LOGIN_MESSAGE = "THE LOGIN YOU ENTERED WAS NOT VALID, OR DID NOT MATCH THE SUPPLIED PASSWORD.  PLEASE TRY AGAIN.";

  /** User Id */
  String uid = null;
  /** User Password */
  String pwd = null;
  /** Authenticated flag */
  boolean authenticated = false;
  /** Login flag */
  boolean loginCommand = false;

  /** 
   * Constructor
   */
  public CPSLoginHandlerNoAuth()
  {
    super();
  }

  /**
   * processScreen - calls processLogin.
   *
   * @param screen Element from Screen DOM
   */
  public void processScreen(Element screen) throws Exception
  {
    processLogin(getRequest());
  } 

  /**
   * processLogin - processes the login request from the login screen.
   *
   * @param servlet request
   */
  public void processLogin(HttpServletRequest request) throws java.lang.Exception
  {
		uid = request.getParameter("uid");
		if (uid != null)
		if (uid.length() == 0)
		uid = null;

		pwd = request.getParameter("pwd");
		if (pwd != null)
		if (pwd.length() == 0)
		pwd = null;

		String command = request.getParameter("command");
		if (command != null)
		if (command.equals("login"))
		loginCommand = true;

		if (log.isInfoEnabled()) 
		{  
		log.info("CPSLoginHandlerNoAuth -> uid = "+uid+", pwd = "+pwd+", command = "+command);
		}

		if (uid != null && pwd != null)
		{
			String userProfileClassName = (String)getServletContext().getAttribute(MainServlet.CONTEXT_CONFIG_USER_PROFILE_IMPL_KEY);

			if (log.isInfoEnabled()) 
			{  
			log.info("Creating User Profile class: "+userProfileClassName);
			}

			//To validate the Net ID & Is Active flag is true

			Users[] users = UsersFactory.getInstance().fetchUsersByNetId(getConnection(),uid); 

			if(users.length==0)
			{
				authenticated = false;
			}
			else
			{
				authenticated = true;
			}
	  
			if(authenticated)
			{
				UserProfile profile = (UserProfile)Class.forName(userProfileClassName).newInstance();
				profile.setUid(uid);

				UserRoles[] roles = UserRolesFactory.getInstance().fetchUserRolesByNetId(getConnection(),uid);  //Sundar - user id is passed here

				for(int i=0; i<roles.length; i++)
				{
					profile.addRole(roles[i].getRole());

					log.info("++++ Roles ->" + roles[i].getRole()); //Sundar - I didn't get any roles from DB
				}

				if (log.isInfoEnabled()) 
				{  
					log.info("**** Roles ->" + profile + "Length : " + roles.length + " UID : " + uid); //Sundar - I'm getting this message
				}

				request.getSession(true).setAttribute(MainServlet.SESSION_USER_PROFILE_KEY,profile);    
				request.setAttribute(MainServlet.REQUEST_TARGET_URL_KEY,"/home");

				if (log.isInfoEnabled()) 
				{  
					log.info("Created User Profile");
				}
			}
			else
			{
				request.setAttribute(MainServlet.REQUEST_TARGET_URL_KEY,"/login");	
			}
	    }
  }

  /**
   * processModel - removes the log out link and the base TabSet from the model Element in the Screen DOM.
   *
   * @param model Element from Screen DOM
   */
  public void processModel(Element model) throws Exception
  {
    // remove logout link
    // Session/UserTabs/BannerTabSet/Tab[@Name='LOG OUT']
    NodeList tabSetNodes = model.getElementsByTagName("BannerTabSet");
    if (tabSetNodes.getLength() > 0)
    {
      Element e = (Element)tabSetNodes.item(0);
      NodeList tabNodes = e.getElementsByTagName("Tab");
      for(int j=0; j < tabNodes.getLength(); j++)
      {
        Element ee = (Element)tabNodes.item(j);
        if (ee.getAttribute("Name").equals("LOG OUT"))
        {
          ee.getParentNode().removeChild(ee);
          break;
        }
      }
    }

    // remove base TabSet

    tabSetNodes = model.getElementsByTagName("TabSet");
    if (tabSetNodes.getLength() > 0)
    for(int i=0; i < tabSetNodes.getLength(); i++)
    {
      Element e = (Element)tabSetNodes.item(i);
      if (e.getAttribute("Url").equals(""))
      {
        e.getParentNode().removeChild(e);
        break; 
      }
    }
  }

  /**
   * processView - appends validation errror message if applicable.
   *
   * @param view Element from Screen DOM
   */
  public void processView(Element view) throws Exception
  {
    Document xmlDoc = getDocument();

    if ((uid == null || pwd == null || !authenticated) && loginCommand)
    {
      Vector validationErrors = getValidationErrors();
      validationErrors.addElement(this.FAILED_LOGIN_MESSAGE);
    }
  }

}
