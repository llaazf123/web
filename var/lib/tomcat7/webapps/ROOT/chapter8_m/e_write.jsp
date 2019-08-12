<meta name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*, java.text.*"  %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<HTML>
<HEAD>

<style>


</style>
	<script type="text/javascript" src="/naver-smarteditor2-e618237/demo/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	<%--이미지 미리보기--%>
	<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
    <script type="text/javascript">		
		//내용의 글자 수 제한
		//form 안에 버튼이 2개일때 처리 모드를 변수로 받아 다른 액션을 부여
	    function submitForm(mode) {
           if(mode == 'write') {
              oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
              const content = document.getElementById('content');
			  const title = document.getElementById('title');
              //값이 널일때 잡음
              if(content.value.trim().length == 0 || title.value.trim().length == 0){
                   alert("값을 입력해주세요");
                   return;
               }
              else if(content.value.trim().length >=10000){
                 alert("글은 10000자 까지만");
                 return;
              }	
               fm.action = "e_insert.jsp";  
              
           }
           fm.submit();
       } 
</script>


</HEAD>
<BODY onload="loadPage()">
<%
		int relevel = 0;
		int recnt = 0;
		int rootid = 0;
		String a = request.getParameter("type");
		int type = Integer.parseInt(a);	
%>
<form method="post" enctype="multipart/form-data" id="fm">
<div class="container">
<br><br>
<table align=center>
	<tr>
		<td width="60%" style="font-weight:bold;min-width:40px">제목</td>		
		<!--<form method="post" enctype="multipart/form-data" onsubmit="return submitContents()">-->	
		<td>
			<input type = "text" id="title" name = "title" maxlength="20" placeholder="20자만 입력 가능 합니다."  style="width:100%"></td>			
		</td>
	</tr>
	<tr>
		<td height="70" style="font-weight:bold;">일자</td>
		<td>
<%
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		String date = sdf.format(new java.util.Date());
		out.println(date);
		sdf.setTimeZone(TimeZone.getTimeZone("UTC+9"));
%>	<input type = "hidden" name= "date" value = "<%=date%>">		
		</td>
	</tr>
	<tr>	
		<td colspan="2" width="100%";>
			<%--input이 아닌 textarea로 해야 처음부터 글을 작성 가능--%>
			<%--<textarea name = "content" style="width:300px; height:150px;" maxlength="400" placeholder="400자만 입력 가능 합니다."></textarea>--%>
			<textarea name="content" id="content" rows="22" style="width:100%;"> </textarea>
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
		<td height="80" style="font-weight:bold;">첨부파일</td>		
		<td>
			<input type='file' id="imgInp" name="picture"/>	
		</td>
	</tr>
	<tr height="30" style="border-right: hidden;border-left:hidden;border-bottom:hidden"><td colspan="2"></td></tr>
	<tr style="border-right: hidden;border-left:hidden;border-bottom:hidden">
		<td colspan="2" align=center>
		<%if(type==1){%>
		<input class="btn btn-success" type = "button" value = "취소" onclick="location.href='e_list.jsp?type=1'">
		<%}else{%>
		<input class="btn btn-success" type = "button" value = "취소" onclick="location.href='e_list.jsp?type=2'">
		<%}%>
		<input class="btn btn-primary" type = "button" value = "쓰기" onclick='submitForm("write")'>
		</td>	
	</tr>
	
</table><br><br><br><br>

</div>
</form>	
</BODY>
</HTML>