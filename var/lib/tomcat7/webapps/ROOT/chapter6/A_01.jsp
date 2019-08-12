<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>

<HTML>
<HEAD>
<script>
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
        // 숫자만 입력하도록 하는 함수
        function onlyNum() {
            if(check_key() != 1) {
            event.returnValue = false;   
            alert("숫자만 입력할 수 있습니다.");
            return;
            }
        }
</script>
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
	<tr>
		<td align=center bgcolor = '#ffff00'><a href = 'http://192.168.56.102:8080/chapter6/A_01.jsp'>후보등록</a></td>
		<td align=center><a href = 'http://192.168.56.102:8080/chapter6/B_01.jsp'>투표</a></td>
		<td align=center><a href = 'http://192.168.56.102:8080/chapter6/C_01.jsp'>개표결과</a></td>	
	</tr>
</table>
<table align=center>
<%
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		
		ResultSet rset = stmt.executeQuery("select * from hubo order by id;");

		while(rset.next()) {
%>	
<tr>
		<td width=100><p align=left> <%out.println("기호번호 : " + Integer.toString(rset.getInt(1))); %></p></td>
		<td width=100><p align=left>  <%out.println ("후보명 : " + rset.getString(2)); %></p></td>
		<td></td>
		<td> <form method="post" action = "A_02.jsp">
				<input type = "hidden" name= "id" value = "<%=Integer.toString(rset.getInt(1))%>">	
				<input type = "submit" value = "삭제">		
			</form></td>
	</tr>
	<%}%>	
<%		int id =0;
		rset = stmt.executeQuery("select * from hubo where id='1';");

		if(rset.next()){
			rset = stmt.executeQuery("select min(id+1) from hubo where (id+1) not in (select id from hubo);");
			rset.next();
			id = rset.getInt(1);
		}else{
			id = 1;
		}
%>
	<tr>
		<form method="post" action = "A_03.jsp">
			<td>기호번호 : <input type="text" value="<%=id%>" name="id" style="text-align:left; width:30px; height:40px; font-size:17px;"readonly></td>
			<td>후보명 : <input type="text" name="name" onkeypress='onlyHanEng()' style="ime-mode:active; text-align:left; width:60px; height:40px; font-size:15px;"></td>
			<td></td>
			<td><input type = "submit" value = "추가"></td>
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