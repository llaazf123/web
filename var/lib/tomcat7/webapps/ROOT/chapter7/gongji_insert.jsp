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
		<form>	
		<td>
			<input type = "text" name = "title">		
		</td>
	</tr>
	<tr>
		<td align=center>일자</td>
		<td>
<%
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(new java.util.Date());
		out.println(date);
%>	<input type = "hidden" name= "date" value = "<%=date%>">		
</td>
	</tr>
	<tr>
		<td align=center>내용</td>		
		<td>
		<div style="overflow:scroll; width:300px; height:150px;">
			<input type = "text" name = "content" style="width:300px; height:150px;">	
		</div>
		</td>
	</tr>
	<tr>
		<td colspan="2" align=right>
		<input type = "submit" value = "쓰기" formaction="gongji_write.jsp">
		<input type = "submit" value = "취소" formaction="gongji_list.jsp">
		</td>	
		</form>
	</tr>
	</table>
</BODY>
</HTML>