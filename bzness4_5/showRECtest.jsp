<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %> 
<!-- java.net.* 한글의 post/get의 파라미터로 연동될 때 필요함-->
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>
<html> <!-- html 시작 -->
<head> <!-- 머리말 시작 -->
<script language="JavaScript">
	function submitForm(mode){
		if(mode == 'update'){
			myform.action = "updateDB.jsp";
			myform.submit();
		} else if (mode == 'delete'){
			myform.action = "deleteDB.jsp";
			myform.submit();
		}
	}
</script>
</head> <!-- 머리말 종료 -->
<body> <!-- 본문 시작 -->
<%
	//mysql 원격 접속 및 조종
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	Statement stmt = conn.createStatement();
	
	String name="", studentid="", kor="", eng="", mat="";
	
	String ctmp=request.getParameter("searchid");
	if (ctmp.length()==0) ctmp="0";
	
	ResultSet rset = stmt.executeQuery("select * from bzness_examtable where studentid = " +ctmp); 
	
	name="해당학번없음";
	
	while(rset.next()){
		name=rset.getString(1);
		studentid=Integer.toString(rset.getInt(2));
		kor=Integer.toString(rset.getInt(3));
		eng=Integer.toString(rset.getInt(4));
		mat=Integer.toString(rset.getInt(5));
	}
	
	stmt.close();
	conn.close();
%>
<h1>성적 조회후 정정 / 삭제</h1> <!-- 본문 입력 -->
<!-- html 페이지에 form 형태에서 값을 전달 -->
<!-- form 형태내부의 값을 showREC.jsp에 전달 -->
<form method='post' action='showRECtest.jsp'> 
	<table cellspacing=1 width=400 border=0> <!-- 테이블 생성 -->
		<tr>
			<!-- 추가 버튼을 우측정렬 -->
			<td width=100><p align=center>조회할 학번</p></td>
			<td width=100><p align=center><input type='text' name='searchid' value=''></p></td>
			<td width=100><input type='submit' value='조회'></td>
		</tr>
	</table>
</form>
<form method='post' name='myform'>
	<table cellspacing=1 width=400 border=1> <!-- 테이블 생성 -->
		<tr> <!-- 행 데이터 입력 -->
			<td width=100><p align=center>이름</p></td>		<!--required : 반드시 채워져야 함-->
			<td width=300><p align=center><input type='text' name='name' value='<%=name%>' onkeyup="characterCheck(this)" onkeydown="characterCheck(this)" required></p></td>
		</tr>
		<tr>
			<td width=100><p align=center>학번</p></td>
			<td width=300><p align=center><input type='number' name='studentid' value='<%=studentid%>' readonly></p></td>
		</tr>
		<tr>
			<td width=100><p align=center>국어</p></td>
			<td width=300><p align=center><input type='number' name='korean' value='<%=kor%>' min='0' max='100' required></p></td>
		</tr>
		<tr>
			<td width=100><p align=center>영어</p></td>
			<td width=300><p align=center><input type='number' name='english' value='<%=eng%>' min='0' max='100' required></p></td>
		</tr>
		<tr>
			<td width=100><p align=center>수학</p></td>
			<td width=300><p align=center><input type='number' name='mathmatic' value='<%=mat%>' min='0' max='100' required></p></td>
		</tr>
	</table>
<%
	if(studentid.length() !=0){
		out.println("<table cellspacing=1 width=400 border=0>");
		out.println("<tr>");
		out.println("<td width=200></td>");
		out.println("<td width=100><p align=center><input type=button value=\"수정\" OnClick=\"submitForm('update')\"</p></td>");
		out.println("<td width=100><p align=center><input type=button value=\"삭제\" OnClick=\"submitForm('delete')\"</p></td>");
		out.println("</tr>");
		out.println("</table>");
	}
%>
</form> <!-- form 종료 -->
</body> <!-- 본문 종료 -->
</html> <!-- html 종료 -->
</body> <!-- 본문 종료 -->
</html> <!-- html 종료 -->