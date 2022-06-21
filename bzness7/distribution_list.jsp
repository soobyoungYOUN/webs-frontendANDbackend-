<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*,org. w3c.dom.*,
      javax.xml.parsers.DocumentBuilder,javax.xml.parsers.DocumentBuilderFactory,
      javax.xml.parsers.ParserConfigurationException,
      java.util.List, java.util.ArrayList"%>
<html>
<head>
</head>
<body>
  <div style="width: 650px; text-align: center; border: 1px solid;">
    <p style="font-size: 20px; text-align:center; "><b>(주)트와이스 재고 현황-전체현황</b></p>
  </div>
  <div style="width: 650px; text-align: center; border: 1px solid;">  
    <br>
  <table align="center" cellspacing="1" width="600" border="1">
    <tr>
      <td width="50"><p align="center">상품번호</p></td>
      <td width="100"><p align="center">상품명</p></td>
      <td width="100"><p align="center">현재재고수</p></td>
      <td width="100"><p align="center">재고파악일</p></td>
      <td width="100"><p align="center">상품등록일</p></td>
    </tr>
  
	<%
		// 전체 상품정보 등록
    List<Integer> ids = new ArrayList();
    List<String> names = new ArrayList();
    List<Integer> counts = new ArrayList();
    List<String> countingDates = new ArrayList();
    List<String> registeredDates = new ArrayList();

    // 공지 리스트 접근
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("select * from distribution");
    
    while (rs.next()) {
      ids.add(rs.getInt(1));
      names.add(rs.getString(2));
      counts.add(rs.getInt(3));
      countingDates.add(rs.getString(4));
      registeredDates.add(rs.getString(5));
    }

    // 전체 데이터의 수를 구한다
    // 한 페이지에 출력할 데이터의 수 = 20;
    // 현재 페이지의 번호
    int standard = 20;
    int endData = ids.size(); // 전체 데이터의 수
    int lastPage = endData / standard; // 마지막 페이지의 넘버
    if (endData % standard != 0) {  // 나머지 데이터를 출력하기 위한 페이지
      lastPage = lastPage + 1;
    }

    // 현재 페이지를 받아오는 코드
    String getPage = request.getParameter("page"); //페이지의 번호를 받아옴
    int nowPage = 0;
    if (getPage == null || "null".equals(getPage)){
      nowPage = 0;
    } else {
      nowPage = Integer.parseInt(getPage) - 1;
    }

    // 현재 페이지의 범위를 조정하는 코드
    if (nowPage < 0){
      nowPage = 0;
    } else if (nowPage > lastPage) {
      nowPage = lastPage - 1;
    }

    String query ="";
    for (int i = nowPage * standard; i < (nowPage + 1) * standard; i++) {
      out.println("<tr>");
      query = "<td width=50><p align=center><a href='distribution_view.jsp?key=" + ids.get(i) + "'>" + 
                ids.get(i).toString() + "</a></p></td>" + 
              "<td width=100><p align=center><a href='distribution_view.jsp?key=" + ids.get(i) + "'>" + 
                names.get(i).toString() + "</a></p></td>" + 
              "<td width=100><p align=center>" + counts.get(i).toString() + "</p></td>" +
              "<td width=100><p align=center>" + countingDates.get(i).toString() + "</p></td>" +
              "<td width=100><p align=center>" + registeredDates.get(i).toString() + "</p></td>";
      out.print(query);
      out.println("</tr>");
    }

    %>
  </table>
  <table width="600" align="center">
  <%
    int startPage = nowPage / 10 + 1; //하단에 표시될 첫 페이지 목록

    out.println("<tr><td width=50 align=center><b><a href='distribution_list.jsp?page=" + (nowPage + 1) + "'>&lt&lt</a></b></td>");
    String sqlPage = "";
    for (int i = startPage; i <= 10; i++){
      sqlPage = "<td width=50 align=center><b><a href='distribution_list.jsp?page=" + i + "'>"+ i +"</a></b></td>";
      out.println(sqlPage);
    }
    out.println("<td width=50 align=center><b><a href='distribution_list.jsp?page=" + ((nowPage + 1) * 10) + "'>&gt&gt</a></b></td>");
	%>
      <td align="right"><input type="button" value="신규등록" onclick="window.location='distribution_insert.jsp'"></td>
    </tr>
  </table>
</div>
  </body>
</html>
