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
		
		//작성한 모든 것들을 받아옴
		String title = multipartRequest.getParameter("title");
		title = shield(title);
		String content = multipartRequest.getParameter("content");
		String date = multipartRequest.getParameter("date");
		String a = multipartRequest.getParameter("type");
		int type = Integer.parseInt(a);
		
		String b = multipartRequest.getParameter("rootid");
		int rootid = Integer.parseInt(b);
		String c = multipartRequest.getParameter("relevel");
		int relevel = Integer.parseInt(c);
		String d = multipartRequest.getParameter("recnt");
		int recnt = Integer.parseInt(d);
		String picture =  multipartRequest.getFilesystemName("picture"); 	

		int real_id = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		
		//하나의 DB를 이용하지만 type만 두개로 나뉘어져 id값이 하나하나 나오는 문제가 발생. 이를 위해 real_id라는 또 다른 컬럼값 생성
		String sql = "select max(real_id) from resort where type=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);    
		pstmt.setInt(1, type);
        ResultSet rset = pstmt.executeQuery();

		while(rset.next()){
			real_id = rset.getInt(1);
		}
		
		if(content == "" || title == ""){
			out.println("제목 및 내용을 작성하여주시기 바랍니다.");
		}else{
			
		//작성한 모든 것들을 삽입하는 쿼리문
		sql = "insert into resort (title, date, content, viewcnt, relevel, recnt, rootid, picture, type, real_id) values (?, ?, ?, 0, ?, ?, ?, ?, ?, ?)"; 
		pstmt = conn.prepareStatement(sql);    
		pstmt.setString(1, title);
		pstmt.setString(2, date);
		pstmt.setString(3, content);
		pstmt.setInt(4, relevel);
		pstmt.setInt(5, recnt);
		pstmt.setInt(6, rootid);
		pstmt.setString(7, picture);
		pstmt.setInt(8, type);
		pstmt.setInt(9, real_id+1);
		
        pstmt.executeUpdate();

		//대댓글을 위한 작업
		sql = "select max(id) from resort"; 
		pstmt = conn.prepareStatement(sql);   
		rset = pstmt.executeQuery();
		while(rset.next()){
			rootid = rset.getInt(1);
		}
		sql = "update resort set rootid=? where id =?"; 
		pstmt = conn.prepareStatement(sql);    
		pstmt.setInt(1, rootid);
		pstmt.setInt(2, rootid);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		}
%>
<script>
	//insert 되자마자 바로 해당 id에 맞는 e_view로 이동
	var id = <%=rootid%>
	location.href="?contentPage=e_view.jsp&id=" + id;
</script>
</BODY>
</HTML>