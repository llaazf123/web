<%@page import="java.text.*,java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, iava.io.*"  %>
<html>
<head>
</head>
<body>
<center>
<%
	request.setCharacterEncoding("utf-8");
	
	String jump = request.getParameter("jump");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	boolean bPassChk = false;
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
	Statement stmt = conn.createStatement(); 
		
	ResultSet rset = stmt.executeQuery("select * from resort_adm;");
	rset.next();
	if(rset.getString(1).equals(id) && rset.getString(2).equals(passwd)){
		bPassChk=true;
	}else{
		bPassChk=false;
	}
	
	//아이디, 패스워드 체크
	// if(id.replaceAll(" ", "").equals("admin") && passwd.replaceAll(" ", "").equals("admin"))
	// {
		// bPassChk=true;
	// }else{
		// bPassChk=false;
	// }
	
	//패스워드 체크가 끝나면, 세션을 기록하고 점프한다.
	
	if(bPassChk){
		session.setAttribute("login_ok", "yes");
		out.println("<script>location.href='"+jump+"';</script>");
		//response.sendRedirect(jump);	//로그인체크 이후 돌아갈 곳
	}else{
		out.println("<h2>아이디 또는 패스워드 오류.</h2>");
		%>
		<input type=button value='로그인' onClick="location.href='adm_login.jsp?jump=<%=jump%>'");
	<%}%>
</center>
</body>
</html>