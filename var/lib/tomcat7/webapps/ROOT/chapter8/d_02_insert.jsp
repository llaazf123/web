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
		try{
		String name = request.getParameter("name");
		
		String resv_date = request.getParameter("resv_date");
		
		String a = request.getParameter("room");
		int room = Integer.parseInt(a);
		
		String address = request.getParameter("address");
		
		String b = request.getParameter("phone");
		int phone = Integer.parseInt(b);
		
		String depositor = request.getParameter("depositor");
		String comment = request.getParameter("comment");
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String write_date = sdf.format(new java.util.Date());
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		stmt.execute("insert into resort_resv (name, resv_date, room, address, phone, depositor, comment, write_date, processing)" 
		+ "values ('" + name + "', '" + resv_date + "', " + room + ", '" + address + "', " + phone + ", '" + depositor + "', '" + comment + "', '" + write_date + "', 1);");
		stmt.close();
		conn.close();
%>
<script>
	location.href="?contentPage=d_01.jsp"
</script>
<%
		}catch(Exception e){%>
		<script>
			alert('다시 입력하여 주시기 바랍니다.');
			location.href="?contentPage=d_01.jsp"
		</script>
		<%}%>

</BODY>
</HTML>