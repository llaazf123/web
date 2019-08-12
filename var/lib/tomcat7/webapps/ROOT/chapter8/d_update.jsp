<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*, java.text.*"  %>
<HTML>
<HEAD>
<%!
//특수문자 체크해주는 함수(주석처리 같은 injection 방어)
public final String shield(String a) {
		    a = a.replace("<", "&lt");
			a = a.replace(">", "&gt");
			a = a.replace("(", " ");
			a = a.replace(")", " ");
			a = a.replace("'", " ");
			a = a.replace(";", " ");
			a = a.replace("=", " ");
			a = a.replace("+", " ");
			a = a.replace("|", " ");
			a = a.replace("#", " ");
			a = a.replace("..", " ");
			return a;
		    }
%>
</HEAD>
<BODY>
<%
		try{
		String name = request.getParameter("name");
		name = shield(name);
		String resv_date = request.getParameter("resv_date");
		
		String a = request.getParameter("room");
		int room = Integer.parseInt(a);
		
		String resv_date_update = request.getParameter("resv_date_update");
		
		String b = request.getParameter("room_update");
		int room_update = Integer.parseInt(b);
		
		//address, phone, depositor, comment를 특수문자 체크함
		String address = request.getParameter("address");
		address = shield(address);
		String phone = request.getParameter("phone");
		phone = shield(phone);
		String depositor = request.getParameter("depositor");
		depositor = shield(depositor);
		String comment = request.getParameter("comment");
		comment = shield(comment);
		
		String d = request.getParameter("processing");
		int processing = Integer.parseInt(d);
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		//내가 수정한 부분 전체를 update 쿼리문을 날림
		stmt.execute("update resort_resv set name='" + name + "', resv_date='" + resv_date_update + "', room=" + room_update + ", address='" + address + "', phone='" + phone + 
		"', depositor='" + depositor + "', comment='" + comment + "', processing=" + processing + " where resv_date='" + resv_date + "' and room=" + room + ";");

		stmt.close();
		conn.close();
		%>
		<script>
			//update 하자 마자 d_list로 이동하게 함
			location.href="?contentPage=d_list.jsp"
		</script>
		<%}catch(Exception e){%>
		<script>
			//오류가 날 시, 알림을 띄워주고 d_list로 이동하게 함
			alert('다시 입력하여 주시기 바랍니다.');
			location.href="?contentPage=d_list.jsp"
		</script>
		<%}%>
</BODY>
</HTML>