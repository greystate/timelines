<?xml version="1.0" encoding="utf-8" ?>
<!--
	File: build-curler.xslt
	Author: Chriztian Steinmeier, <chriztian[at]steinmeier.dk>

	Creates a list of curl commands for hitting the W3C API to get
	the specifications' version history as XML files.

	This is invoked from the `build.sh` script.

-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:output method="text" indent="no" omit-xml-declaration="yes" />
	
	<xsl:param name="directory" select="'api-outputs/'" />
	<xsl:param name="api-key" />

	<xsl:variable name="api-base" select="'https://api.w3.org'" />
	<xsl:variable name="q">&quot;</xsl:variable>
	
	<xsl:template match="specifications">
		<xsl:apply-templates select="specification" />
	</xsl:template>

	<xsl:template match="specification">
		<xsl:value-of select="concat('curl -o ', $directory, 'spec-', @shortname, '.xml')" />
		<xsl:value-of select="concat(' ', $q, $api-base, '/specifications/', @shortname, '/versions?_format=xml&amp;embed=1&amp;apikey=', $api-key, $q)" />
		<xsl:text>&#10;</xsl:text>
	</xsl:template>

</xsl:stylesheet>