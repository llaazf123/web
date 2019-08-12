<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page errorPage="error.jsp"%>

<HTML>
<HEAD>
	<script>	
		var my_form;
		function init() {
			my_form = document.getElementById('my_form');
		}
			
		function update_db () {
			my_form.action = 'updateDB.jsp';
			my_form.submit();
		}
		
		function delete_db () {
			my_form.action = 'deleteDB.jsp';
			my_form.submit();
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
        // 숫자만 입력하도록 하는 함수
        function onlyNum() {
            if(check_key() != 1) {
            event.returnValue = false;   
            alert("숫자만 입력할 수 있습니다.");
            return;
            }
        }
		function minmax(value, min, max) {
			if(parseInt(value) < min || isNaN(parseInt(value))) 
			return min; 
			else if(parseInt(value) > max) 
			return max; 
			else return value;
		}
	</script>
</HEAD>
<BODY onload="init()">
<h1><성적 조회 후 정정/삭제></h1>
<%
	try{
		String a = request.getParameter("student_id");
		int student_id = Integer.parseInt(a);
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select * from examtable where studentid=" + student_id + ";");
%>		
		<form method='post' id='my_form'>
<%		if(!rset.next()){
			out.println("존재하지 않는 학번입니다.");
		}else{ 
%>			이름 : <input type="text" name="name" value='<%=rset.getString(1)%>' style="ime-mode:active" onkeypress='onlyHanEng()'><br>
			학번 : <input type='text' name='student_id' value='<%=Integer.toString(rset.getInt(2))%>' readonly><br>
			국어 : <input type='number' name='korean' value='<%=Integer.toString(rset.getInt(3))%>' onkeyup="this.value = minmax(this.value, 0, 100)"><br>
			영어 : <input type='number' name='english' value='<%=Integer.toString(rset.getInt(4))%>' onkeyup="this.value = minmax(this.value, 0, 100)"><br>
			수학 : <input type='number' name='math' value='<%=Integer.toString(rset.getInt(5))%>' onkeyup="this.value = minmax(this.value, 0, 100)"><br>
<%		
		out.println("<input type = 'submit' value = '수정' onclick='update_db()'>");
		out.println("<input type = 'submit' value = '삭제' onclick='delete_db()'>");
		out.println("</form>");
		}
		rset.close();
		stmt.close();
		conn.close();

	}catch(Exception e){
		out.println("값이 없습니다.");
	}
%>
</BODY>
</HTML>