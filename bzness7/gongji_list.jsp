<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*,org. w3c.dom.*,
      javax.xml.parsers.DocumentBuilder,javax.xml.parsers.DocumentBuilderFactory,
      javax.xml.parsers.ParserConfigurationException,
      java.util.List, java.util.ArrayList, java.util.Date, java.text.SimpleDateFormat"%>
<html>
<head>
</head>
<body>
  <table cellspacing="1" width="600" border="1">
    <tr>
      <td width="50"><p align="center">번호</p></td>
      <td width="500"><p align="center">제목</p></td>
      <td width="100"><p align="center">조회수</p></td>
      <td width="100"><p align="center">등록일</p></td>
    </tr>
  
	<%
    // 현재 페이지를 받아오는 코드
    String getPage = request.getParameter("page"); //페이지의 번호를 받아옴
    String moved = request.getParameter("move"); // 꺽쇠 이동 여부 확인

    int nowPage = 0;                      // 현재 페이지 변수
    int showingPageStandard = 10;         // 출력할 페이지의 수
    int standard = 10;                    // 한 페이지에 출력할 데이터의 수

    if (getPage == null || "null".equals(getPage)){
      nowPage = 1;
    } else {
      nowPage = Integer.parseInt(getPage);
    }

    // 꺽쇠 이동 여부에 대한 반응
    if (moved == "left") {
      nowPage = Integer.parseInt(getPage) / showingPageStandard * showingPageStandard + 1;
    } else if (moved == "right") {
      nowPage = Integer.parseInt(getPage) / showingPageStandard * showingPageStandard + 1;
    }
    
    // 현재 페이지에서 출력할 첫 데이터의 id
    int firstData = (nowPage - 1) * standard;
    if ((nowPage <= 1)) {
      firstData = 0;
    } 

		// 공지 리스트 접근
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("select id, title, date, recnt, viewcnt from gongji order by id desc, recnt asc limit " + firstData + ", " + standard + ";");
    
    // 새글 확인을 위한 표시
    Date dateM = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(dateM);

    // 데이터를 웹 페이지에 출력
    int id = 0;
    String title = "";
    int viewCount = 0;
    String date = "";
    String query = "";
    while (rs.next()) {
      id = rs.getInt(1);
      date = rs.getString(3);
      title = rs.getString(2);
      if (today.equals(date)) {
        title = title + "[new]";
      }
      viewCount = rs.getInt(5);
      

      out.println("<tr>");
      query = "<td width=50><p align=center>" + id + "</p></td>" + 
              "<td width=500><p align=center><a href='gongji_view.jsp?key=" + id + "'>" + 
                title + "</a></p></td>" + 
              "<td width=100><p align=center>" + viewCount + "</p></td>" + 
              "<td width=100><p align=center>" + date + "</p></td>";
      out.print(query);
      out.println("</tr>");
    }
    out.print("</table>");

    // 하단의 페이지 표시를 위한 코드
    // 최대 데이터의 수
    rs = stmt.executeQuery("select count(*) from gongji;");
    int endData = 0;
    while (rs.next()){
      endData = rs.getInt(1);
    }

    // 데이터의 수에 따라 출력할 최종 페이지의 수를 결정
    int lastPage = (int) Math.ceil((double) endData / standard);
    int showingFirstPage = (nowPage / showingPageStandard) * showingPageStandard + 1;     // 출력될 첫 페이지의 번호
    if (nowPage % showingPageStandard == 0) {                               // 10페이지를 클릭하면 하단에 출력되는 페이지가 달라지는 걸 방지
      showingFirstPage = showingFirstPage - showingPageStandard;
    }
    
    int showingLastPage = showingFirstPage + showingPageStandard - 1;      // 출력될 마지막 페이지의 번호
    if (showingLastPage > lastPage) {                                      // 최대 페이지 보다 보여줄 페이지가 크면 최대 페이지 값을 보여줄 페이지로
      showingLastPage = lastPage;
    }

    // 꺽쇠를 클릭하면 이동할 페이지
    int leftMovePage = showingFirstPage - showingPageStandard;
    if (leftMovePage < 0) {
      leftMovePage = 1;
    }

    // 우측으로 이동하면 다음 10개의 페이지 목록중 1번 목록으로 이동하도록 조정
    int rightMovePage = showingFirstPage + showingPageStandard;
    if (rightMovePage > lastPage) {
      rightMovePage = lastPage;
    }

    out.print("<br>");
    out.println("<table cellspacing='1' width='600'>");
    out.println("<tr><td width=50 align=center><b><a href='gongji_list.jsp?page=" + leftMovePage + "&move=left'>&lt&lt</a></b></td>");
    String sqlPage = "";
    for (int i = showingFirstPage; i <= showingLastPage; i++){
      sqlPage = "<td width=50 align=center><b><a href='gongji_list.jsp?page=" + i + "'>"+ i +"</a></b></td>";
      out.println(sqlPage);
    }
    out.println("<td width=50 align=center><b><a href='gongji_list.jsp?page=" + rightMovePage + "&move=right'>&gt&gt</a></b></td>");
	%>
  </table>
  <table width="650">
    <tr>
      <td width="550"></td>
      <td><input type="button" value="신규" onclick="window.location='gongji_insert.jsp'"></td>
    </tr>
  </table>
  </body>
</html>