<!DOCTYPE html>
<html lang="en">
<head>

  <meta charset="UTF-8">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <%@ page contentType="text/html; charset=utf-8" %> <!--한글깨짐 방지-->
  <%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.Date,java.text.SimpleDateFormat" %> 
  <!--라이브러리 불러오기-->
  <% request.setCharacterEncoding("UTF-8"); %>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>글 생성</title>
</head>
  <body>

    <%
      //mysql 원격 접속 및 조종
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
      Statement stmt = conn.createStatement();

      String title = request.getParameter("title");
      String content = request.getParameter("content");
      
      String which = request.getParameter("key");
      String sql="";
      if ("INSERT".equals(which)){
        sql="insert into gongji(title,date,content) values('"+title+"',date(now()),'"+content+"')"; 
      } else {
        sql = "update gongji set title = '" + request.getParameter("title") + "', content ='" + request.getParameter("content") + "' where id ='" + request.getParameter("id") + "';";
      }
      stmt.executeUpdate(sql);
      stmt.close();
      conn.close();
    %>
    <script>
      alert("성공적으로 작성했습니다");
      document.location.href="./gongji_list.jsp"
    </script>
  </body>
</html>