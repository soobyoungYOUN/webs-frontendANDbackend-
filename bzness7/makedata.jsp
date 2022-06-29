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
  try{
    stmt.execute("drop table if exists gongji");
    out.println("drop table if gongji OK <br>");
  } catch(Exception e){
    out.println("drop table gongji NOT OK <br>");
    out.println(e.getMessage());
  }
  stmt.execute("create table gongji( id int not null primary key auto_increment, title varchar(70), date date, content text) DEFAULT CHARSET=utf8");

  String sql="";
  sql = "alter table gongji add rootid int"; stmt.execute(sql);
  sql = "alter table gongji add relevel int"; stmt.execute(sql);
  sql = "alter table gongji add recnt int"; stmt.execute(sql);
  sql = "alter table gongji add viewcnt int"; stmt.execute(sql);
  for (int i = 0; i < 121; i++) {
    StringBuffer sb = new StringBuffer();
    StringBuffer sb2 = new StringBuffer();
    sb.append("공지사항").append(i+1);
    sb2.append("공지사항내용").append(i+1);
    sql = "insert into gongji(title, date, content) values('" + sb + "', date(now()),'" + sb2 + "')"; stmt.execute(sql);
  }

  stmt.close();
  conn.close();
%>
</body>
</html>