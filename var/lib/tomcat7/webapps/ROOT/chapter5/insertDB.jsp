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
<h1><성적입력 추가완료></h1>
<%
		String name = request.getParameter("name");
		String a = request.getParameter("korean");
		int korean = Integer.parseInt(a);
		String b = request.getParameter("english");
		int english = Integer.parseInt(b);
		String c = request.getParameter("math");
		int math = Integer.parseInt(c);
		int max =0;

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		
		ResultSet rset = stmt.executeQuery("select * from examtable where studentid='209901';");

		if(rset.next()){
			rset = stmt.executeQuery("select min(studentid+1) from examtable where (studentid+1) not in (select studentid from examtable);");
			rset.next();
			max = rset.getInt(1);
		}else{
			max = 209901;
		}

		out.println("이름 : <input type='text' value='" + name + "'readonly><br>");
		out.println("학번 : <input type='text' value='" + max + "'readonly><br>");
		out.println("국어 : <input type='text' value='" + korean + "'readonly><br>");
		out.println("영어 : <input type='text' value='" + english  + "'readonly><br>");
		out.println("수학 : <input type='text' value='" + math + "'readonly><br>");
	
		out.println("<a href = 'http://192.168.56.102:8080/chapter5/inputForm1.html'>뒤로가기</a>");
		
		stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values ('" + name + "'," + max + "," + korean + "," + english + "," + math + ");");
		rset.close();
		stmt.close();
		conn.close();
		
%>
</table>
</BODY>
</HTML>