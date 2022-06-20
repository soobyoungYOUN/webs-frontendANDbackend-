<meta http-equiv="Content-Type" content= "text/html; charset= utf-8"/>
<%@ page contentType= "text/html; charset=utf-8" %>
<%@ page import= "java.sql.*, javax.sql.*, java.io.*" %>
<html>
  <head>
    <script LANGUAGE="JavaScript">
      
      function submitForm(mode){
        if(mode == "write"){
          fm.action = "gongji_write.jsp" ;
        } else if (mode = "delete") {
          fm.action = "gongji_delete.jsp" ;
        }
        fm.submit();
      }
    </script>
  </head>
  <body>
    <%
      // 공지 리스트 접근
      String id = request.getParameter("key");
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
      Statement stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery("select * from gongji where id= " + id + ";");
      
      String title = "";
      String date = "";
      String content = "";

      while(rs.next()){
        title = rs.getString(2);
        date = rs.getString(3);
        content = rs.getString(4);
      }
    %>
    <form method="post" name="fm">
      <table width='650' border="1" cellspacing="0" cellpadding="5">
        <tr>
          <td><b>번호</b></td>
          <td><input type="text" name="id" size="70" maxlength="70" value=<%=id%> readonly></td>
        </tr>
        <tr>
          <td><b>제목</b></td>
          <td><input type="text" name="title" size="70" maxlength="70" value=<%=title%>></td>
        </tr>
        <tr>
          <td><b>일자</b></td>
          <td><%=date%></td>
        </tr>
        <tr>
          <td><b>내용</b></td>
          <td><textarea style="width: 525px; height: 250px; " name="content" cols="70" rows="600"><%=content%></textarea></td>
        </tr>
      </table>
      <table width="650">
        <tr>
          <td width="600"></td>
          <td><input type="button" value="취소" onclick="location.href='gongji_list.jsp'"></td>
          <td><input type="button" value="쓰기" onclick="submitForm('write')"></td>
          <td><input type="button" value="삭제" onclick="submitForm('delete')"></td>
        </tr>
      </table>
    </form>
    <%
      rs.close();
      stmt.close();
      conn.close();
    %>    
  </body>
</html>