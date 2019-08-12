<%@ page import="java.io.*" contentType="text/html; charset=UTF-8" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<HTML>
<HEAD>
<%
File f= new File("/var/lib/tomcat7/webapps/ROOT/chapter4/wifi.txt");
BufferedReader br= new BufferedReader(new FileReader(f));
String readtxt;
int startpage=1;
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
		// 융합기술 위도경도
		// 위도 :37.3856012
		// 경도 :127.1203785
		double lat=37.3856012;
		double lng=127.1203785;
		
		int LineCnt=0;
		
		String a = request.getParameter("fromPT");
		String b = request.getParameter("cntPT");
		if(a == null) a = "1";
		if(b == null) b = "10";
		int fromPT = Integer.parseInt(a);
		int cntPT = Integer.parseInt(b);
		
		out.println("<table border=1>");
		out.println("<tr>");
		out.println("<td align=center>번호</td>");
		out.println("<td align=center>주소</td>");
		out.println("<td align=center>위도</td>");
		out.println("<td align=center>경도</td>");
		out.println("<td align=center>거리</td>");
		out.println("</tr>");
		while((readtxt= br.readLine())!=null) {
			
			if(LineCnt<fromPT){ 
			LineCnt++;
			continue;}
			if(LineCnt>fromPT+cntPT-1) break;

			String[] field = readtxt.split("\t");
			
			out.println("<tr>");

			out.println("<td>" + LineCnt + "</td>"); 
			// 9번 : 지번주소
			out.println("<td>" + field[9] + "</td>"); 
			// 12번 : 위도주소
			out.println("<td>" + field[12] + "</td>"); 
			// 13번 : 경도주소
			out.println("<td>" + field[13] + "</td>"); 
			// 거리 계산(pow는 거듭제곱값([대상 숫자], [거듭제곱 횟수]), sqrt는 제곱근값, Double.parseDouble은 문자열을 더블로 강제변환)
			double dist=Math.sqrt(Math.pow(Double.parseDouble(field[12])-lat, 2) + 
								 Math.pow(Double.parseDouble(field[13])-lng, 2));
			out.println("<td>" +  dist + "</td>"); 
			out.println("</tr>");
			LineCnt++;
		}
		out.println("</table>");
		
		//1~10페이지
		if(fromPT>=1&&fromPT<=100){
			out.println("<a href = 'http://192.168.56.102:8080/chapter4/wifi3.jsp?fromPT=1&cntPT=10'><<</a>");
			for(int i=1;i<11;i++){	
				out.println("<a href = 'http://192.168.56.102:8080/chapter4/wifi3.jsp?fromPT=" + (i*10-9) + "&cntPT=10'>" + i + "</a>");
			}
			out.println("<a href = 'http://192.168.56.102:8080/chapter4/wifi3.jsp?fromPT=101&cntPT=10'>>></a>");
		}
		//그 이후 나머지 페이지들
		for(int k=1;k<1000;k++){
			startpage = startpage + 1;
			
				if(fromPT>=((startpage)*100)-99&&fromPT<=(startpage)*100){
					if(startpage<187){
					out.println("<a href = 'http://192.168.56.102:8080/chapter4/wifi3.jsp?fromPT=" + (startpage*100-199) +  "&cntPT=10'><<</a>");
					for(int i=startpage*10-9;i<startpage*10+1;i++){	
							out.println("<a href = 'http://192.168.56.102:8080/chapter4/wifi3.jsp?fromPT=" + (i*10-9) + "&cntPT=10'>" + i + "</a>");				
					}
					out.println("<a href = 'http://192.168.56.102:8080/chapter4/wifi3.jsp?fromPT=" + (startpage*100+1) +  "&cntPT=10'>>></a>");
				}else{
				out.println("<a href = 'http://192.168.56.102:8080/chapter4/wifi3.jsp?fromPT=18501&cntPT=10'><<</a>");
				for(int i=startpage*10-9;i<startpage*10-3;i++){	
							out.println("<a href = 'http://192.168.56.102:8080/chapter4/wifi3.jsp?fromPT=" + (i*10-9) + "&cntPT=10'>" + i + "</a>");				
				}
				}
			}
		}
		

		
		//위의 식 짜기 이전에 햇갈려서 직접 만들어봄
		// if(fromPT>=1&&fromPT<=100){
			// if(k==1){
				// for(int i=1;i<11;i++){	
					// out.println("<a href = 'http://192.168.56.102:8080/chapter4/wifi3.jsp?fromPT=" + (i*10-9) + "&cntPT=10'>" + i + "</a>");
				// }
			// }	
		// }else if(fromPT>=101&&fromPT<=200){
			// for(int i=11;i<21;i++){	
				// out.println("<a href = 'http://192.168.56.102:8080/chapter4/wifi3.jsp?fromPT=" + (i*10-9) + "&cntPT=10'>" + i + "</a>");
			// }startpage = startpage + 1;
		// }else if(fromPT>=201&&fromPT<=300){
			// for(int i=21;i<31;i++){	
				// out.println("<a href = 'http://192.168.56.102:8080/chapter4/wifi3.jsp?fromPT=" + (i*10-9) + "&cntPT=10'>" + i + "</a>");
			// }startpage = startpage + 2;
		// }


		br.close();
%>
</BODY>
</HTML>