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
<h1><레코드 삭제></h1>

<%
		String a = request.getParameter("student_id");
		int student_id = Integer.parseInt(a);
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		stmt.execute("delete from examtable where studentid='" + student_id + "'");
		
	ResultSet rset = stmt.executeQuery("select * from examtable;");
%>
<table cellspacing=1 width=600 border=1>
<%
		out.println("<tr><td align=center>이름</td>");
		out.println("<td align=center>학번</td>");
		out.println("<td align=center>국어</td>");
		out.println("<td align=center>영어</td>");
		out.println("<td align=center>수학</td></tr>");


		//rset을 각각 출력한다.
		while(rset.next()) {
			out.println("<tr>");
			out.println("<td width=50><p align=center><a href = 'http://192.168.56.102:8080/chapter5/oneviewDB.jsp?member=" + rset.getString(1) +"'>"+rset.getString(1)+"</a></p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(2)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
			out.println("</tr>");
		}

		rset.close();
		stmt.close();
		conn.close();
		
%>
</BODY>
</HTML>