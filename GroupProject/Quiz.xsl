<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="urn:Question-Schema">
<<<<<<< HEAD
 
<xsl:template match="/t:Quiz">
  <div >
    <xsl:for-each select="t:Questions/t:MultipleChoice/t:Question">
      <xsl:value-of select="@ID"/>
      <br/>
      <xsl:value-of select="t:Questi"/>
      <br/>
      <xsl:for-each select="t:Options/t:Option">
        <panel>
          <input type="radio" name="radio-choice" id="SelectedChoice{position()}" value="true"/>
          <label for="SelectedChoice{position()}">
            <xsl:value-of select="text"/>
          </label>
          <xsl:value-of select="text()"/>
=======

  <xsl:template match="/t:Quiz">
    <div >
      <xsl:for-each select="t:Questions/t:MultipleChoice/t:Question">
        <div class="Question">
          <xsl:value-of select="t:Questi"/>
>>>>>>> origin/master
          <br/>
          <xsl:for-each select="t:Options/t:Option">
            <form class="options">
              <xsl:if test="@Correct">
                <input class="option" type="radio" name="radio-choice" id="SelectedChoice{position()}"  value="1" />
              </xsl:if>
              <xsl:if test="not(@Correct)">
                <input class="option" type="radio" name="radio-choice" id="SelectedChoice{position()}" value="0" />
              </xsl:if>
              <label for="SelectedChoice{position()}">
                <xsl:value-of select="text"/>
              </label>
              <xsl:value-of select="text()"/>
              <br/>
            </form>
          </xsl:for-each>
          <br/>
          <br/>
          <hr/>
        </div>
      </xsl:for-each>
<<<<<<< HEAD
      <br/>
      <br/>
      <hr/>
    </xsl:for-each> 
    
  </div>
</xsl:template>
</xsl:stylesheet>

=======
    </div>
  </xsl:template>
</xsl:stylesheet>
>>>>>>> origin/master
