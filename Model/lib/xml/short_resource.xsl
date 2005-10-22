<?xml version="1.0" ?>
<xsl:stylesheet 
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      version="1.0">
  <xsl:output method="xml" /> 
  <xsl:template match="/">
    <xmlAnswer>
      <xsl:for-each select="resourcesPipeline/resource">
        <record>
          <xsl:attribute name="recordID">
            <xsl:value-of select="@resource"/>
          </xsl:attribute>
          <xsl:element name="attribute">
            <xsl:attribute name="attributeFieldRef">resource</xsl:attribute>
            <xsl:attribute name="value">
              <xsl:value-of select="@resource"/>
            </xsl:attribute>
          </xsl:element>
          <xsl:element name="attribute">
            <xsl:attribute name="attributeFieldRef">version</xsl:attribute>
            <xsl:attribute name="value">
              <xsl:value-of select="@version"/>
            </xsl:attribute>
          </xsl:element>
          <xsl:element name="attribute">
            <xsl:attribute name="attributeFieldRef">url</xsl:attribute>
            <xsl:attribute name="value">
              <xsl:value-of select="@url"/>
            </xsl:attribute>
          </xsl:element>
        </record>
      </xsl:for-each>
    </xmlAnswer>
  </xsl:template>
</xsl:stylesheet>