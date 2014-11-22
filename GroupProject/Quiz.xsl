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
            <xsl:variable name="UserAnswer" select="t:UserAnswer"></xsl:variable>
            <panel class="options">
              <xsl:for-each select="t:Options/t:Option">
                <xsl:variable name="OptionText" select="text()"/>
                <xsl:if test="@Correct">
                  <input class="option" type="radio" name="Question{$QuestionID}" id="{position()}" value="1" >
                    <xsl:if test="$OptionText =$UserAnswer">
                      <xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:if>
                  </input>
                </xsl:if>
                <xsl:if test="not(@Correct)">
                  <input class="option" type="radio" name="Question{$QuestionID}" id="{position()}" value="0" >
                    <xsl:if test="$OptionText =$UserAnswer">
                      <xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:if>
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
        <!--TrueFalse-->
        <xsl:for-each select="t:Questions/t:TrueFalse/t:Question">
          <xsl:variable name="QuestionID" select="@ID"></xsl:variable>
          <xsl:variable name="CorrectAnswer" select="t:Answer"></xsl:variable>
          <div class="Question">
            <xsl:value-of select="t:Questi"/>
            <br/>
            <xsl:variable name="UserAnswer" select="t:UserAnswer"></xsl:variable>
            <panel class="options">
              <xsl:if test="$CorrectAnswer ='True'">
                <input class="option" type="radio" name="Question{$QuestionID}" id="True" value="1" >
                  <xsl:if test="$UserAnswer = 'True'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:if>
                True</input>
                <input class="option" type="radio" name="Question{$QuestionID}" id="False" value="0" >
                  <xsl:if test="$UserAnswer = 'False'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:if>
                  False
                </input>
              </xsl:if>
              <xsl:if test="$CorrectAnswer ='False'">
                <input class="option" type="radio" name="Question{$QuestionID}" id="True" value="0" >
                  <xsl:if test="$UserAnswer = 'True'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:if>
                  True
                </input>
                <input class="option" type="radio" name="Question{$QuestionID}" id="False" value="1" >
                  <xsl:if test="$UserAnswer = 'False'">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:if>
                  False
                </input>
              </xsl:if>
            </panel>
          
          </div>
        </xsl:for-each>
        
      <!--fillIn-->
        <xsl:for-each select="t:Questions/t:FillBlanks/t:Question">
          <xsl:variable name="QuestionID" select="@ID"></xsl:variable>

          <div class="Question">
            <xsl:value-of select="t:Questi"/>
            <xsl:variable name="BlankToDropDown" select="________________"></xsl:variable>
            <SELECT name ="Answers">
              <OPTION VALUE ="{t:Option}">
                -Select your answer
              </OPTION>
              <xsl:for-each select="t:Options/t:Option">
                <xsl:variable name="OptionText" select="text()"/>
                
                <xsl:choose>
                  <xsl:when test="@Correct">
                    <OPTION VALUE ="1" name="Question{$QuestionID}" id="{position()}">
                      <xsl:value-of select="$OptionText"/>
                    </OPTION>
                  </xsl:when>
                  <xsl:otherwise>
                    <OPTION VALUE ="0" name="Question{$QuestionID}" id="{position()}">
                      <xsl:value-of select="$OptionText"/>
                    </OPTION>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:for-each>
            </SELECT>
            <br/>
            
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>