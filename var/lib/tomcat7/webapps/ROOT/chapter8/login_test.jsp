<%@page import="java.text.*,java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, iava.io.*"  %>

<html>
<head>
<%
////세션을 체크해서 없다면 로그인 창으로 보낸다. 그리고 로그인이 되면 자기 자신에게 와야하므로
//자기 자신의 url을 써줘야 한다.

	String loginOK=null;
	String jumpURL="login.jsp?jump=login_test.jsp";
	
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null){
		response.sendRedirect(jumpURL);
		return;
	}else{
		
	}
	%>

</head>
<body>
<center>
<h1> 로그인 오케이 </h1>
<br>
<br>
<a href="logout.jsp">로그아웃</a>
</center>
</html>