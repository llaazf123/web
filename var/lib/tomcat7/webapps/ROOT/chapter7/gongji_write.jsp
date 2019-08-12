<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*, java.text.*"  %>

<HTML>
<HEAD>

</HEAD>
<BODY>
<%
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String date = request.getParameter("date");

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		stmt.execute("insert into gongji (title, date, content) values ('" + title + "','" + date + "','" + content + "');");
		stmt.close();
		conn.close();
%>
작성되었습니다.
</BODY>
</HTML>