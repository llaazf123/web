<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*,java.util.*"%>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*"%>
<html>
<head>
</head>
<body>
<h1>도로공사 조회</h1>

<%

	
	//파싱을 위한 준비과정
	String strUrl = "http://openapi.its.go.kr:8082/api/NEventIdentity?key=1498271446332&ReqType=2&MinX=127.100000&MaxX=128.890000&MinY=34.100000%20&MaxY=39.100000&type=its";
	
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document doc = builder.parse(strUrl);
	String coordxArr="";
	String coordyArr="";
	
	//태그를 가진 값들을 리스트 식으로 받기 위해 NodeList로 선언 
	NodeList tag_eventtype = doc.getElementsByTagName("eventtype");
	NodeList tag_lanesblocktype = doc.getElementsByTagName("lanesblocktype");
	NodeList tag_LanesBlocked = doc.getElementsByTagName("lanesblocked"); 
	NodeList tag_EventStartDay = doc.getElementsByTagName("eventstartday");
	NodeList tag_EventEndDay = doc.getElementsByTagName("eventendday"); 
	NodeList tag_EventStartTime = doc.getElementsByTagName("eventstarttime"); 
	NodeList tag_EventEndTime = doc.getElementsByTagName("eventendtime"); 
	NodeList tag_EventStatusMsg = doc.getElementsByTagName("eventstatusmsg");
	NodeList tag_ExpectedDetourMsg = doc.getElementsByTagName("expecteddetourmsg"); 
	NodeList tag_EventDirection = doc.getElementsByTagName("eventdirection"); 
	NodeList tag_coordx = doc.getElementsByTagName("coordx"); 
	NodeList tag_coordy = doc.getElementsByTagName("coordy"); 
	
	
	//각 변수들 초기값을 지정
	String eventtype = "";
	String lanesblocktype = "";
	String LanesBlocked = "";
	String EventStartDay = "";
	String EventEndDay = "";
	String EventStartTime = "";
	String EventEndTime = "";
	String EventStatusMsg = "";
	String ExpectedDetourMsg = "";
	String EventDirection = "";
	String coordx = "";
	String coordy = "";

	
	
	out.println("<table cellspacing=1 width='100%' border=1 style='text-align:center'>");
	out.println("<tr>");
	out.println("<td width=100>공사정보유형</td>");
	out.println("<td width=100>차단 방법</td>");
	out.println("<td width=100>차단된 차로 수</td>");
	out.println("<td width=100>공사 시작일</td>");
	out.println("<td width=100>공사 종료일</td>");
	out.println("<td width=100>공사 실제 개시 시간</td>");
	out.println("<td width=100>공사 실제 종료 시간</td>");
	out.println("<td width=100>공사 상황 정보 메시지</td>");
	out.println("<td width=100>우회정보 메시지</td>");
	out.println("<td width=100>진행방향</td>");
	out.println("<td width=100>지도보기</td>");
	out.println("</tr>");
	

	//변수들에 저장
	for(int i=0;i<tag_eventtype.getLength();i++){
		eventtype = tag_eventtype.item(i).getFirstChild().getNodeValue();
		lanesblocktype = tag_lanesblocktype.item(i).getFirstChild().getNodeValue();
		if(tag_LanesBlocked.item(i).getFirstChild()==null){
			LanesBlocked = "";
		 }
		else{
			LanesBlocked = tag_LanesBlocked.item(i).getFirstChild().getNodeValue();
		}
		
		// EventStartDay = tag_EventStartDay.item(i).getFirstChild().getNodeValue();
	
		
		if(tag_EventEndDay.item(i).getFirstChild()==null){
			EventEndDay = "";
		}
		if(tag_EventStartTime.item(i).getFirstChild()==null){
			EventStartTime = "";
		}
		if(tag_EventEndTime.item(i).getFirstChild()==null){
			EventEndTime = "";
		}
		if(tag_EventStatusMsg.item(i).getFirstChild()==null){
			EventStatusMsg = "";
		}else{
			EventStatusMsg = tag_EventStatusMsg.item(i).getFirstChild().getNodeValue();
		}
		if(tag_ExpectedDetourMsg.item(i).getFirstChild()==null){
			ExpectedDetourMsg = "";
		}
		if(tag_EventDirection.item(i).getFirstChild()==null){
			EventDirection = "";
		}else{
			EventDirection = tag_EventDirection.item(i).getFirstChild().getNodeValue();
		}
		coordx = tag_coordx.item(i).getFirstChild().getNodeValue();
		coordy = tag_coordy.item(i).getFirstChild().getNodeValue();
		
		out.println("<tr>");
		//아래와 같은 형식으로 불러온다.
		out.println("<td width=100>"+eventtype+"</td>");
		out.println("<td width=100>"+lanesblocktype+"</td>");
		out.println("<td width=100>"+LanesBlocked+"</td>");
		out.println("<td width=100>"+EventStartDay+"</td>");
		out.println("<td width=100>"+EventEndDay+"</td>");
		out.println("<td width=100>"+EventStartTime+"</td>");
		out.println("<td width=100>"+EventEndTime+"</td>");
		out.println("<td width=100>"+EventStatusMsg+"</td>");
		out.println("<td width=100>"+ExpectedDetourMsg+"</td>");
		out.println("<td width=100>"+EventDirection+"</td>");
		out.println("<td width=100><a href = 'map_one.jsp?coordx=" + coordx + "&coordy=" + coordy + "'>지도보기</a></td>");

		
		coordxArr = coordxArr + coordx + ",";
		coordyArr = coordyArr + coordy + ",";
		
		out.println("</tr>");
	}%>
		<form method="post" action='map_all.jsp'>
		<input type = "hidden" value = "<%=coordxArr%>" name = "coordxArr">
		<input type = "hidden" value = "<%=coordyArr%>" name = "coordyArr">
		<input type = "submit" value = "전체지도보기">
		</form>

</body>
</html>