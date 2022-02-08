<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.util.*" %>

<%
	String bidx = "";
	String cname = "";
	//rs2
	String carimgsub = "";
	String carimg = "";
	String carpaintsub = "";
	String carpaint = "";
	//rs3
	String wheelname = "";
	String wheelimg = "";
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	
	//rs2
	ArrayList<String> arcarimgsub = new ArrayList<>();
	ArrayList<String> arcarimg = new ArrayList<>();
	ArrayList<String> arcarpaintsub = new ArrayList<>();
	ArrayList<String> arcarpaint = new ArrayList<>();
	//rs3
	ArrayList<String> arwheelname = new ArrayList<>();
	ArrayList<String> arwheelimg = new ArrayList<>();
	
	ArrayList<TO> arTo = new ArrayList<>();
	
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
		
		sql = "select * from adminCar a, wheel w where a.cname = w.cname and a.cname like '%아반떼%'";
		
		psmt = conn.prepareStatement(sql);
		
		rs3 = psmt.executeQuery();
		
		while(rs3.next()){
			wheelname = rs3.getString("wheelname");
			arwheelname.add(wheelname);
			
			wheelimg = rs3.getString("wheelimg");
			arwheelimg.add(wheelimg);
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
		if(rs3 != null){
			rs3.close();
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
	.carImg{
		width : 50px;
		height : 50px;
		border-radius : 25px;
	}
	
	.wheelImg{
		width : 101px;
	}
	
	.fWheel{
		position : absolute;
		top : 239px;
		left : 119px;
	}
	
	.rWheel{
		position : absolute;
		top : 239px;
		left : 548px;
	}
	
	h2{
		position : absolute;
	}
</style>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
		<%@ include file = "/aside.jsp" %>
		<article class="carColor">
			<h2><%=cname %></h2>
			<div><img src="<%=request.getContextPath()%>/image<%=arcarimg.get(0)%>" alt="<%=arcarimgsub.get(0)%>" width="800px"></div>
			<h3>색상 선택</h3>
			<hr>
			<div>
			<%for(int i=0; i<arcarpaint.size(); i++){ 
				if(i == 0){
			%>
				<label>
					<input type="radio" name="color" onclick="colorFn(this)" checked>
					<img src="<%=request.getContextPath()%>/image<%=arcarpaint.get(i)%>" alt="<%=arcarpaintsub.get(i)%>" class="carImg" title="<%=arcarpaintsub.get(i)%>">
					<input type="hidden" value="<%=arcarpaintsub.get(i)%>">
				</label>
			<%
				}else{
			%>
				<label>
					<input type="radio" name="color" onclick="colorFn(this)">
					<img src="<%=request.getContextPath()%>/image<%=arcarpaint.get(i)%>" alt="<%=arcarpaintsub.get(i)%>" class="carImg" title="<%=arcarpaintsub.get(i)%>">
					<input type="hidden" value="<%=arcarpaintsub.get(i)%>">
				</label>
			<%
				}
			}
			%>
			</div>
			<div class="wheel">
				<div><img src="<%=request.getContextPath()%>/image<%=arwheelimg.get(0)%>" alt="<%=arwheelname.get(0)%>" class="wheelImg fWheel"></div>
				<div><img src="<%=request.getContextPath()%>/image<%=arwheelimg.get(0)%>" alt="<%=arwheelname.get(0)%>" class="wheelImg rWheel"></div>
			</div>
			<h3>휠 선택</h3>
			<hr>
			<div>
			<%
				for(int i=0; i<arwheelimg.size(); i++){ 
					if(i == 0){
			%>
				<label>
					<input type="radio" name="wheel" onclick="wheelFn(this)" checked>
					<img src="<%=request.getContextPath()%>/image<%=arwheelimg.get(i)%>" alt="<%=arwheelname.get(i)%>" title="<%=arwheelname.get(i)%>">
					<input type="hidden" value="<%=arwheelimg.get(i)%>">
				</label>
			<%
				}else{
			
			%>
				<label>
					<input type="radio" name="wheel" onclick="wheelFn(this)">
					<img src="<%=request.getContextPath()%>/image<%=arwheelimg.get(i)%>" alt="<%=arwheelname.get(i)%>" title="<%=arwheelname.get(i)%>">
					<input type="hidden" value="<%=arwheelimg.get(i)%>">
				</label>
			<%
					} 
				}
			%>
			</div>
		</article>
	</section>
	<script>
		function colorFn(obj){
			var value = $(obj).next().next().val();
			var html = "<img src='<%=request.getContextPath()%>/image/"+value+".jpg' alt='+value+' width='800px'>";
			console.log(value);
			var a = $(".carColor").find("div:eq(0)").html(html);
			console.log(a);
		}
		
		function wheelFn(obj){
			var value = $(obj).next().next().val();
			var html = "<div><img src='<%=request.getContextPath()%>/image/"+value+"' alt='+value+' class='wheelImg fWheel'><div>";
				html += "<div><img src='<%=request.getContextPath()%>/image/"+value+"' alt='+value+' class='wheelImg rWheel'><div>";
			$(".wheel").html(html);
		}
	</script>
</body>
</html>