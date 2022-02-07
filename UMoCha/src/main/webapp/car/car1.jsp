<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.util.*" %>

<%
	String bidx = "";
	String cname = "";
	String carimgsub = "";
	String carimg = "";
	String carpaintsub = "";
	String carpaint = "";
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	
	ArrayList<String> arcarimgsub = new ArrayList<>();
	ArrayList<String> arcarimg = new ArrayList<>();
	ArrayList<String> arcarpaintsub = new ArrayList<>();
	ArrayList<String> arcarpaint = new ArrayList<>();
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from adminCar where bidx = 1";
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			bidx = rs.getString("bidx");		
			cname = rs.getString("cname");		
		}
		
		sql = "select * from adminCar a join color c on a.cname=c.cname where a.cname like '%아반떼%'";
		
		psmt = conn.prepareStatement(sql);
		
		rs2 = psmt.executeQuery();
		
		while(rs2.next()){
			carimgsub = rs2.getString("carimgsub");
			arcarimgsub.add(carimgsub);
			
			carimg = rs2.getString("carimg");
			arcarimg.add(carimg);
			
			carpaintsub = rs2.getString("carpaintsub");
			arcarpaintsub.add(carpaintsub);
			
			carpaint = rs2.getString("carpaint");
			arcarpaint.add(carpaint);
		}
		

	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null){
			conn.close();
		}
		if(psmt != null){
			conn.close();
		}
		if(rs != null){
			rs.close();
		}
		if(rs2 != null){
			rs2.close();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유모차[당신이 찾는 모든 차]-<%=cname %></title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>

</style>
</head>
<body>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
		<%@ include file = "/aside.jsp" %>
		<article class="carColor">
			<div><img src="<%=request.getContextPath()%>/image<%=arcarimg.get(0)%>" alt="<%=arcarimgsub.get(0)%>"></div>
			<div>
			<%for(int i=0; i<arcarpaint.size(); i++){ %>
				<label>
					<input type="radio" name="color" onclick="colorFn(this)"><img src="<%=request.getContextPath()%>/image<%=arcarpaint.get(i)%>" alt="<%=arcarpaintsub.get(i)%>">
					<input type="hidden" value="<%=i%>">
				</label>
			<%} %>
			</div>
		</article>
	</section>
	<script>
		function colorFn(obj){
			var val = $(obj);
			console.log(val);
			
		}
	</script>
</body>
</html>