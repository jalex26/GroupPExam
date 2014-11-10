<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="urn:Question-Schema">

  <xsl:template match="/t:Quiz">
    <html>
      <body>
      <xsl:for-each select="t:Questions/t:MultipleChoice/t:Question">
        <xsl:variable name="QuestionID" select="@ID"></xsl:variable>
        <div class="Question">
          <xsl:value-of select="t:Questi"/>
          <br/>
          <panel class="options">
          <xsl:for-each select="t:Options/t:Option">
            
              <xsl:if test="@Correct">
                <input class="option" type="radio" name="Question{$QuestionID}" id="Choice{position()}"  value="1" >
                </input>
              </xsl:if>
              <xsl:if test="not(@Correct)">
                <input class="option" type="radio" name="Question{$QuestionID}" id="Choice{position()}" value="0" >
                </input>
              </xsl:if>
              <label for="SelectedChoice{position()}">
                <xsl:value-of select="text"/>
              </label>
              <xsl:value-of select="text()"/>
              <br/>
            
          </xsl:for-each>
          </panel>
        </div>
      </xsl:for-each>
    </body>
    </html>
  </xsl:template>
</xsl:stylesheet>