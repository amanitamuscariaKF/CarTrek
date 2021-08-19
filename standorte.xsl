<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0">
<xsl:output 
  method="html" 
  encoding="UTF-8" 
  omit-xml-declaration="yes" />
  <xsl:decimal-format name="eu" decimal-separator="," grouping-separator="."/>  
  <!-- <xsl:param name="url" select="standorte/stationen/station/geopos"/>
  <xsl:param name="lat" select="standorte/stationen/station/geopos/@lat">
  <xsl:param name="lng" select="standorte/stationen/station/geopos/@lng"> -->
  <xsl:param name="city"></xsl:param>
<xsl:param name="suche"></xsl:param>

<xsl:param name="pfad" select="standorte/cities[starts-with(city,$city) and contains(translate(.,'abcdefghijklmnopqrstuvwxyzäöüß','ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜẞ'), translate($suche,'abcdefghijklmnopqrstuvwxyzäöüß','ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜẞ'))]"/>
<xsl:param name="adresse" select="standorte/stationen/station[address/city=$city and contains(translate(.,'abcdefghijklmnopqrstuvwxyzäöüß','ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜẞ'), translate($suche,'abcdefghijklmnopqrstuvwxyzäöüß','ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜẞ'))]"/>
<xsl:param name="stadt" select="$city"/>

<xsl:variable name="anzahlStaedte" select="count($adresse)"/>
<xsl:template match="/">
  <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
  <html lang="de">

  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Carsharing Standorte</title>
    <link rel="stylesheet" href="css/stylesheet.css" />
  </head>
  <body>
    <h1>Station suchen</h1>

    <!-- <xsl:value-of select="$adresse"/> -->
    
 <form method="GET" action="standorte.php" class="xslform">
 <xsl:for-each select="standorte/cities/city">
 <label>
  <input  type="radio" name="city" value="{.}">
    <xsl:if test="$city=.">
      <xsl:attribute name="checked">checked</xsl:attribute>
    </xsl:if>
  </input>
 

 <xsl:value-of select="."></xsl:value-of>
</label>
</xsl:for-each>



<br/>
   <label>Stichwort: <input type="text" name="suche" value="{$suche}"/>


   <input type="submit" value="Suchen"/>
  </label>
 </form>



  <xsl:choose>
    <xsl:when test="$stadt=''">
      <p>
        Bitte Stadt wählen. 
      </p>
    </xsl:when>
    <xsl:when test="$anzahlStaedte=0"> 
      
          <!-- <xsl:when test="$suche=''">
            <p>
              Bitte Suche eingeben.
            </p>

          </xsl:when>
          <xsl:otherwise>-->
        
        <p> 
          Leider kein Standort in <xsl:value-of select="$suche"/>, <xsl:value-of select="$stadt"/>
          gefunden.
        </p><br/> 
      <!-- </xsl:otherwise> -->
    </xsl:when>

    <xsl:when test="$anzahlStaedte=1"> <p>
      Es wurde ein Standort gefunden   in <xsl:value-of select="$suche"/>, <xsl:value-of select="$stadt"/> gefunden.
    </p><br/>  
    <!-- <xsl:value-of select=""/>, <xsl:value-of select="{suche}"/> gefunden.  -->
    
      <!-- <xsl:for-each select="standorte/stationen/station"> -->
      <xsl:for-each select="$adresse">
      <p>
        <a href="https://www.google.com/maps/">
        <!-- ?q=lat+lng -->
  
          <xsl:value-of select="name"/>
  </a>
      </p>
      <p>
        <xsl:value-of select="address/street"></xsl:value-of>
  
      <xsl:value-of select="address/number"></xsl:value-of>          </p>
      <xsl:value-of select="address/zip"></xsl:value-of>
      <xsl:value-of select="address/city"></xsl:value-of>
      <xsl:value-of select="address/district"></xsl:value-of>
      <br/>
    </xsl:for-each>
  
  </xsl:when>
  
    <xsl:when test="$anzahlStaedte>0">


      <p>
        Es wurden <strong><xsl:value-of select="$anzahlStaedte">
          
        </xsl:value-of></strong> Standorte in <xsl:value-of select="$suche"/>, <xsl:value-of select="$stadt"/> gefunden.
      </p>
            <xsl:for-each select="$adresse">
            
              <a class="addresses" href="{geopos/@url}" >
              <!-- ?q=lat+lng -->
  
                <xsl:value-of select="name"/>
  </a>
            
            <p class="addresses">
              <xsl:value-of select="address/street"></xsl:value-of> &#160;
            <xsl:value-of select="address/number"></xsl:value-of> 
            <br/>       
            <xsl:value-of select="address/zip"></xsl:value-of> &#160;
            
            <xsl:value-of select="address/city"></xsl:value-of>
            <br/>
            <xsl:value-of select="address/district"></xsl:value-of>
          </p>
            <br/>
          </xsl:for-each>


  
    </xsl:when>
   


  </xsl:choose>



  </body>
  </html>
</xsl:template>
</xsl:stylesheet>
