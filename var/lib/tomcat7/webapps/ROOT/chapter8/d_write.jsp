<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="java.util.*, java.text.*"  %>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
.title {
	text-align:center
}
.contents {
	text-align:left
}
</style>
<script type="text/javascript">		
	//길이 값이 0인 경우를 잡기 위한 함수
	function submitForm(mode) {
	   if(mode == 'write') {
		  const name = document.getElementById('name');
		  const address = document.getElementById('address');
		  const phone = document.getElementById('phone');
		  const depositor = document.getElementById('depositor');
		  //if문에 해당이 안될 시 d_insert로 이동
		  if(name.value.trim().length == 0){
			   alert("성명을 입력해주세요");
			   return;
		   }else if(address.value.trim().length == 0){
			   alert("주소를 입력해주세요");
			   return;
		   }else if(phone.value.trim().length == 0){
			   alert("전화번호를 입력해주세요");
			   return;
		   }else if(depositor.value.trim().length == 0){
			   alert("입금자명을 입력해주세요");
			   return;
		   }
		   fm.action = "?contentPage=d_insert.jsp";  
	   }
	   fm.submit();
   } 
	// 입력값 제외 function
	// 입력값의 문자 종류 판별하는 함수 아래 function들에서 활용함.
	function check_key() { 
		var char_ASCII = event.keyCode;
		//숫자
		if (char_ASCII >= 48 && char_ASCII <= 57)
			return 1;
		//영어
		else if ((char_ASCII >= 65 && char_ASCII <= 90) || (char_ASCII >= 97 && char_ASCII <= 122))
			return 2;
		//특수기호
		else if ((char_ASCII >= 33 && char_ASCII <= 47) || (char_ASCII >= 58 && char_ASCII <= 64)
			|| (char_ASCII >= 91 && char_ASCII <= 96) || (char_ASCII >= 123 && char_ASCII <= 126))
			return 4;
		//한글
		else if ((char_ASCII >= 12592) || (char_ASCII <= 12687))
			return 3;
		//그 밖에
		else
			return 0;
	}
	//한글 영어만 입력하도록 하는 함수
	function onlyHanEng() {
		if (check_key() != 3 && check_key() != 2) {
			event.returnValue = false;
			alert("한글이나 영문만 입력하세요.");
			return;//리턴으로 아무것도 안 뱉으면 함수가 끝난다
		}
	}
</script>
</head>
<body>
<%
	String resv_date = request.getParameter("resv_date");
	String a = request.getParameter("room");
	int room = Integer.parseInt(a);
	//날짜 형태 세팅
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	//오늘부터 30일 후 까지만 예약을 받게하기 위해 2개의 변수 세팅
	String resv_date_today = sdf.format(cal.getTime());
	cal.add(cal.DATE,+29);
	String resv_date_max = sdf.format(cal.getTime());
%>
<!--제목부분-->
<div class="title">	
	<span style = "font-weight: bold; font-size:2.5em;"><br>
		예약하기
	</span><br>
	리조트를 예약하는 화면입니다.<br><br><br><br>
</div>
<!--내용부분-->
<div class = "contents common" style="width:60%">
<form method="post" id="fm">
<table border=1 align=center style="width:100%;" height="600" >
	<tr>
		<td style="width:10%;text-align:center;height:6%;font-weight: bold;" bgcolor="#f5f5f5">성명</td>
		<!--한글 영어만 입력 가능-->
		<td><input type="text" id="name" name="name" style="width:100%;height:100%" maxlength="10" style="ime-mode:active" onkeypress='onlyHanEng()'></td>
	</tr>
	<tr>
		<td style="text-align:center;height:1%;font-weight: bold;" bgcolor="#f5f5f5">예약일자</td>
			<td>
				<!--오늘 날짜부터 30일 뒤까지만 선택 가능-->
				<input type = "date" min = "<%=resv_date_today%>" max = "<%=resv_date_max%>" name = "resv_date" value="<%=resv_date%>" style="width:100%">
			</td>
	</tr>
	<tr>
		<td style="text-align:center;font-weight: bold;height:6%;" bgcolor="#f5f5f5">예약방</td>
			<td>				
				<select name="room" style="width:100%; height:100%">
					<!--1번이 선택이 됬을시 그랜드호텔이 선택된 채로 보여줌-->
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
		<td><textarea name="address" id = "address" style="width:100%;height:100%" maxlength="50"></textarea></td>
	</tr>
	<tr>
		<td style="text-align:center;height:6%;font-weight: bold;" bgcolor="#f5f5f5">전화번호</td>
		<!--숫자만 입력 가능-->
		<td><input type="text" id = "phone" name="phone" style="width:100%;height:100%" maxlength="15" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
	</tr>
	<tr>
		<td style="text-align:center;height:6%;font-weight: bold;" bgcolor="#f5f5f5">입금자명</td>
		<!--한글 영어만 입력 가능-->
		<td><input type="text" id="depositor" name="depositor" style="width:100%;height:100%" maxlength="10" style="ime-mode:active" onkeypress='onlyHanEng()'></td>
	</tr>
	<tr>
		<td style="text-align:center;height:35%;font-weight: bold;" bgcolor="#f5f5f5">하실 말</td>
		<td><textarea name="comment" style="width:100%;height:100%" maxlength="200"></textarea></td>
	</tr>
<tr style="border-right: hidden;border-left:hidden;border-bottom:hidden">
	<td colspan="2" align=center>
		<input class="btn btn-secondary"  type = "reset" value = "초기화">
		<input  class="btn btn-warning" type="button" value="취소" onclick="location.href='?contentPage=d_list.jsp'" >
		<input class="btn btn-primary" type="button" value="전송" onclick='submitForm("write")'>
	</td>
</tr>
</table><br><br>
</form>
</div>
</body>
</html>