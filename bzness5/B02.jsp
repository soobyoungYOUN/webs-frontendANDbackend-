<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*,java.text.*"%>
<html>
<head>
<style type="text/css"> 
      a { text-decoration:none }   
</style> 
<title>B02</title>
</head>
<body>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
	Statement stmt = conn.createStatement();
	
	int num = Integer.parseInt(request.getParameter("huboChoice"));
	int age = Integer.parseInt(request.getParameter("ageChoice"));
	
	String query = String.format("insert into tupyo_table values (" + num + ", " + age + ");");
	stmt.execute(query);
%>

<table cellspacing=3 width=600 border=1>
	<tr>
		<td width=100><a href="A01.jsp">후보등록</a></td>
		<td width=100><a href="B01.jsp">투표</a></td>
		<td width=100 bgcolor="#00ffff"><a href="C01.jsp">개표결과</a></td>
	</tr>
</table>
<br>
<h1>투표 결과 : 투표를 완료하였습니다.</h1>
</body>
</html>