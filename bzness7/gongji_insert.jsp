<meta http-equiv="Content-Type" content= "text/html; charset= utf-8"/>
<%@ page contentType= "text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*, java.util.Date, java.text.SimpleDateFormat"%>
<html>
  <head>
    <script LANGUAGE="JavaScript">
      function submitForm(mode){
        fm.action = 'gongji_write.jsp?key=INSERT';
        fm.submit();
      }
    </script>
  </head>
  <body>
    <%
      // 현재 시간 
      Date date = new Date();
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      String today = sdf.format(date);
    %>
    <form method="post" name="fm">
      <table width='650' border="1" cellspacing="0" cellpadding="5">
        <tr>
          <td><b>번호</b></td>
          <td>신규(insert) <input type="hidden" name="id" value="INSERT"></td>
        </tr>
        <tr>
          <td><b>제목</b></td>
          <td><input type="text" name="title" size="70" maxlength="70"></td>
        </tr>
        <tr>
          <td><b>일자</b></td>
          <td name="date"><%=today%></td>
        </tr>
        <tr>
          <td><b>내용</b></td>
          <td><textarea style="width: 525px; height: 250px; " name="content" id="" cols="70" rows="600"></textarea></td>
        </tr>
      </table>
      <table width="650">
        <tr>
          <td width="600"></td>
          <td><input type="button" value="취소" onclick="location.href='gongji_list.jsp'"></td>
          <td><input type="button" value="쓰기" onclick="submitForm('write')"></td>
        </tr>
      </table>
    </form>  
  </body>
</html>