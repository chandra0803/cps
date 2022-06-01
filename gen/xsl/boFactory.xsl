<?xml version="1.0"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="text" indent="no" media-type="text/plain"/>

<xsl:variable name="classExtension" select="'Factory'"/>
<xsl:variable name="parentClassExtension" select="'FactoryImplBase'"/>

<xsl:template match="/">
<xsl:variable name="className" select='concat(/BusinessObject/@name,$classExtension)'/>
<xsl:variable name="parentClassName" select='concat(/BusinessObject/@name,$parentClassExtension)'/>
<xsl:variable name="boClassName" select="/BusinessObject/@name"/>
/**
 *
 * Class: <xsl:value-of select="$className"/>
 *
 * This is a generated extension Class for modification.
 **/

package <xsl:value-of select="/BusinessObject/@package"/>;

import org.apache.commons.logging.*;

<xsl:if test="/BusinessObject/Overview">
/** 
This class provides a subclass for the implementation base factory.  
All factory extentions should be done in this class.    
<xsl:value-of select="/BusinessObject/Overview"/>
All public methods and objects are static, so no instance object is necessary.
*/
</xsl:if>
public class <xsl:value-of select="$className"/> extends <xsl:value-of select="$parentClassName"/> 
{
  /**
  * Defines the logging object reference.
  */
  private Log log = LogFactory.getLog(<xsl:value-of select="$className"/>.class);

  private static <xsl:value-of select="$className"/> _instance = new <xsl:value-of select="$className"/>();

  /**
  * Protected no-arg Business Object constructor.  Since these factories are stateless, 
  * the factories can be accessed as singletons.
  */
  protected <xsl:value-of select="$className"/>()
  {
    super();
  }

  public static <xsl:value-of select="$className"/> getInstance()
  {
    return _instance;
  }
}
</xsl:template>

</xsl:stylesheet>
