package com.delphi.gfad.coreframework.util;

import java.util.*;
import java.io.*;

import org.apache.xerces.parsers.DOMParser;
import org.w3c.dom.*;
import org.xml.sax.*;
import org.apache.xml.serialize.*;
import org.w3c.dom.traversal.NodeIterator;

import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;


public class XMLUtils
{

  public static String serialize(Node node) throws Exception
  {
    return serialize(node, true);
  }

  public static String serialize(Node node, boolean doIndent) throws Exception
  {
    StringWriter sw = new StringWriter();
    try
    {
       TransformerFactory tfactory = TransformerFactory.newInstance(); 
       // This creates a transformer that does a simple identity transform, 
       // and thus can be used for all intents and purposes as a serializer.
       Transformer serializer = tfactory.newTransformer();
      if ( doIndent )
      {
       serializer.setOutputProperty(OutputKeys.INDENT, "yes");
      }
       serializer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");

       serializer.transform(new DOMSource(node), new StreamResult(sw));
    }
    catch (Exception e)
    {
//      Logger.error(CNAME, "Exception in serialize(): ", e);
      //e.printStackTrace();
    }

    return sw.toString();
  }

  public static String escapeSpecialCharacters(String val)
  {
    if(val == null) return null;

    char c;
    int index = 0;

    StringBuffer sb = new StringBuffer(val.length());
    while(true)
    {
      try
      {
        c = val.charAt(index);
        if(c == '<')
          sb.append("&lt;");
        else if(c == '>')
          sb.append("&gt;");
        else if(c == '&')
          sb.append("&amp;");
        else if(c == '\'')
          sb.append("&apos;");
        else if(c == '"')
          sb.append("&quot;");
        else if(c == '%')
          sb.append("&perc;");
        else
          sb.append(c);
        index++;
      }
      catch(Exception ex)
      {
        break;
      }
    }
    return sb.toString();
  }
}
