<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>

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

<table border=1 align=center>
<%		double total =0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select* from gongji order by rootid desc, recnt asc;");
		// ResultSet rset = stmt.executeQuery("select* from gongji order by date desc;");
		int startpage=0;
		int max = 0;
		int maxx=0;
		int LineCnt=1;
		String a = request.getParameter("fromPT");
		String b = request.getParameter("cntPT");
		if(a == null) a = "1";
		if(b == null) b = "10";
		int fromPT = Integer.parseInt(a);
		int cntPT = Integer.parseInt(b);	
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		sdf.setTimeZone(TimeZone.getTimeZone("UTC+9"));
%>	
	<tr>
		<td align=center>번호</td>
		<td align=center>제목</td>
		<td align=center>조회수</td>	
		<td align=center>등록일</td>	

	</tr>
	
<%		while(rset.next()) {
				if(LineCnt<fromPT){			
			LineCnt++;
			continue;}
			if(LineCnt>fromPT+cntPT-1) break;

%>	
		<tr>
		<td width=100><p align=center> <%out.println(rset.getInt(1));%></p></td> 	
		
		<td width=250><p align=left> 
		<a href ='gongji_view.jsp?title=<%=rset.getString(2)%>&id=<%=rset.getInt(1)%>'>
		<%
		if(rset.getInt(7) >= 1){
			for(int i = 0 ; i < rset.getInt(7); i++){
				%>
				-
				<%
			}
			%>
			>[RE]<%=rset.getString(2)%>[New]
			<%
		} else {
			%>
			<%=rset.getString(2)%>
			<%
		}
		%>
		</a>
		</p></td> 

		<td width=100><p align=center> <%out.println(rset.getInt(3));%></p></td> 
		<td width=100><p align=center> <%out.println(sdf.format(rset.getTimestamp(4)));%></p></td> 

		</tr>
<%		LineCnt++;
		}
		ResultSet rset2 = stmt.executeQuery("SELECT COUNT(id) FROM gongji;");
		rset2.next();
		max = rset2.getInt(1);
		%>
		<form method="post" action = "gongji_write.jsp">	
		<tr><td colspan = "4" align=center >
<%		
		if(max%10==0){
			maxx = max/10;
		}else{
			maxx = max/10+1;
		}
		for(int k=1;k<100;k++){
			startpage = startpage + 1;
			if(fromPT>=((startpage*100)-99)&&fromPT<=(startpage*100)){
				//첫페이지는 무조건 <<누르면 첫페이지여야 하므로 나눔
				if(startpage==1){
					out.println("<a href = 'gongji_list.jsp?fromPT=1&cntPT=10'><<</a>");
				}else {
					out.println("<a href = 'gongji_list.jsp?fromPT=" + ((startpage*100)-199) +  "&cntPT=10'><<</a>");
				}
				//가운데 번호(10개씩 반복이니까 if문과 for문 조건은 변경 할 필요 없다. else도 마찬가지.)
				if(maxx<startpage*10+1){
					for(int i=((startpage*10)-9);i<maxx+1;i++){	
							out.println("<a href = 'gongji_list.jsp?fromPT=" + ((i*10)-9) + "&cntPT=10'>" + i + "</a>");				
					}
				//11페이지, 21페이지, 31페이지일 때 else로 이동(11, 21, 31이 있어야 >>버튼이 생기기 때문)	
				}else {
					for(int i=((startpage*10)-9);i<(startpage*10)+1;i++){	
							out.println("<a href = 'gongji_list.jsp?fromPT=" + ((i*10)-9) + "&cntPT=10'>" + i + "</a>");
					//>>버튼
					}out.println("<a href = 'gongji_list.jsp?fromPT=" + ((startpage*100)+1) +  "&cntPT=10'>>></a>");
				}
			}        
		}
		%>		
				<div style="display:inline-block; float:right;">
					<input type = "submit" value = "신규등록">		
				</div>	
			</form>
		</td>
	</tr>
<%
		rset.close();
		stmt.close();
		conn.close();
%>	
</table>
</BODY>
</HTML>