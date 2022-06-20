<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="java.sql.*"%>
<!-- 문서 인코딩 방식 및 자바 활용을 위한 import -->
<html>
<head>
  <%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%>
</head>
<body>
  <h1>Make table</h1>
<%
  Class.forName("com.mysql.jdbc.Driver");
  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
  Statement stmt = conn.createStatement();
%>
<%
  try{
    out.println("drop table gongji OK <br>");
  } catch(Exception e){
    out.println("drop table gongji NOT OK <br>");
    out.println( e.toString() );
  }
%>
<%stmt.execute("create table gongji( id int not null primary key auto_increment, title varchar(70), date date, content text) DEFAULT CHARSET=utf8"); %>
<%
  String sql="";
  sql="insert into gongji(title, date, content) values('공지사항1', date(now()),'공지사항내용1')"; stmt.execute(sql);
  sql="insert into gongji(title, date, content) values('공지사항2', date(now()),'공지사항내용2')"; stmt.execute(sql);
  sql="insert into gongji(title, date, content) values('공지사항3', date(now()),'공지사항내용3')"; stmt.execute(sql);
  sql="insert into gongji(title, date, content) values('공지사항4', date(now()),'공지사항내용4')"; stmt.execute(sql);
  sql="insert into gongji(title, date, content) values('공지사항5', date(now()),'공지사항내용5')"; stmt.execute(sql);

  stmt.close();
  conn.close();
%>
</body>
</html>