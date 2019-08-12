<%@page import="java.sql.*,
javax.mail.*,javax.mail.internet.*"
	contentType="text/html; charset=EUC-KR" %>	//선언
<HTML>
<BODY>
	<% String myUrl = "http://www.kopo.ac.kr";%>
	<%--<%=%>는 변수 값을 출력함 --%>
	<a href="<%=myUrl%>">Hello</a> World.
</BODY>
</HTML>