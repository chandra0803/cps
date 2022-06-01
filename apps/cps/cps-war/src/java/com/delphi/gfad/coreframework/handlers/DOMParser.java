package com.delphi.gfad.coreframework.handlers;

import java.io.*;
import java.util.*;
import org.xml.sax.*;
import org.xml.sax.helpers.*;

// Imported DOM classes
import org.w3c.dom.Document;
import org.w3c.dom.DocumentFragment;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.w3c.dom.Element;
import org.w3c.dom.Text;

/** DOMParser
 *
 *  Implements parsing an XML document using the SAX 2.0 Interface
 */

public class DOMParser extends DefaultHandler
{
  private Element parentNode;
  private Document parentDocument;
  private Element currentNode;
  private StringBuffer currentNodeValue = new StringBuffer();

  /** Called to parse the XML document and append all contents to the Element parentNode.
   *
   *  @exception Exception if an error occurs.
  */

  public void parseAppend(Element parentNode, java.io.Reader source) throws Exception
  {
    this.parentNode = parentNode;
    this.currentNode = parentNode;
    this.parentDocument = parentNode.getOwnerDocument();
    parse(source);
  }

  /** Called to parse the XML document in the Reader source.
   *
   *  @exception Exception if an error occurs.
  */

  private void parse(java.io.Reader source) throws Exception
  {
    try
    {
      InputSource input = new InputSource(source);
      javax.xml.parsers.SAXParser parser = javax.xml.parsers.SAXParserFactory.newInstance().newSAXParser();
      parser.parse(input,this);
    }
    catch(Exception e)
    {
      this.endDocument();
//      Logger.error(CNAME, "Exception in parse", e);
      throw e;
    }
  }

  /** Called to set the text value of an elementMain method for testing class.
   *
   *  @exception SAXException if an error occurs.
  */

  private void setNodeValue(Element currNode) throws SAXException
  {
    if (currentNodeValue.length() > 0)
    {
      if (currentNode.getFirstChild() == null)
      {
        String val = currentNodeValue.toString().trim();
        if (val.length() > 0)
        {
          Text text = (Text)parentDocument.createTextNode(val);
          currentNode.appendChild(text);
        }
        currentNodeValue = new StringBuffer();
      }
    }
  }

  /** Called when the start of an XML Document is encountered.
   *
   *  @exception SAXException if a parse error occurs.
  */

  public void characters(char[] ch, int start, int length) throws SAXException
  {
    if (length > 0)
      currentNodeValue.append(ch,start,length);
  }

  /** Called when the start of an XML Document is encountered.
   *
   *  @exception SAXException if a parse error occurs.
  */

  public void startDocument() throws SAXException
  {
  }

  /** Called when a start element of an XML Document is encountered.
   *
   *
   *
   *  @exception SAXException if a parse error occurs.
  */

  public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
  {
    currentNodeValue = new StringBuffer();
    org.w3c.dom.Element e = (org.w3c.dom.Element)parentDocument.createElement(qName);
    for(int i=0; i<attributes.getLength(); i++)
    {
      e.setAttribute(attributes.getQName(i),attributes.getValue(i));
    }
    currentNode.appendChild(e);
    setNodeValue(currentNode);
    currentNode = e;
  }

  /** Called when an end element of an XML Document is encountered.
   *
   *  Set Text Data on the Element if any exists.  Set the current node back to this nodes parent.
   *
   *  @exception SAXException if a parse error occurs.
  */

  public void endElement(String uri, String localName, String qName) throws SAXException
  {
    setNodeValue(currentNode);
    currentNode = (org.w3c.dom.Element)currentNode.getParentNode();
  }

  /** Called when the end of an XML Document is encountered.
   *
   *  @exception SAXException if a parse error occurs.
  */

  public void endDocument() throws SAXException
  {
  }

  /** Called when an error occurs parsing the XML Document.
   *
   *  @exception SAXException if a parse error occurs.
  */

  public void error(SAXParseException e) throws SAXException
  {
  }

}

