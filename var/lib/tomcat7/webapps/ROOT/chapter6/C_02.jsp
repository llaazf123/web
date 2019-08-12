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
<!-- Downloaded chart.css -->
<link rel="stylesheet" href="chart.css">

<table border=1 align=center>
	<tr>
		<td align=center><a href = 'http://192.168.56.102:8080/chapter6/A_01.jsp'>후보등록</a></td>
		<td align=center><a href = 'http://192.168.56.102:8080/chapter6/B_01.jsp'>투표</a></td>
		<td align=center bgcolor = '#ffff00'><a href = 'http://192.168.56.102:8080/chapter6/C_01.jsp'>개표결과</a></td>	
	</tr>
</table>
<div class="charts">
<table border=1 align=center>
<%		
		String hubo_id = request.getParameter("hubo_id");
		String name = request.getParameter("name");
%>
<br><center><h2><%=name%> 후보 득표 현황</h2></center>
<%
		double total =0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		ResultSet rset2 = stmt.executeQuery("SELECT COUNT(id) FROM tupyo where hubo_id = " + hubo_id + ";");
		rset2.next();
		total = rset2.getInt(1);

		ResultSet rset = stmt.executeQuery("select hubo_id, any_value(NAME), ANY_VALUE(age), COUNT(age) from (select h.id as hubo_id, h.NAME, t.age from tupyo as t right join hubo as h on h.id=t.hubo_id)s" 
						+ " WHERE hubo_id = " + hubo_id + " AND (age=10 OR age =20 OR age =30 OR age=40 OR age=50 OR age=60 OR age=70 OR age=80 OR age=90)"
						+ " GROUP BY hubo_id, NAME, age;");

		while(rset.next()) {
			int rate = (int)(Math.round((rset.getInt(4)/total)*100));
%>	
<tr>	
		<td width=100><p align=left> <%out.println(rset.getInt(3) + "대 " + rset.getInt(4) + "표"); %></p></td> 
		<td width=150><p align=left><div class="charts__chart chart--p<%=rate %> chart--blue" data-percent></div></p></td><!-- /.charts__chart -->
		</tr>
<%		 
		}		
		rset.close();
		rset2.close();
		stmt.close();
		conn.close();
%>	
</div><!-- /.charts -->
</table>
</BODY>
</HTML>