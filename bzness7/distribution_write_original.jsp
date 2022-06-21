<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <%@ page contentType="text/html; charset=utf-8" %> <!--한글깨짐 방지-->
  <%@ page import="java.sql.*, javax.sql.*, java.io.*, java.util.Date,
                   java.text.SimpleDateFormat, java.util.Enumeration,
                   com.oreilly.servlet.multipart.DefaultFileRenamePolicy,
                   com.oreilly.servlet.MultipartRequest" %> 
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

      String id = request.getParameter("id");
      String count = request.getParameter("count");
      String today = request.getParameter("registeredDate");
      
      String which = request.getParameter("key");
      String sql="";

      if ("INSERT".equals(which)){
        // sql="insert into gongji(title,date,content) values('"+title+"',date(now()),'"+content+"')"; 

        // 이미지 등록
        
      } else {
        sql = "update distribution set count = '" + count + "', countingDate ='" + today + "', registeredDate ='" + today + "' where id ='" + id + "';";
      }
      stmt.executeUpdate(sql);
      stmt.close();
      conn.close();
    %>
    <script>
      alert("성공적으로 작성했습니다");
      document.location.href="./distribution_list.jsp"
    </script>
  </body>
</html>