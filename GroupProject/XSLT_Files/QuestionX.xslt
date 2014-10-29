<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns="urn:Question-Schema"
>

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="*">
    <xsl:element name="{local-name()}">
      <!-- Work through attributes -->
      <xsl:for-each select="@*">
        <!-- Remove any attribute prefixes -->
        <xsl:attribute name="{local-name()}">
          <xsl:value-of select="."/>
        </xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
