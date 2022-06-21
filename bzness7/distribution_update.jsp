<meta http-equiv="Content-Type" content= "text/html; charset= utf-8"/>
<%@ page contentType= "text/html; charset=utf-8" %>
<%@ page import= "java.sql.*, javax.sql.*, java.io.*, java.util.Date, java.text.SimpleDateFormat" %>
<html>
  <head>
    <script LANGUAGE="JavaScript">
      function submitForm(mode){
        fm.action = "distribution_write.jsp" ;
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

      // 공지 리스트 접근
      String id = request.getParameter("key");
      
      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
      Statement stmt = conn.createStatement();
      ResultSet rs = stmt.executeQuery("select * from distribution where id= " + id + ";");
      
      // db데이터 받아오는 변수 선언
      String name = "";
      int count = 0;
      String countingDate = "";
      String registeredDate= "";
      String discription= "";
      String imageAdd= "";

      // db 데이터 입력
      while(rs.next()){
        id = rs.getString(1);
        name = rs.getString(2);
        count = rs.getInt(3);
        registeredDate = rs.getString(5);
        discription = rs.getString(6);
        imageAdd = rs.getString(7);
      }
      countingDate = today;
      
    %>
    <form method="post" name="fm">
      <table width='650' border="1" cellspacing="0" cellpadding="5">
        <tr>
          <td><b>상품 번호</b></td>
          <td><input type="number" name="id" size="70" maxlength="70" value=<%=id%> readonly></td>
        </tr>
        <tr>
          <td><b>상품명</b></td>
          <td><input type="text" name="name" size="70" maxlength="70" value=<%=name%> readonly></td>
        </tr>
        <tr>
          <td><b>재고 현황</b></td>
          <td><input type="number" name="count" size="70" maxlength="70" value=<%=count%>></td>
        </tr>
        <tr>
          <td><b>상품등록일</b></td>
          <td><input type="date" name="registeredDate" size="70" maxlength="70" value=<%=registeredDate%> readonly></td>
        </tr>
        <tr>
          <td><b>재고등록일</b></td>
          <td><input type="date" name="countingDate" size="70" maxlength="70" value=<%=today%> readonly></td>
        </tr>
        <tr>
          <td><b>상품설명</b></td>
          <td><input type="text" name="discription" size="70" maxlength="70" value=<%=discription%> readonly></td>
        </tr>
        <tr>
          <td><b>상품사진</b></td>
          <td>
            <img src=<%=imageAdd%> alt=<%=name%>>
          </td>
        </tr>
      </table>

      <table width="650">
        <tr>
          <td width="600"></td>
          <td><input type="button" value="재고수정완료" onclick="submitForm('update')"></td>
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