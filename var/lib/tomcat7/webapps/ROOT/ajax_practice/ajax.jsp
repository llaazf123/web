<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String name = request.getParameter("name");
System.out.println(name);
if("홍길동".equals(name)){
	out.print("{\"title\": \"홍길동전\", \"html\": \"아버지를 아버지라....\"}");
}else if("흥부".equals(name)){
	out.print("{\"title\": \"흥부전\", \"html\": \"흥부와 놀부는 별명이 아닌 이름이고, 성은 덕수\"}");
}
%>