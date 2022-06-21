<meta http-equiv="Content-Type" content= "text/html; charset= utf-8"/>
<%@ page contentType= "text/html; charset=utf-8" %>
<%@ page import= "java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
  <script LANGUAGE="JavaScript">
    function submitForm(mode){
      if(mode == 'update') {
        fm.action = 'distribution_update.jsp';
      } else if (mode = "delete") {
        fm.action = "distribution_delete.jsp";
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
	ResultSet rs = stmt.executeQuery("select * from distribution where id= " + id + ";");
	
  String name = "";
  int count = 0;
  String countingDate = "";
  String registeredDate= "";
  String discription= "";
  String imageAdd= "";

	while(rs.next()){
    id = rs.getString(1);
    name = rs.getString(2);
    count = rs.getInt(3);
    countingDate = rs.getString(4);
    registeredDate = rs.getString(5);
    discription = rs.getString(6);
    imageAdd = rs.getString(7);
	}
%>
  <form method="post" name="fm">
    <table width='650' border="1" cellspacing="0" cellpadding="5">
      <tr>
        <td><b>상품 번호</b></td>
        <td><%=id%></td>
      </tr>
      <tr>
        <td><b>상품명</b></td>
        <td><%=name%></td>
      </tr>
      <tr>
        <td><b>재고 현황</b></td>
        <td><%=count%></td>
      </tr>
      <tr>
        <td><b>상품등록일</b></td>
        <td><%=countingDate%></td>
      </tr>
      <tr>
        <td><b>재고등록일</b></td>
        <td><%=registeredDate%></td>
      </tr>
      <tr>
        <td><b>상품설명</b></td>
        <td><%=discription%></td>
      </tr>
      <tr>
        <td><b>상품사진</b></td>
        <td><img src=<%=imageAdd%> alt=<%=name%>></td>
      </tr>
    </table>
    <table width="650">
      <tr>
        <td width="600"></td>
        <td><input type="button" value="상품 삭제" onclick="location.href='distribution_delete.jsp?key=<%=id%>'"></td>
        <td><input type="button" value="재고 수정" onclick="location.href='distribution_update.jsp?key=<%=id%>'"></td>
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