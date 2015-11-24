<?xml version="1.0" encoding="utf-8" ?>
<!--
	File: transform-spec.xslt
	Author: Chriztian Steinmeier, <chriztian[at]steinmeier.dk>
	
	Spawned by [this tweet from @meyerweb](https://twitter.com/meyerweb/status/668856592553656321)...
	
	Renders a timeline for W3C Specifications, like the ones Eric Meyer have
	created for CSS modules in [CSS Module Timelines](http://meyerweb.com/eric/css/timelines/).

	The XML data for a specification's versions can be returned from the W3C API using a
	request like this:

		GET /specifications/css3-mediaqueries/versions?apikey=<API_KEY>&_format=xml&page=1&items=10&embed=1

	Note:  
	At the time of writing (November 2015) I couldn't get the `document()` function to load the actual API
	requests with `xsltproc`, so I wrote a bash script using multiple `curl` commands to fetch the specs to
	local XML files, which are then processed by this stylesheet.
	
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns:make="http://exslt.org/common"
	exclude-result-prefixes="make date"
>

	<xsl:output method="html"
		indent="yes"
		doctype-system="about:legacy-compat"
	/>

	<!-- You MUST provide your API key to get any results -->
	<xsl:param name="apikey" />
	
	<xsl:variable name="api-base" select="'https://api.w3.org/'" />

	<xsl:template match="/">
		<html>
		<head>
			<link rel="stylesheet" href="timelines.css" />
		</head>
		<body>

		<div id="tl">
			<xsl:apply-templates select="specifications" />
		</div>
		
		</body>
		</html>
	</xsl:template>

	<xsl:template match="specifications">
		<table id="lines" summary="{summary}">
			<xsl:apply-templates select="specification" />
		</table>
	</xsl:template>
	
	<xsl:template match="specification">
		<xsl:variable name="request" select="concat($api-base, 'specifications/', @shortname, '/versions?_format=xml&amp;embed=1&amp;apikey=', $apikey)" />
		<xsl:variable name="local-file" select="concat('api-outputs/spec-', @shortname, '.xml')" />
		
		<!--
		Using local files for now - replace `$local-file` with `$request` to use actual lookup,
		if your processor supports https:// with the `document()` function. -->
		<xsl:variable name="data" select="document($local-file)" />
		
		<tr>
			<th><xsl:value-of select="title" /></th>
			<td>
				<ul>
					<xsl:apply-templates select="$data/collection/version-history/specVersion">
						<xsl:sort select="date" data-type="text" order="ascending" />
					</xsl:apply-templates>
				</ul>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="specVersion">
		<xsl:variable name="year" select="substring(date, 1, 4)" />
		<xsl:variable name="month" select="substring(date, 6, 2)" />
		<xsl:variable name="date" select="substring(date, 9, 2)" />
		<xsl:variable name="monthname" select="date:month-name(date)" />
		<li class="y{$year} m{$month}">
			<a href="{uri}" title="{$date} {$monthname} {$year}">
				<xsl:value-of select="title" />
			</a>
		</li>
	</xsl:template>

</xsl:stylesheet>
