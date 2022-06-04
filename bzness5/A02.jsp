<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*,java.text.*"%>
<html>
<head>
<style type="text/css"> 
      a { text-decoration:none }   
</style> 
<title>후보삭제 A02.jsp</title>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
	Statement stmt = conn.createStatement();
	
	String num = request.getParameter("id");
	String query = String.format("delete from hubo_table where id=" + num + ";");
	stmt.execute(query);

	// 후보자를 삭제하면 후보자의 표도 사라짐
	query = String.format("delete from tupyo_table where id=" + num + ";");
	stmt.execute(query);
%>

<table cellspacing=3 width=600 border=1>
	<tr>
		<td width=100 bgcolor="#00ffff"><a href="A01.jsp">후보등록</a></td>
		<td width=100><a href="B01.jsp">투표</a></td>
		<td width=100><a href="C01.jsp">개표결과</a></td>
	</tr>
</table>
<br>
<h1>후보등록 삭제 결과 : 후보등록 삭제 완료</h1>
</body>
</html>