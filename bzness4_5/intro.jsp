<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<%@ page contentType="text/html; charset=utf-8" %> 
<!-- java.net.* 한글의 post/get의 파라미터로 연동될 때 필요함-->
<%@ page import="java.io.*, java.net.*" %>
<html> <!-- html 시작 -->
<head> <!-- 머리말 시작 -->
</head>
<body>
<h1><center> JSP Database 실습 1</center></h1>
<%
	String data;
	int cnt = 0;
	
	FileReader fl = new FileReader("/home/cnt.txt");
	StringBuffer sb = new StringBuffer();
	int ch = 0;
	while((ch = fl.read()) != -1){
		sb.append((char)ch);
	}
	data=sb.toString().trim().replace("\n", "");
	fl.close();
	
	cnt=Integer.parseInt(data);
	cnt++;
	data=Integer.toString(cnt);
	out.println("<br><br>현재 홈페이지 방문조회수는 ["+data+"] 입니다</br>");
	
	FileWriter fl2 = new FileWriter("/home/cnt.txt", false);
	fl2.write(data);
	fl2.close();
%>
</body>
</html>