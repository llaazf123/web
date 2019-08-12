<%@ page language="java" contentType="text/html; charset=EUC-KR"
 pageEncoding="EUC-KR"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-ｅquiv="Content-Type" content="text/html; charset=EUC-KR">
<title>멀티파트 테스트 결과</title>
</head>
<body>
<%
 String type = request.getContentType();
 int len = request.getContentLength();
%>
MIME: <%=type%><br>
길이: <%=len %>
<xmp>
<%
 ServletInputStream in = request.getInputStream(); //서버입장에선입력
 byte[] buf = new byte[1024];
 int n = 0;
 while((n = in.read(buf, 0, 1024))>0) {
  out.println(new String(buf, 0, n));
 }//while
 in.close();
%>
</xmp>
</body>
</html>