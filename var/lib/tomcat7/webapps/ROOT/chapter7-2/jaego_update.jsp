<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*, java.text.*"  %>

<HTML>
<HEAD>
<style>
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
</style>
</HEAD>
<BODY>
<%
		String a = request.getParameter("id");
		int id = Integer.parseInt(a);
		String b = request.getParameter("number");
		int number = Integer.parseInt(b);
		String name = request.getParameter("name");
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		String date = sdf.format(new java.util.Date());
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		stmt.execute("update jaego set number=" + number + ", inventory_date='" + date + "' where id=" + id);
		stmt.close();
		conn.close();
%>
<table border=1 align=center>
	<tr>
		<td align=center>(주)트와이스 재고 현황 - 상품수정</td>
	</tr>
	<tr><td>[<%=name%>] 상품이 수정되었습니다.</td></tr>
<form method="post" action="jaego_list.jsp">
	<tr><td><input type="submit" value = "재고현황"></td></tr>
</form>
</table>
</BODY>
</HTML>