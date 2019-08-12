<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<title>떙떙리조트에 오신것을 대 환영합니다 </title>
	<script src="//code.jquery.com/jquery.min.js"></script>
<%
String contentPage = request.getParameter("contentPage");

//contentPage가 아예 없을 시 intro 초기화면을 띄워준다.
if(contentPage==null) {
	contentPage="intro.jsp";}%>
</head>
<body>
	<!--최상단-->
	<div id="top">
	 <jsp:include page="top.html"/>
    </div>
	<!--중간-->
	<div id="main" name=main>
	<jsp:include page="<%=contentPage%>"/>
    </div>
	<!--최하단-->
	<div id="bottom" name=bottom>
	<jsp:include page="bottom.html"/>
    </div>
</body>
</html>

<!--<html>
<head>
한글깨짐 방지
<meta charset="utf-8">
<title>조아리조트에 오신것을 대 환영합니다 </title>

<frameset rows="100,*" frameborder="0" border="0" frameborder="1">
	<frame src = "top.html">
	<frame src = "main.html" name=main>
</frameset>
</head>
<body>
</body>
</html>-->