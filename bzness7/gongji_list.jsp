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
  <table cellspacing="1" width="600" border="1">
    <tr>
      <td width="50"><p align="center">번호</p></td>
      <td width="500"><p align="center">제목</p></td>
      <td width="100"><p align="center">등록일</p></td>
    </tr>
  
	<%
		// 공지 리스트 접근
    List<Integer> ids = new ArrayList();
    List<String> titles = new ArrayList();
    List<String> dates = new ArrayList();
    List<String> contents = new ArrayList();

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("select * from gongji");
    
    while (rs.next()) {
      ids.add(rs.getInt(1));
      titles.add(rs.getString(2));
      dates.add(rs.getString(3));
      contents.add(rs.getString(4));
    }

    int start = ids.size();
    int breakPoint = 0;
    String query ="";
    for (int i = start-1; i >= 0; i--) {
      out.println("<tr>");
      query = "<td width=50><p align=center>" + ids.get(i).toString() + "</p></td>" + 
              "<td width=500><p align=center><a href='gongji_view.jsp?key=" + (i+1) + "'>" + 
                titles.get(i).toString() + "</a></p></td>" + 
              "<td width=100><p align=center>" + dates.get(i).toString() + "</p></td>";
      out.print(query);
      out.println("</tr>");
      breakPoint++;
      if (breakPoint == 9) break;
    }
    int endData = ids.size();

    //데이터의 수에 따라 출력할 최종 페이지의 수를 결정
    int nowPage = 0;	//화면에 보여줄 현재 페이지
    int printData = 10; //출력할 데이터의 수
    int firstData = 0;	//페이지에 출력될 처음 데이터
    int startPage = 0; //하단에 표시될 첫 페이지
    int finalPage = (endData / 10) + 1; //출력될 최대 페이지의 수를 제한
    
    // 데이터의 따라 마지막 여주는 페이지를 출력하는 
    if (endData % 10 == 0){
      finalPage = (endData / 10);
    }
    
    // if (finalPage < 11) {
      // tempFinalPage = finalPage;
    // }
    
    // 현재 페이지를 받아오는 코드
    String getFrom = request.getParameter("from"); //페이지의 번호를 받아옴
    if (getFrom == null || "null".equals(getFrom)){
      nowPage = 0;
    } else {
      nowPage = Integer.parseInt(getFrom) - 1;
    }
    
    // 현재 페이지의 범위를 조정하는 코드
    if (nowPage < 0){
      nowPage = 0;
    } else if (nowPage > finalPage) {
      nowPage = 0;
    }
    if (nowPage > finalPage){
      nowPage = finalPage - 1;
    }
    
    startPage = nowPage / 10 + 1; //하단에 표시될 첫 페이지 목록
    firstData = nowPage * printData; //현재 페이지에서 출력할 첫번째 데이터의 번호

    out.println("<tr><td width=50 align=center><b><a href='gongji_list.jsp?from=" + (int)(Math.floor(startPage/10)*10 -1) + "'>&lt&lt</a></b></td>");
    String sqlPage = "";
    for (int i = startPage; i <= finalPage; i++){
      sqlPage = "<td width=50 align=center><b><a href='gongji_list.jsp?from=" + i + "'>"+ i +"</a></b></td>";
      out.println(sqlPage);
    }
    out.println("<td width=50 align=center><b><a href='gongji_list.jsp?from=" + (int)((Math.ceil(startPage/10) +1)*10) + "'>&gt&gt</a></b></td>");
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