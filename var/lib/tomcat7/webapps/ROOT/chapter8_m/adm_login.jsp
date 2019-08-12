<%@page import="java.text.*,java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, iava.io.*"  %>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

</head>
<body>
<%
	String jump = request.getParameter("jump");
	%>
<center>
	<span style = "font-weight: bold; font-size:2.5em;"><br>
		관리자 로그인
	</span><br><br><br><br>
<form method="post" action="adm_loginck.jsp">
<table border=1>
	<tr>
		<td>아이디</td>
		<td><input type = "text" name="id"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></td>
	</tr>
	<tr>
		<td colspan=2 align=center><input type = "submit" value="전송"></td>
	</tr>
</table><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<input type = "hidden" name="jump" value='<%=jump%>'>
</form>
</center>
</body>
</html>