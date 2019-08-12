<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %>
<html>
<head>
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
</style>
</head>
<body>
<%
	String resv_date = request.getParameter("resv_date");
	String a = request.getParameter("room");
	int room = Integer.parseInt(a);
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String resv_date_today = sdf.format(cal.getTime());
	cal.add(cal.DATE,+29);
	String resv_date_max = sdf.format(cal.getTime());
	String adm = request.getParameter("adm");
%>
<div class="title common">	
	<span style = "font-weight: bold; font-size:2.5em;"><br>
		예약하기
	</span><br>
	리조트를 예약하는 화면입니다.<br><br><br><br>
</div>
<form class="contexts common" method="post">
<table border=1 align=center style="width:100%;" height="600" >
	<tr>
		<td style="width:20%;text-align:center;height:6%;font-weight: bold;" bgcolor="#f5f5f5">성명</td>
		<td><input type="text" name="name" style="width:100%;height:100%"></td>
	</tr>
	<tr>
		<td style="text-align:center;height:1%;font-weight: bold;" bgcolor="#f5f5f5">예약일자</td>
			<!--<td><input type="text" name="resv_date" style="width:100%;height:100%"></td>-->
			<td>
				<input type = "date" min = "<%=resv_date_today%>" max = "<%=resv_date_max%>" name = "resv_date" value="<%=resv_date%>" style="width:100%">
			</td>
	</tr>
	<tr>
		<td style="text-align:center;font-weight: bold;height:6%;" bgcolor="#f5f5f5">예약방</td>
			<td>				
				<select name="room" style="width:100%; height:100%">
					<%if(room==1){%>
						<option value="1" selected="selected">그랜드호텔</option>
						<option value="2">팰리스호텔</option>
						<option value="3">힐 콘도</option>
					<%}else if(room==2){%>
						<option value="1">그랜드호텔</option>
						<option value="2" selected="selected">팰리스호텔</option>
						<option value="3">힐 콘도</option>
					<%}else{%>
						<option value="1">그랜드호텔</option>
						<option value="2">팰리스호텔</option>
						<option value="3" selected="selected">힐 콘도</option>
					<%}%>
				</select>
			</td>
	</tr>
	<tr>
		<td style="text-align:center;height:20%;font-weight: bold;" bgcolor="#f5f5f5">주소</td>
		<td><textarea name="address" style="width:100%;height:100%"> </textarea></td>
	</tr>
	<tr>
		<td style="text-align:center;height:6%;font-weight: bold;" bgcolor="#f5f5f5">전화번호</td>
		<td><input type="text" name="phone" style="width:100%;height:100%"></td>
	</tr>
	<tr>
		<td style="text-align:center;height:6%;font-weight: bold;" bgcolor="#f5f5f5">입금자명</td>
		<td><input type="text" name="depositor" style="width:100%;height:100%"></td>
	</tr>
	<tr>
		<td style="text-align:center;height:35%;font-weight: bold;" bgcolor="#f5f5f5">하실 말</td>
		<td><textarea name="comment" style="width:100%;height:100%"> </textarea></td>
	</tr>
<tr style="border-right: hidden;border-left:hidden;border-bottom:hidden">
	<td colspan="2" align=center>
		<input class="btn btn-secondary" type = "reset" value = "초기화">
		<input class="btn btn-primary" type="submit" value="전송" formaction="?contentPage=d_insert.jsp" >

	</td>
</tr>
</table><br><br>
</form>
</body>
</html>