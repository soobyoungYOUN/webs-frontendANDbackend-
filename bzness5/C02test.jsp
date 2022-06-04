<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트(아래 3개는 반드시 입력) -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*,java.text.*"%>
<html>
<head>
<style type="text/css"> 
      a { text-decoration:none }   
</style> 

<%!	
	public String typyoList(int kiho, String image, int vote, int totalVote){						
		String query = "<tr><td width=75><p align=center>"+ (kiho * 10) + "대</a></p></td>" +
						"<td width=500><p align=left><img src='" + image + "' width='"+ vote +"' height=20>" + vote + "(" + (int)(vote * 100 / totalVote ) +"%)</p></td></tr>";
		return query;
	}
%>

<title>C02</title>
</head>
<body>

<%
	//후보자의 기호를 받아옴
	int id = Integer.parseInt(request.getParameter("key1"));
	String name = request.getParameter("key2");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
	Statement stmt = conn.createStatement();
	
	
	//한 후보자의 전체 투표자의 수 
	ResultSet rsetTupyo = stmt.executeQuery("select count(*) from tupyo_table where id= " + id + ";");
	int totalVote = 0;
	while(rsetTupyo.next()){
		totalVote = rsetTupyo.getInt(1);
	}
	
	//한 후보자의 세대별 득표 분포를 출력
	int[] age = {1,2,3,4,5,6,7,8,9};
	int[] ageA = new int[9];
	for (int i = 0; i < 0; i++){
		out.print(i);
		ResultSet rset = stmt.executeQuery("select count(*) from tupyo_table where id='" + id + "' and age='" + age[i] + "';");	
		while(rset.next()){
			// ageA[i] = rset.getInt(1);
			out.println(rset.getInt(1));
		}
		rset.close();
	}	
%>

<table cellspacing=3 width=600 border=1>
	<tr>
		<td width=100 align='center'><a href="A01.jsp">후보등록</a></td>
		<td width=100 align='center'><a href="B01.jsp">투표</a></td>
		<td width=100 align='center' bgcolor="#00ffff"><a href="C01.jsp">개표결과</a></td>
	</tr>
</table>
<h4><%=name%>후보 득표 성향</h4>
<table cellspacing=3 width=600 border=1>
	<tr>
		<td width=75><p align=center>연령대</p></td>
		<td width=500><p align=center>인기도</p></td>
	</tr>
	<%
		for (int i = 0; i < 9; i++){
			out.print(typyoList((i+1), "bar.jpg", ageA[i], totalVote));
		}
		rsetTupyo.close();		
		stmt.close();
		conn.close();
	%>
	
</table>
</body>
</html>