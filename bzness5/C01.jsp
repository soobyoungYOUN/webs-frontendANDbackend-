<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*,java.text.*"%>
<html>
<head>
<style type="text/css"> 
      a { text-decoration:none }   
</style> 
<title>C01</title>
<%!	
	public String huboList(int kiho, String name, String image, int vote, int totalVote){						
		String query = "<tr><td width=75><p align=center>"+ kiho + "</a><a href='C02.jsp?key1=" + kiho + "&key2=" + name +"'>" + name +"</a></p></td>" +
						"<td width=500><p align=left><img src='" + image + "' width='"+ vote +"' height=20>" + vote + "(" + (int)(vote * 100 / totalVote ) +"%)</p></td></tr>";
		return query;
	}
%>

</head>
<body>
<table cellspacing=3 width=600 border=1>
	<tr>
		<td width=100 align='center'><a href="A01.jsp">후보등록</a></td>
		<td width=100 align='center'><a href="B01.jsp">투표</a></td>
		<td width=100 align='center' bgcolor="#00ffff"><a href="C01.jsp">개표결과</a></td>
	</tr>
</table>
<h4>후보별 득표 성향</h4>
<table cellspacing=3 width=600 border=1>
	<tr>
		<td width=75><p align=center>이름</p></td>
		<td width=500><p align=center>인기도</p></td>
	</tr>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
	Statement stmt = conn.createStatement();
	ResultSet rsetTupyo = stmt.executeQuery("select count(*) from tupyo_table;");
	
	//전체 투표자의 수 
	int totalVote = 0;
	while(rsetTupyo.next()){
		totalVote = rsetTupyo.getInt(1);
	}
	
	//전체 후보자 수
	int totalHubo = 0;
	ResultSet rsetHubo = stmt.executeQuery("select count(*) from hubo_table;");
	while(rsetHubo.next()){
		totalHubo=rsetHubo.getInt(1);
	}
	//각 후보자의 득표 수를 저장하기 위한 배열
	int[] votePer = new int[totalHubo];
	
	//배열에 후보자 별 득표 입력
	int index1 = 0;
	ResultSet rsetVote = stmt.executeQuery("select count(id) from tupyo_table group by id;");
	while(rsetVote.next()){
		votePer[index1] = rsetVote.getInt(1);
		index1++;
	}
	ResultSet rset = stmt.executeQuery("select * from hubo_table;");

	int index2 = 0;
	while(rset.next()){
		out.print(huboList(rset.getInt(1), rset.getString(2), "bar.jpg", votePer[index2],totalVote));
		index2++;
	}
	
	rsetTupyo.close();
	rsetHubo.close();
	rsetVote.close();
	rset.close();
	stmt.close();
	conn.close();
	%>
</table>
</body>
</html>