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

		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
			for(int i=0; i<200; i++){
			stmt.execute("insert into resort (title, date, content, viewcnt, relevel, recnt, rootid, picture, type, real_id) VALUES ('a', '2019-07-05 15:30', '아아', 0, 0, 0, 0, 'dd', 1, 2);");
			}
		stmt.close();
		conn.close();
%>