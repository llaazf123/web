<%@page import="java.text.*,java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, iava.io.*"  %>
<html>
<head>
</head>
<body BACKGROUND>
<center>
<%
	//세션 종료
	session.invalidate();
	out.println("<h2>로그아웃 되었습니다.</h2>");
	//로그아웃 후 일반적으로는 홈으로 간다(여기서는 login_test.jsp)
	out.println("<input type=button value='메인페이지' onClick=\"location.href='login_test.jsp'\">");
	%>
</center>
</body>
</html>