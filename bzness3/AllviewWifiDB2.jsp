<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>
<h1>와이파이</h1>
<%
	//출력할 데이터의 번호와 그 수를 지정하는 변수 선언-->
	int sum = 0;
	int p10 = 10;
	
	//query에 대입될 변수를 선언, 일반적인 자바의입력 방식으로 인식되지 않음-->
	String sSum = Integer.toString(sum);
	String sp10 = Integer.toString(p10);
	String query;
	//string.form 형태로 변환해줘야 함-->
	query = String.format(" select * from freewifi2 limit "+ sSum +", "+sp10+";");
	
	//원격으로 데이터베이스에 접근하여 통제-->
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery(query);
%>
<!-- 데이터를 출력하는 테이블 -->
<table cellspacing=1 width=600 border=1>
	<tr>
		<td width=50><p align=center>번호</p></td>
		<td width=400><p align=center>주소</p></td>
		<td width=50><p align=center>위도</p></td>
		<td width=50><p align=center>경도</p></td>
		<td width=50><p align=center>거리</p></td>
	</tr>
<%		
	while (rset.next()){
		out.println("<tr>");
		out.println("<td width=50><p align=center>" + rset.getString(1) + "</p></td>");
		out.println("<td width=400><p align=center>"+rset.getString(2)+"</p></td>");
		out.println("<td width=50><p align=center>"+Double.toString(rset.getDouble(3))+"</p></td>");
		out.println("<td width=50><p align=center>"+Double.toString(rset.getDouble(4))+"</p></td>");
		out.println("<td width=50><p align=center>"+Double.toString(rset.getDouble(5))+"</p></td>");
		out.println("<tr>");
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>

<table cellspacing=1 width=800 border=1>
	<tr>
		<td width=50>&lt&lt</td>
		<%
		String inTOstr; 
		String stringPage;
		
		for (int i = 0; i < 10; i++){
			inTOstr = Integer.toString(i+1);
			stringPage = String.form("<td>" + inTOstr + "</td>");
			out.print(stringPage);
		}
		%>
		<td width=50>&gt&gt</td>
	<tr>
</table>
</body>
</html>