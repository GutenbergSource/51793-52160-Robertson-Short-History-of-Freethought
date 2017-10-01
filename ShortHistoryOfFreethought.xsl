<!DOCTYPE xsl:stylesheet [

    <!ENTITY ndash "&#x2013;">
    <!ENTITY mdash "&#x2014;">
    <!ENTITY euml "&#x00EB;">
    <!ENTITY aacute "&#x00E1;">
    <!ENTITY tdotb "&#x1E6D;">

]>
<xsl:transform
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:f="urn:stylesheet-functions"
    exclude-result-prefixes="f xs"
    version="2.0">


<xsl:include href="merge-documents.xsl"/>


<xsl:variable name="volume1" select="f:import-document('Volume 1/ShortHistoryOfFreethought1.xml', 'v1', 'v2')"/>
<xsl:variable name="volume2" select="f:import-document('Volume 2/ShortHistoryOfFreethought2.xml', 'v2', 'v1')"/>


<xsl:template match="/">
    <TEI.2 lang="en">
    <teiHeader>
        <fileDesc>
            <titleStmt>
                <title>A Short History of Freethought Ancient and Modern</title>
                <author key="Robertson, John Mackinnon" ref="https://viaf.org/viaf/7479661">John Mackinnon Robertson (1856&ndash;1933)</author>
                <respStmt><resp>Transcription</resp> <name>Jeroen Hellingman</name></respStmt>
            </titleStmt>
            <publicationStmt>
                <publisher>Project Gutenberg</publisher>
                <pubPlace>Urbana, Illinois, USA.</pubPlace>
                <idno type="OLN">OL7047848M</idno>
                <idno type="OLW">OL107585W</idno>
                <idno type="OCLC">3369394</idno>
                <idno type="PGclearance">20150830105501robertson</idno>
                <idno type="PGSrc">51793-52160-Robertson-Short-History-of-Freethought</idno>
                <idno type="epub-id">urn:uuid:7c100db3-2477-48fc-b743-ee29d31c6c5a</idno>
                <idno type="PGnum">#####</idno>
                <date>#####</date>

                <xsl:apply-templates select="$volume1/teiHeader/fileDesc/publicationStmt/availability"/>

            </publicationStmt>
            <sourceDesc>
                <bibl>
                    <author>John M. Robertson</author>
                    <title>A Short History of Freethought Ancient and Modern</title>
                    <date>1915</date>
                </bibl>
            </sourceDesc>
        </fileDesc>

        <xsl:apply-templates select="$volume1/teiHeader/encodingDesc"/>
        <xsl:apply-templates select="$volume1/teiHeader/profileDesc"/>

        <revisionDesc>
            <list type="simple">
                <item>2016-05-22 Started.</item>
            </list>
        </revisionDesc>
    </teiHeader>
    <text rend="stylesheet(style/classic.css)">
        <front id="frontmatter">
            <div1 id="cover" type="Cover">
                <p>
                    <figure id="cover-image" rend="image(images/new-cover.jpg)">
                        <figDesc>Newly Designed Front Cover.</figDesc>
                    </figure>
                </p>
            </div1>

            <xsl:apply-templates select="$volume1/text/front/div1[@id='v1titlepage']"/>
            <xsl:apply-templates select="$volume1/text/front/titlePage"/>
            <xsl:apply-templates select="$volume1/text/front/div1[@id='v1copyright' or @id='v1preface']"/>

            <div1 id="toc" type="Contents">
                <head>Contents</head>

                <div2 type="Contents">
                    <head>Volume I.</head>
                    <xsl:apply-templates select="$volume1/text/front/div1[@id='v1toc']/*[not(self::head)]"/>
                </div2>
                <div2 type="Contents">
                    <head>Volume II.</head>
                    <xsl:apply-templates select="$volume2/text/front/div1[@id='v2toc']/*[not(self::head)]"/>
                </div2>
            </div1>
        </front>
        <body>
            <div0 type="Volume" n="I" id="v1">
                <head>Volume I.</head>
                <xsl:apply-templates select="$volume1/text/body/div1"/>
                <pb n="1" id="v2pb1b"/>
            </div0>
            <div0 type="Volume" n="II" id="v2">
                <head>Volume II.</head>
                <xsl:apply-templates select="$volume2/text/body/div1"/>
            </div0>
        </body>
        <back id="backmatter">
            <xsl:apply-templates select="$volume1/text/back/div1"/>
            <xsl:apply-templates select="$volume2/text/back/div1"/>

            <div1 id="gentoc">
                <divGen id="genToc" type="toc"/>
            </div1>

            <divGen type="Colophon"/>
        </back>
    </text>
    </TEI.2>
</xsl:template>


<xsl:template match="*[@id='v1volumeTitle' or @id='v1volumeCount']"/>


<xsl:template match="node()|@*">
    <xsl:copy>
        <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
</xsl:template>


</xsl:transform>
