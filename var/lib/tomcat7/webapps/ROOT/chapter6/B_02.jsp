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
	try{
		String hubo_id = request.getParameter("hubo_id");
		String age = request.getParameter("age");
		int id=0;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select * from tupyo;");
		
		rset = stmt.executeQuery("select * from tupyo where id='1';");
		
		if(rset.next()){
			rset = stmt.executeQuery("select id+1 from tupyo where (id+1) not in (select id from tupyo);");
			rset.next();
			id = rset.getInt(1);
		}else{
			id = 1;
		}
		stmt.execute("insert into tupyo (id, hubo_id, age) values (" + id + "," + hubo_id + "," + age + ");");%>
		<center>
		투표 결과 : 투표하였습니다.
		</center>
		<%
		rset.close();
		stmt.close();
		conn.close();
	}catch(Exception e){
		out.println("투표를 다시 하시기 바랍니다.");
	}
%>	
</BODY>
</HTML>