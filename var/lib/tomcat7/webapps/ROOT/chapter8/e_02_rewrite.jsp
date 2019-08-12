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
	<!--에디터-->
	<script type="text/javascript" src="/naver-smarteditor2-e618237/demo/js/service/HuskyEZCreator.js" charset="utf-8"></script>
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
               fm.action = "?contentPage=e_02_reinsert.jsp";  
              
           }else if(mode == 'cancel'){
              fm.action = "?contentPage=e_02_list.jsp";
           }
           fm.submit();
       } 
</script>
</HEAD>
<BODY>
<%
		String a = request.getParameter("id");
		int id = Integer.parseInt(a);
		String c = request.getParameter("relevel");
		int relevel = Integer.parseInt(c);
		String d = request.getParameter("recnt");
		int recnt = Integer.parseInt(d);
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		String date = sdf.format(new java.util.Date());
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select* from resort where id =" + id + ";");
		String title = "";
		String content = "";
		int rootid = 0;

		
		while(rset.next()) {
			title = rset.getString(2);
			content = rset.getString(5);
			rootid = rset.getInt(6);
		}
		
		
%>
<table border=1 align=center>
	<tr>
		<form method="post"  enctype="multipart/form-data" id="fm">	
		<td align=center>번호</td>
		<td align=left>댓글</td>
	</tr>
	<tr>
		<td align=center>제목</td>		
		<td align=left>
		<input type = "text"  name = "title" maxlength="20" placeholder="20자만 입력 가능 합니다."></td>
		
	</tr>
	<tr>
		<td align=center>일자</td>
			<td align=left><%=date%></td>
			<td align=left><input type = "hidden" value = "<%=date%>" name = "date"></td>
	</tr>
	<tr>
		<td align=center>내용</td>	
		<td align=left width="645">		
		<!--<textarea name = "content" style="width:300px; height:150px;" maxlength="400" placeholder="400자만 입력 가능 합니다."><%=content%></textarea>-->
		
		<textarea name="content" id="content" rows="22" style="width:645px;"></textarea>
				<script type="text/javascript">
					 var oEditors = [];

					 nhn.husky.EZCreator.createInIFrame({

					 oAppRef: oEditors,

					 elPlaceHolder: "content", //textarea에서 지정한 id와 일치해야 합니다.

					 sSkinURI: "${contextPath} /naver-smarteditor2-e618237/demo/index.html",

					 fCreator: "createSEditor2"

					 });

				</script>
		
		</td>	
	</tr>
	<tr>
		<td align=center>원글</td>
		<%if(relevel>1){
			%>
			<td align=left><%=rootid%></td>
			<td align=left><input type = "hidden" value = "<%=rootid%>" name = "rootid"></td>
		
		<%}else {%>
			<td align=left><%=id%></td>
			<td align=left><input type = "hidden" value = "<%=id%>" name = "rootid"></td>
		<%}%>
	</tr>
	<tr>
		<td align=center>댓글수준</td>
			<td align=left><%=relevel%></td>
			<td align=left><input type = "hidden" value = "<%=relevel%>" name = "relevel"></td>
	</tr>
	<tr>
		<td align=center>댓글 내 순서</td>
			<td align=left><%=recnt%></td>
			<td align=left><input type = "hidden" value = "<%=recnt%>" name = "recnt"></td>
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
		<td colspan="2" align=right><input type = "button" value = "취소" onclick='submitForm("cancel")'>
		<input type = "button" value = "쓰기" onclick='submitForm("write")'></td>	
		</form>
	</tr>
	</table>
</BODY>
</HTML>