<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %> 
<!-- java.net.* 한글의 post/get의 파라미터로 연동될 때 필요함-->
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>
<html> <!-- html 시작 -->
<head> <!-- 머리말 시작 -->
</head> <!-- 머리말 종료 -->
<body> <!-- 본문 시작 -->
<h1>레코드 삭제</h1> <!-- 본문 입력 -->
<%
	//mysql 원격 접속 및 조종
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	Statement stmt = conn.createStatement();
	
	//html 주소로부터 studentid 변수의 값을 받아옴
	String cTmp = request.getParameter("studentid");
	//cTmp의 문자를 8859_1 코드셋을 받아들여 utf-8로 변환하여 새로운 string 생성
	//한글데이터를 데이터베이스로부터 가져올 때
	String cTmpHan = new String(cTmp.getBytes("8859_1"), "utf-8"); 
	
	String sql = "delete from bzness_examtable where studentid = " + cTmp;
	
	stmt.executeUpdate(sql);
	
	ResultSet rset = stmt.executeQuery("select * from bzness_examtable;");
%>
</body> <!-- 본문 종료 -->
</html> <!-- html 종료 -->