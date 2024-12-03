<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
<html>
<head>
    <title>学生信息</title>
</head>
<body>
    <h2>个人信息</h2>
    <xsl:apply-templates select="student/basic_info"/>
    
    <h2>课程成绩</h2>
    <table border="1">
        <tr>
            <th>课程名称</th>
            <th>学时</th>
            <th>成绩</th>
        </tr>
        <xsl:apply-templates select="student/course_grades/course">
            <xsl:sort select="grade" data-type="number" order="ascending"/>
        </xsl:apply-templates>
    </table>
    <xsl:call-template name="calculateWeightedAverage"/>
</body>
</html>
</xsl:template>

<xsl:template match="basic_info">
    <p><strong>学号:</strong> <xsl:value-of select="student_id"/></p>
    <p><strong>姓名:</strong> <xsl:value-of select="name"/></p>
    <p><strong>班级:</strong> <xsl:value-of select="class"/></p>
    <p><strong>兴趣:</strong>
        <xsl:for-each select="interests/hobby">
            <xsl:value-of select="."/><xsl:if test="position() != last()">, </xsl:if>
        </xsl:for-each>
    </p>
    <p><strong>照片:</strong> <img src="{photo}" alt="Student Photo" width="30%" height="30%"/></p>
</xsl:template>

<xsl:template match="course">
    <tr>
        <td><xsl:value-of select="name"/></td>
        <td><xsl:value-of select="hours"/></td>
        <td><xsl:value-of select="grade"/></td>
    </tr>
</xsl:template>

<xsl:template name="calculateWeightedAverage">
    <xsl:variable name="total_hours" select="sum(/student/course_grades/course/hours)"/>
    <xsl:variable name="weighted_sum">
        <xsl:call-template name="calculateWeightedSum">
            <xsl:with-param name="courses" select="/student/course_grades/course"/>
            <xsl:with-param name="total_weighted_grade" select="0"/>
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="weighted_average" select="sum($weighted_sum) div $total_hours"/>
    <p><strong>加权成绩:</strong> <xsl:value-of select="format-number($weighted_average, '#.##')"/></p>
</xsl:template>

<xsl:template name="calculateWeightedSum">
    <xsl:param name="courses"/>
    <xsl:param name="total_weighted_grade" select="0"/>

    <xsl:choose>
        <xsl:when test="count($courses) > 0">
            <xsl:variable name="current_course" select="$courses[1]"/>
            <xsl:variable name="weighted_grade" select="$current_course/grade * $current_course/hours"/>
            <xsl:call-template name="calculateWeightedSum">
                <xsl:with-param name="courses" select="$courses[position() > 1]"/>
                <xsl:with-param name="total_weighted_grade" select="$total_weighted_grade + $weighted_grade"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$total_weighted_grade"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
