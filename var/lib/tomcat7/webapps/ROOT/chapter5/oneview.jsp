<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>

<HTML>
<HEAD>
</HEAD>
<BODY>
<%

		String a = request.getParameter("member");
		int member = Integer.parseInt(a);
		
		String peoplename=null;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		if (member == 1){
			peoplename="효민";
		}else if(member == 2){
			peoplename="보람";
		}else if(member == 3){
			peoplename="은정";
		}else if(member == 4){
			peoplename="지연";
		}else if(member == 5){
			peoplename="소연";
		}else if(member == 6){
			peoplename="큐리";
		}else if(member == 7){
			peoplename="화영";
		}
		ResultSet rset = stmt.executeQuery("select * from examtable where name='" + peoplename + "';");
%>
<table cellspacing=1 width=600 border=1>
<%
		//rset을 각각 출력한다.
		while(rset.next()) {
			out.println("<tr>");
			out.println("<td width=50><p align=center>" + rset.getString(1) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(2)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
			out.println("</tr>");

		}
		rset.close();
		stmt.close();
		conn.close();
%>
</table>
</BODY>
</HTML>