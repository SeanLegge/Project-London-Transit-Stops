<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output method="html" indent="yes"/>
    <!--Created By: Sean Legge
        Student Number: 0062897
        Date: March 26th 2016
        Title: LTC Project
        
  
      Param for user input-->
    <xsl:param name="streetName"/>

  <xsl:template match="/">
    <html>
      <body>
        <h1>
          <font face="Verdana">
            LTC stops on <xsl:value-of select="$streetName"/>
          </font>
        </h1>
        <table style="width:720px" border="3">
          <tr>
            <!--Count the number of instances that contain the users input-->
            <font face="Verdana">Number of stops: </font>
                  <xsl:value-of select="count(//stop/@name[contains(., $streetName)])"/>
          </tr>      
          <tr>
            <th>
              <font face="Verdana" size="4">Stop #</font>   
            </th>
            <th>
              <font face="Verdana" size="4">Stop Name</font>
            </th>
            <th>
              <font face="Verdana" size="4">Latitude</font>
            </th>
            <th>
              <font face="Verdana" size="4">Longitude</font>
            </th>
            <th>
              <font face="Verdana" size="4">Routes</font>
            </th>
          </tr>
          <!--Apply the template and sort -->
          <xsl:apply-templates select ="//stop">
            <xsl:sort select="@number" data-type="number" order="ascending"/>         
          </xsl:apply-templates>
        </table>
      </body>
    </html>
  </xsl:template>
  <!--Match on stop-->
    <xsl:template match="stop">     
      <!--If the user input is found in the xml-->
      <xsl:if test="@name[contains(., $streetName)]">      
             <xsl:element name="tr">
               <xsl:element name="td">
                 <xsl:value-of select="@number"/>
               </xsl:element>
               <xsl:element name="td">
                 <xsl:value-of select="@name"/>
               </xsl:element>
               <xsl:element name="td">
                 <xsl:value-of select="location/latitude"/>
               </xsl:element>
               <xsl:element name="td">
                 <xsl:value-of select="location/longitude"/>
               </xsl:element>
               <xsl:element name="td">
                 <xsl:value-of select="routes"/>
               </xsl:element>
             </xsl:element>             
      </xsl:if>
     
      <!--If no input is entered get the whole xml-->
   <xsl:if test="@name[contains(., $streetName)] = false">
      <xsl:element name="tr">
        <xsl:element name="td">
          <xsl:value-of select="@number"/>
        </xsl:element>
        <xsl:element name="td">
          <xsl:value-of select="@name"/>
        </xsl:element>
        <xsl:element name="td">
          <xsl:value-of select="/location/latitude"/>
        </xsl:element>
        <xsl:element name="td">
          <xsl:value-of select="/location/longitude"/>
        </xsl:element>
         <xsl:element name="td">
          <xsl:value-of select="routes"/>
        </xsl:element>
      </xsl:element>
   </xsl:if>
 </xsl:template>
</xsl:stylesheet>
