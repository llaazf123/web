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

		String name = request.getParameter("name");
		
		String resv_date = request.getParameter("resv_date");
		
		String a = request.getParameter("room");
		int room = Integer.parseInt(a);
		
		String address = request.getParameter("address");
		
		String b = request.getParameter("phone");
		int phone = Integer.parseInt(b);
		
		String depositor = request.getParameter("depositor");
		String comment = request.getParameter("comment");
			
		String c = request.getParameter("processing");
		int processing = Integer.parseInt(c);
		
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		stmt.execute("update resort_resv set name='" + name + "', resv_date='" + resv_date + "', room=" + room + ", address='" + address + "', phone=" + phone + 
		", depositor='" + depositor + "', comment='" + comment + "', processing=" + processing + ";)");
		
		
		
		
		stmt.close();
		conn.close();
%>
<script>
	location.href="?contentPage=adm_allview.jsp"
</script>
</BODY>
</HTML>