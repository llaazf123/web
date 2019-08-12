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
	<script type="text/javascript" src="/naver-smarteditor2-e618237/demo/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	<%--이미지 미리보기--%>
	<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
    <script type="text/javascript">
		//미리보기
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
		
		//내용의 글자 수 제한
		//form 안에 버튼이 2개일때 처리 모드를 변수로 받아 다른 액션을 부여
	    function submitForm(mode) {
           if(mode == 'write') {
              oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
              const content = document.getElementById('content');
            
              //값이 널일때 잡음
              if(content.value.trim() == ""){
                   alert("값을 입력해주세요");
                   return;
               }
              else if(content.value.trim().length >=50){
                 alert("글은 50자 까지만");
                 return;
              }	
               fm.action = "?contentPage=e_insert.jsp";  
              
           }else if(mode == 'cancel'){
              fm.action = "?contentPage=e_01_list.jsp";
           }
           fm.submit();
       } 
</script>


</HEAD>
<BODY onload="loadPage()">
<%
		String a = request.getParameter("type");
		int type = Integer.parseInt(a);
		out.println(type);
%>



<table border=1 align=center>
	<tr>
		<td align=center>번호</td>
		<td align=left>신규(insert)</td>
	</tr>
	<tr>
		<td align=center>제목</td>		
		<!--<form method="post" enctype="multipart/form-data" onsubmit="return submitContents()">-->	
		<form method="post" enctype="multipart/form-data" id="fm">	
		<td>
			<input type = "text" id="title" name = "title" maxlength="20" placeholder="20자만 입력 가능 합니다."></td>			
		</td>
	</tr>
	<tr>
		<td align=center>일자</td>
		<td>
<%
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		String date = sdf.format(new java.util.Date());
		out.println(date);
		sdf.setTimeZone(TimeZone.getTimeZone("UTC+9"));
		
		int relevel = 0;
		int recnt = 0;
		int rootid = 0;

%>	<input type = "hidden" name= "date" value = "<%=date%>">		
</td>
	</tr>
	<tr>
		<td align=center>내용</td>		
		<td width="645";>
			<%--input이 아닌 textarea로 해야 처음부터 글을 작성 가능--%>
			<%--<textarea name = "content" style="width:300px; height:150px;" maxlength="400" placeholder="400자만 입력 가능 합니다."></textarea>--%>
			<textarea name="content" id="content" rows="22" style="width:645px;"> </textarea>
				<script type="text/javascript">
					 var oEditors = [];

					 nhn.husky.EZCreator.createInIFrame({

					 oAppRef: oEditors,

					 elPlaceHolder: "content", //textarea에서 지정한 id와 일치해야 합니다.

					 sSkinURI: "${contextPath} /naver-smarteditor2-e618237/demo/index.html",

					 fCreator: "createSEditor2"

					 });

				</script>
			<input type = "hidden" name= "relevel" value = "<%=relevel%>">		
			<input type = "hidden" name= "recnt" value = "<%=recnt%>">	
			<input type = "hidden" name= "rootid" value = "<%=rootid%>">		
			<input type = "hidden" name= "type" value = "<%=type%>">			
		</td>
	</tr>
	<tr>
		<td align=center>첨부파일</td>		
		<td>
			<%-- <img id="blah" src="#" alt="your image"/><br> --%>
			<img id="blah"/><br>
			<input type='file' id="imgInp" name="picture"/>	
		</td>
	</tr>
	<tr>
		<td colspan="2" align=right>
		<input type = "submit" value = "쓰기" onclick='submitForm("write")'>
		<input type = "button" value = "취소" onclick='submitForm("cancel")'>
		</td>	
		</form>
	</tr>
	</table>
</BODY>
</HTML>