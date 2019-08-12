<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page errorPage="error.jsp"%>

<HTML>
<HEAD>
</HEAD>
<BODY>
<h1><레코드 수정></h1>
<%
		String name = request.getParameter("name");
		
		String a = request.getParameter("korean");
		int korean = Integer.parseInt(a);
		
		String b = request.getParameter("english");
		int english = Integer.parseInt(b);
		
		String c = request.getParameter("math");
		int math = Integer.parseInt(c);
		
		String d = request.getParameter("student_id");
		int studentid = Integer.parseInt(d);
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		stmt.execute("update examtable set name='" + name + "', studentid=" + studentid + ", kor=" + korean + ", eng=" + english + ", mat=" + math + " where studentid =" + studentid + ";");
		
		ResultSet rset = stmt.executeQuery("select * from examtable;");
%>
<table cellspacing=1 width=600 border=1>
<%
		out.println("<tr><td align=center>이름</td>");
		out.println("<td align=center>학번</td>");
		out.println("<td align=center>국어</td>");
		out.println("<td align=center>영어</td>");
		out.println("<td align=center>수학</td></tr>");

		//rset을 각각 출력한다.
		while(rset.next()) {
			
			out.println("<tr>");
			if(studentid==rset.getInt(2)){http://192.168.56.102:8080/chapter5/oneviewDB.jsp?member=" + rset.getString(1) +"&studentid=" + rset.getInt(2)
				out.println("<td bgcolor = '#ffff00' width=50><p align=center><a href = 'http://192.168.56.102:8080/chapter5/oneviewDB.jsp?member=" + rset.getString(1) +"&studentid=" + rset.getInt(2)+ "'>"+rset.getString(1)+"</a></p></td>");
				out.println("<td bgcolor = '#ffff00' width=50><p align=center>" + Integer.toString(rset.getInt(2)) + "</p></td>");
				out.println("<td bgcolor = '#ffff00' width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
				out.println("<td bgcolor = '#ffff00' width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
				out.println("<td bgcolor = '#ffff00' width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
			}
			else{
				out.println("<td width=50><p align=center><a href = 'http://192.168.56.102:8080/chapter5/oneviewDB.jsp?member=" + rset.getString(1) +"&studentid=" + rset.getInt(2)+ "'>"+rset.getString(1)+"</a></p></td>");
				out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(2)) + "</p></td>");
				out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
				out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
				out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
			}
			out.println("</tr>");
		}
		rset.close();
		stmt.close();
		conn.close();
%>
</table>
</BODY>
</HTML>