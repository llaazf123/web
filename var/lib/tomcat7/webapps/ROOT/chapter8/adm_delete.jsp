<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*, java.text.*"  %>

<HTML>
<HEAD>
</HEAD>
<BODY>
<%
		String resv_date = request.getParameter("resv_date");
		
		String a = request.getParameter("room");
		int room = Integer.parseInt(a);

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		stmt.execute("delete from resort_resv where resv_date = '" + resv_date + "' and room = " + room + ";");
		
		stmt.close();
		conn.close();
%>
<script>
	location.href="?contentPage=d_01.jsp"
</script>
</BODY>
</HTML>