<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*, java.text.*"  %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<HTML>
<HEAD>
<style>
table {
	border:1px solid black;
	border-collapse: collapse;
}
tr {
	border:1px solid black;
}
td {
	border-bottom:1px solid black;
}
</style>
</HEAD>
<BODY>
<%try{
		String uploadPath = request.getRealPath("/chapter7-2/picture/"); 
		
		MultipartRequest multipartRequest = new MultipartRequest( // MultipartRequest 인스턴스 생성(cos.jar의 라이브러리) - 생성되는 순간 파일 업로드
				request, 
				uploadPath, // 파일을 저장할 디렉토리 지정
				10 * 1024 * 1024, // 첨부파일 최대 용량 설정(bite) / 10MB / 용량 초과 시 예외 발생
				"utf-8", // 인코딩 방식 지정
				new DefaultFileRenamePolicy() // 중복 파일 처리(동일한 파일명이 업로드되면 뒤에 숫자 등을 붙여 중복 회피)
		);
		String name = multipartRequest.getParameter("name");
		String a = multipartRequest.getParameter("number");	
		int number = Integer.parseInt(a);
		String inventory_date = multipartRequest.getParameter("inventory_date"); 
		String register_date = multipartRequest.getParameter("register_date");
		String detail = multipartRequest.getParameter("detail"); 
		String picture = "picture/" + multipartRequest.getFilesystemName("picture"); 	
	
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		stmt.execute("insert into jaego(name, number, inventory_date, register_date, detail, picture) values('" + name + "'," + number + ",'" 
		+ inventory_date + "','" + register_date + "','" + detail + "','" + picture + "');");
		stmt.close();
		conn.close();
		
%>
<table border=1 align=center>
	<tr>
		<td align=center>(주)트와이스 재고 현황 - 상품추가</td>
	</tr>
	<tr><td>[<%=name%>] 상품이 추가되었습니다.</td></tr>
<form method="post" action="jaego_list.jsp">
	<tr><td><input type="submit" value = "재고현황"></td></tr>
</form>
<%
}catch(Exception e){
	out.println("다시 작성해주시기 바랍니다.");
}
%>
</table>
</BODY>
</HTML>