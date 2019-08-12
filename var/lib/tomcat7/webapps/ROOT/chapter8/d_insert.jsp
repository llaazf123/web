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
		String name = request.getParameter("name");
		name = shield(name);

		String resv_date = request.getParameter("resv_date");
		
		String a = request.getParameter("room");
		int room = Integer.parseInt(a);
		try{
		String address = request.getParameter("address");
		address = shield(address);
		String phone = request.getParameter("phone");
		phone = shield(phone);
		String depositor = request.getParameter("depositor");
		depositor = shield(depositor);
		String comment = request.getParameter("comment");
		comment = shield(comment);
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String write_date = sdf.format(new java.util.Date());
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		stmt.execute("insert into resort_resv (name, resv_date, room, address, phone, depositor, comment, write_date, processing)" 
		+ "values ('" + name + "', '" + resv_date + "', " + room + ", '" + address + "', '" + phone + "', '" + depositor + "', '" + comment + "', '" + write_date 
		+ "', 1);");
		stmt.close();
		conn.close();
%>
<script>
	//insert한 뒤 바로 d_list로 이동
	location.href="?contentPage=d_list.jsp"
</script>
<%
		}catch(Exception e){%>
		<script>
			//오류가 날 경우, 알람창을 띄어 준 뒤 d_list로 이동
			alert('다시 입력하여 주시기 바랍니다.');
			location.href="?contentPage=d_list.jsp
		</script>
		<%}%>

</BODY>
</HTML>