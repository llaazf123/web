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

</HEAD>
<BODY>
<%
		String uploadPath = request.getRealPath("/chapter7-1/picture/"); 
		
		MultipartRequest multipartRequest = new MultipartRequest( // MultipartRequest 인스턴스 생성(cos.jar의 라이브러리) - 생성되는 순간 파일 업로드
				request, 
				uploadPath, // 파일을 저장할 디렉토리 지정
				10 * 1024 * 1024, // 첨부파일 최대 용량 설정(bite) / 10MB / 용량 초과 시 예외 발생
				"utf-8", // 인코딩 방식 지정
				new DefaultFileRenamePolicy() // 중복 파일 처리(동일한 파일명이 업로드되면 뒤에 숫자 등을 붙여 중복 회피)
		);
		
		
		
		String title = multipartRequest.getParameter("title");

		String date = multipartRequest.getParameter("date");
		String content = multipartRequest.getParameter("content");
		String b = multipartRequest.getParameter("rootid");
		int rootid = Integer.parseInt(b);
		String c = multipartRequest.getParameter("relevel");
		int relevel = Integer.parseInt(c);
		String d = multipartRequest.getParameter("recnt");
		int recnt = Integer.parseInt(d);
		String picture = multipartRequest.getFilesystemName("picture"); 	
		
		
		if(content == "" || title == ""){
			out.println("제목 및 내용을 작성하여주시기 바랍니다.");
		}else{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		stmt.execute("update gongji set recnt=recnt+1 where rootid =" + rootid + " and recnt>=" + recnt + ";");
		stmt.execute("insert into gongji (title, date, content, viewcnt, relevel, recnt, rootid, picture) values ('" + title + "','" + date + "','" + content + "', 0," 
		+ relevel + ", " + recnt + ", " + rootid + ", '" + picture + "');");
		stmt.close();
		conn.close();
		
%>
<table align=center>
<tr><td>작성되었습니다.</td>
<tr><td>
<form method="post">
<input type ="submit" value = "목록" formaction = gongji_list.jsp>
</form>
</td></tr>
</table>
		<%}%>
</BODY>
</HTML>