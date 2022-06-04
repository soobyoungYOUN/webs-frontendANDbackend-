<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>
<h1>조회</h1>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from c3_examtable;");
%>
<table cellspacing=1 width=600 border=1>
<%
	while (rset.next()){
		out.println("<tr>");
		out.println("<td width=50><p align=center>"+rset.getString(1)+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");
		out.println("<tr>");
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
</body>
</html>