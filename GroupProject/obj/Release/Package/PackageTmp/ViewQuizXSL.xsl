<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <HTML>
      <BODY>
        <TABLE BORDER="1">
          <TR>
            <TD>Multiple Choice</TD>
            <TD>Fill in the Blanks</TD>
            <TD>True or False</TD>
            <TD>Long Answers</TD>
          </TR>
          <xsl:for-each select="Quiz/Questions">
            <TR>
              <TD>
                <xsl:value-of select="Questi"/>
              </TD>
              <TD>
                <xsl:value-of select="Last"/>
              </TD>
              <TD>
                <xsl:value-of select="Phone"/>
              </TD>
            </TR>
          </xsl:for-each>
        </TABLE>
      </BODY>
    </HTML>
  </xsl:template>
</xsl:stylesheet>