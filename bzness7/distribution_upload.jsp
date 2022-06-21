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
      // 이미지 등록
      String path = request.getRealPath("bzness7/imageAddress");
      int size = 1024 * 1024 * 5; // 5MB
      String str, filename, original_filename;
      // try{
        MultipartRequest multiRequest = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
        
        Enumeration files = multiRequest.getFileNames();
        str = (String)files.nextElement();
        filename = multiRequest.getFilesystemName(str);
        original_filename = multiRequest.getOriginalFileName(str);
        
        // out.println("str : "+str);
        // out.println("filename : "+filename);
        // out.println("original_filename : "+original_filename);
      // } catch (Exception e){
      //  e.printStackTrace();
      //}
    %>
    <script>
      // document.location.href="./distribution_list.jsp"
    </script>
  </body>
</html>