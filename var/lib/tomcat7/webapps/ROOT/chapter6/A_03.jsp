<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>

<HTML>
<HEAD>
<STYLE>
table {
	border:1px solid black;
	border-collapse: collapse;
}
tr {
	border:1px solid black;
}
td {
	border-bottom:1px solid black;
}
</STYLE>
</HEAD>

<BODY>
<table border=1 align=center>
	<tr>
		<td align=center bgcolor = '#ffff00'><a href = 'http://192.168.56.102:8080/chapter6/A_01.jsp'>후보등록</a></td>
		<td align=center><a href = 'http://192.168.56.102:8080/chapter6/B_01.jsp'>투표</a></td>
		<td align=center><a href = 'http://192.168.56.102:8080/chapter6/C_01.jsp'>개표결과</a></td>	
	</tr>
</table>
<center>후보등록 결과 : 후보가 추가 되었습니다.</center>
<%
		String a = request.getParameter("id");
		int id = Integer.parseInt(a);
		String name = request.getParameter("name");
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		
		stmt.execute("insert into hubo (id, name) values (" + id + ",'" + name + "');");
		stmt.close();
		conn.close();
%>	
</BODY>
</HTML>