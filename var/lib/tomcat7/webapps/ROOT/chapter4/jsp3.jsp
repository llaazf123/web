<%@page contentType="text/html; charset=UTF-8"%>
<HTML>
<HEAD>
<%!	//함수나 변수 선언시 !
private String call1(){
	String a = "abc";
	String b = "efg";
	return(a+b);
}
private Integer call2(){
	Integer a = 1;
	Integer b = 2;
	return(a+b);
}
%>
</HEAD>
<BODY>
String연산 : <%=call1()%><br>
Integer연산 : <%=call2()%><br>
Good...
</BODY>
</HTML>