<?xml version="1.0" encoding="ISO-8859-1" ?>
<xsl:stylesheet version="1.4" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
			<title>Absinthe Target Information</title>
			<style>
				body 
				{ 
					font-family: tahoma, arial; 
				}

				li 
				{ 
					border-style: dotted;
					border-width: 2px;       
					border-color: darkgreen;
					padding: 4px;
				}
	
				.row0 { background-color: lightgrey;
			       		padding: 2px; }
				.row1 { background-color: lightgreen; 
					padding: 2px; }
				.databasetables 
				{ 
					border-width: 2px;
					border-color: darkgreen;
					background-color: darkgreen;
					padding: 4px;
					border-style: groove;
				}
				.databaserows 
				{ 
					border-width: 2px;
					border-color: darkgreen;
					background-color: white;
					padding: 4px;
					border-style: groove;
				}
				.copyright 
				{
					float: center; 
					text-align: center;
					font-size: 10px;
				}
				.databasesection
				{
					margin: 0 auto; text-align: left;
					}
				.dbtitle
				{
					font-family: Tahoma; Verdana;
					font-size: 24pt;
				}
			</style>
			</head>
			<body>
				<center><img src="http://0x90.org/releases/absinthe/absinthe.png" alt="Absinthe"/></center>
				<br />
				<br />
				 
				
				<xsl:for-each select="absinthedata/target">					
					<center>
					<table cellpadding="4px">
						<tr>
							<td>
								<u>Target</u>: 
								<xsl:variable name="httptype">
									<xsl:choose>
										<xsl:when test="@ssl='true'">https://</xsl:when>
										<xsl:otherwise>http://</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
							</td>
							<td colspan="6">
								<xsl:value-of select="concat($httptype,@address)"/>
							</td>
							<td>
								<u>Plugin Used</u>: 
							</td>
							<td>
								<xsl:value-of select="@plugin" />
							</td>
						</tr>
						<tr>
							<td valign="top">
								<u>Parameters:</u>
							</td>
							<td>
								<table>
						<xsl:for-each select="parameter">
							<tr>
								<xsl:variable name="inject">
									<xsl:choose>
										<xsl:when test="@injectable='true'">red</xsl:when>
										<xsl:otherwise>black</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<td width="0">
								<xsl:value-of select="@name"/>
							</td> <td> = </td><td><span style="color: {$inject}"><xsl:value-of select="@value"/></span></td>	
						</tr>
						</xsl:for-each>
								</table>
							</td>
						</tr>
					</table>
				</center>
					
					<!-- authentication information -->
					<xsl:for-each select="authentication">						
						<xsl:if test="@authtype != 'None'">
							<center>
							<u>Authentication [<xsl:value-of select="@authtype"/>]:</u><br />
							<table>
								<tr>
									<td>User:</td>
									<td><xsl:value-of select="@username"/></td>
								</tr>
								<tr>
									<td>Password:</td>
									<td><xsl:value-of select="@password"/></td>
								</tr>
								<xsl:if test="@authtype = 'Ntlm'">
									<tr>
										<td>Domain</td>
										<td><xsl:value-of select="@domain"/></td>
									</tr>
								</xsl:if>
							</table>
						</center>
						</xsl:if>
					</xsl:for-each>

					<br />

					<!-- signature information, may not be desired -->
					<xsl:for-each select="attackvector">
						<center>
							<u>Injection Point Used</u>: <xsl:value-of select="@name"/>=<xsl:value-of select="@buffer"/><br />
						</center>
						<xsl:if test="@type='ErrorBasedTSQL'">
							<br />
							<center>
							<u>Query Components</u>:
							<br /><br />
							<table class="databasetables">
								<xsl:for-each select="entry">
									<tr class="databaserows">
										<td>
											<xsl:value-of select="concat(concat(@table, '.'), @field)" /> 
										</td>
										<td><xsl:value-of select="@datatype" /></td>
									</tr>
								</xsl:for-each>
							</table>
						</center>
						</xsl:if>
					</xsl:for-each>
					
					
				</xsl:for-each>  

				<hr />

				<xsl:for-each select="absinthedata/databaseschema">
					<div class="databasesection">
						<center>
					<span class="dbtitle">Database:</span><br />
					<xsl:if test="@username != ''">
						<u>Username</u>: <xsl:value-of select="@username" /><br /><br />
					</xsl:if>

					<table class="databasetables">
					<xsl:for-each select="table">
						<tr>
							<td class="databaserows">
							<a name="#{@name}"/><xsl:value-of select="@name"/> : <xsl:value-of select="@recordcount" /> records

						<table>
							<xsl:for-each select="field">
								<tr class="row{position() mod 2}">
									<td>
										<xsl:value-of select="@name"/>
									</td>
									<td>
										<xsl:value-of select="@datatype"/>
									</td>
								</tr>
							</xsl:for-each>
						</table>
							</td>
						</tr>
					</xsl:for-each>
					</table>
				</center>
				</div>
					
				</xsl:for-each>

				<br />
					<div class="copyright">Generated by Absinthe 2004-2005 &#169; nummish, 0x90.org</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>

  