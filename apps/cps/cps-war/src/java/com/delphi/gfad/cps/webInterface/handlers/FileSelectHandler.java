/**
 * FileSelectHandler
 *
 *
 * $Revision: 1.1 $
 * $Log: FileSelectHandler.java,v $
 * Revision 1.1  2005/03/21 18:55:10  rzhtj5
 * File Select Handler class
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

import com.delphi.gfad.cps.db.gen.SelectFileFactory;

import org.apache.commons.logging.*;


/**
 * The FileSelectHandler class queries the database and 
 * lists the CPS files .
 */

public class FileSelectHandler extends BaseHandler
{
  /** Logging handle */
  private static Log log = LogFactory.getLog(CPSLoginHandlerNoAuth.class);
 
  private final String CPS_FILE_DEFAULT="*";


  //boolean FileSelectCommand = false;
  private String strUserId; 
  private String strFileName = null;
  private String strFileType = null;

  /** 
   * Constructor
   */
  public FileSelectHandler()
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
    processFileSelect(getRequest());
  } 

  /**
   * processLogin - processes the login request from the login screen.
   *
   * @param servlet request
   */
  public void processFileSelect(HttpServletRequest request) throws java.lang.Exception
  {
   
		UserProfile profile = (UserProfile) request.getSession(true).getAttribute(MainServlet.SESSION_USER_PROFILE_KEY);   
		strUserId = profile.getUid();

		strFileName = request.getParameter("filename");
		strFileType = request.getParameter("fileType");

		if(strFileName==null)
		{
			strFileName = CPS_FILE_DEFAULT;
		}

		if (log.isInfoEnabled()) 
		{  
			log.info("FileSelectHandler -> File name : " + strFileName + ", File Type : " + strFileType);
		}

		request.setAttribute(MainServlet.REQUEST_TARGET_URL_KEY,"/selectfile");

		if (log.isInfoEnabled()) 
		{  
		log.info("File Select Process ended...");
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

    //if ((uid == null || pwd == null || !authenticated) && loginCommand)
    //{
      //Vector validationErrors = getValidationErrors();
      //validationErrors.addElement(this.FAILED_LOGIN_MESSAGE);
    //}

	org.w3c.dom.Element filesElement = SelectFileFactory.getInstance().fetchFileInfoDOM(getConnection(),getDocument(),strUserId);
    view.appendChild(filesElement);

  }

}
