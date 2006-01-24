<?xml version="1.0" ?>
<xsl:stylesheet 
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      version="1.0">
  <xsl:output method="xml" /> 
  <xsl:template match="/rss">
    <xmlAnswer>
      <xsl:for-each select="channel/item">
        <record>
          <xsl:element name="attribute">
            <xsl:attribute name="name">headline</xsl:attribute>
            <xsl:value-of select="title"/>
          </xsl:element>
          <xsl:element name="table">
            <xsl:attribute name="name">relatedLinks</xsl:attribute>
            
            <xsl:element name="row">
              <xsl:attribute name="name">headline</xsl:attribute>
              <xsl:element name="attribute">
                <xsl:attribute name="name">displayName</xsl:attribute>
                <xsl:value-of select="description"/>
              </xsl:element>
              <xsl:element name="attribute">
                <xsl:attribute name="name">url</xsl:attribute>
                <xsl:value-of select="link"/>
              </xsl:element>
            </xsl:element>
          </xsl:element>
          <xsl:element name="attribute">
            <xsl:attribute name="name">item</xsl:attribute>
            <xsl:value-of select="description"/>
          </xsl:element>
          <xsl:element name="attribute">
            <xsl:attribute name="name">date</xsl:attribute>
            <xsl:value-of select="pubDate"/>
          </xsl:element>
        </record>
      </xsl:for-each>
    </xmlAnswer>
  </xsl:template>
</xsl:stylesheet>