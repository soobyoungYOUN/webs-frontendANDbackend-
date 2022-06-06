<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*"%>
<html>
<head>
<title>C02</title>
</head>
<body>

<%
	//후보자의 기호를 받아옴
	String id = request.getParameter("key1");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
	Statement stmt = conn.createStatement();
	
	
	//한 후보자의 전체 투표자의 수 
	ResultSet rsetTupyo = stmt.executeQuery("select count(*) from tupyo_table where id= " + id + ";");
	int totalVote = 0;
	while(rsetTupyo.next()){
		totalVote = rsetTupyo.getInt(1);
	}

	if (totalVote == 0){
		totalVote = 1;
	}
	
	ResultSet rsetHubo = stmt.executeQuery("select name from hubo_table where id= " + id + ";");
	String huboName = "";
	while(rsetHubo.next()){
		huboName = rsetHubo.getString(1);
	}
	
	//한 후보자의 세대별 득표 분포를 출력
	//for 문의 int 변수의 이름을 각각 다르게 해줘야 한다. 비록 한 for문에서만 사용하더라도 여기선 저장됨
	int[] age = {1,2,3,4,5,6,7,8,9};
	int[] ageA = new int[9];
	for(int j = 0; j < age.length; j++){
		ResultSet rset = stmt.executeQuery("select count(*) from tupyo_table where id='" + id + "' and age='" + age[j] + "';");	
		while(rset.next()){
			ageA[j] = rset.getInt(1);
		}
		rset.close();
	}	
%>
<h4>기호 <%=id%>번 <%=huboName%> 후보 득표 성향</h4>
	<%
		out.println("<datas>");
		for (int i = 0; i < 9; i++){
			out.println("<data>");
			out.println("<ages>" + (i+1)*10 + "대</ages>");
			out.println("<vote>" + ageA[i] + "</vote>");
			out.println("<rate>" + (ageA[i]*100 / totalVote) + "</rate>");
				out.println("</data>");
		}
		out.println("</datas>");
		
		rsetTupyo.close();		
		stmt.close();
		conn.close();
	%>
</body>
</html>