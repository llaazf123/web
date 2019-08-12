<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding= "UTF-8" trimDirectiveWhitespaces="true" %>
   
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.net.URLEncoder" %>

<%
     String fileName = request.getParameter("filename");

     String sFilePath = "/chapter7-1/" + fileName;

     byte b[] = new byte [10 * 1024 * 1024];
     File oFile = new File(sFilePath);

     out.clearBuffer();
     response.setContentType("application/octet-stream");
//      response.setHeader("Content-Disposition", "attachment;filename=" +      
//           URLEncoder.encode(fileName, "utf-8"));
     
 //sample.jpg 파일명으로 다운로드 되게끔 수정함
     response.setHeader("Content-Disposition", "attachment;filename=" +      
             URLEncoder.encode("sample.jpg", "utf-8"));
     
     
     FileInputStream in = new FileInputStream(sFilePath);
     ServletOutputStream out2 = response.getOutputStream();
     int numRead;
     while((numRead = in.read(b, 0, b.length)) != -1) {
          out2.write(b, 0, numRead);
     }
     out2.flush();
     out2.close();
     in.close();
%>