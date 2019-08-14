<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="user-scable= no, width=device-width" />
<meta name="apple-mobile-web-app-capable" content="yes"/>
<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
<meta http-equiv="Cache-Control" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<meta http-equiv="Pragma" content="no-cache"/>
<script language='javascript' type='text/javascript'>
var orientationEvent;
var uAgent=navigator.userAgent.toLowerCase();
var mobilePhones= 'android';
if(uAgent.indexOf(mobilePhones)!=-1){
   orientationEvent="resize";   //안드로이드는 resize로 들어옴
}
else orientationEvent="orientationchange"; //아이폰은 이렇게 들어옴
window.addEventListener(orientationEvent, function(){
   alert("회전했어요");
   location.href('#');
}, false);

var prevScreen=0;
var sv_prevScreen=0;

function prevShow(){
	//iframe을 활용하다 보니 back버튼을 누르면 초기 화면이 나뉘어져 나오는 사태가 일어나서 prevScreen이 0일때 작동하지 않게 만듬
  if(prevScreen!=0){
	   ScreenShow( prevScreen );
  }
}

//서브메뉴를 선택(하단 버튼을 누름)했을 때 함수
var muCnt = 5; //서브메뉴
var scCnt = 12; //화면
function fncShow( pos ){
   var i = 0;
   
   //모든 일반화면은 막는다.
   for(i=0; i<scCnt; i++){
      var obj = document.getElementById("s"+i);
      obj.style.display = 'none';
   }
  
   //메뉴선택에 따라 중간메뉴 div는 보여주고, 누른 버튼의 배경을 바꿔준다
   for(i=0; i<muCnt; i++){
      var obj = document.getElementById("menu"+i);
      var obj2 = document.getElementById("m"+i);
      
      if(i == pos){
         obj.style.display = '';
         obj2.style.background="#ff0000"; //하단 버튼 누르면 빨강
      }else{
         obj.style.display = 'none';
         obj2.style.background="#ffff00"; //안눌리면 노랑
      }
   }
}

//총 화면은 11개이고 화면이 선택된 번호에 따라 화면을 보여주는 함수
var scCnt = 12;
var ScrObj;

var timer1;

// function ScrAnimation(){
  // var offset = -50;
  
  // if(parseInt(ScrObj.style.left)> 10){
    // ScrObj.style.left = parseInt(ScrObj.style.left) + offset + "px";
    // timer1 = setTimeout("ScrAnimation()", 1);
  // }else{
    // ScrObj.style.left=5;
    // clearTimeout(timer1);
  // }
// }

function ScreenShow(pos){
   var i = 0;
   //모든 메뉴 페이지는 막는다.
   for (i=0;i<muCnt; i++){
      var obj = document.getElementById("menu"+i);
      obj.style.display = 'none';
   }
   
   //선택된 화면번호의 화면만 보여준다
   for(i=0; i<scCnt; i++){
      var obj = document.getElementById("s"+i);
      if(i == pos){
		 prevScreen = sv_prevScreen;

		 sv_prevScreen=i;

		 obj.style.display = '';

		 obj.style.position="relative";
		 obj.style.top=35;
		 obj.style.left=screen.width;
		 obj.style.height=screen.height-120;

		 ScrObj=obj;
		 ScrAnimation();
      }else{
         obj.style.display='none';
      }
   }
}
</script>
<style type="text/css">
li {text-align: left;vertical-align: middle;margin: 2;padding: 10;height: 20;background-color: #aaaa00;border: 2px;solid:red;font-size: 16px}
ul {text-align: left;vertical-align: middle;margin: 2;padding: 10;height: 20;background-color: #bbaabb;border: 2px;solid:red;font-size: 16px}
.header{  
   z-index: 2;
   position: relative;
}
</style>
</head>
<body onload='ScreenShow(0);'>
<center>

<div class='container' style='width:device-width;height:device-height;'>
	<!--뒤로가기, 홈버튼이 있는 상단부-->
	<div class = "header" id = "header1" style="background-color:#00FFFF;height:35px;width:15%;float:left;" onclick='prevShow();'><center>
		<img src="picture/back.png" width="40px" height="32px"></center>
	</div>
	<div class = "header" id = "header2" style="background-color:#00FFFF;height:35px;width:70%;float:left;"><center style="margin:10px;"><B>떙떙리조트</B></center>
	</div>
	<div class = "header" id = "header3" style="background-color:#00FFFF;height:35px;width:15%;float:left;" onclick='ScreenShow(0);'>
	<center>
		<!--iframe을 활용하다 보니 home버튼을 누르면 초기 화면이 나뉘어져 나오는 사태가 일어나서 아예 home버튼에 첫화면 링크를 걸음-->
		<a href = "http://192.168.56.102:8080/chapter8_m/">
		<img src="picture/home.png" width=30px height=32px>
		</a>
	</center>
	</div>
  <!--메뉴를 눌렀을 때 나오는 소메뉴-->
  <div id="menu0" style="background-color: #eeeeee; display:none; width: device-width;">
  객실
    <li style="font-size:1.5em" onclick="ScreenShow(0);">떙떙리조트</li>
    <li style="font-size:1.5em" onclick="ScreenShow(1);">그랜드호텔(메인타워)</li>
    <li style="font-size:1.5em" onclick="ScreenShow(2);">팰리스호텔</li>
    <li style="font-size:1.5em" onclick="ScreenShow(3);">힐 콘도</li>
    <br>
  </div>
  <div id="menu1" style="background-color: #eeeeee; display:none; width: device-width;">
    찾아오기
      <li style="font-size:1.5em" onclick="ScreenShow(4);">대중교통이용</li>
      <li style="font-size:1.5em" onclick="ScreenShow(5);">자가용이용</li>
      <br>
  </div>
  <div id="menu2" style="background-color: #eeeeee; display:none; width: device-width;">
    카지노
      <li style="font-size:1.5em" onclick="ScreenShow(6);">카지노 소개</li>
      <li style="font-size:1.5em" onclick="ScreenShow(7);">시설안내</li>
	  <li style="font-size:1.5em" onclick="ScreenShow(8);">입장안내</li>
      <br>
  </div>
  <div id="menu3" style="background-color: #eeeeee; display:none; width: device-width;">
    예약하기
      <li style="font-size:1.5em" onclick="ScreenShow(9);">예약상황</li>
      <br>
  </div>
  <div id="menu4" style="background-color: #eeeeee; display:none;">
    게시판
      <li style="font-size:1.5em" onclick="ScreenShow(10);">리조트소식</li>
      <li style="font-size:1.5em" onclick="ScreenShow(11);">이용후기</li>
      <br>
  </div>

  <!--중간 메인부-->
  <div id="s0" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
    <center>
      <img src="picture/first.jpg" width="359px" height="309px">
      <br> 떙떙리조트로 놀러오세요
    </center>
  </div>
  <div id="s1" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
    <center>
		<!--iframe을 활용하여 이전에 만들었던 파일들을 불러옴-->
		<iframe src="/chapter8_m/a_01.html" frameborder="0" border="0" bordercolor="white"
     style="width:100vw; height: 88vh;" marginwidth="0" marginheight="0"
    scrolling="yes"></iframe>
    </center>
  </div>
  <div id="s2" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
    <center>
        <iframe src="/chapter8_m/a_02.html" frameborder="0" border="0" bordercolor="white"
     style="width:100vw; height: 88vh;" marginwidth="0" marginheight="0"
    scrolling="yes"></iframe>
    </center>
  </div>
  <div id="s3" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
    <center>
        <iframe src="/chapter8_m/a_03.html" frameborder="0" border="0" bordercolor="white"
     style="width:100vw; height: 88vh;" marginwidth="0" marginheight="0"
    scrolling="yes"></iframe>
    </center>
  </div>
  <div id="s4" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
    <iframe src="/chapter8_m/b_01.html" frameborder="0" border="0" bordercolor="white"
     style="width:100vw; height: 88vh;" marginwidth="0" marginheight="0"
    scrolling="yes"></iframe>
  </div>
  <div id="s5" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
    <iframe src="/chapter8_m/b_02.html" frameborder="0" border="0" bordercolor="white"
     style="width:100vw; height: 88vh;" marginwidth="0" marginheight="0"
    scrolling="yes"></iframe>
  </div>
  <div id="s6" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
	<iframe src="/chapter8_m/c_01.html" frameborder="0" border="0" bordercolor="white"
     style="width:100vw; height: 88vh;" marginwidth="0" marginheight="0"
    scrolling="yes"></iframe>
  </div>
  <div id="s7" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
    <iframe src="/chapter8_m/c_02.html" frameborder="0" border="0" bordercolor="white"
     style="width:100vw; height: 88vh;" marginwidth="0" marginheight="0"
    scrolling="yes"></iframe>
  </div>
  <div id="s8" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
    <iframe src="/chapter8_m/c_03.html" frameborder="0" border="0" bordercolor="white"
     style="width:100vw; height: 88vh;" marginwidth="0" marginheight="0"
    scrolling="yes"></iframe>
  </div>
  <div id="s9" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
    <iframe src="/chapter8_m/d_list.jsp" frameborder="0" border="0" bordercolor="white"
     style="width:100vw; height: 88vh;" marginwidth="0" marginheight="0"
    scrolling="yes"></iframe>
  </div>
  <div id="s10" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
    <iframe src="/chapter8_m/e_list.jsp?type=1" frameborder="0" border="0" bordercolor="white"
     style="width:100vw; height: 88vh;" marginwidth="0" marginheight="0"
    scrolling="yes"></iframe>
  </div>
  <div id="s11" style="background-image:url(../image/background.jpg); display:none; width:device-width;">
     <iframe src="/chapter8_m/e_list.jsp?type=2" frameborder="0" border="0" bordercolor="white"
     style="width:100vw; height: 88vh;" marginwidth="0" marginheight="0"
    scrolling="yes"></iframe>
  </div>
  
  <!--하단 메뉴부-->
  <div id="m0" onclick="fncShow(0);" style="position:fixed;bottom: 3px;left:1%;background-color: #ff0000;height: 40px;width: 18%;float:left;">
  <center><img src="picture/room.png" width="40px" height="40px"><br>
    </center>
  </div>
  <div id="m1" onclick="fncShow(1);" style="position:fixed;bottom: 3px;left:21%;background-color: #ffff00;height: 40px;width: 18%;float:left;">
    <center><img src="picture/road.png" width="40px" height="40px"><br>
    </center>
  </div>
  <div id="m2" onclick="fncShow(2);" style="position:fixed;bottom: 3px;left:41%;background-color: #ffff00;height: 40px;width: 18%;float:left;">
      <center><img src="picture/casino.png" width="40px" height="40px"><br>
      </center>
  </div>
  <div id="m3" onclick="fncShow(3);" style="position:fixed;bottom: 3px;left:61%;background-color: #ffff00;height: 40px;width: 18%;float:left;">
    <center><img src="picture/reservation.png" width="40px" height="40px"><br>
    </center>
  </div>
  <div id="m4" onclick="fncShow(4);" style="position:fixed;bottom: 3px;left:81%;background-color: #ffff00;height: 40px;width: 18%;float:left;">
    <center><img src="picture/board.png" width="40px" height="40px"><br>
    </center>
  </div>

</div>
</center>

</body>
</html>