<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%
	response.setHeader("Access-Control-Allow-Origin", "*");
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from examtable;");
	try{
		out.print("[");
		
			while(rset.next()){
				out.print("{");
				out.print("\"name\":");
				out.print("\"" + rset.getString(1) + "\", ");
				out.print("\"studentid\":");
				out.print("\"" + Integer.toString(rset.getInt(2)) + "\", ");
				out.print("\"kor\":");
				out.print("\"" + Integer.toString(rset.getInt(3)) + "\", ");
				out.print("\"eng\":");
				out.print("\"" + Integer.toString(rset.getInt(4)) + "\", ");
				out.print("\"mat\":");
				out.print("\"" + Integer.toString(rset.getInt(5)) + "\"");
				if(rset.isLast()){	
					out.print("}");
				}else{
					out.print("}, ");
				}
			}
		out.print("]");	
	}catch(Exception e){
		out.println(e.toString());
	}
%>