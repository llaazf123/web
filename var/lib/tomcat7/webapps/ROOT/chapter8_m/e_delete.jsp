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
		String a = request.getParameter("id");
		int id = Integer.parseInt(a);
		
		String b = request.getParameter("rootid");
		int rootid = Integer.parseInt(b);
		String c = request.getParameter("relevel");
		int relevel = Integer.parseInt(c);
		String d = request.getParameter("recnt2");
		int recnt = Integer.parseInt(d);
		String e = request.getParameter("type");
		int type = Integer.parseInt(e);
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		
		if(id == rootid){
			stmt.execute("delete from resort where rootid='" + rootid + "'");
			
		}else {
			stmt.execute("delete from resort where id=" + id + ";");
			stmt.execute("update resort set recnt=recnt-1 where rootid =" + rootid + " and recnt>" + recnt + ";");
		}
		
		stmt.close();
		conn.close();
%>
<script>
	var type = "<%=type%>"
	location.href="e_list.jsp?type=" + type
</script>
</BODY>
</HTML>