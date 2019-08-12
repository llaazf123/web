<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*"%>
<html>
<head>
</head>
<body>
<h1>날씨 조회</h1>
<%
	//파싱을 위한 준비과정
	String strUrl = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123";
	
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document doc = builder.parse(strUrl);
	
	//각 태그들을 불러와 태그변수에 저장
	NodeList tag_hour = doc.getElementsByTagName("hour");
	NodeList tag_day = doc.getElementsByTagName("day");
	NodeList tag_temp = doc.getElementsByTagName("temp");
	NodeList tag_tmx = doc.getElementsByTagName("tmx");
	NodeList tag_tmn = doc.getElementsByTagName("tmn");
	NodeList tag_sky = doc.getElementsByTagName("sky");
	NodeList tag_pty = doc.getElementsByTagName("pty");
	NodeList tag_wfKor = doc.getElementsByTagName("wfKor");
	NodeList tag_wfEn = doc.getElementsByTagName("wfEn");
	NodeList tag_pop = doc.getElementsByTagName("pop");
	NodeList tag_r12 = doc.getElementsByTagName("r12");
	NodeList tag_s12 = doc.getElementsByTagName("s12");
	NodeList tag_ws = doc.getElementsByTagName("ws");
	NodeList tag_wd = doc.getElementsByTagName("wd");
	NodeList tag_wdKor = doc.getElementsByTagName("wdKor");
	NodeList tag_wdEn = doc.getElementsByTagName("wdEn");
	NodeList tag_reh = doc.getElementsByTagName("reh");
	NodeList tag_r06 = doc.getElementsByTagName("r06");
	NodeList tag_s06 = doc.getElementsByTagName("s06");
	
	//각 변수들 초기값을 지정
	String hour = "";
	String day = "";
	String temp = "";
	String tmx = "";
	String tmn = "";
	String sky = "";
	String pty = "";
	String wfKor = "";
	String wfEn = "";
	String pop = "";
	String r12 = "";
	String s12 = "";
	String ws = "";
	String wd = "";
	String wdKor = "";
	String wdEn = "";
	String reh = "";
	String r06 = "";
	String s06 = "";
	
	out.println("<table cellspacing=1 width='100%' border=1 style='text-align:center'>");
	out.println("<tr>");
	out.println("<td width=100>seq</td>");
	out.println("<td width=100>동네예보 3시간 단위</td>");
	out.println("<td width=100>day</td>");
	out.println("<td width=100>현재 시간온도</td>");
	out.println("<td width=100>최고 온도</td>");
	out.println("<td width=100>최저 온도</td>");
	out.println("<td width=100>하늘 상태코드</td>");
	out.println("<td width=100>강수 상태코드</td>");
	out.println("<td width=100>날씨 한국어</td>");
	out.println("<td width=100>날씨 영어</td>");
	out.println("<td width=100>강수 확률</td>");
	out.println("<td width=100>12시간 예상 강수량</td>");
	out.println("<td width=100>12시간 예상 적설량</td>");
	out.println("<td width=100>풍속(m/s)</td>");
	out.println("<td width=100>풍향</td>");
	out.println("<td width=100>풍향 한국어</td>");
	out.println("<td width=100>풍향 영어</td>");
	out.println("<td width=100>습도(%)</td>");
	out.println("<td width=100>6시간 예상 강수량</td>");
	out.println("<td width=100>6시간 예상 적설량</td>");
	out.println("</tr>");

	//변수들에 저장
	for(int i=0;i<tag_hour.getLength();i++){
		hour = tag_hour.item(i).getFirstChild().getNodeValue();
		day = tag_day.item(i).getFirstChild().getNodeValue();
		temp = tag_temp.item(i).getFirstChild().getNodeValue();
		tmx = tag_tmx.item(i).getFirstChild().getNodeValue();
		tmn = tag_tmn.item(i).getFirstChild().getNodeValue();
		sky = tag_sky.item(i).getFirstChild().getNodeValue();
		pty = tag_pty.item(i).getFirstChild().getNodeValue();
		wfKor = tag_wfKor.item(i).getFirstChild().getNodeValue();
		wfEn = tag_wfEn.item(i).getFirstChild().getNodeValue();
		pop = tag_pop.item(i).getFirstChild().getNodeValue();
		r12 = tag_r12.item(i).getFirstChild().getNodeValue();
		s12 = tag_s12.item(i).getFirstChild().getNodeValue();
		ws = tag_ws.item(i).getFirstChild().getNodeValue();
		wd = tag_wd.item(i).getFirstChild().getNodeValue();
		wdKor = tag_wdKor.item(i).getFirstChild().getNodeValue();
		wdEn = tag_wdEn.item(i).getFirstChild().getNodeValue();
		reh = tag_reh.item(i).getFirstChild().getNodeValue();
		r06 = tag_r06.item(i).getFirstChild().getNodeValue();
		s06 = tag_s06.item(i).getFirstChild().getNodeValue();
		
		out.println("<tr>");
		//아래와 같은 형식으로 불러온다.
		out.println("<td width=100>"+i+"</td>");
		out.println("<td width=100>"+hour+"</td>");
		if(day.equals("0")){
			out.println("<td width=100>오늘</td>");
		}else if(day.equals("1")){
			out.println("<td width=100>내일</td>");
		}else{
			out.println("<td width=100>모레</td>");
		}
		out.println("<td width=100>"+temp+"</td>");
		out.println("<td width=100>"+temp+"</td>");
		out.println("<td width=100>"+tmn+"</td>");
		if(sky.equals("1")){
			out.println("<td width=100><img src='sunny.png' width='100%'></td>");
		}else if(sky.equals("2")){
			out.println("<td width=100><img src='partlycloudy.png' width='100%'></td>");
		}else if(sky.equals("3")){
			out.println("<td width=100><img src='mostlycloudy.png' width='100%'></td>");
		}else{
			out.println("<td width=100><img src='cloudy.png' width='100%'></td>");
		}
		if(pty.equals("0")){
			out.println("<td width=100><img src='sunny.png' width='100%'></td>");
		}else if(pty.equals("1")){
			out.println("<td width=100><img src='rain1.png' width='100%' ></td>");
		}else if(pty.equals("2")){
			out.println("<td width=100><img src='rain2.png' width='100%' ></td>");
		}else if(pty.equals("3")){
			out.println("<td width=100><img src='rain3.png' width='95%' ></td>");
		}else{
			out.println("<td width=100><img src='rain4.png' width='100%' ></td>");
		}
		
		out.println("<td width=100>"+wfKor+"</td>");
		out.println("<td width=100>"+wfEn+"</td>");
		out.println("<td width=100>"+pop+"</td>");
		out.println("<td width=100>"+r12+"</td>");
		out.println("<td width=100>"+s12+"</td>");
		out.println("<td width=100>"+ws.substring(0,3)+"</td>");
		if(wd.equals("0")){
			out.println("<td width=100><img src='wind0.png' width='100%' ></td>");
		}else if(wd.equals("1")){
			out.println("<td width=100><img src='wind1.png' width='100%' ></td>");
		}else if(wd.equals("2")){
			out.println("<td width=100><img src='wind2.png' width='100%' ></td>");
		}else if(wd.equals("3")){
			out.println("<td width=100><img src='wind3.png' width='100%' ></td>");
		}else if(wd.equals("4")){
			out.println("<td width=100><img src='wind4.png' width='100%' ></td>");
		}else if(wd.equals("5")){
			out.println("<td width=100><img src='wind5.png' width='100%' ></td>");
		}else if(wd.equals("6")){
			out.println("<td width=100><img src='wind6.png' width='100%' ></td>");
		}else{
			out.println("<td width=100><img src='wind7.png' width='100%' ></td>");
		}
		out.println("<td width=100>"+wdKor+"</td>");
		out.println("<td width=100>"+wdEn+"</td>");
		out.println("<td width=100>"+reh+"</td>");
		out.println("<td width=100>"+r06+"</td>");
		out.println("<td width=100>"+s06+"</td>");
		out.println("</tr>");
	}
%>
</body>
</html>