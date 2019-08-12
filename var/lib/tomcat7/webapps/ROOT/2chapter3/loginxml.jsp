<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=utf-8"%>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*"%>
<%	//로그인 체크
	String thispage="loginxml.jsp";
	String login_url="login.jsp?rtn_url="+thispage;
	
	String loginVal = (String) session.getAttribute("loginOK");
	//session.invalidate();
	
	//맨처음 들어왔을 때는 null이기 때문에 login.jsp로 이동
	if(loginVal == null || !loginVal.equals("YES"))
		response.sendRedirect(login_url);	//로그인 필요
%>
<%	
	//로그인 되었을 시 보여지는 내용
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
	Statement stmt = conn.createStatement();
	
	ResultSet rset = stmt.executeQuery("select * from examtable");
	out.println("<datas>");
	while(rset.next()){
		out.println("<data>");
		out.println("<name>"+rset.getString(1)+"</name>");
		out.println("<studentid>"+Integer.toString(rset.getInt(2))+"</studentid>");
		out.println("<kor>"+rset.getInt(3)+"</kor>");
		out.println("<eng>"+rset.getInt(4)+"</eng>");
		out.println("<mat>"+rset.getInt(5)+"</mat>");
		out.println("</data>");
	}
	out.println("</datas>");
	stmt.close();
	conn.close();
%>
