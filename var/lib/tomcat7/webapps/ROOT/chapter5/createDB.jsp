<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page errorPage="error.jsp"%>

<HTML>
<HEAD>
</HEAD>
<BODY>
<h1><생성완료></h1>

<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		stmt.execute("create table examtable("+
				"name varchar(20),"+
				"studentid int not null primary key,"+
				"kor	int,"+
				"eng	int,"+
				"mat	int)"+		
				"DEFAULT CHARSET=utf8;");
		stmt.close();
		conn.close();
%>
</BODY>
</HTML>