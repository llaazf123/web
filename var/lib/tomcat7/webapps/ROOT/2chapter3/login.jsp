<%@ page import = "java.net.*, java.io.*, java.util.*, java.text.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<%
	String username=request.getParameter("username");
	String userpasswd = request.getParameter("userpasswd");
	String rtn_url = request.getParameter("rtn_url");
	String logincnt = request.getParameter("logincnt");
	
	//로그인 횟수
	if(logincnt == null) logincnt="0";
	if(username == null) username="";
	if(userpasswd == null) userpasswd="";
	if(rtn_url == null) rtn_url="";
	
	//이름과 비밀번호가 일치 시, 다시 rtn_url에 해당하는 loginxml.jsp로 돌아감
	if(username.equals("kopoctc") && userpasswd.equals("kopoctc")){	//login OK
		session.setAttribute("loginOK", "YES");
		response.sendRedirect(rtn_url);
	}else{	//login Err
		//에러가 날 시 logincnt에 값을 1씩 더함
		logincnt=Integer.toString(Integer.parseInt(logincnt)+1);
	}
%>
</head>
<body>
<!--이름과 비밀번호를 입력받음-->
<form method="post" action="login.jsp">
	이름 : <input type="text" name="username"><br>
	비밀번호 : <input type="password" name="userpasswd"><br>
	<input type="hidden" name="logincnt" value=<%=logincnt%>><br>
	<input type="hidden" name="rtn_url" value=<%=rtn_url%>><br>
	<input type="submit" value="전송">
</form>
로그인 시도횟수 <%=logincnt%>회 입니다.<br>
rtn_url <%=rtn_url%>입니다.<br>
</body>
</html>