<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*"%>
<html>
<head>
</head>
<body>
<h1>와이파이 조회</h1>
<%
	//파싱을 위한 준비과정
	DocumentBuilder docBuilder= DocumentBuilderFactory.newInstance().newDocumentBuilder();
	
	//당연히 파일을 읽을 때 서버내부 local path(전체경로)로 지정 .. 이 문장이 xml파싱을 한다. 단 위에 xml관련 임포트를 주의하라.
	Document doc = docBuilder.parse(new File("/var/lib/tomcat7/webapps/ROOT/2chapter2/wifi.xml"));
	
	Element root = doc.getDocumentElement();	//root태그를 가져오기도 하지만 이 소스에서는 쓰이는 곳이 없다.

	//태그들을 가져와서 변수에 저장
	NodeList tag_address = doc.getElementsByTagName("소재지지번주소");
	NodeList tag_latitude = doc.getElementsByTagName("위도");
	NodeList tag_longitude = doc.getElementsByTagName("경도");

	out.println("<table cellspacing=1 width=500 border=1>");
	out.println("<tr>");
	
	out.println("<td width=100>순번</td>");
	out.println("<td width=100>소재지지번주소</td>");
	out.println("<td width=100>위도</td>");
	out.println("<td width=100>경도</td>");

	
	out.println("</tr>");
	
	for(int i=0;i<tag_address.getLength();i++){
		out.println("<tr>");
		//아래와 같은 형식으로 불러온다.
		out.println("<td width=100>"+ i + "</td>");
		out.println("<td width=100>"+tag_address.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_latitude.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_longitude.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("</tr>");
	}
%>
</body>
</html>