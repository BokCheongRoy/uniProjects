<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>

    <!-- Template to match the root -->
    <xsl:template match="/">
      
        <html>
            <body>
                <h2>Registered Users</h2>

                <!-- Customers Table -->
                <h4>Customers</h4>
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Address</th>
                        <th>Status</th>
                        <th>Register Date</th>
                    </tr>
                    <xsl:for-each select="//user[role='customer']">
                        <tr>
                            <td><xsl:value-of select="accId"/></td>
                            <td><xsl:value-of select="name"/></td>
                            <td><xsl:value-of select="email"/></td>
                            <td><xsl:value-of select="phoneNum"/></td>
                            <td><xsl:value-of select="address"/></td>
                            <td><xsl:value-of select="status"/></td>
                            <td><xsl:value-of select="created_at"/></td>
                        </tr>
                    </xsl:for-each>
                    <!-- Display total number of customers -->
                    <tr>
                        <td colspan="6" align="right">
                            Total number of customers: <xsl:value-of select="count(//user[role='customer'])"/>
                        </td>
                    </tr>
                </table>

                <!-- Employees Table -->
                <h4>Employees</h4>
                <table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Address</th>
                        <th>Status</th>
                        <th>Register Date</th>
                    </tr>
                    <xsl:for-each select="//user[role='employee']">
                        <tr>
                            <td><xsl:value-of select="accId"/></td>
                            <td><xsl:value-of select="name"/></td>
                            <td><xsl:value-of select="email"/></td>
                            <td><xsl:value-of select="phoneNum"/></td>
                            <td><xsl:value-of select="address"/></td>
                            <td><xsl:value-of select="status"/></td>
                            <td><xsl:value-of select="created_at"/></td>
                        </tr>
                    </xsl:for-each>
                    <!-- Display total number of employees -->
                    <tr>
                        <td colspan="6" align="right">
                            Total number of employees: <xsl:value-of select="count(//user[role='employee'])"/>
                        </td>
                    </tr>
                </table>

                <!-- Overall Total -->
                <p>Total registered users : <xsl:value-of select="count(//user)"/></p>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
