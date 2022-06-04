<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %> 
<!-- java.net.* 한글의 post/get의 파라미터로 연동될 때 필요함-->
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>
<html> <!-- html 시작 -->
<head> <!-- 머리말 시작 -->
</head> <!-- 머리말 종료 -->
<body> <!-- 본문 시작 -->

<%
	//mysql 원격 접속 및 조종
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo26");
	Statement stmt = conn.createStatement();
		
	ResultSet rsetMin = stmt.executeQuery("select min(studentid) from bzness_examtable"); //학번중 가장 작은 번호 찾기
	//입력할 학번과 탐색할 학번 설정
	int minId = 0;
	int newStdId = 0;
	//최저학번 받아오기
	while(rsetMin.next()){
		minId = rsetMin.getInt(1);
	}
	if (minId == 0){
	newStdId = 209901;
	}
	
	ResultSet rset = stmt.executeQuery("select studentid from bzness_examtable"); //전체학번 조회
	//전체 학번을 조회하고 그 중에 비어있는 학번을 부여
	while(rset.next()){ 
		if (newStdId != rset.getInt(1)){
			break;
		} 
		newStdId++;
	}
	
	//html 주소로부터 name 변수의 값을 받아옴
	String cTmp = request.getParameter("name");
	//cTmp의 문자를 8859_1 코드셋을 받아들여 utf-8로 변환하여 새로운 string 생성
	//한글데이터를 데이터베이스로부터 가져올 때
	String cTmpHan = new String(cTmp.getBytes("8859_1"), "utf-8"); 
	
	//참고 쿼리
	//큰 따옴표 작은 따옴표를 번갈아 가며 사용하여 문장에 변수를 입력하는 방식이 필요함
	stmt.execute("insert into bzness_examtable (name, studentid, kor, eng, mat) values('" +
		cTmpHan + "',"+
		Integer.toString(newStdId) +","+
		request.getParameter("korean") + ","+
		request.getParameter("english") + ","+
		request.getParameter("mathmatic") +");");
	
	stmt.close();
	conn.close();
%>

<!-- 학생성적 추가 결과를 출력 --> 
<h1>학생성적추가완료</h1> <!-- 본문 입력 -->
<!-- html 페이지에 form 형태에서 값을 전달 -->
<!-- form 형태내부의 값을 insertDB.jsp에 전달 -->
<form method='post' action=inputForm1.html> 
	<table cellspacing=1 width=400 border=0> <!-- 테이블 생성 -->
		<tr>
			<td width=300></td>
			<!-- 뒤로가기 버튼을 우측정렬 -->
			<td width=100 ><input type="submit" value="뒤로가기"></td>
		</tr>
	</table>
	<table cellspacing=1 width=400 border=1> <!-- 테이블 생성 -->
		<tr> <!-- 행 데이터 입력 -->
			<td width=100><p align=center>이름</p></td>
			<td width=300><p align=center>
				<!-- cTmpHan의 변수 값을 입력된 상태로 둠,  -->
				<input type='text' name='name' value='<%=cTmpHan%>' readonly></p>
			</td>
		</tr>
		<tr>
			<td width=100><p align=center>학번</p></td>
			<td width=300><p align=center>
			<!-- 학번을 받아서 string 형태로 바꾼후 출력 될 때 기본 값으로 출력되도록 함 -->
				<input type='text' name='studentid' value='<%=Integer.toString(newStdId)%>' readonly></p>
			</td>
		</tr>
		<tr>
			<td width=100><p align=center>국어</p></td>
			<td width=300><p align=center>
				<input type='text' name='korean' value='<%=request.getParameter("korean")%>' readonly></p>
			</td>
		</tr>
		<tr>
			<td width=100><p align=center>영어</p></td>
			<td width=300><p align=center>
				<input type='text' name='korean' value='<%=request.getParameter("english")%>' readonly></p>
			</td>
		</tr>
		<tr>
			<td width=100><p align=center>수학</p></td>
			<td width=300><p align=center>
				<input type='text' name='korean' value='<%=request.getParameter("mathmatic")%>' readonly></p>
			</td>
		</tr>
	</table>
</form> <!-- form 종료 -->
</body>
</html>