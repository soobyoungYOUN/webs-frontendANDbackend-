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
    stmt.execute("drop table distribution");
    out.println("drop table distribution OK <br>");
  } catch(Exception e){
    out.println("drop table distribution NOT OK <br>");
    out.println( e.toString() );
  }
%>
<%stmt.execute("create table distribution( id int not null primary key auto_increment, name varchar(70), count int, countingDate date, registeredDate date, discription varchar(100), imageAddress varchar(100)) DEFAULT CHARSET=utf8"); %>
<%
  String sql="";
  sql="insert into distribution(name, count, countingDate, registeredDate, discription, imageAddress) values('바나나', 10, date(now()), date(now() - interval 7 day), '알래스카산 바나나로 맘모스의 아침식사', '../bzness7/imageAddress/banana.jpg')"; stmt.execute(sql);
  sql="insert into distribution(name, count, countingDate, registeredDate) values('따알기', 10, date(now()), date(now() - interval 7 day))"; stmt.execute(sql);
  sql="insert into distribution(name, count, countingDate, registeredDate) values('사아과', 10, date(now()), date(now() - interval 7 day))"; stmt.execute(sql);
  sql="insert into distribution(name, count, countingDate, registeredDate) values('배애애', 10, date(now()), date(now() - interval 7 day))"; stmt.execute(sql);
  sql="insert into distribution(name, count, countingDate, registeredDate) values('참외애', 10, date(now()), date(now() - interval 7 day))"; stmt.execute(sql);
  sql="insert into distribution(name, count, countingDate, registeredDate) values('바나나1', 10, date(now()), date(now() - interval 10 day))"; stmt.execute(sql);
  sql="insert into distribution(name, count, countingDate, registeredDate) values('따알기1', 10, date(now()), date(now() - interval 10 day))"; stmt.execute(sql);
  sql="insert into distribution(name, count, countingDate, registeredDate) values('사아과1', 10, date(now()), date(now() - interval 10 day))"; stmt.execute(sql);
  sql="insert into distribution(name, count, countingDate, registeredDate) values('배애애1', 10, date(now()), date(now() - interval 10 day))"; stmt.execute(sql);
  sql="insert into distribution(name, count, countingDate, registeredDate) values('참외애1', 10, date(now()), date(now() - interval 10 day))"; stmt.execute(sql);

  stmt.close();
  conn.close();
%>
</body>
</html>