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

<table border=1>
	<tr>
		<td align=center>번호</td>
		<td align=left>신규(insert)</td>
	</tr>
	<tr>
		<td align=center>제목</td>		
		<form method="post" action = "aaaa.jsp">	
		<td>
			<input type = "text" name = "new">		
		</td>
	</tr>
	<tr>
		<td align=center>일자</td>
		<td>
<%
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
		String today = formatter.format(new java.util.Date());
		out.println(today);
%>		</td>
	</tr>
	<tr>
		<td align=center>내용</td>		
		<td>
			<input type = "text" name = "content">		
		</td>
	</tr>

	</form>	
	</table>

</BODY>
</HTML>