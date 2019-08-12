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
<h1><세팅완료></h1>

<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('효민', 209901, 95, 100, 95);");
		stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('보람', 209902, 95, 95, 95);");
		stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('은정', 209903, 100, 100, 100);");
		stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('지연', 209904, 100, 95, 90);");
		stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('소연', 209905, 80, 100, 70);");
		stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('큐리', 209906, 100, 100, 70);");
		stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('화영', 209907, 70, 70, 70);");

		stmt.close();
		conn.close();
%>

</BODY>
</HTML>