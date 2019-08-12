<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*, java.text.*"  %>
<HTML>
<HEAD>
<style>
td,tr {
padding: 8px;
}
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
	<!--에디터-->
	<script type="text/javascript" src="/naver-smarteditor2-e618237/demo/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
    <script type="text/javascript">
		//내용의 글자 수 제한 및 길이가 0인 경우를 잡는 함수
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
               fm.action = "?contentPage=e_reinsert.jsp";  
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
		
		String content = "";
		int rootid = 0;

		while(rset.next()) {
			rootid = rset.getInt(6);
		}		
%>
<form method="post"  enctype="multipart/form-data" id="fm">	
<div class="contents common">
<br><br><br><br><br><br>
<table align=center style="width:100%;">
	<tr>
		<td width="10%" style="font-weight:bold;">제목</td>		
		<td align=left>
		<input type = "text" id = "title" name = "title" maxlength="20" placeholder="20자만 입력 가능 합니다." style="width:100%"></td>
	</tr>
	<tr>
		<td style="font-weight:bold;">일자</td>
			<td align=left><%=date%></td>
			<input type = "hidden" value = "<%=date%>" name = "date">
	</tr>
	<tr>	
		<td align=left colspan="2" width="645">		
		<textarea name="content" id="content" rows="22" style="width:100%;"></textarea>
				<!--네이버 에디터 api 사용-->
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
		<%if(relevel>1){
			%>
			<input type = "hidden" value = "<%=rootid%>" name = "rootid">
		<%}else {%>
			<input type = "hidden" value = "<%=id%>" name = "rootid">
		<%}%>
			<input type = "hidden" value = "<%=relevel%>" name = "relevel">
			<input type = "hidden" value = "<%=recnt%>" name = "recnt">
	<tr>
		<td style="font-weight:bold;">첨부파일</td>		
		<td>
			<input type='file' id="imgInp" name="picture"/>	
		</td>
	</tr>
	<tr height="30" style="border-right: hidden;border-left:hidden;border-bottom:hidden"><td colspan="2"></td></tr>
	<tr style="border-right: hidden;border-left:hidden;border-bottom:hidden">
		<td colspan="2" align=center>
			<input class="btn btn-secondary" type = "button" value = "취소" onclick="location.href='?type=2&contentPage=e_list.jsp';">
			<input class="btn btn-primary" type = "button" value = "댓글쓰기" onclick='submitForm("write")'>
		</td>	
	</tr>
	</table><br><br><br><br>
	</div>
	</form>
</BODY>
</HTML>