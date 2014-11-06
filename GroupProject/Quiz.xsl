<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
 
<xsl:template match="Quiz">
  
      <xsl:for-each select="Questions/MultipleChoice/Question">
      
        <xsl:value-of select="Questi"/>
        <br/>
        
          
        <xsl:for-each select="Options/Option">
          <input type="radio" name="radio-choice" id="radio-choice-{position()}"  />
           <label for="radio-choice-{position()}"><xsl:value-of select="text"/></label>
          <xsl:value-of select="text()"/>
          <br/>
        </xsl:for-each>
        

          
        
        
        <br/>
        <br/>
        <hr/>
       
 
        
      
      </xsl:for-each>
      
</xsl:template>
</xsl:stylesheet>