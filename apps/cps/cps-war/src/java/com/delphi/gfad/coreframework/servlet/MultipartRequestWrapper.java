/**
 * L.O'TOOLE - Code borrowed from org.apache.struts and adapted for our use.
 * (new code appears between //+ delimiters)
 */

//+
package com.delphi.gfad.coreframework.servlet;
//+

//package org.apache.struts.upload;

/*
 * The Apache Software License, Version 1.1
 *
 * Copyright (c) 1999-2001 The Apache Software Foundation.  All rights
 * reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * 3. The end-user documentation included with the redistribution, if
 *    any, must include the following acknowlegement:
 *       "This product includes software developed by the
 *        Apache Software Foundation (http://www.apache.org/)."
 *    Alternately, this acknowlegement may appear in the software itself,
 *    if and wherever such third-party acknowlegements normally appear.
 *
 * 4. The names "The Jakarta Project", "Struts", and "Apache Software
 *    Foundation" must not be used to endorse or promote products derived
 *    from this software without prior written permission. For written
 *    permission, please contact apache@apache.org.
 *
 * 5. Products derived from this software may not be called "Apache"
 *    nor may "Apache" appear in their names without prior written
 *    permission of the Apache Group.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESSED OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED.  IN NO EVENT SHALL THE APACHE SOFTWARE FOUNDATION OR
 * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals on behalf of the Apache Software Foundation.  For more
 * information on the Apache Software Foundation, please see
 * <http://www.apache.org/>.
 *
 */

import java.util.Map;
import java.util.List;
import java.util.Locale;
import java.util.Vector;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Collection;
import java.util.Collections;
import java.util.Enumeration;
import java.io.IOException;
import java.io.InputStream;
import java.io.BufferedReader;
import java.security.Principal;
import javax.servlet.ServletInputStream;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
//+
import com.oreilly.servlet.multipart.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Set;
//+

/**
 * This class functions as a wrapper around HttpServletRequest to
 * provide working getParameter methods for multipart requests.  Once
 * Struts requires Servlet 2.3, this class will definately be changed to
 * extend javax.servlet.http.HttpServletRequestWrapper instead of
 * implementing HttpServletRequest.  Servlet 2.3 methods are implemented
 * to return <code>null</code> or do nothing if called on.  Use
 * {@link #getRequest() getRequest} to retrieve the underlying HttpServletRequest
 * object and call on the 2.3 method there, the empty methods are here only
 * so that this will compile with the Servlet 2.3 jar.  This class exists temporarily
 * in the process() method of ActionServlet, just before the ActionForward is processed
 * and just after the Action is performed, the request is set back to the original
 * HttpServletRequest object.
 * 
 */
public class MultipartRequestWrapper implements HttpServletRequest
{

  /**
   * The parameters for this multipart request
   */
  protected Map parameters;

//+
  /**
   * Container for files parsed from the multipart data
   */
  private Map requestFiles;
  /**
   * Container for errors encountered during parsing of multipart data
   */
  private ArrayList requestParseErrors;
  
  /**
   * Default maximum file size
   */
  private static final int DEFAULT_MAX_POST_SIZE = 4 * 1024 * 1024;  // 4 Meg
//+

  /**
   * The underlying HttpServletRequest
   */
  protected HttpServletRequest request;

  public MultipartRequestWrapper(HttpServletRequest request) 
//+
    throws Exception
//+
  {
    this.request = request;
    this.parameters = new HashMap();

//+
//    Logger.debug(CNAME, "DEBUG - INSIDE MultipartRequestWrapper CONSTRUCTOR");

      parseMultipart(request,DEFAULT_MAX_POST_SIZE);
//+
  }

//+
  public MultipartRequestWrapper(HttpServletRequest request, int maxPostSize) throws Exception
  {
    this.request = request;
    this.parameters = new HashMap();

//    Logger.debug(CNAME, "DEBUG - INSIDE MultipartRequestWrapper CONSTRUCTOR");

    parseMultipart(request,maxPostSize);
  }

  public void setRequest(HttpServletRequest request) throws Exception
  {
    this.request = request;
  }
//+

  /**
   * Sets a parameter for this request.  The parameter is actually
   * separate from the request parameters, but calling on the
   * getParameter() methods of this class will work as if they weren't.
   */
/*
//-  public void setParameter(String name, String value) {
//-    String[] mValue = (String[]) parameters.get(name);
//-    if(mValue == null)
//-    {
//-      mValue = new String[0];
//-    }
//-    String[] newValue = new String[mValue.length + 1];
//-    System.arraycopy(mValue, 0, newValue, 0, mValue.length);
//-    newValue[mValue.length] = value;
//-
//-    parameters.put(name, newValue);
//-  }
*/

  /**
   * Sets a parameter for this request.  The parameter is actually
   * separate from the request parameters, but calling on the
   * getParameter() methods of this class will work as if they weren't.
   */
  public void setParameter(String name,String value)
  {
    if(parameters == null)
      parameters = new HashMap();
    ArrayList avalues = (ArrayList)parameters.get(name);
    if(avalues == null)
      parameters.put(name, avalues=new ArrayList());

    // Remove old values, use only the current one.
    avalues.clear();
    avalues.add(value);
  }

  /**
   * The parameter contains one and only one value.  Handles null values properly
   * before converting to String
   */
  public void setParameterAsString(String name,Object value)
  {
    if(value != null) value=value.toString();
    setParameter(name,(String)value);
  }

  /**
   * The parameter contains multiple values.
   */
  public void setParameterValues(String name,String [] values)
  {
    if(parameters == null)
      parameters = new HashMap();
    ArrayList avalues = (ArrayList)parameters.get(name);
    if(avalues == null)
      parameters.put(name, avalues=new ArrayList());

    // Remove old values, use only the current one.
    avalues.clear();
    avalues.addAll(java.util.Arrays.asList(values));
  }

  /**
   * Attempts to get a parameter for this request.  It first looks in the
   * underlying HttpServletRequest object for the parameter, and if that
   * doesn't exist it looks for the parameters retrieved from the multipart
   * request
   */
/*
//-  public String getParameter(String name) {
//-    String value = request.getParameter(name);
//-    if(value == null)
//-    {
//-      String[] mValue = (String[]) parameters.get(name);
//-      if((mValue != null) && (mValue.length > 0))
//-      {
//-        value = mValue[0];
//-      }
//-    }
//-    return value;
//-  }
*/
  
  /**
   * Attempts to get a parameter for this request.  It first looks in the
   * underlying HttpServletRequest object for the parameter, and if that
   * doesn't exist it looks for the parameters retrieved from the multipart
   * request
   */
  public String getParameter(String name)
  {
    String ret = null;

    ArrayList avalues = (ArrayList)parameters.get(name);
    if(avalues != null)
      ret = (String)avalues.get(0);

    if(ret != null)
      return ret;
    return request.getParameter(name);
  }

  /**
   * Returns the names of the parameters for this request.
   * The enumeration consists of the normal request parameter
   * names plus the parameters read from the multipart request
   */
  public Enumeration getParameterNames() {
    Enumeration baseParams = request.getParameterNames();
    Vector list = new Vector();
    while(baseParams.hasMoreElements())
    {
      list.add(baseParams.nextElement());
    }
    Collection multipartParams = parameters.keySet();
    Iterator iterator = multipartParams.iterator();
    while(iterator.hasNext())
    {
      list.add(iterator.next());
    }
    return Collections.enumeration(list);
  }

  public String[] getParameterValues(String name) {
    String[] value = request.getParameterValues(name);
    if(value == null)
    {
      ArrayList al = (ArrayList) parameters.get(name);
      if(al != null)
      {
        value = (String[])al.toArray(new String[al.size()]);
      }
//-      //value = (String[]) parameters.get(name);
    }
    return value;
  }

  /**
   * Returns the underlying HttpServletRequest for this wrapper
   */
  public HttpServletRequest getHttpServletRequest() {
    return request;
  }

  public ServletRequest getRequest() {
    return request;
  }

  //WRAPPER IMPLEMENTATIONS OF SERVLET REQUEST METHODS
  public Object getAttribute(String name) {
    return request.getAttribute(name);
  }
  public Enumeration getAttributeNames() {
    return request.getAttributeNames();
  }
  public String getCharacterEncoding() {
    return request.getCharacterEncoding();
  }
  public int getContentLength() {
    return request.getContentLength();
  }
  public String getContentType() {
    return request.getContentType();
  }
  public ServletInputStream getInputStream() throws IOException {
    return request.getInputStream();
  }
  public String getProtocol() {
    return request.getProtocol();
  }
  public String getScheme() {
    return request.getScheme();
  }
  public String getServerName() {
    return request.getServerName();
  }
  public int getServerPort() {
    return request.getServerPort();
  }
  public BufferedReader getReader() throws IOException {
    return request.getReader();
  }
  public String getRemoteAddr() {
    return request.getRemoteAddr();
  }
  public String getRemoteHost() {
    return request.getRemoteHost();
  }
  public void setAttribute(String name, Object o) {
    request.setAttribute(name, o);
  }
  public void removeAttribute(String name) {
    request.removeAttribute(name);
  }
  public Locale getLocale() {
    return request.getLocale();
  }
  public Enumeration getLocales() {
    return request.getLocales();
  }
  public boolean isSecure() {
    return request.isSecure();
  }
  public RequestDispatcher getRequestDispatcher(String path) {
    return request.getRequestDispatcher(path);
  }

  /**
   * @deprecated old  
   */
  public String getRealPath(String path) {
    return request.getRealPath(path);
  }

  //WRAPPER IMPLEMENTATIONS OF HTTPSERVLETREQUEST METHODS
  public String getAuthType() {
    return request.getAuthType();
  }
  public Cookie[] getCookies() {
    return request.getCookies();
  }
  public long getDateHeader(String name) {
    return request.getDateHeader(name);
  }
  public String getHeader(String name) {
    return request.getHeader(name);
  }
  public Enumeration getHeaders(String name) {
    return request.getHeaders(name);
  }
  public Enumeration getHeaderNames() {
    return request.getHeaderNames();
  }
  public int getIntHeader(String name) {
    return request.getIntHeader(name);
  }
  public String getMethod() {
    return request.getMethod();
  }
  public String getPathInfo() {
    return request.getPathInfo();
  }
  public String getPathTranslated() {
    return request.getPathTranslated();
  }
  public String getContextPath() {
    return request.getContextPath();
  }
  public String getQueryString() {
    return request.getQueryString();
  }
  public String getRemoteUser() {
    return request.getRemoteUser();
  }
  public boolean isUserInRole(String user) {
    return request.isUserInRole(user);
  }
  public Principal getUserPrincipal() {
    return request.getUserPrincipal();
  }
  public String getRequestedSessionId() {
    return request.getRequestedSessionId();
  }
  public String getRequestURI() {
    return request.getRequestURI();
  }
  public String getServletPath() {
    return request.getServletPath();
  }
  public HttpSession getSession(boolean create) {
    return request.getSession(create);
  }
  public HttpSession getSession() {
    return request.getSession();
  }
  public boolean isRequestedSessionIdValid() {
    return request.isRequestedSessionIdValid();
  }
  public boolean isRequestedSessionIdFromURL() {
    return request.isRequestedSessionIdFromURL();
  }
  /**
   * @deprecated old  
   */
  public boolean isRequestedSessionIdFromUrl() {
    return request.isRequestedSessionIdFromUrl();
  }

  public int getRemotePort()
  {
    return request.getRemotePort();
  }

  public String getLocalName()
  {
    return request.getLocalName();
  }

  public String getLocalAddr()
  {
    return request.getLocalAddr();
  }

  public int getLocalPort()
  {
    return request.getLocalPort();
  }

  //SERVLET 2.3 EMPTY METHODS
  /**
   * This method returns null.  To use any Servlet 2.3 methods,
   * call on getRequest() and use that request object.  Once Servlet 2.3
   * is required to build Struts, this will no longer be an issue.
   */
  public Map getParameterMap() {
    return null;
  }
  /**
   * This method does nothing.  To use any Servlet 2.3 methods,
   * call on getRequest() and use that request object.  Once Servlet 2.3
   * is required to build Struts, this will no longer be an issue.
   */
  public void setCharacterEncoding(String encoding) {
    ;
  }
  /**
   * This method returns null.  To use any Servlet 2.3 methods,
   * call on getRequest() and use that request object.  Once Servlet 2.3
   * is required to build Struts, this will no longer be an issue.
   */
  public StringBuffer getRequestURL() {
    return null;
  }
  /**
   * This method returns false.  To use any Servlet 2.3 methods,
   * call on getRequest() and use that request object.  Once Servlet 2.3
   * is required to build Struts, this will no longer be an issue.
   */
  public boolean isRequestedSessionIdFromCookie() {
    return false;
  }


//+
/*
//-  private void setRequestParams(HashMap params)
//-  {
//-    Set keys = params.keySet();
//-    
//-    Iterator iterator =  keys.iterator();
//-
//-    while(iterator.hasNext())
//-    {
//-      String key = (String)iterator.next();
//-
//-      setParameter(key, (String)params.get(key));
//-    }
//-  }  
*/

  private void setRequestParams(HashMap params) {
    parameters = params;
  }
  public void setRequestFiles(Map files)
  {
    requestFiles = files;
  }

  public Map getRequestFiles()
  {
    return requestFiles;
  }

  public String[] getRequestFileNames()
  {
    if(requestFiles == null)
    {
      return new String[0];
    }
    
    Set keys = requestFiles.keySet();    
    Iterator iterator =  keys.iterator();
    String[] fileNames = new String[requestFiles.size()];

    int i = 0;
    while(iterator.hasNext())
    {
      fileNames[i] = (String)iterator.next();
      i++;
    }
    return fileNames;
  }

  public byte[] getRequestFile(String name)
  {
    if(requestFiles == null)
      return null;
    return(byte[])requestFiles.get(name);
  }

  public String[] getParseErrors()
  {    
    if(requestParseErrors == null)
    {
//      Logger.debug(CNAME, "requestParseErrors == null");
      return new String[0];
    }
      
    Iterator iterator =  requestParseErrors.iterator();
    String[] errorMsgs = new String[requestParseErrors.size()];

//    Logger.debug(CNAME, "requestParseErrors.size()"+requestParseErrors.size());

    int i = 0;
    while(iterator.hasNext())
    {      
      errorMsgs[i] = (String)iterator.next();
      
//      Logger.debug(CNAME, "Add error message: "+errorMsgs[i]);
      i++;
    }
    return errorMsgs;
  }

  public boolean isParseOk()
  {
    //if we created a collection for parse errors, things did not go so well
    return (requestParseErrors == null);
  }


  void parseMultipart(HttpServletRequest request, int maxPostSize) throws IOException
  {
    HashMap params = new HashMap();
    HashMap files = new HashMap();

    //MultipartParser parser = new MultipartParser(request,10000000);
    MultipartParser parser = new MultipartParser(request,20000000, true, false);
    com.oreilly.servlet.multipart.Part part;  // Part is in javax.mail also
    while((part = parser.readNextPart()) != null)
    {
      String name = part.getName();

      // Keep an ArrayList (KEEP THE ORDER!) of values.
      ArrayList avalues = (ArrayList)params.get(name);
      if(avalues == null)
      {
        params.put(name, avalues = new ArrayList());
      }

      if(part.isParam())
      {
        // It's a parameter part, add it to the values
        ParamPart paramPart = (ParamPart) part;
        String value = paramPart.getStringValue();
        //params.put(name,value);
        avalues.add(value);
      }
      else if(part.isFile())
      {
        // It's a file part
        FilePart filePart = (FilePart) part;
        String fileName = filePart.getFileName();
        if(fileName != null)
        {
          ByteArrayOutputStream st = new ByteArrayOutputStream(60*1024);

          // The part actually contained a file
          filePart.writeTo(st);
          /** @todo Make the file container take multiple files for the same parameter **/
          files.put(name, st.toByteArray());
          //params.put(name,fileName);
          avalues.add(fileName);
        }
        else
        {
          // The field did not contain a file
          files.put(name, null);
          avalues.add(null);
        }
      }
      setRequestParams(params);
      setRequestFiles(files);
    }
  }

/*
//-  void parseMultipart(HttpServletRequest request, int maxPostSize) throws Exception
//-  {
//-    requestParseErrors = null;
//-    try
//-    {
//-      HashMap params = new HashMap();
//-      HashMap files = new HashMap();
//-      
//-      MultipartParser parser = new MultipartParser(request,maxPostSize);
//-      Part part;
//-      while((part = parser.readNextPart()) != null)
//-      {
//-        String name = part.getName();
//-        if(part.isParam())
//-        {
//-          // It's a parameter part, add it to the values
//-          ParamPart paramPart = (ParamPart) part;
//-          String value = paramPart.getStringValue();
//-          params.put(name,value);
//-        }
//-        else if(part.isFile())
//-        {
//-          try
//-          {
//-            // It's a file part
//-            FilePart filePart = (FilePart) part;
//-            String fileName = filePart.getFileName();
//-            if(fileName != null)
//-            {
//-              ByteArrayOutputStream st = new ByteArrayOutputStream();          
//-
//-              // The part actually contained a file
//-              filePart.writeTo(st);
//-              files.put(name, st.toByteArray());
//-              params.put(name,fileName);
//-            }
//-            else
//-            {
//-              // The field did not contain a file
//-              files.put(name, null);
//-            }
//-          }
//-          catch (IOException ioex)
//-          {
//-            Logger.debug(CNAME, "I/O exception trying to parse file: "+ioex);
//-          }
//-        }
//-      }
//-      setRequestParams(params);
//-      setRequestFiles(files);
//-    }
//-    catch (Exception ex)
//-    {
//-      requestParseErrors = new ArrayList();
//-      requestParseErrors.add(ex.toString());
//-    }
//-  }
*/
//+
}
