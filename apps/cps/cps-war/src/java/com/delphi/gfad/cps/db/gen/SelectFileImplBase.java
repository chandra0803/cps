
/**
 *
 * Class: SelectFileImplBase
 *
 * This is a generated Class. Do not modify directly.
 * Subclasses are provided for extending this class.
 **/

package com.delphi.gfad.cps.db.gen;

import java.io.*;
import java.sql.*;
import oracle.sql.*;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.apache.commons.logging.*;

/** 
The Users business object encapsulates access to the set of CPS File Select.  
  
This class is the implementation base object, and should be extended (if necessary)
using the subclass SelectFile.
*/
public class SelectFileImplBase
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(SelectFileImplBase.class);
  public static int BUFFER_LENGTH = 4096;

  private Long id;
  private Date dt;
  private String name;
  private String comment;
 
  private boolean selectedForUpdate;

  public SelectFileImplBase()
  {
    setSelectedForUpdate(false);
  }
  public void setId( Long id )

  {
    this.id = id;

  }

  public Long getId()
  {
    return id;
  }
  public void setDt( Date dt )

  {
    this.dt = dt;

  }

  public Date getDt()
  {
    return dt;
  }
  public void setName( String name )

  {
    this.name = name;

  }

  public String getName()
  {
    return name;
  }
  public void setComment( String comment )

  {
    this.comment = comment;

  }

  public String getComment()
  {
    return comment;
  }
 
  protected void setSelectedForUpdate(boolean selectedForUpdate)
  {
    this.selectedForUpdate = selectedForUpdate;
  }
  
  public boolean getSelectedForUpdate()
  {
    return selectedForUpdate;
  }


  public String toString()
  {
    StringBuffer sb = new StringBuffer();
      sb.append("Long id = ");
    sb.append(getId()) ;
    sb.append("\n");
    sb.append("Date dt = ");
    sb.append(getDt()) ;
    sb.append("\n");
    sb.append("String name = ");
    sb.append(getName()) ;
    sb.append("\n");
    sb.append("String comment = ");
    sb.append(getComment()) ;
    sb.append("\n");
 
    sb.append("selectedForUpdate = ");
    sb.append(selectedForUpdate) ;
    sb.append("\n");
    return sb.toString();
  }

  public org.w3c.dom.Element getElement(org.w3c.dom.Document doc) 
    throws SQLException
  {
    org.w3c.dom.Element node = (org.w3c.dom.Element)doc.createElement("SelectFile");
    String temp = null;


    Element element = null;
    if (getId() != null)
    {
      temp = ""+getId();
      element = (Element)doc.createElement("id");
      element.appendChild((org.w3c.dom.Text)doc.createTextNode(temp));
      node.appendChild(element);
      //Logger.debug(CNAME, "id = " + temp);
    }
    if (getDt() != null)
    {
      temp = ""+getDt();
      element = (Element)doc.createElement("dt");
      element.appendChild((org.w3c.dom.Text)doc.createTextNode(temp));
      node.appendChild(element);
      //Logger.debug(CNAME, "dt = " + temp);
    }
    if (getName() != null)
    {
      temp = ""+getName();
      element = (Element)doc.createElement("name");
      element.appendChild((org.w3c.dom.Text)doc.createTextNode(temp));
      node.appendChild(element);
      //Logger.debug(CNAME, "name = " + temp);
    }
    if (getComment() != null)
    {
      temp = ""+getComment();
      element = (Element)doc.createElement("comment");
      element.appendChild((org.w3c.dom.Text)doc.createTextNode(temp));
      node.appendChild(element);
      //Logger.debug(CNAME, "comment = " + temp);
    }
   

    return node;
  }




}
