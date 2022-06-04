<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta charset="UTF-8">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<title>후보등록 A_01_H.jsp</title>
<%!
	public String huboList(int kiho, String name){
		String query = "<tr><td><form method='post' action='A_03_H.jsp'>기호: <input type='text' name='id' value='" + kiho + 
						"'readonly>이름: <input type='text' name='name' value='" + name + "'><input type='submit' value='삭제'></form></td></tr>";
		return query;
	}
%>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from hubo_table;");
	ResultSet rset1 = stmt.executeQuery("select count(*) from hubo_table;");
%>
<table cellspacing=3 width=600 border=1>
	<%
		while(rset.next()){
			out.print(huboList(rset.getInt(1), rset.getString(2)));
		}
		
		int number = 0;
		while(rset1.next()){
			number = rset1.getInt(1);
		}
	%>
	<tr>
		<td>
			<form method='post' action='A_03_H.jsp'>
			기호: <input type='number' name='id' value='<%=number%>'>이름: <input type='text' name='name' value=''><input type='submit' value='추가'>
			</form>
		</td>
	</tr>
</table>
</body>
</html>