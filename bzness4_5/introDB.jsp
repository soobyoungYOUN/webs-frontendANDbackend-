<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %> 
<!-- java.net.* 한글의 post/get의 파라미터로 연동될 때 필요함-->
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>
<html> <!-- html 시작 -->
<head> <!-- 머리말 시작 -->
<style type="text/css"> 
      a { text-decoration:none }   
</style> 
</head>
<body>
<h1><center> JSP Database 실습 1</center></h1>
<%
	//데이터 베이스 원격 접속 및 조종-->
	int add = 1;
	int now = 0;
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	Statement stmt = conn.createStatement();
	//DB 명령 결과를 받아서 변수에 대입 -->
	ResultSet rset = stmt.executeQuery("select * from JSPcount;");
	while(rset.next()){
		now = rset.getInt(1);
	}
	
	stmt.execute("insert into JSPcount values (" + (now + add) +");");
	
	ResultSet rsetAfter = stmt.executeQuery("select * from JSPcount;");
	while(rsetAfter.next()){
		now = rsetAfter.getInt(1);
	}
	out.println("<br><br>현재 홈페이지 방문조회수는 ["+now+"] 입니다</br>");
%>
</body>
</html>