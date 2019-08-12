<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*, java.text.*"  %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<HTML>
<HEAD>
<style>

.common {
	width:90%;
	margin:auto;
}
.contents {
	text-align:left
}
</style>
</HEAD>
<BODY>
<%
		String a = request.getParameter("id");
		int id = Integer.parseInt(a);
		String loginOK=null;
		
		loginOK = (String)session.getAttribute("login_ok");
		
		String title = "";
		String date = "";
		String content = "";
		int rootid = 0;
		int relevel = 0;
		int recnt = 0;
		int viewcnt = 0;
		int aa = 0;
		int type = 0;
		
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		stmt.execute("update resort set viewcnt= viewcnt + 1 where id =" + id + ";");
		
		ResultSet rset = stmt.executeQuery("select * from resort where id=" + id + ";");
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yy-MM-dd HH:mm");
		sdf.setTimeZone(TimeZone.getTimeZone("UTC+9"));
		
		String picture = "";
		
		while(rset.next()) {
			title = rset.getString(2);
			viewcnt = rset.getInt(3);
			date = sdf.format(rset.getTimestamp(4));
			content = rset.getString(5);
			rootid = rset.getInt(6);
			relevel = rset.getInt(7);
			recnt = rset.getInt(8);
			if(rset.getString(9)==null){
				picture = "null"; 	
			}else{
				picture = rset.getString(9);
			}
			type = rset.getInt(10);
		}

%>
<form method = "post">	
<table class="common" align=center style="height:700;text-align:center" ><br><br><br><br><br><br><br>
	<tr height="8%" style="border-bottom:1px dashed #E6E6E6;">
		<td width="5%"><%=id%></td>
		<td width="20%" align=left><%=title%></td>
		<td width="8%"><%=date%></td>
		<td width="5%"><%=viewcnt%></td>
		<input type = "hidden" value = "<%=id%>" name = "id">
		<input type = "hidden" value = "<%=title%>" name = "title">
		<input type = "hidden" value = "<%=date%>" name = "date">
		<input type = "hidden" value = <%=viewcnt%> name = "viewcnt">
	</tr>
	<tr>
		<td colspan="4" height="50%" style="text-align:left">
			<div class="contents common">
			<%=content%>
			</div>
		</td>
	</tr>
			<input type = "hidden" value = "<%=rootid%>" name = "rootid">
	 <%
		//대댓글
		aa = recnt;
		rset = stmt.executeQuery("select rootid, relevel, recnt from resort where rootid=" + rootid + " and recnt>" + recnt + " order by recnt asc;");
		while(rset.next()) {
			if (relevel < rset.getInt(2)){
				aa = rset.getInt(3);
			}else{
				break;
			}
		}aa++;         	
		rset.close();
		stmt.close();
		conn.close();
	%>
	
	<%
		 // aa = recnt;
		 // rset = stmt.executeQuery("select rootid, relevel, recnt from resort where rootid=" + rootid + " and recnt>" + recnt + " order by recnt asc;");
		// while(rset.next()) {
			// if (relevel >= rset.getInt(2)){
				// break;
			// }aa = rset.getInt(3);
		// }aa++;	
	%>
			<input type = "hidden" value = "<%=relevel+1%>" name = "relevel"> 
			<input type = "hidden" value = "<%=aa%>" name = "recnt">
			<input type = "hidden" value = "<%=recnt%>" name = "recnt2">

	<tr height="8%" style="border-top:1px dashed #E6E6E6;">
		<td align=center style="font-weight:bold;" bgcolor="#f5f5f5" width="10%">첨부파일</td>		
		<td colspan="3" align=left>
		<%if(picture.equals("null")){
			out.println("");
		}else{%>
		<a href="picture/<%=picture%>" download><%=picture%></a><br>
		<%}%>
		<input type = "hidden" value = "<%=picture%>" name = "picture">
		</td>
	</tr>
	<input type = "hidden" value = "<%=type%>" name = "type">
	<tr align=right  style="border-right: hidden;border-left:hidden;border-bottom:hidden">
		<%if(type==1){
			if(loginOK==null){%>
			<td colspan="4"><input class="btn btn-success" type = "submit" value = "목록" formaction="e_list.jsp?type=1">
			<%}else{%>
			<td colspan="4"><input class="btn btn-success" type = "submit" value = "목록" formaction="e_list.jsp?type=1">
			<input type = "submit" class="btn btn-warning" value = "수정" formaction="e_beforeupdate.jsp">
			<input type = "submit"  class="btn btn-danger" value = "삭제" formaction="e_delete.jsp"></td>	
			<%}%>
		<%}else{%>
		<td colspan="4"><input class="btn btn-success" type = "submit" value = "목록" formaction="e_list.jsp?type=2">
		<input type = "submit" class="btn btn-warning" value = "수정" formaction="e_beforeupdate.jsp">
		<input type = "submit" class="btn btn-danger" value = "삭제" formaction="e_delete.jsp">
		<input type = "submit" class="btn btn-info" value = "댓글" formaction="e_rewrite.jsp"></td>	
		<%}%>
	</tr>
</table><br><br><br><br>
</form>
</BODY>
</HTML>