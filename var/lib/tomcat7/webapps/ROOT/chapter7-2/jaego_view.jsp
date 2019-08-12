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
		String name = "";
		int number = 0;
		String inventory_date = "";
		String register_date = "";
		String detail = "";
		String picture = "";
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		sdf.setTimeZone(TimeZone.getTimeZone("UTC+9"));
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 

		ResultSet rset = stmt.executeQuery("select * from jaego where id=" + id + ";");
		
		
		while(rset.next()) {
			name = rset.getString(2);
			number = rset.getInt(3);
			inventory_date = sdf.format(rset.getTimestamp(4));
			register_date = sdf.format(rset.getTimestamp(5));
			detail = rset.getString(6);
			picture = rset.getString(7);
		}
%>

<table border=1 align=center>
	<tr>
		<td align=center colspan = "2">(주)트와이스 재고 현황 - 상품상세</td>
	</tr>
<form>		
	<tr>
		<td align=center>상품번호</td>
		<td>	
			<%=id%>
			<input type = "hidden" value = "<%=id%>" name="id">
		</td>
	</tr>
	<tr>
		<td align=center>상품명</td>		
		<td>
			<%=name%>	
			<input type = "hidden" value = "<%=name%>" name="name">
		</td>
	</tr>
	<tr>
		<td align=center>재고현황</td>		
		<td>
			<%=number%>	
		</td>
	</tr>
	<tr>
		<td align=center>상품등록일</td>
		<td>
			<%=inventory_date%>		
		</td>
	</tr>
	<tr>
		<td align=center>재고등록일</td>		
		<td>
			<%=register_date%>	
		</td>
	</tr>
	<tr>
		<td align=center>상품설명</td>		
		<td>
			<%=detail%>		
		</td>
	</tr>
	<tr>
		<td align=center>상품사진</td>		
		<td>
		<img src="<%=picture%>" >
					
		</td>
	</tr>
	<tr>
		<td colspan="2" align=right>
		<input type = "submit" value = "상품삭제" formaction="jaego_delete.jsp">
		<input type = "submit" value = "재고수정" formaction="jaego_beforeupdate.jsp">
		</td>	
	</tr>
</form>	
</table>
</BODY>
</HTML>