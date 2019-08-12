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
		
		String resv_date_update = request.getParameter("resv_date_update");
		
		String b = request.getParameter("room_update");
		int room_update = Integer.parseInt(b);
		
		String address = request.getParameter("address");
		
		String c = request.getParameter("phone");
		int phone = Integer.parseInt(c);
		
		String depositor = request.getParameter("depositor");
		
		String comment = request.getParameter("comment");
			
		String d = request.getParameter("processing");
		int processing = Integer.parseInt(d);
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		stmt.execute("update resort_resv set name='" + name + "', resv_date='" + resv_date_update + "', room=" + room_update + ", address='" + address + "', phone=" + phone + 
		", depositor='" + depositor + "', comment='" + comment + "', processing=" + processing + " where resv_date='" + resv_date + "' and room=" + room + ";");
		
		stmt.close();
		conn.close();
		%>
		<script>
			location.href="?contentPage=d_01.jsp"
		</script>
		<%}catch(Exception e){%>
		<script>
			alert('다시 입력하여 주시기 바랍니다.');
			location.href="?contentPage=d_01.jsp"
		</script>
		<%}%>

</BODY>
</HTML>