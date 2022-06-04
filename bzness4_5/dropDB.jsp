<%@ page errorPage = "errorDrop.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
	<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
</head>
<body>
<h1>테이블지우기 ok</h1>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	Statement stmt = conn.createStatement();
	stmt.execute("drop table bzness_examtable;");
	stmt.close();
	conn.close();
%>
</table>
</body>
</html>