<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page errorPage="error.jsp"%>

<HTML>
<HEAD>
</HEAD>
<BODY>
<h1><조회></h1>
<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select a.name, a.studentid, a.kor, a.eng, a.mat, a.total, a.avgg, count(*)" 
		+ "from (select name, studentid, kor, eng, mat, (kor + eng + mat) as total,ROUND((kor + eng + mat)/3) AS avgg from examtable) as a,"
		+ "(select name, studentid, kor, eng, mat, (kor + eng + mat) as total, ROUND((kor + eng + mat)/3) AS avgg from examtable) as b "
		+ "where a.total <= b.total group by a.studentid;");
		
		
		int count=0;
		int rank=0;
		int startpage=0;
		
		int LineCnt=1;
		String a = request.getParameter("fromPT");
		String b = request.getParameter("cntPT");
		if(a == null) a = "1";
		if(b == null) b = "2";
		int fromPT = Integer.parseInt(a);
		int cntPT = Integer.parseInt(b);			
%>
<table cellspacing=1 width=600 border=1>
<%
		out.println("<tr><td align=center>이름</td>");
		out.println("<td align=center>학번</td>");
		out.println("<td align=center>국어</td>");
		out.println("<td align=center>영어</td>");
		out.println("<td align=center>수학</td>");
		out.println("<td align=center>총점</td>");
		out.println("<td align=center>평균</td>");
		out.println("<td align=center>등수</td></tr>");
		int max = 0;
		int maxx=0;
		while(rset.next()) {
			if(LineCnt<fromPT){			
			LineCnt++;
			continue;}
			if(LineCnt>fromPT+cntPT-1) break;
			out.println("<tr>");
			out.println("<td width=50><p align=center><a href = 'http://192.168.56.102:8080/chapter5/oneviewDB.jsp?member=" + rset.getString(1) +"&studentid=" + rset.getInt(2) +"'>"+rset.getString(1)+"</a></p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(2)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(6)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(7)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(8)) + "</p></td>");
			out.println("</tr>");
			LineCnt++;
		}out.println("</table>");
		ResultSet rset2 = stmt.executeQuery("SELECT COUNT(studentid) FROM examtable;");
		rset2.next();
		max = rset2.getInt(1);
		
		
		if(max%2==0){
			maxx = max/2;
		}else{
			maxx = max/2+1;
		}
		for(int k=1;k<100;k++){
			startpage = startpage + 1;
			if(fromPT>=((startpage*20)-19)&&fromPT<=(startpage*20)){
				//첫페이지는 무조건 <<누르면 첫페이지여야 하므로 나눔
				if(startpage==1){
					out.println("<a href = 'http://192.168.56.102:8080/chapter5/AllviewDB.jsp?fromPT=1&cntPT=2'><<</a>");
				}else {
					out.println("<a href = 'http://192.168.56.102:8080/chapter5/AllviewDB.jsp?fromPT=" + ((startpage*20)-39) +  "&cntPT=2'><<</a>");
				}
				//가운데 번호
				if(maxx<startpage*10+1){
					for(int i=((startpage*10)-9);i<maxx+1;i++){	
							out.println("<a href = 'http://192.168.56.102:8080/chapter5/AllviewDB.jsp?fromPT=" + ((i*2)-1) + "&cntPT=2'>" + i + "</a>");				
					}
				}else {
					for(int i=((startpage*10)-9);i<(startpage*10)+1;i++){	
							out.println("<a href = 'http://192.168.56.102:8080/chapter5/AllviewDB.jsp?fromPT=" + ((i*2)-1) + "&cntPT=2'>" + i + "</a>");
					//>>버튼
					}out.println("<a href = 'http://192.168.56.102:8080/chapter5/AllviewDB.jsp?fromPT=" + ((startpage*20)+1) +  "&cntPT=2'>>></a>");
				}
			}
		}
		rset.close();
		rset2.close();
		stmt.close();
		conn.close();
		
		
		
				//1~10페이지
		// if(fromPT>=1&&fromPT<=20){
			// out.println("<a href = 'http://192.168.56.102:8080/chapter5/AllviewDB.jsp?fromPT=1&cntPT=2'><<</a>");
			// for(int i=1;i<11;i++){	
				// out.println("<a href = 'http://192.168.56.102:8080/chapter5/AllviewDB.jsp?fromPT=" + (i*2-1) + "&cntPT=2'>" + i + "</a>");
			// }
			// out.println("<a href = 'http://192.168.56.102:8080/chapter5/AllviewDB.jsp?fromPT=21&cntPT=2'>>></a>");
		// }
		//그 이후 나머지 페이지들
%>
</BODY>
</HTML>