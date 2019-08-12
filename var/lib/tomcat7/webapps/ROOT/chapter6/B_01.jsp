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
		<td align=center><a href = 'http://192.168.56.102:8080/chapter6/A_01.jsp'>후보등록</a></td>
		<td align=center bgcolor = '#ffff00'><a href = 'http://192.168.56.102:8080/chapter6/B_01.jsp'>투표</a></td>
		<td align=center><a href = 'http://192.168.56.102:8080/chapter6/C_01.jsp'>개표결과</a></td>	
	</tr>
</table>
<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		
		ResultSet rset = stmt.executeQuery("select * from hubo order by id;");
		String a ="";
		%>
		<form align=center method="post" action = "B_02.jsp">
		<select name="hubo_id">
		<option value="">후보 선택</option>
<%		while(rset.next()) {
%>	    
    <option value="<%=Integer.toString(rset.getInt(1))%>"><%=Integer.toString(rset.getInt(1)) +" " + rset.getString(2) %></option>
		<%}%></select>

<select name="age">
    <option value="">연령대 선택</option>
    <option value="10">10대</option>
    <option value="20">20대</option>
    <option value="30">30대</option>
	<option value="40">40대</option>
	<option value="50">50대</option>
	<option value="60">60대</option>
	<option value="70">70대</option>
	<option value="80">80대</option>
	<option value="90">90대</option>
</select>

		<input type = "submit" value = "투표하기">			
</form>
</BODY>
</HTML>