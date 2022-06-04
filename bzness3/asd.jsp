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
	String choicePage = request.getParameter("from");
	int p10 = 10;
	
	//query에 대입될 변수를 선언, 일반적인 자바의입력 방식으로 인식되지 않음-->
	String sp10 = Integer.toString(p10);
	
	if (choicePage == null || "null".equals(choicePage)) {
		choicePage = "1";
	}
	
	
	//string.format 형태로 변환해줘야 함-->
	String query = String.format(" select * from freewifi2 limit "+ choicePage +", "+sp10+";");
	
	//원격으로 데이터베이스에 접근하여 통제-->
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery(query);
%>
<!-- 데이터를 출력하는 테이블 -->
<table cellspacing=1 width=800 border=1 align=center>
	<tr>
		<td width=50><p align=center>번호</p></td>
		<td width=400><p align=center>주소</p></td>
		<td width=50><p align=center>위도</p></td>
		<td width=50><p align=center>경도</p></td>
		<td width=50><p align=center>거리</p></td>
	</tr>
<%		
	//출력될 데이터 
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
<br>
<br>

<!--페이지 이동을 위한 테이블-->
<table cellspacing=1 width=800 border=1 align=center>
	<tr>
		<td width=50 align=center>&lt&lt</td>
		<%
		int inputPage = Integer.parseInt(choicePage);
		int printPage = (inputPage - 1) * 10;
		String stringPage;
		for (int i = inputPage; i < inputPage+10; i++){
			out.print("<td align=center width=50><a href='asd.jsp?from="+Integer.toString(inputPage)+"'>" + Integer.toString(i+1) + "</a></td>");
		}
		%>
		<td width=50 align=center>&gt&gt</td>
	<tr>
</table>
</body>
</html>