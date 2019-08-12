<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*, java.text.*"  %>
<HTML>
<HEAD>
<style>
table {
	border:1px solid black;
	border-collapse: collapse;
}
tr {
	border:1px solid black;
}
td {
	border-bottom:1px solid black;
}
</style>
</HEAD>
<BODY>
<%
		String title = request.getParameter("title");
		String a = request.getParameter("id");
		int id = Integer.parseInt(a);
		
		
		String date = "";
		String content = "";
		int rootid = 0;
		int relevel = 0;
		int recnt = 0;
		int viewcnt = 0;
		int aa = 0;
		
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		
		stmt.execute("update gongji set viewcnt= viewcnt + 1 where id =" + id + ";");
		
		ResultSet rset = stmt.executeQuery("select * from gongji where id=" + id + ";");
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		sdf.setTimeZone(TimeZone.getTimeZone("UTC+9"));
		
		String picture = "";
		
		while(rset.next()) {
			viewcnt = rset.getInt(3);
			date = sdf.format(rset.getTimestamp(4));
			content = rset.getString(5);
			rootid = rset.getInt(6);
			relevel = rset.getInt(7);
			recnt = rset.getInt(8);
			picture = rset.getString(9);
		}
%>

<table border=1 align=center>
	<tr>
		<form method = "post">	
		<td align=center>번호</td>
		<td align=left><%=id%></td>
		<input type = "hidden" value = "<%=id%>" name = "id">
	</tr>
	<tr>
		<td align=center>제목</td>		
		<td>
			<%=title%>
			<input type = "hidden" value = "<%=title%>" name = "title">
		</td>
	</tr>
	<tr>
		<td align=center>일자</td>
		<td>
			<%=date%>	
			<input type = "hidden" value = "<%=date%>" name = "date">
		</td>
	</tr>
	<tr>

	<td align=center>조회수</td>		
		<td>
			<%=viewcnt%>
			<input type = "hidden" value = <%=viewcnt%> name = "viewcnt">
		</td>
	</tr>

	<tr>
		<td align=center>내용</td>		
		<td>
			<%=content%>
		</td>
	</tr>
	
	<tr>
		<td align=center>원글</td>		
		<td>
			<%=rootid%>
			<input type = "hidden" value = "<%=rootid%>" name = "rootid">
		</td>
	</tr>
	
	 <%
		//대댓글
		aa = recnt;
		rset = stmt.executeQuery("select rootid, relevel, recnt from gongji where rootid=" + rootid + " and recnt>" + recnt + " order by recnt asc;");
		while(rset.next()) {
			if (relevel < rset.getInt(2)){
				aa = rset.getInt(3);
			}else{
				break;
			}
		}aa++;         	
	%>
	
	<%
		 // aa = recnt;
		 // rset = stmt.executeQuery("select rootid, relevel, recnt from gongji where rootid=" + rootid + " and recnt>" + recnt + " order by recnt asc;");
		// while(rset.next()) {
			// if (relevel >= rset.getInt(2)){
				// break;
			// }aa = rset.getInt(3);
		// }aa++;	
	%>
	
	<tr>
		<td align=center>댓글수준</td>		
		<td>
			<%=relevel%>
			<input type = "hidden" value = "<%=relevel+1%>" name = "relevel"> 
	</tr>
	
	<tr>
		<td align=center>댓글내 순서</td>		
		<td>
			<%=recnt%>
			<input type = "hidden" value = "<%=aa%>" name = "recnt">
			<input type = "hidden" value = "<%=recnt%>" name = "recnt2">
		</td>
	</tr>
	<tr>
		<td align=center>첨부파일</td>		
		<td>
		<%if(picture.equals("null")){
			out.println("");
		}else{%>
		<img src="picture/<%=picture%>">
		<a href="picture/<%=picture%>" download><%=picture%></a><br>
		<%}%>
		<input type = "hidden" value = "<%=picture%>" name = "picture">
		</td>
	</tr>
	<tr>
		<td colspan="2" align=right><input type = "submit" value = "목록" formaction="gongji_list.jsp">
		<input type = "submit" value = "수정" formaction="gongji_beforeupdate.jsp">
		<input type = "submit" value = "삭제" formaction="gongji_delete.jsp">
		<input type = "submit" value = "댓글" formaction="gongji_rewrite.jsp"></td>	
		</form>
	</tr>
	</table>
<%
		rset.close();
		stmt.close();
		conn.close();
%>
</BODY>
</HTML>