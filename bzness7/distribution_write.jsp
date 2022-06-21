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
<!DOCTYPE html>
<html lang="en">
<head>
  <title>글 생성</title>
</head>
  <body>
    <%
      //mysql 원격 접속 및 조종
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
      Statement stmt = conn.createStatement();

      // 추가냐 수정이냐 확인
      String which = request.getParameter("key");
      String sql="";
      String id = request.getParameter("id");
      String name = request.getParameter("name");
      String count = request.getParameter("count");
      String today = request.getParameter("registeredDate"); // 재고등록일 (및 상품등록일)
      String discription = request.getParameter("discription");

      if ("INSERT".equals(which)){
        // 이미지 등록
        String path = request.getRealPath("bzness7/imageAddress");
        int size = 1024 * 1024 * 5; // 5MB
        String str, filename, original_filename;
  
        MultipartRequest multiRequest = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
        name = multiRequest.getParameter("name");
        count = multiRequest.getParameter("count");
        today = multiRequest.getParameter("registeredDate"); // 재고등록일 (및 상품등록일)
        discription = multiRequest.getParameter("discription");
        String imageAdd = "";
        
        Enumeration files = multiRequest.getFileNames();
        str = (String)files.nextElement();
        filename = multiRequest.getFilesystemName(str);
        original_filename = multiRequest.getOriginalFileName(str);

        // 이미지 주소
        imageAdd = "imageAddress/" + filename;

        sql = "insert into distribution (name, count, countingDate, registeredDate, discription, imageAddress)" + 
              " values ('"+ name +"', '"+ count +"', '"+ today +"', '"+ today +"', '" + discription + "', '" + imageAdd + "')"; 
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