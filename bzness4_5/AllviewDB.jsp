<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<%@ page errorPage = "errorAllviewDB.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %> 
<!-- java.net.* 한글의 post/get의 파라미터로 연동될 때 필요함-->
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>
<html> <!--html 실행-->
<head> <!--머리말 실행-->
</head>
<body> <!--본문 실행-->
<h1>전부조회</h1>
<% //데이터 베이스 원격 접속 및 조종-->
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	Statement stmt = conn.createStatement();
	
	//전체 데이터의 수 
	ResultSet rsetCount = stmt.executeQuery("select count(*) from bzness_examtable;");
	//rsetCount.next() 로 호출 후에 사용한다. 안하면 java.sql.SQLException: Before start of result set 에러 남
	int endData = 0;
	while(rsetCount.next()){
		endData = rsetCount.getInt(1);
	}
	
	//데이터의 수에 따라 출력할 최종 페이지의 수를 결정
	int nowPage = 0;	//화면에 보여줄 현재 페이지
	int printData = 10; //출력할 데이터의 수
	int firstData = 0;	//페이지에 출력될 처음 데이터
	//int tempFinalPage = 0;
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
	
	//DB 명령 결과를 받아서 변수에 대입 -->
	//모든 데이터 받아오기 + 등수 입력
	String sql = String.format("select *, (select count(*)+1 from bzness_examtable as a where (a.kor+a.eng+a.mat) > (b.kor + b.eng + b.mat))" + 
								" from bzness_examtable as b limit " + firstData + ", " + printData + ";");
	ResultSet rset = stmt.executeQuery(sql);
%> 
<table cellspacing=1 width=600 border=1> <!--웹페이지에 테이블 생성-->
	<tr>
		<td width=50><p align=center>이름</p></td>
		<td width=50><p align=center>학번</p></td>
		<td width=50><p align=center>국어</p></td>
		<td width=50><p align=center>영어</p></td>
		<td width=50><p align=center>수학</p></td>
		<td width=50><p align=center>총점</p></td>
		<td width=50><p align=center>평균</p></td>
		<td width=50><p align=center>등수</p></td>
	</tr>
<% //DB 결과를 한 행씩 출력-->
	while (rset.next()){
		out.println("<tr>");
		out.println("<td width=50><p align=center><a href='oneview.jsp?key="+rset.getString(1)+"'>"+rset.getString(1)+"</a></p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3)+rset.getInt(4)+rset.getInt(5))+"</p></td>"); //총점
		out.println("<td width=50><p align=center>"+Integer.toString((rset.getInt(3)+rset.getInt(4)+rset.getInt(5))/3)+"</p></td>"); //평균
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(6))+"</p></td>"); //등수
		out.println("<tr>");
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
<br>
<table cellspacing=1 width=600 border=1>
<%	//하단의 페이지 목록을 출력
	out.println("<tr><td width=50 align=center><b><a href='AllviewDB.jsp?from=" + (int)(Math.floor(startPage/10)*10 -1) + "'>&lt&lt</a></b></td>");
	String sqlPage = "";
	for (int i = startPage; i <= finalPage; i++){
		sqlPage = "<td width=50 align=center><b><a href='AllviewDB.jsp?from=" + i + "'>"+ i +"</a></b></td>";
		out.println(sqlPage);
	}
	out.println("<td width=50 align=center><b><a href='AllviewDB.jsp?from=" + (int)((Math.ceil(startPage/10) +1)*10) + "'>&gt&gt</a></b></td>");
%>
</table>
</body>
</html>