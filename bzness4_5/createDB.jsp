<!--한글깨짐 방지-->
<%@ page errorPage = "errorCreate.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %> <!--한글깨짐 방지-->
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %> <!--라이브러리 임포트-->
<html> <!--html 실행-->
<head> <!--머리말 실행-->
</head>
<body>
<h1>테이블만들기 ok</h1>
<%	//db에 원격 접속 및 조종
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	Statement stmt = conn.createStatement();
	
	//db에서 테이블 생성
	stmt.execute("create table bzness_examtable(" +
		"name varchar(20)," +
		"studentid int not null primary key," +
		"kor int," +
		"eng int," +
		"mat int) default charset=utf8;");
		
	stmt.close();
	conn.close();
%>
</body>
</html>