<%@ page import="java.io.*" contentType="text/html; charset=UTF-8" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<HTML>
<HEAD>
<%
File f= new File("/var/lib/tomcat7/webapps/ROOT/chapter4/wifi.txt");
BufferedReader br= new BufferedReader(new FileReader(f));
String readtxt;
%>
</HEAD>
<BODY>

<%

		// 첫번째 줄이 비어있으면 종료
		if((readtxt=br.readLine())==null) {
			out.println("빈 파일입니다");
			br.close();
			return;
		}
		// 첫줄은 필드명이기 때문에 따로 읽는다.
		// 탭을 기준으로 필드를 나눈다.
		String[] field_name= readtxt.split("\t");
		
		// 융합기술 위도경도
		// 위도 :37.3856012
		// 경도 :127.1203785
		double lat=37.3856012;
		double lng=127.1203785;
		
		int LineCnt=0;
		out.println("<table border=1>");
		while((readtxt= br.readLine())!=null) {
			String[] field = readtxt.split("\t");
			
			out.println("<tr>");
			out.println("<td>" + LineCnt + "번째 항목</td>"); 
			// 9번 : 지번주소
			out.println("<td>" + field_name[9] + ":" + field[9] + "</td>"); 
			// 12번 : 위도주소
			out.println("<td>" + field_name[12] + ":" + field[12] + "</td>"); 
			// 13번 : 경도주소
			out.println("<td>" + field_name[13] + ":" + field[13] + "</td>"); 
			// 거리 계산(pow는 거듭제곱값([대상 숫자], [거듭제곱 횟수]), sqrt는 제곱근값, Double.parseDouble은 문자열을 더블로 강제변환)
			double dist=Math.sqrt(Math.pow(Double.parseDouble(field[12])-lat, 2) + 
								 Math.pow(Double.parseDouble(field[13])-lng, 2));
			out.println("<td> 현재지점과 거리 : " + dist + "</td>"); 
			out.println("</tr>");
			LineCnt++;
			
		}
		out.println("</table>");
		br.close();
%>
</BODY>
</HTML>