<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%>
<html>
<head>
<title>C01</title>
</head>
<body>
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
	out.println("<datas>");
	while(rset.next()){
		out.println("<data>");
		out.println("<id>" + rset.getInt(1) + "</id>");		//기호
		out.println("<name>" + rset.getString(2) + "</name>");	//이름
		out.println("<getVote>" + votePer[index2] + "</getVote>");	//인당 투표
		out.println("<rate>" + (votePer[index2]*100/totalVote) + "</rate>");			// 토탈 투표
		out.println("</data>");
		index2++;
	}
	out.println("</datas>");
	
	
	rsetTupyo.close();
	rsetHubo.close();
	rsetVote.close();
	rset.close();
	stmt.close();
	conn.close();
	%>
</body>
</html>