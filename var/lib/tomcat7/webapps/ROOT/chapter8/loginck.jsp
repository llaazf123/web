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
	
	//아이디, 패스워드 체크
	if(id.replaceAll(" ", "").equals("admin") && passwd.replaceAll(" ", "").equals("admin"))
	{
		bPassChk=true;
	}else{
		bPassChk=false;
	}
	
	//패스워드 체크가 끝나면, 세션을 기록하고 점프한다.
	
	if(bPassChk){
		session.setAttribute("login_ok", "yes");
		response.sendRedirect(jump);	//로그인체크 이후 돌아갈 곳
	}else{
		out.println("<h2>아이디 또는 패스워드 오류.</h2>");
		out.println("<input type=button value='로그인' onClick=\"location.href='login.jsp?jump="+jump+"'\">");
	}
	
	%>
</center>
</body>
</html>