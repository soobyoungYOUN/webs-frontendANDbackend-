<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*,java.text.*"%>
<html>
<head>
<style type="text/css"> 
      a { text-decoration:none }   
</style> 
<title>투표 B01</title>
<%!
	public String huboChoice(int kiho, String name){
		String query = "<option value=" + kiho + ">" + kiho + "번 " + name;
		return query;
	}
	
	public String ageChoice(int ii){
		String query = "<option value=" + ii + ">" + (ii*10) + "대";
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
%>

<table cellspacing=3 width=600 border=1>
	<tr>
		<td width=100><a href="A01.jsp">후보등록</a></td>
		<td width=100 bgcolor="#00ffff"><a href="B01.jsp">투표</a></td>
		<td width=100><a href="C01.jsp">개표결과</a></td>
	</tr>
</table>
<h1>투표하기</h1>
<table cellspacing=3 width=600 border=1>
	<tr>
		<form method="post" action="B02.jsp">
			<td width=200><p align=center>
				<select name=huboChoice>
					<%
						while(rset.next()){
							out.print(huboChoice(rset.getInt(1), rset.getString(2)));
						}
					%>
				</select>
			</p></td>
			<td width=200><p align=center>
				<select name=ageChoice>
					<%
						for(int i = 1; i < 10; i++){
							out.print(ageChoice(i));
						}
					%>
				</select>
			</p></td>
			<td><input type=submit value="투표하기" align=right></td>
		</form>
	</tr>
</table>
</body>
</html>