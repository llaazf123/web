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
<%!
//특수문자 체크해주는 함수(주석처리 같은 injection 방어)
public final String shield(String a) {
		    a = a.replace("<", "&lt");
			a = a.replace(">", "&gt");
			a = a.replace("(", " ");
			a = a.replace(")", " ");
			a = a.replace("'", " ");
			a = a.replace(";", " ");
			a = a.replace("=", " ");
			a = a.replace("+", " ");
			a = a.replace("|", " ");
			a = a.replace("#", " ");
			a = a.replace("..", " ");
			return a;
		    }
%>
</HEAD>
<BODY>
<%
		//파일 업로드 경로 지정
		String uploadPath = request.getRealPath("/chapter8/picture/"); 
		
		MultipartRequest multipartRequest = new MultipartRequest( // MultipartRequest 인스턴스 생성(cos.jar의 라이브러리) - 생성되는 순간 파일 업로드
				request, 
				uploadPath, // 파일을 저장할 디렉토리 지정
				10 * 1024 * 1024, // 첨부파일 최대 용량 설정(bite) / 10MB / 용량 초과 시 예외 발생
				"utf-8", // 인코딩 방식 지정
				new DefaultFileRenamePolicy() // 중복 파일 처리(동일한 파일명이 업로드되면 뒤에 숫자 등을 붙여 중복 회피)
		);

		String a = multipartRequest.getParameter("id");
		int id = Integer.parseInt(a);
		String title = multipartRequest.getParameter("title");
		title = shield(title);
		String content = multipartRequest.getParameter("content");
		String picture = multipartRequest.getFilesystemName("picture"); 
		String b = multipartRequest.getParameter("type");
		int type = Integer.parseInt(b);
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		//title, content, picture, id를 업데이트 하는 쿼리문
		stmt.execute("update resort set title='" + title + "', content='" + content + "', picture='" + picture + "' where id =" + id + ";");
		stmt.close();
		conn.close();
%>
<script>
	//update 되자마자 바로 해당 id에 맞는 e_view로 이동
	var id = "<%=id%>"
	location.href="?contentPage=e_view.jsp&id=" + id;
</script>
</BODY>
</HTML>