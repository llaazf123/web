<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*, java.text.*"  %>

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
	<%--이미지 미리보기--%>
	<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $("#imgInp").on('change', function(){
                readURL(this);
            });
        });

        function readURL(input) {
            if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                    $('#blah').attr('src', e.target.result);
                }
              reader.readAsDataURL(input.files[0]);
            }
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

        // 숫자만 입력하도록 하는 함수
        function onlyNum() {
            if(check_key() != 1) {
            event.returnValue = false;   
            alert("숫자만 입력할 수 있습니다.");
            return;
            }
        }
	</script>
</HEAD>
<BODY>
<form id="form1" runat="server" method="post" enctype="multipart/form-data">
<table border=1 align=center>
	<tr>
		<td align=center colspan = "2">(주)트와이스 재고 현황 - 상품등록</td>
	</tr>
	<tr>
		<td align=center>상품번호</td>
		<td align=left>신규(insert)</td>
	</tr>
<form>	
	<tr>
		<td align=center>상품명</td>		
			
		<td>
			<input type = "text" name = "name" maxlength="20" placeholder="20자만 입력 가능 합니다.">	
		</td>
	</tr>
	<tr>
		<td align=center>재고현황</td>		
		<td>
			<input type = "text" name = "number" maxlength="4" onkeypress="onlyNum();">	
		</td>
	</tr>
	<tr>
		<td align=center>상품등록일</td>
		<td>
<%
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		String date = sdf.format(new java.util.Date());
		out.println(date);
%>	<input type = "hidden" name= "inventory_date" value = "<%=date%>">		
		</td>
	</tr>
	<tr>
		<td align=center>재고등록일</td>		
		<td>
			<%=date%>	
			<input type = "hidden" name= "register_date" value = "<%=date%>">	
		</td>
	</tr>
	<tr>
		<td align=center>상품설명</td>		
		<td>
			<input type = "text" name = "detail" maxlength="400" placeholder="400자만 입력 가능 합니다."></textarea>
		</td>
	</tr>
	<tr>
		<td align=center>상품사진</td>		
		<td>
			<%-- <img id="blah" src="#" alt="your image"/><br> --%>
			<img id="blah"/><br>
			<input type='file' id="imgInp" name="picture"/>	
		</td>
	</tr>
	<tr>
		<td colspan="2" align=right>
		<input type = "submit" value = "완료" formaction="jaego_insert.jsp">
		</td>	
	</tr>
</table>
</form>
</BODY>
</HTML>