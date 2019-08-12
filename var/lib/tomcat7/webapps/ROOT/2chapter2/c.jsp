<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%>
<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		
		ResultSet rset = stmt.executeQuery("select * from examtable");
		out.println("<datas>");
		while(rset.next()){
			out.println("<data>");
			out.println("<name>"+rset.getString(1)+"</name>");
			out.println("<studentid>"+rset.getString(2)+"</studentid>");
			out.println("<kor>"+rset.getInt(3)+"</kor>");
			out.println("<eng>"+rset.getInt(4)+"</eng>");
			out.println("<mat>"+rset.getInt(5)+"</mat>");
			out.println("</data>");
		}
		out.println("</datas>");
		stmt.close();
		conn.close();
%>