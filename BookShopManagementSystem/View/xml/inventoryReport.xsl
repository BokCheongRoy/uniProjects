<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <body>
                <style>
                    .inventory-table {
                        border-collapse: collapse;
                        width: 100%;
                    }

                    .inventory-table th, .inventory-table td {
                        border: 1px solid black;
                        padding: 8px;
                    }

                    .inventory-table th {
                        background-color: lightgrey;
                    }
                </style>
                <h1>Books Inventory</h1>
                <!-- All Books Table -->
                <h2>All Stock Items</h2>
                <table class="inventory-table">
                    <tr>
                        <th>Book ID</th>
                        <th>Book Title</th>
                        <th>Author</th>
                        <th>Category</th>
                        <th>Stock</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                    <xsl:for-each select="catalog/cd">
                        <tr>
                            <td><xsl:value-of select="id"/></td>
                            <td><xsl:value-of select="title"/></td>
                            <td><xsl:value-of select="author"/></td>
                            <td><xsl:value-of select="category"/></td>
                            <td><xsl:value-of select="stock"/></td>
                            <td><xsl:value-of select="price"/></td>
                            <td><xsl:value-of select="status"/></td>
                        </tr>
                    </xsl:for-each>
                </table>

                <!-- Low Stock Items Table -->
                <h2>Low Stock Items</h2>
                <table class="inventory-table">
                    <tr>
                        <th>Book ID</th>
                        <th>Book Title</th>
                        <th>Author</th>
                        <th>Category</th>
                        <th>Stock</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                    <xsl:for-each select="catalog/lowStock/cd">
                        <tr>
                            <td><xsl:value-of select="id"/></td>
                            <td><xsl:value-of select="title"/></td>
                            <td><xsl:value-of select="author"/></td>
                            <td><xsl:value-of select="category"/></td>
                            <td><xsl:value-of select="stock"/></td>
                            <td><xsl:value-of select="price"/></td>
                            <td><xsl:value-of select="status"/></td>
                        </tr>
                    </xsl:for-each>
                </table>

                <!-- Top 10 Low Stock Items Table -->
                <h2>Top 10 Low Stock Items</h2>
                <table class="inventory-table">
                    <tr>
                        <th>Book ID</th>
                        <th>Book Title</th>
                        <th>Author</th>
                        <th>Category</th>
                        <th>Stock</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                    <xsl:for-each select="catalog/top10LowStock/cd">
                        <tr>
                            <td><xsl:value-of select="id"/></td>
                            <td><xsl:value-of select="title"/></td>
                            <td><xsl:value-of select="author"/></td>
                            <td><xsl:value-of select="category"/></td>
                            <td><xsl:value-of select="stock"/></td>
                            <td><xsl:value-of select="price"/></td>
                            <td><xsl:value-of select="status"/></td>
                        </tr>
                    </xsl:for-each>
                </table>

                <!-- Top 10 High Stock Items Table -->
                <h2>Top 10 High Stock Items</h2>
                <table class="inventory-table">
                    <tr>
                        <th>Book ID</th>
                        <th>Book Title</th>
                        <th>Author</th>
                        <th>Category</th>
                        <th>Stock</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                    <xsl:for-each select="catalog/top10HighStock/cd">
                        <tr>
                           <td><xsl:value-of select="id"/></td>
                            <td><xsl:value-of select="title"/></td>
                            <td><xsl:value-of select="author"/></td>
                            <td><xsl:value-of select="category"/></td>
                            <td><xsl:value-of select="stock"/></td>
                            <td><xsl:value-of select="price"/></td>
                            <td><xsl:value-of select="status"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
