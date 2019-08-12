<%@page import="java.text.*,java.util.*"%>
<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*, java.text.*"  %>

<% //session option
	session.setAttribute("session_id", "park");
	SimpleDateFormat fmt = new SimpleDateFormat("yy-MM-dd [hh:mm:ss]");
	long createTime = (long)session.getCreationTime(); //세션 생성시간
	long lastTime = (long)session.getLastAccessedTime();//마지막 처리 시간
%>
session 생성 시간 ==> <%=fmt.format(new Date(createTime))%><br>
session 마지막 처리 시간 ==> <%=fmt.format(new Date(lastTime))%><br>
session 유지 시간 ==> <%=(int) session.getMaxInactiveInterval()%><br>
session 유지 시간 변경 ==> <%session.setMaxInactiveInterval(5);%><br>
session값 표시 ==> <%=(String)session.getAttribute("session_id")%><br>
session ID ==> <%=session.getId()%><br>
session 유지 시간 ==> <%=(int)session.getMaxInactiveInterval()%><br>
