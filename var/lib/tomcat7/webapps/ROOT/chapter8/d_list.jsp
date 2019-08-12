<%@page import="java.text.*,java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.net.*, iava.io.*"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;harset=utf-8"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
.common {
	width:60%;
	margin:auto;
}

.title {
	text-align:center
}

.contents {
	text-align:left
}

td,tr {
padding: 7px;
}

</style>
<%
	//관리자 로그인 하였을 시 사용자 버튼을 활성화 시키기 위함
	String loginOK=null;
	loginOK = (String)session.getAttribute("login_ok");
	%>
</head>
<body>
<!--제목부분-->
<div class="title common">	
	<span style = "font-weight: bold; font-size:2.5em;"><br>
		예약상황
	</span><br>
	예약 상황을 한번에 볼 수 있는 화면입니다.<br><br><br><br>
</div>
<%
	//날짜 형식 세팅
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
	Statement stmt = conn.createStatement(); 
%>
<!--내용부분-->
<div class="contents common">	
<table align=center style="width:100%;text-align:center">
	<tr style = "font-weight: bold;font-size:1.2em;height:60;border-bottom:1px solid #E6E6E6;border-top:1px solid black;" bgcolor="#f5f5f5">
		<td>날짜</td>
		<td>그랜드호텔</td>
		<td>팰리스호텔</td>
		<td>힐 콘도</td>
	</tr>
<%	//30일치를 보여주고자 30번 반복
	for(int z=0;z<30;z++){%>	
	<!--마우스를 오버했을 때와 내렸을 때 background 컬러를 삽입-->
	<tr onmouseover="this.style.background='#F2F2F2'" onmouseout="this.style.background='white'" style="border-bottom:1px solid #E6E6E6;">
		<%
		//날짜, 그랜드호텔, 팰리스호텔, 힐 콘도를 위해 총 4번 반복
		for(int i=0;i<4;i++){
			//현재 날짜 세팅
			int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
			String resv_date = sdf.format(cal.getTime());
			%>
			<td style="width:20%">
			<%
			//날짜 및 요일
			if(i==0){
				out.println(resv_date);
				switch (dayOfWeek) {
					case 1:
						out.println("(일)");
						break;
					case 2:
						out.println("(월)");
						break;
					case 3:
						out.println("(화)");
						break;
					case 4:
						out.println("(수)");
						break;
					case 5:
						out.println("(목)");
						break;
					case 6:
						out.println("(금)");
						break;
					case 7:
						out.println("(토)");
						break;
				}
			//그랜드호텔	
			}else if(i==1){
				ResultSet rset = stmt.executeQuery("select name FROM resort_resv where resv_date='" + resv_date + "' and room=1;");
				Boolean found = rset.next();
				//DB에 값이 있을 경우
				if (found){
					//로그인 안 했을 경우
					if(loginOK==null){
					out.println(rset.getString(1));}
					//로그인 하였을 경우
					else{%>
					<a href = "?contentPage=d_oneview.jsp&resv_date=<%=resv_date%>&room=1"><%=rset.getString(1)%></a>
					<%}%>
				<%//DB에 값이 없을 경우
				}else{%>
					<a href = "?contentPage=d_write.jsp&resv_date=<%=resv_date%>&room=1&adm=1">예약가능</a>
				<%}
			//팰리스호텔
			}else if(i==2){
				ResultSet rset = stmt.executeQuery("select name FROM resort_resv where resv_date='" + resv_date + "' and room=2;");
				Boolean found = rset.next();
				if (found){
					if(loginOK==null){
					out.println(rset.getString(1));}
					else{%>
					<a href = "?contentPage=d_oneview.jsp&resv_date=<%=resv_date%>&room=2"><%=rset.getString(1)%></a>
					<%}%>
				<%}else{%>
					<a href = "?contentPage=d_write.jsp&resv_date=<%=resv_date%>&room=2&adm=1">예약가능</a>
				<%}
			//힐 콘도
			}else{
				ResultSet rset = stmt.executeQuery("select name FROM resort_resv where resv_date='" + resv_date + "' and room=3;");
				Boolean found = rset.next();
				if (found){
					if(loginOK==null){
					out.println(rset.getString(1));}
					else{%>
					<a href = "?contentPage=d_oneview.jsp&resv_date=<%=resv_date%>&room=3"><%=rset.getString(1)%></a>
					<%}%>
				<%}else{%>
					<a href = "?contentPage=d_write.jsp&resv_date=<%=resv_date%>&room=3&adm=1">예약가능</a>
				<%}
				//오늘 날짜에서 1씩을 증가시킴
				cal.add(cal.DATE,+1);
			}%>
			</td>
		<%}%>
		</tr>
	<%}%>
	</table>
	</div>
	<%
	stmt.close();
	conn.close();
	%>
<br><br><br><br><br><br>
</body>
</html>