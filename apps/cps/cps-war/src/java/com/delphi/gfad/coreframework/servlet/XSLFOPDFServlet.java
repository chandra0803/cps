/**
 * XSLFOPDFServlet
 *
 *            driver.setRenderer(org.apache.fop.apps.Driver.RENDER_XML);
 *            driver.setRenderer(org.apache.fop.apps.Driver.RENDER_TXT);
 *            driver.setRenderer(org.apache.fop.apps.Driver.RENDER_SVG);
 */

package com.delphi.gfad.coreframework.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import org.xml.sax.InputSource;


public class XSLFOPDFServlet extends HttpServlet
{
  private String fopConfigFile = "";
  private ServletContext servletContext;

  public void init(ServletConfig config) throws ServletException
  {
    servletContext = config.getServletContext();

    String initParamVal = config.getInitParameter("FOPConfigFile");
    if (initParamVal != null)
    {
      fopConfigFile = initParamVal;
    }

  }

  public void doPost(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException
  {
    doGet(request, response);
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
  {
    if (request.getContentLength() > 0)
    { 
      response.setContentType("application/pdf");

      String xslfo = request.getParameter("xslfo");
      
      if (xslfo == null)
      {
        BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream()));

        StringBuffer sb = new StringBuffer();
        String inLine;
        while((inLine = in.readLine()) != null)
        {
          sb.append(inLine); 
        }
        xslfo = sb.toString(); 
      }
     
      System.out.println("\n----------------------------");
      System.out.println("----- PDF Servlet ----------");
      System.out.println("----------------------------");
      System.out.println("Input: \n");
      System.out.println(xslfo);

      InputSource is = new InputSource(new StringReader(xslfo));

      ByteArrayOutputStream outputBuffer = new ByteArrayOutputStream(8096);

      try
      {
        InputStream fopOtionsInputStream = servletContext.getResourceAsStream(fopConfigFile);
        if (fopOtionsInputStream == null)
        {
          ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
          fopOtionsInputStream = classLoader.getResourceAsStream(fopConfigFile);
        }  
        org.apache.fop.apps.Options userConfig = new org.apache.fop.apps.Options(fopOtionsInputStream);

        org.apache.fop.apps.Driver driver = new org.apache.fop.apps.Driver(is,outputBuffer);
        org.apache.avalon.framework.logger.Logger logger = new org.apache.avalon.framework.logger.ConsoleLogger(org.apache.avalon.framework.logger.ConsoleLogger.LEVEL_INFO);
        org.apache.fop.messaging.MessageHandler.setScreenLogger(logger);
        driver.setLogger(logger);
        driver.setRenderer(org.apache.fop.apps.Driver.RENDER_PDF);
        driver.run();
      }
      catch(Exception ex)
      {
        System.out.println("Caught Exception in FOP: "+ex);
        throw new ServletException(ex);
      }

      byte[] content = outputBuffer.toByteArray();
      response.setContentLength(content.length);
      response.getOutputStream().write(content);
      response.getOutputStream().flush();

      System.out.println("----------------------------");
      System.out.println("Output: \n");
      System.out.println(new String(content));
      System.out.println("----------------------------");
      System.out.println("----------------------------");
    }
    else
    {
      StringBuffer sb = new StringBuffer();

      sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
      sb.append("<error>content length = 0</error>");

      PrintWriter out = new PrintWriter(new BufferedWriter(response.getWriter()));
      out.write(sb.toString()); 
      out.flush();
    }
  }
}
