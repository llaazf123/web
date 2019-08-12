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
	
	//resort_adm DB에 있는 id와 비밀번호가 일치하면 bPassChk는 true 아니면 false
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
	
	//bPassChk가 true이면 세션을 yes로 세팅한 뒤 jump(adm_logintest.jsp)로 이동
	if(bPassChk){
		session.setAttribute("login_ok", "yes");
		out.println("<script>location.href='"+jump+"';</script>");
		//response.sendRedirect(jump);	//로그인체크 이후 돌아갈 곳
	}
	
	//bPassChk가 false이면 아이디 패스워드 오류를 출력한 뒤 adm_login.jsp로 이동하는 로그인 버튼 생성.
	else{
		out.println("<h2>아이디 또는 패스워드 오류.</h2>");
		%>
		<input type=button value='로그인' onClick="location.href='?contentPage=adm_login.jsp&jump=<%=jump%>'");
	<%}%>
</center>
</body>
</html>