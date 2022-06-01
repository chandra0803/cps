<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="text" indent="no" media-type="text/plain"/>

<xsl:variable name="parentClassExtension" select="'ImplBase'"/>

<xsl:template match="/">
<xsl:variable name="className" select="/BusinessObject/@name"/>
<xsl:variable name="parentClassName" select='concat(/BusinessObject/@name,$parentClassExtension)'/>
/**
 *
 * Class: <xsl:value-of select="$className"/>
 *
 * This is a generated extension Class for modification.
 **/

package <xsl:value-of select="/BusinessObject/@package"/>;

import java.sql.*;
import org.apache.commons.logging.*;

<xsl:if test="/BusinessObject/Overview">
/** 
This class provides a subclass for the implementation base object.  
All business object extentions should be done in this class.  
<xsl:value-of select="/BusinessObject/Overview"/>
*/
</xsl:if>
public class <xsl:value-of select="$className"/> extends <xsl:value-of select="$parentClassName"/> 
{
  /**
  * Defines the static logging object reference.
  */
  private static Log log = LogFactory.getLog(<xsl:value-of select="$className"/>.class);

  /**
  * Public no-arg Business Object constructor
  */
  public <xsl:value-of select="$className"/>()
  {
  }
}

</xsl:template>

</xsl:stylesheet>
