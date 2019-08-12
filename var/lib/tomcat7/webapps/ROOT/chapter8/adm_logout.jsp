<%@page import="java.text.*,java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, iava.io.*"%>
<html>
<head>
</head>
<body BACKGROUND>
<center>
<%
	//세션 종료
	session.invalidate();
	%>
</center>
<script>
	<!--세션을 종료한 뒤 index.jsp로 바로 이동-->
	location.href="index.jsp"
</script>
</body>
</html>