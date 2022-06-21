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
        String realFolder="";
        String saveFolder = "imageAddress";		//사진을 저장할 경로
        String encType = "utf-8";				//변환형식
        int maxSize=5*1024*1024;				//사진의 size

        ServletContext context = this.getServletContext();		//절대경로를 얻는다
        realFolder = context.getRealPath(saveFolder);			//saveFolder의 절대경로를 얻음
            
        MultipartRequest multi = null;

        //파일업로드를 직접적으로 담당		
        multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());

        //form으로 전달받은 3가지를 가져온다
        String fileName = multi.getFilesystemName("fileName");
        String bbsTitle = multi.getParameter("bbsTitle");
        String bbsContent = multi.getParameter("bbsContent");

        bbs.setBbsTitle(bbsTitle);
        bbs.setBbsContent(bbsContent);

        // sql="insert into gongji(title,date,content) values('"+title+"',date(now()),'"+content+"')"; 
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