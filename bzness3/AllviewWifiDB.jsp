<!-- html과 jsp에서 한글 처리를 지시하는 명령, 필요한 파일 임포트 -->
<meta http-equiv="Content-Type" content="text/html; charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
	<head>
		<title> 실습데이터 입력 </title>
		<style type="text/css"> 
			a { text-decoration:none } 
			table {border-spacing: 0px; padding:0px; }
			td {border-spacing: 0px; padding:0px;}
			p { margin-top:0px; margin-bottom:0px;}
		</style> 
	</head>
	<body>
		<!-- 메세지 출력 -->
		<h1> 전국 와이파이 정보 </h1>
		<!--jsp 사용해서 mysql 원격 조종, 경로 설정 -->
		<%
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc","root","kopo26");
			Statement stmt = conn.createStatement();	
			// get 방식으로 받아온 변수 값을 입력한다.
			String cfrom = request.getParameter("from");
			String ccnt = request.getParameter("cnt");
			String cpagemove = request.getParameter("pagemove");
			
			//최초로 페이지에 접속할 땐, 1페이지의 내용이 출력 되도록함
			if (cfrom == null || "null".equals(cfrom)) {
				cfrom = "1";
			}
			if (ccnt == null || "null".equals(ccnt)) {
				ccnt = "10";
			}
			if (cpagemove == null || "null".equals(cpagemove)) {
				cpagemove = "1";
			}

			//해당페이지의 처음 인원을 계산하다.
			String startpage =  Integer.toString((Integer.parseInt(cfrom) - 1) * Integer.parseInt(ccnt));
			String QueryTxt;
			String QueryTxt2;

			// select 문을 이용해서 총 데이터 개수 출력
			QueryTxt2 = String.format(" select count(*) from freewifi2;");
			ResultSet rset2 = stmt.executeQuery(QueryTxt2);
			int total=0;
			while (rset2.next()) {
				total = rset2.getInt(1);
			}
			//테이블 전체 내용을 보여주는 명령 실행
			QueryTxt = String.format(" select * from freewifi2 limit "+ startpage +", "+ccnt+";");
			ResultSet rset = stmt.executeQuery(QueryTxt);
		%>
		<!--테이블 생성,총폭 600, 경계 1 폭 50 중앙정렬-->
		<table border = 1 cellspacing = 1>
			<tr>
				<td width = 50> <p align = center> 번호 </p></td>
				<td width = 50> <p align = center> 주소 </p></td>
				<td width = 50> <p align = center> 위도 </p></td>
				<td width = 50> <p align = center> 경도 </p></td>
				<td width = 50> <p align = center> 현재 지점과 거리 </p></td>
			</tr>
		<%
			// rset으로 받은 실행문 결과를 테이블로 출력하는 while 문 작성
			while (rset.next()) {
				out.println("<tr>");
				//여기서 get방식을 이용해 url로 key에 값을 전달한다.
				out.println("<td width=60><p align=center>" + Integer.toString(rset.getInt(1)) + "</p></td>");
				out.println("<td width=450><p align=center>" + rset.getString(2) + "</p></td>");
				out.println("<td width=150><p align=center>" + Double.toString(rset.getDouble(3)) + "</p></td>");
				out.println("<td width=150><p align=center>" + Double.toString(rset.getDouble(4)) + "</p></td>");
				out.println("<td width=200><p align=center>" + Double.toString(rset.getDouble(5)) + "</p></td>");
			}
			
			int inpagemove = (Integer.parseInt(cpagemove));		
			int pageprintnum = 10;
			int lastpage = 10;
			int firstpage = 0;
			// 1페이지 이하에선 1로 출력
			if (inpagemove < 1) {
				inpagemove = 1;
				firstpage = 0;
			} 
			
			if (inpagemove <= 1) {
				firstpage = 0;
			} else {
				firstpage = 10;
			}
			//마지막 페이지에선 마지막페이지만 출력
			if(inpagemove>=((total/100)*10 + 1)){
				pageprintnum = (total/10)%10 + 1;
				inpagemove = (total/100)*10 + 1;
				lastpage = (total/10)%10;
			} else {
				pageprintnum = 10;
				lastpage = 10;
			}

			// 테이블을 제작하여 안에 페이지 이동할 숫자를 작성한다. 작성하면서 get방식으로 값을 보낸다.
			out.print("</table><br> <table border=0><br>");
			out.print("<tr><td width = 1010 align = center><b><a href = 'AllviewWifiDB.jsp?from="+(inpagemove-firstpage)+"&cnt=10&pagemove="+(inpagemove-10)+"'> &lt&lt  </a></b>");		
			for (int i = inpagemove; i < inpagemove + pageprintnum; i++) {
				out.print("<b><a href = 'AllviewWifiDB.jsp?from="+i+"&cnt=10&pagemove="+(inpagemove)+"'> "+i+" </a></b>");			
			}
			out.print("<b><a href = 'AllviewWifiDB.jsp?from="+(inpagemove+lastpage)+"&cnt=10&pagemove="+(inpagemove+lastpage)+"'> &gt&gt </a></b>");

			out.print("</td></tr></table>");
				
			// 사용후 종료 
			rset2.close();
			rset.close();
			stmt.close();
			conn.close();
		%>
		</table>
	</body>
</html>