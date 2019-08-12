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
		String title = request.getParameter("title");
		String a = request.getParameter("id");
		int id = Integer.parseInt(a);
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		
		String date = "";
		
		String content = "";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 

		ResultSet rset = stmt.executeQuery("select * from gongji where id=" + id + ";");
		
		
		while(rset.next()) {
			date = sdf.format(rset.getDate(3));
			content = rset.getString(4);
		}
%>

<table border=1>
	<tr>
		<form method = "post">	
		<td align=center>번호</td>
		<td align=left><%=id%></td>
		<input type = "hidden" value = "<%=id%>" name = "id">
	</tr>
	<tr>
		<td align=center>제목</td>		
		
		<td>
			<%=title%>
			<input type = "hidden" value = "<%=title%>" name = "title">
		</td>
	</tr>
	<tr>
		<td align=center>일자</td>
		<td>
			<%=date%>	
			<input type = "hidden" value = "<%=date%>" name = "date">
		</td>
	</tr>
	<tr>
		<td align=center>내용</td>		
		<td>
			<%=content%>
			<input type = "hidden" value = "<%=content%>" name = "content">
		</td>
	</tr>
	<tr>
		<td colspan="2" align=right><input type = "submit" value = "목록" formaction="gongji_list.jsp">
		<input type = "submit" value = "수정" formaction="gongji_beforeupdate.jsp"></td>	
		</form>
	</tr>
	</table>
<%
		rset.close();
		stmt.close();
		conn.close();
%>
</BODY>
</HTML>