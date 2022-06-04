<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*,java.text.*"%>
<html>
<head>
<style type="text/css"> 
      a { text-decoration:none }   
</style> 
		
<title>후보등록 A01.jsp</title>
<%! // 후보자 등록을 하는 메소드
	public String huboList(int kiho, String name){
		String query = "<tr><td><form method='post' action='A02.jsp'>기호: <input type='number' name='id' value='" + kiho + 
						"'readonly>이름: <input type='text' name='name' pattern='[가-힣a-zA-Z]{2,10}' title='한글,영어 2~10자로 입력해주세요'	value='" + name
						+ "'><input type='submit' value='삭제'></form></td></tr>";
		return query;
	}
%>
</head>
<body>
<% // 후보자 DB에 접속
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from hubo_table;");
%>
<table cellspacing=3 width=600 border=1>
	<tr>
		<td width=100 bgcolor="#00ffff"><a href="A01.jsp">후보등록</a></td>
		<td width=100><a href="B01.jsp">투표</a></td>
		<td width=100><a href="C01.jsp">개표결과</a></td>
	</tr>
</table>

<table cellspacing=3 width=600 border=1>
	<% //DB에서 후보자 정보를 찾아오는 코드
		while(rset.next()){
			out.print(huboList(rset.getInt(1), rset.getString(2)));
		}
		ResultSet rset1 = stmt.executeQuery("select max(id) from hubo_table;");
		int number = 0;
		while(rset1.next()){
			number = rset1.getInt(1) + 1;
		}
	%>
	<tr>
		<td>
			<form method='get' action='A03.jsp'>
				기호: <input type='number' name='id' value='<%=number%>' readonly>이름: 
				<input type='text' pattern="[가-힣a-zA-Z]{2,10}" title='한글,영어 2~10자로 입력해주세요' name='name' value=''>
				<input type='submit' value='추가' bgcolor='#ff00ff'>
			</form>
		</td>
	</tr>
</table>
</body>
</html>