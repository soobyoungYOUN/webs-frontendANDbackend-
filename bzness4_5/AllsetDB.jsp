<!-- html과 jsp에서 한글처리 -->
<%@ page errorPage = "errorAllsetDB.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!-- html과 jsp에서 한글처리 -->
<%@ page contentType="text/html; charset=utf-8" %>
<!-- 임포트할 파일 -->
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html> <!-- html 시작 --> 
<head> <!-- 머리말 -->
</head> 
<body> <!-- 본문 -->
<h1>실습데이터 입력</h1>
<% //jsp 언어 입력, 데이터 입력
	// 원격으로 db접속 및 조종 
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	
	// 명령 처리 
	Statement stmt = conn.createStatement();
	
	// 데이터 입력 명령 실행 -->
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('나연', 209901, 95,100,95);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('정연', 209902, 95,95,95);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('모모', 209903, 100,100,100);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('사나', 209904, 100,95,90);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('지효', 209905, 80,100,70);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('미나', 209906, 95,90,95);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('다현', 209907, 100,90,100);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('채영', 209908, 100,75,90);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('쯔위', 209909, 100,100,70);");	
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('나연', 209910, 95,100,95);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('정연', 209911, 95,95,95);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('모모', 209912, 100,100,100);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('사나', 209913, 100,95,90);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('지효', 209915, 80,100,70);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('미나', 209916, 95,90,95);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('다현', 209917, 100,90,100);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('채영', 209918, 100,75,90);");
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('쯔위', 209914, 100,100,70);");	
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('팽수', 209919, 10,100,50);");	
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values ('팽수', 209920, 100,10,70);");	
	stmt.close();
	conn.close();
%>
</body>
</html>