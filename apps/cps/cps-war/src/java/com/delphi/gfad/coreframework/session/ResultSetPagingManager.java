/**
 *
 * ResultSetPagingManager
 *
 * Class for persisting result set paging state on a users session.
 *
 * $Revision: 1.3 $
 * $Log: ResultSetPagingManager.java,v $
 * Revision 1.3  2004/12/01 22:23:24  vz86k2
 * update
 *
 *
 */
package com.delphi.gfad.coreframework.session;

import java.util.Vector;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;

import org.w3c.dom.Element;
import org.w3c.dom.Document;

/**
 * ResultSetPagingManager - persist paging state
 *
*/
public class ResultSetPagingManager implements java.io.Serializable
{
  /** instance name */
  protected String name = "DefaultPagingManager";
  /** current page starting row id */
  protected long currentStartRowId = 1;
  /** current page ending row id */
  protected long currentEndRowId = 10;
  /** maximum number of rows in page */
  protected long currentPageNumRows = 10;
  /** current page */
  protected long currentPage = 1;
  /** number of overall pages */
  protected long numPages = 1;  
  /** number of rows in result set */
  protected long numRows = 10;  
  /** present first button flag */
  protected boolean firstButton = false;
  /** present last button flag */
  protected boolean lastButton = false;
  /** present previous button flag */
  protected boolean prevButton = false;
  /** present next button flag */
  protected boolean nextButton = false;

  /** choice list for selecting number of rows per page */
  public static long[] pageNumRowsSelection = new long[] { 10, 20, 30, 40, 50 };

  /**
   * constructor
   *
   */
  public ResultSetPagingManager()
  {
  }

  /**
   * constructor
   *
   * @param instance name
   */
  public ResultSetPagingManager(String name)
  {
    this.name = name;
  }

  /**
   * reset
   *
   * @param result set size
   */
  public void reset(long numRows) throws Exception
  {
    this.numRows = numRows;  
    currentPage = 1;

    numPages = numRows / currentPageNumRows;  
    if ((numPages * currentPageNumRows) != numRows)
    {
      numPages++;
    }

    processRequest(currentPageNumRows,true,false,false,false);
  }

  /**
   * processRequest
   *
   * @param number of rows per page
   * @param select first page
   * @param select last page
   * @param select next page
   * @param select previous page
   */
  public void processRequest(long inputPageNumRows, boolean inputFirstPage, boolean inputLastPage, boolean inputNextPage, boolean inputPrevPage) throws Exception
  {
    firstButton = false;
    prevButton = false;
    lastButton = false;
    nextButton = false;

    // handle display # rows changing

    if (inputPageNumRows != currentPageNumRows)
    {
      currentPage = currentStartRowId / inputPageNumRows;
      numPages = numRows / inputPageNumRows;  
      if ((numPages * inputPageNumRows) != numRows)
      {
        numPages++;
      }
      currentPageNumRows = inputPageNumRows;
    }

    // handle navigation button

    if (inputFirstPage)
    {
      currentPage = 1;
    }
    else if (inputLastPage)
    {
      currentPage = numPages;
    }
    else if (inputPrevPage)
    {
      currentPage--;
    }
    else if (inputNextPage)
    {
      currentPage++;
    }

    // bounds checking - should not happen 
 
    if (currentPage <= 0)
    {
      currentPage = 1;
    }
    else if (currentPage > numPages)
    {
      currentPage = numPages;
    }

    // handle buttons to display

    if (currentPage > 1) 
    { 
      firstButton = true;
      prevButton = true;
    }

    if (numPages > currentPage) 
    { 
      lastButton = true;
      nextButton = true;
    }

    currentStartRowId = (currentPage-1) * inputPageNumRows + 1;
    currentEndRowId = currentStartRowId + inputPageNumRows - 1;

    if (currentEndRowId > numRows)
      currentEndRowId = numRows;
  }

  /**
   * handleRequest - process request parameters for this component
   *
   * @param servlet request
   * @param validation errors vector
   */
  public void handleRequest(HttpServletRequest request, Vector validationErrors) throws Exception
  {
    long inputPageNumRows = currentPageNumRows;
    boolean inputFirstPage = false;
    boolean inputLastPage = false;
    boolean inputNextPage = false;
    boolean inputPrevPage = false;

    String param = request.getParameter("pageNumRows");
    if (param != null)
    {
      inputPageNumRows = Long.parseLong(param);
    }

    param = request.getParameter("pageButton");
    if (param != null)
    {
      if (param.equals("firstPage"))
        inputFirstPage = true;
      else if (param.equals("lastPage"))
        inputLastPage = true;
      else if (param.equals("prevPage"))
        inputPrevPage = true;
      else if (param.equals("nextPage"))
        inputNextPage = true;  
    }

    processRequest(inputPageNumRows,inputFirstPage,inputLastPage,inputNextPage,inputPrevPage);
  }

  public String getName()
  {
    return name;
  }

  public long getCurrentStartRowId()
  {
    return currentStartRowId;
  }

  public long getCurrentEndRowId()
  {
    return currentEndRowId;
  }

  public long getCurrentPageNumRows()
  {
    return currentPageNumRows;
  }

  public long getCurrentPage()
  {
    return currentPage;
  }

  public long getNumPages()
  {
    return numPages;
  }

  public long getNumRows()
  {
    return numRows;
  }

  public boolean isFirstButton()
  {
    return firstButton;
  }

  public boolean isLastButton()
  {
    return lastButton;
  }

  public boolean isPrevButton()
  {
    return prevButton;
  }

  public boolean isNextButton()
  {
    return nextButton;
  }

  public Element getState(Document doc) throws Exception
  {
    Element resultSetPagingManager = doc.createElement("ResultSetPagingManager");
    resultSetPagingManager.setAttribute("name",""+name);
    resultSetPagingManager.setAttribute("cStartRowId",""+currentStartRowId);
    resultSetPagingManager.setAttribute("cEndRowId",""+currentEndRowId);
    resultSetPagingManager.setAttribute("cPageNumRows",""+currentPageNumRows);
    resultSetPagingManager.setAttribute("cPage",""+currentPage);
    resultSetPagingManager.setAttribute("nPages",""+numPages);
    resultSetPagingManager.setAttribute("nRows",""+numRows);
    resultSetPagingManager.setAttribute("firstB",""+firstButton);
    resultSetPagingManager.setAttribute("lastB",""+lastButton);
    resultSetPagingManager.setAttribute("prevB",""+prevButton);
    resultSetPagingManager.setAttribute("nextB",""+nextButton);
    return resultSetPagingManager;
  }

  public String toString()
  {
    StringBuffer sb = new StringBuffer();
    sb.append("<ResultSetPagingManager ");
    sb.append("name=\"").append(name).append("\" ");
    sb.append("cStartRowId=\"").append(currentStartRowId).append("\" ");
    sb.append("cEndRowId=\"").append(currentEndRowId).append("\" ");
    sb.append("cPageNumRows=\"").append(currentPageNumRows).append("\" ");
    sb.append("cPage=\"").append(currentPage).append("\" ");
    sb.append("nPages=\"").append(numPages).append("\" ");
    sb.append("nRows=\"").append(numRows).append("\" ");
    sb.append("firstB=\"").append(firstButton).append("\" ");
    sb.append("lastB=\"").append(lastButton).append("\" ");
    sb.append("prevB=\"").append(prevButton).append("\" ");
    sb.append("nextB=\"").append(nextButton).append("\" >");
    return sb.toString();
  }

  public static void main(String[] args) throws Exception
  {
    System.out.println("Testing Paging...");
    System.out.println("-----------------");

    ResultSetPagingManager manager = new ResultSetPagingManager();
    manager.reset(54);
    System.out.println("Reset: -----------------\n"+manager.toString());

    manager.processRequest(10,true,false,false,false);
    System.out.println("\nFirst Page: -----------------\n"+manager.toString());

    manager.processRequest(10,false,false,true,false);
    System.out.println("\nNext Page: -----------------\n"+manager.toString());

    manager.processRequest(10,false,false,true,false);
    System.out.println("\nNext Page: -----------------\n"+manager.toString());

    manager.processRequest(10,false,false,true,false);
    System.out.println("\nNext Page: -----------------\n"+manager.toString());

    manager.processRequest(10,false,false,true,false);
    System.out.println("\nNext Page: -----------------\n"+manager.toString());
    
    manager.processRequest(10,false,false,true,false);
    System.out.println("\nNext Page: -----------------\n"+manager.toString());

    manager.processRequest(10,true,false,false,false);
    System.out.println("\nFirst Page: -----------------\n"+manager.toString());

    manager.processRequest(10,false,true,false,false);
    System.out.println("\nLast Page: -----------------\n"+manager.toString());

    manager.processRequest(10,false,false,false,true);
    System.out.println("\nPrev Page: -----------------\n"+manager.toString());

    manager.processRequest(10,false,false,false,true);
    System.out.println("\nPrev Page: -----------------\n"+manager.toString());

    manager.processRequest(10,false,false,false,true);
    System.out.println("\nPrev Page: -----------------\n"+manager.toString());

    manager.processRequest(10,false,false,false,true);
    System.out.println("\nPrev Page: -----------------\n"+manager.toString());

    manager.processRequest(10,false,false,false,true);
    System.out.println("\nPrev Page: -----------------\n"+manager.toString());

    manager.processRequest(10,false,false,true,false);
    System.out.println("\nNext Page: -----------------\n"+manager.toString());

    manager.processRequest(20,false,false,true,false);
    System.out.println("\nNext Page (20): -----------------\n"+manager.toString());

    manager.processRequest(20,false,false,true,false);
    System.out.println("\nNext Page (20): -----------------\n"+manager.toString());

  }
}
