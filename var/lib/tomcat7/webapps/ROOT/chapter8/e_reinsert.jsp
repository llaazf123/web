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
		    a = a.replace("<", " ");
			a = a.replace("<", " ");
			a = a.replace(">", " ");
			a = a.replace("(", " ");
			a = a.replace(")", " ");
			a = a.replace("'", " ");
			a = a.replace(";", " ");
			a = a.replace("=", " ");
			a = a.replace("+", " ");
			a = a.replace("|", " ");
			a = a.replace("&", " ");
			a = a.replace("-", " ");
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
		
		//작성한 모든 것들을 받아옴
		int id = 0;
		String title = multipartRequest.getParameter("title");
		title = shield(title);
		String date = multipartRequest.getParameter("date");
		String content = multipartRequest.getParameter("content");
		String b = multipartRequest.getParameter("rootid");
		int rootid = Integer.parseInt(b);
		String c = multipartRequest.getParameter("relevel");
		int relevel = Integer.parseInt(c);
		String d = multipartRequest.getParameter("recnt");
		int recnt = Integer.parseInt(d);
		String picture = multipartRequest.getFilesystemName("picture"); 	
		int real_id = 0;
	
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		//real_id 값을 insert 하기 전 select 쿼리
		ResultSet rset = stmt.executeQuery("select max(real_id) from resort where type=2;");
		
		while(rset.next()){
			real_id = rset.getInt(1);
		}
		
		//insert하기 이전 recnt update 작업
		stmt.execute("update resort set recnt=recnt+1 where rootid =" + rootid + " and recnt>=" + recnt + ";");
		
		//insert 쿼리문
		stmt.execute("insert into resort (title, date, content, viewcnt, relevel, recnt, rootid, picture, type, real_id) values ('" + title + "','" + date 
		+ "','" + content + "', 0," + relevel + ", " + recnt + ", " + rootid + ", '" + picture + "', 2, " + (real_id + 1) + ");");
		
		//reinsert하자마자 e_view로 바로 이동 시키기 위해 id를 불러오는 쿼리문
		rset = stmt.executeQuery("select max(id) from resort;");
		while(rset.next()){
			id = rset.getInt(1);
		}
		stmt.close();
		conn.close();
%>
<script>
	//reinsert 되자마자 바로 해당 id에 맞는 e_view로 이동
	var id = "<%=id%>"
	location.href="?contentPage=e_view.jsp&id=" + id;
</script>
</BODY>
</HTML>