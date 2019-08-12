<HTML>
<HEAD>
</head>
<body>
<%

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.56.102:3306/kopoctc?useSSL=false&serverTimezone=UTC", "root", "kopo17");
		Statement stmt = conn.createStatement(); 
		

		stmt.execute(
"create table resort_resv ( "+
"name varchar(20), "+   //성명	
"resv_date date not null, "+  //예약일
"room int not null, "+ //예약방 1:VIP룸 2:일반룸 3:합리적인룸
"address varchar(100), "+  //주소
"phone varchar(20), "+ //연락처
"depositor  varchar(20), "+ //입금자명
"comment  text, "+ //남기실말
"write_date date, "+// 예약한(이 글을 쓴) 날짜
"process int, "+//현재 진행 1:예약완료 2: 입금완료(예약확정) 3: 환불요청 4:...
"primary key (resv_date,room) )"+  // 예약일과 룸을 합쳐서 DB의 키로 사용
"DEFAULT CHARSET=utf8"); 

		stmt.close();
		conn.close();


%>
</body>
</html>