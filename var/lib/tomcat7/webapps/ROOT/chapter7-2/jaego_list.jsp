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
		ResultSet rset = stmt.executeQuery("select* from jaego order by inventory_date desc;");
		int startpage=0;
		int max = 0;
		int maxx=0;
		int LineCnt=1;
		String a = request.getParameter("fromPT");
		String b = request.getParameter("cntPT");
		if(a == null) a = "1";
		if(b == null) b = "5";
		int fromPT = Integer.parseInt(a);
		int cntPT = Integer.parseInt(b);	
		
%>	
	<tr>
		<td align=center colspan = "5">(주)트와이스 재고 현황 - 전체현황</td>
	</tr>

	<tr>
		<td align=center>상품번호</td>
		<td align=center>상품명</td>
		<td align=center>재고수량</td>	
		<td align=center>재고파악일</td>	
		<td align=center>상품등록일</td>	
	</tr>
	
<%		while(rset.next()) {
			if(LineCnt<fromPT){			
			LineCnt++;
			continue;}
			if(LineCnt>fromPT+cntPT-1) break;
%>	
		<tr>
		<td width=100><p align=center> <%out.println(rset.getInt(1));%></p></td> 	
		<td width=100><p align=center> <%out.println("<a href = 'jaego_view.jsp?id=" + rset.getInt(1) + "'>" + rset.getString(2) + "</a>");%></p></td> 
		<td width=100><p align=center> <%out.println(rset.getInt(3));%></p></td>
		<td width=100><p align=center> <%
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		// java.util.Calendar cal = Calendar.getInstance();
		// java.sql.Timestamp ts = rset.getTimestamp(4);
		// cal.setTime(ts);
		// out.println(sdf.format(cal.getTime()));
		sdf.setTimeZone(TimeZone.getTimeZone("UTC+9"));
		out.println(sdf.format(rset.getTimestamp(4)));
		%></p></td>
		<td width=100><p align=center> <%out.println(sdf.format(rset.getTimestamp(5)));%></p></td> 
		</tr>
<%			LineCnt++;
		}
		ResultSet rset2 = stmt.executeQuery("SELECT COUNT(id) FROM jaego;");
		rset2.next();
		max = rset2.getInt(1);
%><form method="post" action = "jaego_write.jsp">	
	<tr><td colspan = "5" align=center >
<%		
		if(max%5==0){
			maxx = max/5;
		}else{
			maxx = max/5+1;
		}
		for(int k=1;k<100;k++){
			startpage = startpage + 1;
			if(fromPT>=((startpage*50)-49)&&fromPT<=(startpage*50)){
				//첫페이지는 무조건 <<누르면 첫페이지여야 하므로 나눔
				if(startpage==1){
					out.println("<a href = 'http://192.168.56.102:8080/chapter7-2/jaego_list.jsp?fromPT=1&cntPT=5'><<</a>");
				}else {
					out.println("<a href = 'http://192.168.56.102:8080/chapter7-2/jaego_list.jsp?fromPT=" + ((startpage*50)-99) +  "&cntPT=5'><<</a>");
				}
				//가운데 번호(10개씩 반복이니까 if문과 for문 조건은 변경 할 필요 없다. else도 마찬가지.)
				if(maxx<startpage*10+1){
					for(int i=((startpage*10)-9);i<maxx+1;i++){	
							out.println("<a href = 'http://192.168.56.102:8080/chapter7-2/jaego_list.jsp?fromPT=" + ((i*5)-4) + "&cntPT=5'>" + i + "</a>");				
					}
				}else {
					for(int i=((startpage*10)-9);i<(startpage*10)+1;i++){	
							out.println("<a href = 'http://192.168.56.102:8080/chapter7-2/jaego_list.jsp?fromPT=" + ((i*5)-4) + "&cntPT=5'>" + i + "</a>");
					//>>버튼
					}out.println("<a href = 'http://192.168.56.102:8080/chapter7-2/jaego_list.jsp?fromPT=" + ((startpage*50)+1) +  "&cntPT=5'>>></a>");
				}
			}
		}
		
	%>	
		<div style="display:inline-block; float:right;">
			<input type = "submit" value = "신규등록">		
		</div>
	</td>
	</tr>
</form>
<%
		rset.close();
		stmt.close();
		conn.close();
%>	
</table>
</BODY>
</HTML>