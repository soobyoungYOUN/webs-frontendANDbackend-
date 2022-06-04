<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %> 
<!-- java.net.* 한글의 post/get의 파라미터로 연동될 때 필요함-->
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>
<html> <!-- html 시작 -->
<head> <!-- 머리말 시작 -->
</head> <!-- 머리말 종료 -->
<body> <!-- 본문 시작 -->
<h1>레코드 수정</h1> <!-- 본문 입력 -->


<%
	//mysql 원격 접속 및 조종
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	Statement stmt = conn.createStatement();
	
	//html 주소로부터 name 변수의 값을 받아옴
	String cTmp = request.getParameter("name");
	//cTmp의 문자를 8859_1 코드셋을 받아들여 utf-8로 변환하여 새로운 string 생성
	//데이터베이스로부터 한글데이터를  가져올 때
	String cTmpHan = new String(cTmp.getBytes("8859_1"), "utf-8"); 
	
	String sql = " update bzness_examtable set "+
	"name = '"+cTmpHan+"'," +
	"kor = " + request.getParameter("korean")+"," +
	"eng = " + request.getParameter("english")+"," +
	"mat = " + request.getParameter("mathmatic") +
	" where studentid =" +request.getParameter("studentid");
	
	stmt.executeUpdate(sql);
	
	ResultSet rset = stmt.executeQuery("select * from bzness_examtable;");
%>
	<table cellspacing=1 width=600 border=1> <!-- 테이블 생성 -->
		<tr> <!-- 행 데이터 입력 -->
			<td width=50><p align=center>이름</p></td>
			<td width=50><p align=center>학번</p></td>
			<td width=50><p align=center>국어</p></td>
			<td width=50><p align=center>영어</p></td>
			<td width=50><p align=center>수학</p></td>
		</tr>
	
<%
	while (rset.next()){
		if(request.getParameter("studentid").equals(Integer.toString(rset.getInt(2)))){
			out.println("<tr bgcolor='#ffff00'>");
			
			out.println("<td width=50><p align=center><a href='onview.jsp?key="
						+ rset.getString(1)+"'> " + rset.getString(1)+"</a></p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");
			
			out.println("</tr>");
		} else {
			out.println("<tr>");
			
			out.println("<td width=50><p align=center><a href='onview.jsp?key="
						+ rset.getString(1)+"'> " + rset.getString(1)+"</a></p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");
			out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");
			
			out.println("</tr>");
		}
	}
	rset.close();
	stmt.close();
	conn.close();
%>
	</table>
</body> <!-- 본문 종료 -->
</html> <!-- html 종료 -->