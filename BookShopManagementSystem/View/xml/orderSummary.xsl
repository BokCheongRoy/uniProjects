<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="/orders">
        <html>
            <head>
                <title>Order Summary Report</title>
                <style>
                    table {
                        width: 100%;
                        border-collapse: collapse;
                    }
                    table, th, td {
                        border: 1px solid black;
                    }
                    th, td {
                        padding: 10px;
                        text-align: left;
                    }
                    th {
                        background-color: #f2f2f2;
                    }
                    .order-count {
                        text-align: right;
                        font-weight: bold;
                    }
                </style>
            </head>
            <body>
                <h1>Order Summary</h1>
                <div class="order-count">
                    Total Orders: <xsl:value-of select="count(order)"/>
                </div>
                
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Order Date</th>
                            <th>Status</th>
                            <th>Books Ordered</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="order">
                            <tr>
                                <td><xsl:value-of select="order_id"/></td>
                                <td><xsl:value-of select="order_date"/></td>
                                <td><xsl:value-of select="status"/></td>
                                <td>
                                    <ul>
                                        <xsl:for-each select="order_detail">
                                            <li>
                                                <xsl:value-of select="book_name"/> (<xsl:value-of select="book_id"/>) x<xsl:value-of select="quantity"/>
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
