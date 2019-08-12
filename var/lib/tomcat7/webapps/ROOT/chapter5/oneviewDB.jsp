<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>

<HTML>
<HEAD>
</HEAD>
<BODY>
<%
		String member = request.getParameter("member");
		
		String a = request.getParameter("studentid");
		int studentid = Integer.parseInt(a);

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();

		out.println("<h1><" + member + " 조회></h1>");
		ResultSet rset = stmt.executeQuery("select * from examtable where studentid='" + studentid + "';");
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
			out.println("<td width=50><p align=center>" + rset.getString(1) + "</p></td>");
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
</table>
</BODY>
</HTML>