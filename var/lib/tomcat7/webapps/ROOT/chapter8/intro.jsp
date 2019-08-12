<meta http-equiv="content-Type" content="text/html; charset=utf-8"/>
<%@ page contentType="text/html; charset=UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
</head>
<body>

<div id="myCarousel" class="carousel slide" data-ride="carousel"> 
	<!--페이지-->
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>

	</ol>
	<!--페이지-->
	<div class="carousel-inner">
		<!--슬라이드1-->
		<div class="item active" align=center> 
			<img src="picture/index1.jpg" alt="First slide" style="width:100%">
			<div class="container">
				<div class="carousel-caption">
					<span style = "font-weight: bold; font-size:2.5em;"><br>
						꽃, 바람, 숲, 빛과 함께하는 국민쉼터
					</span>
					<p>가족여행은 4계절 힐링의 성소 떙떙리조트에서</p>
				</div>
			</div>
		</div>
		<!--슬라이드1-->

		<!--슬라이드2-->
		<div class="item" align=center> 
			<img src="picture/index2.jpg" data-src="" alt="Second slide" style="width:100%">
			<div class="container">
				<div class="carousel-caption">
					<span style = "font-weight: bold; font-size:2.5em;"><br>
						꽃, 바람, 숲, 빛과 함께하는 국민쉼터
					</span>
					<p>가족여행은 4계절 힐링의 성소 떙떙리조트에서</p>
				</div>
			</div>
		</div>
		<!--슬라이드2-->
		
		<!--슬라이드3-->
		<div class="item" align=center> 
			<img src="picture/index3.jpg" data-src="" alt="Third slide" style="width:100%">
			<div class="container">
				<div class="carousel-caption">
					<span style = "font-weight: bold; font-size:2.5em;"><br>
						꽃, 바람, 숲, 빛과 함께하는 국민쉼터
					</span>
					<p>가족여행은 4계절 힐링의 성소 떙떙리조트에서</p>
				</div>
			</div>
		</div>
		<!--슬라이드3-->
	</div>
	
	<!--이전, 다음 버튼-->
	<a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a> 
	<a class="right carousel-control" href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a> 
</div>
  

</body>
</html>