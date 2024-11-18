<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>Review Report</title>
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
                </style>
            </head>
            <body>
                <h1>User Review Report</h1>
                <br/>

                <table>
                    <tr>
                        <th>Review ID</th>
                        <th>Book ID</th>
                        <th>Book Name</th>
                        <th>Rating</th>
                        <th>Review</th>
                        <th>Date</th>
                    </tr>
                    <xsl:for-each select="reviews/review">
                        <tr>
                            <td>
                                <xsl:value-of select="review_id"/>
                            </td>
                            <td>
                                <xsl:value-of select="book_id"/>
                            </td>
                            <td>
                                <xsl:value-of select="book_name"/>
                            </td>
                            <td>
                                <xsl:value-of select="rating"/>
                            </td>
                            <td>
                                <xsl:value-of select="review_text"/>
                            </td>
                            <td>
                                <xsl:value-of select="review_date"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
                <br/>
                <p>
                    <strong>Total Reviews: </strong>
                    <xsl:value-of select="count(reviews/review)" />
                </p>

                <p>
                    <strong>Average Rating: </strong>
                    <xsl:choose>
                        <xsl:when test="count(reviews/review) > 0">
                            <xsl:value-of select="format-number(sum(reviews/review/rating) div count(reviews/review), '0.0')" />
                        </xsl:when>
                        <xsl:otherwise>
                            No ratings available
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
