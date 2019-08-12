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
		String title = request.getParameter("title");
		String date = request.getParameter("date");
		String content = request.getParameter("content");
%>
<table border=1>
	<tr>
		<form method="post">	
		<td align=center>번호</td>
		<td align=left><input type = "text" value = "<%=id%>" name = "number" readonly></td>
		<input type = "hidden" value = "<%=id%>" name = "id">
	</tr>
	<tr>
		<td align=center>제목</td>		
			<td align=left><input type = "text" value = "<%=title%>" name = "title"></td>
	</tr>
	<tr>
		<td align=center>일자</td>
			<td align=left><%=date%></td>
			<td align=left><input type = "hidden" value = "<%=date%>" name = "date"></td>
	</tr>
	<tr>
		<td align=center>내용</td>	
		<td align=left>		
		<div style="overflow:scroll; width:300px; height:150px;">
		<input type = "text" value = "<%=content%>" name = "content" style="width:300px; height:150px;">	
		</div>
		</td>	
	</tr>
	<tr>
		<td colspan="2" align=right><input type = "submit" value = "취소" formaction="gongji_list.jsp">
		<input type = "submit" value = "완료" formaction="gongji_update.jsp">
		<input type = "submit" value = "삭제" formaction="gongji_delete.jsp"></td>	
		</form>
	</tr>
	</table>
</BODY>
</HTML>