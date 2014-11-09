<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:t="urn:Question-Schema">

  <xsl:template match="/t:Quiz">
    <div >
      <xsl:for-each select="t:Questions/t:MultipleChoice/t:Question">
        <div class="Question">
          <xsl:value-of select="t:Questi"/>
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
    </div>
  </xsl:template>
</xsl:stylesheet>