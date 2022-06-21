<meta http-equiv="Content-Type" content= "text/html; charset= utf-8"/>
<%@ page contentType= "text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*,java.net.*, 
    java.util.Date, java.text.SimpleDateFormat"%>
<html>
  <head>
    <script LANGUAGE="JavaScript">
      function submitForm(mode){
        fm.action = 'distribution_write.jsp?key=INSERT';
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
    <form method="post" name="fm" encType = "multipart/form-data">
      <table width='650' border="1" cellspacing="0" cellpadding="5">
        <tr>
          <td><b>상품 번호</b></td>
          <td><input type="number" name="id" size="70" maxlength="70" value=<%=id%>></td>
        </tr>
        <tr>
          <td><b>상품명</b></td>
          <td><input type="text" name="name" size="70" maxlength="70" value=<%=name%>></td>
        </tr>
        <tr>
          <td><b>재고 현황</b></td>
          <td><input type="number" name="count" size="70" maxlength="70" value=<%=count%>></td>
        </tr>
        <tr>
          <td><b>상품등록일</b></td>
          <td><input type="date" name="registeredDate" size="70" maxlength="70" value=<%=today%> readonly></td>
        </tr>
        <tr>
          <td><b>재고등록일</b></td>
          <td><input type="date" name="countingDate" size="70" maxlength="70" value=<%=today%> readonly></td>
        </tr>
        <tr>
          <td><b>상품설명</b></td>
          <td><input type="text" name="discription" size="70" maxlength="70" value=<%=discription%>></td>
        </tr>
        <tr>
          <td><b>상품사진</b></td>
          <td><input type="file" name="fileName"></td>
        </tr>
      </table>
      <table width="650">
        <tr>
          <td width="600"></td>
          <td><input type="button" value="등록" onclick="submitForm('write')"></td>
        </tr>
      </table>
    </form>  
  </body>
</html>