<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.sql.*,javax.sql.*,java.io.*" %>
<%--html에서 받아올 때 한글 깨짐 방지--%>
<% request.setCharacterEncoding("UTF-8"); %>

<HTML>
<HEAD>
</HEAD>
<BODY>
<!-- Downloaded chart.css -->
<link rel="stylesheet" href="chart.css">
<div class="charts">
  <div class="charts__chart"></div>
  ...
</div>
<div class="charts">
  <span>chart--default</span>
  <div class="charts__chart chart--p100 chart--default" data-percent></div><!-- /.charts__chart -->
  <span>chart--blue</span>
  <div class="charts__chart chart--p80 chart--blue" data-percent></div><!-- /.charts__chart -->
  <span>chart--green</span>
  <div class="charts__chart chart--p60 chart--green" data-percent></div><!-- /.charts__chart -->
  <span>chart--red</span>
  <div class="charts__chart chart--p40 chart--red" data-percent></div><!-- /.charts__chart -->
  <span>chart--yellow</span>
  <div class="charts__chart chart--p20 chart--yellow" data-percent></div><!-- /.charts__chart -->
  <span>chart--grey</span>
  <div class="charts__chart chart--p5 chart--grey" data-percent></div><!-- /.charts__chart -->
</div><!-- /.charts -->



</BODY>
</HTML>