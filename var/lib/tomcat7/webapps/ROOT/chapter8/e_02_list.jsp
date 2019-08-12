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
hr{width:110px;} 
hr{height:0px;} 
hr{margin-left:0} 
hr{border: solid 2px black;}

.common {
	width:80%;
	margin:auto;
}

.title {
	text-align:center
}

.contents {
	text-align:left
}
</style>
</HEAD>
<BODY>
<div class="title common">
<span style = "font-weight: bold; font-size:2.5em;"><br>
	이용후기
</span><br>
고객님들의 생생한 이용후기<br><br><br><br>
</div>
<div class="contents common">
<table align=center style="width:100%;" height="600">
<%		double total =0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select* from resort where type=2 order by rootid desc, recnt asc;");
		// ResultSet rset = stmt.executeQuery("select* from resort order by date desc;");
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
	<tr bgcolor="#f5f5f5" style = "font-size:1.2em; font-weight: 700;">
		<td align=center>번호</td>
		<td align=center>제목</td>
		<td align=center>작성일</td>	
		<td align=center>조회수</td>	
	</tr>
	
<%		while(rset.next()) {
				if(LineCnt<fromPT){			
			LineCnt++;
			continue;}
			if(LineCnt>fromPT+cntPT-1) break;

%>	
		<tr>
		<td width=100><p align=center> <%out.println(rset.getInt(11));%></p></td> 	
		<td width=250><p align=left> 
		<a href ='?contentPage=e_view.jsp&title=<%=rset.getString(2)%>&id=<%=rset.getInt(1)%>'>
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
		
		<td width=100><p align=center> <%out.println(sdf.format(rset.getTimestamp(4)));%></p></td> 
		<td width=100><p align=center> <%out.println(rset.getInt(3));%></p></td> 
		</tr>
<%		LineCnt++;
		}
		ResultSet rset2 = stmt.executeQuery("SELECT COUNT(id) FROM resort where type=2;");
		rset2.next();
		max = rset2.getInt(1);
		%>
		</table>
		<form method="post">
			<div style="position: relative;">
				<div style="position:absolute;left:43.3%;">
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
					out.println("<a href = '?contentPage=e_02_list.jsp&fromPT=1&cntPT=10'><<</a>");
				}else {
					out.println("<a href = '?contentPage=e_02_list.jsp&fromPT=" + ((startpage*100)-199) +  "&cntPT=10'><<</a>");
				}
				//가운데 번호(10개씩 반복이니까 if문과 for문 조건은 변경 할 필요 없다. else도 마찬가지.)
				if(maxx<startpage*10+1){
					for(int i=((startpage*10)-9);i<maxx+1;i++){	
							out.println("<a href = '?contentPage=e_02_list.jsp&fromPT=" + ((i*10)-9) + "&cntPT=10'>" + i + "</a>");				
					}
				//11페이지, 21페이지, 31페이지일 때 else로 이동(11, 21, 31이 있어야 >>버튼이 생기기 때문)	
				}else {
					for(int i=((startpage*10)-9);i<(startpage*10)+1;i++){	
							out.println("<a href = '?contentPage=e_02_list.jsp&fromPT=" + ((i*10)-9) + "&cntPT=10'>" + i + "</a>");
					//>>버튼
					}out.println("<a href = '?contentPage=e_02_list.jsp&fromPT=" + ((startpage*100)+1) +  "&cntPT=10'>>></a>");
				}
			}        
		}
		%>	
				</div>
				<div style="position:absolute;left:93.3%;">
					<input type = "hidden" name= "type" value = "2">	
					<input type = "submit" value = "신규등록" formaction="?contentPage=e_write.jsp">	
				</div>	
			</div>
		</form>	
<%
		rset.close();
		stmt.close();
		conn.close();
%>	
</div>
</BODY>
</HTML>