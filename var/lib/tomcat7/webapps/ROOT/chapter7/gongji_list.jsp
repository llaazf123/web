<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>

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

<table border=1>
<%		double total =0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();

		
		ResultSet rset = stmt.executeQuery("select* from gongji order by id desc;");
%>	
	<tr>
		<td align=center>번호</td>
		<td align=center>제목</td>
		<td align=center>등록일</td>	
	</tr>
	
<%		while(rset.next()) {
%>	
		<tr>
		<td width=100><p align=center> <%out.println(rset.getInt(1));%></p></td> 	
		<td width=250><p align=left> <%out.println("<a href = 'gongji_view.jsp?title=" + rset.getString(2) +"&id=" + rset.getInt(1) + "'>" + rset.getString(2)+ "</a>");%></p></td> 
		<td width=100><p align=center> <%out.println(rset.getDate(3));%></p></td> 
		</tr>
	<%}%>		

	<tr>
		<td colspan = "3" align=right> <form method="post" action = "gongji_insert.jsp">	
			<input type = "submit" value = "신규">		
			</form>
		</td>
	</tr>
<%
		rset.close();
		stmt.close();
		conn.close();
%>	
</table>
</BODY>
</HTML>