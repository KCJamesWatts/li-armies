<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="replace" select="' ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:variable name="replaceWith" select="'-abcdefghijklmnopqrstuvwxyz'" />

  <xsl:template match="/">
    <html>
      <head>
        <link rel="stylesheet" href="army-list.css" />
      </head>
      <body>
        <div class="page">
          <h1 class="faction-title"><xsl:value-of select="army/@name" /></h1>
          <img src="assets/images/factions/{translate(army/@name, $replace, $replaceWith)}-symbol.png" class="faction-logo" alt="Faction Symbol" />
        </div>

        <div class="page">
          <h2>Unit List</h2>
          <table>
            <thead>
              <tr>
                <th class="text-start">Name</th>
                <th>Mv</th>
                <th>Sv</th>
                <th>CAF</th>
                <th class="text-start">Weapons</th>
                <th>M</th>
                <th>W</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="army/units/unit">
                <xsl:sort select="@name" />
                <tr>
                  <td class="text-start"><xsl:value-of select="@name" /></td>
                  <td><xsl:value-of select="move" /></td>
                  <td><xsl:value-of select="save" /></td>
                  <td><xsl:value-of select="caf" /></td>
                  <td class="text-start">
                    <xsl:for-each select="weapons/weapon">
                      <xsl:value-of select="@name" />
                      <xsl:if test="position() != last()"><br /></xsl:if>
                    </xsl:for-each>
                  </td>
                  <td><xsl:value-of select="morale" /></td>
                  <td><xsl:value-of select="wounds" /></td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </div>

        <div class="page">
          <h2>Weapon List</h2>
          <table>
            <thead>
              <tr>
                <th class="text-start">Name</th>
                <th>Range</th>
                <th>Dice</th>
                <th>To Hit</th>
                <th>AP</th>
                <th class="text-start">Traits</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="army/weapons/weapon">
                <xsl:sort select="@name" />
                <tr>
                  <td class="text-start"><xsl:value-of select="@name" /></td>
                  <td><xsl:value-of select="range" /></td>
                  <td><xsl:value-of select="dice" /></td>
                  <td><xsl:value-of select="tohit" /></td>
                  <td><xsl:value-of select="ap" /></td>
                  <td class="text-start">
                    <xsl:for-each select="traits/trait">
                      <xsl:value-of select="@name" />
                      <xsl:if test="position() != last()">, </xsl:if>
                    </xsl:for-each>
                  </td>
                </tr>
              </xsl:for-each>
            </tbody>
          </table>
        </div>

        <div class="page">
          <h2>Formations</h2>

          <xsl:for-each select="army/formations/formation">
            <xsl:sort select="@name" />

            <div style="page-break-inside: avoid;">
              <table class="formation-table" style="margin-bottom: 2em;">
                <tbody>
                  <tr>
                    <td colspan="2" style="background-color: #e6e6e6;"><xsl:value-of select="@name" /></td>
                  </tr>

                  <tr>
                    <td style="font-weight: bold;">
                      Compulsory
                    </td>

                    <td style="font-weight: bold;">
                      Optional
                    </td>
                  </tr>

                  <tr>
                    <td style="width: 50%;" rowspan="{count(optional/detachmentChoice)+1}">
                      <div style="display: flex; flex-wrap: wrap; padding-top: 1em;">
                        <xsl:for-each select="compulsory/detachment">
                          <div style="flex-grow: 1; margin-bottom: 1em; width: 50%">
                            <img>
                              <xsl:attribute name="src">
                                <xsl:text>assets/images/detachments/detachment-</xsl:text>
                                <xsl:value-of select="translate(@type, $replace, $replaceWith)"/>
                                <xsl:text>.jpg</xsl:text>
                              </xsl:attribute>
                            </img>
                            <br />
                            <xsl:value-of select="@type" />
                          </div>
                        </xsl:for-each>
                      </div>
                    </td>

                    <td style="width: 50%;">
                      <div style="display: flex; flex-wrap: wrap; padding-top: 1em;">
                        <xsl:for-each select="optional/detachment">
                          <div style="flex-grow: 1; margin-bottom: 1em; width: 33%">
                            <img style="filter: invert(10%);">
                              <xsl:attribute name="src">
                                <xsl:text>assets/images/detachments/detachment-</xsl:text>
                                <xsl:value-of select="translate(@type, $replace, $replaceWith)"/>
                                <xsl:text>.jpg</xsl:text>
                              </xsl:attribute>
                            </img>
                            <br />
                            <xsl:value-of select="@type" />
                          </div>
                        </xsl:for-each>
                      </div>
                    </td>
                  </tr>
                  <xsl:for-each select="optional/detachmentChoice">
                    <tr>
                      <td style="width: 50%;">
                        <div style="display: flex; flex-wrap: wrap; padding-top: 1em;">
                          <div style="padding-bottom: 1em; width: 100%;">Choose one of the following:</div>
                          <xsl:for-each select="detachment">
                            <div style="flex-grow: 1; margin-bottom: 1em; width: 33%">
                              <img style="filter: invert(10%);">
                                <xsl:attribute name="src">
                                  <xsl:text>assets/images/detachments/detachment-</xsl:text>
                                  <xsl:value-of select="translate(@type, $replace, $replaceWith)"/>
                                  <xsl:text>.jpg</xsl:text>
                                </xsl:attribute>
                              </img>
                              <br />
                              <xsl:value-of select="@type" />
                            </div>
                          </xsl:for-each>
                        </div>
                      </td>
                    </tr>
                  </xsl:for-each>
                  <xsl:for-each select="rule">
                    <tr>
                      <td colspan="2" style="line-height: 1.5em; padding: 10px; text-align: left;">
                        <span style="font-weight: bold;"><xsl:value-of select="@name" />: </span> <xsl:value-of select="." />
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </div>
          </xsl:for-each>
        </div>

        <div class="page">
          <h2>Detachments</h2>
        </div>

        <div class="page">
          <h2>Cards</h2>
        </div>

        <div class="page">
          <h2>Weapon Traits</h2>
          <xsl:for-each select="army/traits/trait">
            <xsl:sort select="@name" />
            <xsl:value-of select="@name" />, 
          </xsl:for-each>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>