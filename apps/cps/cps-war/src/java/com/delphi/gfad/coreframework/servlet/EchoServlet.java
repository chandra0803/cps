/**
 * EchoServlet
 *
 */

package com.delphi.gfad.coreframework.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class EchoServlet extends HttpServlet
{
  public void init()
  {
  }

  public void doPost(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException
  {
    doGet(request, response);
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
  {
    if (request.getContentLength() > 0)
    { 
      BufferedReader in = new BufferedReader(new InputStreamReader(request.getInputStream()));
      String inLine;
      while((inLine = in.readLine()) != null)
      {
        System.out.println("--> "+inLine);
      }
    }

    StringBuffer sb = new StringBuffer();

    sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
    sb.append("<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n");
    sb.append("  <soapenv:Header>\n");
    sb.append("    <wsu:Timestamp xmlns:wsu=\"http://schemas.xmlsoap.org/ws/2002/07/utility\">\n");
    sb.append("      <wsu:Created>\n");
    sb.append("      2004-07-29T09:11:18Z\n");
    sb.append("      </wsu:Created>\n");
    sb.append("      <wsu:Expired>\n");
    sb.append("      2004-07-29T09:15:18Z\n");
    sb.append("      </wsu:Expired>\n");
    sb.append("    </wsu:Timestamp>\n");
    sb.append("  </soapenv:Header>\n");
    sb.append("  <soapenv:Body>\n");
    sb.append("    <XStatusResponse xmlns=\"http://www.delphiauto.net/ns/gfad/#dsi\">\n");
    sb.append("      <XStatusResult>xml</XStatusResult>\n");
    sb.append("    </XStatusResponse>\n");
    sb.append("  </soapenv:Body>\n");
    sb.append("</soapenv:Envelope>\n");

    PrintWriter out = new PrintWriter(new BufferedWriter(response.getWriter()));
    out.write(sb.toString()); 
    out.flush();
  }
}
