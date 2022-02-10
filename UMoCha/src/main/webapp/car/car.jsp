<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.util.*" %>

<%
	String bidx_ = request.getParameter("bidx");

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
	//rs4 - trim
	String trim = "";
	String pt = "";
	String Tsafe = "";
	String safe = "";
	String ext = "";
	String inte = "";
	String seat = "";
	String conve = "";
	String info = "";
	String TPrice = "";
	//rs5 - trim 개수 구하기
	String trimCnt = "";
	//rs6 - option
	String opt = "";
	String oName = "";
	String oPrice = "";
	
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	ResultSet rs4 = null;
	ResultSet rs5 = null;
	ResultSet rs6 = null;
	
	//rs2
	ArrayList<String> arcarimgsub = new ArrayList<>();
	ArrayList<String> arcarimg = new ArrayList<>();
	ArrayList<String> arcarpaintsub = new ArrayList<>();
	ArrayList<String> arcarpaint = new ArrayList<>();
	//rs3
	ArrayList<String> arwheelname = new ArrayList<>();
	ArrayList<String> arwheelimg = new ArrayList<>();
	//rs4 - trim
	ArrayList<String> arTrim = new ArrayList<>();
	ArrayList<String> arPt = new ArrayList<>();
	ArrayList<String> arTsafe = new ArrayList<>();
	ArrayList<String> arSafe = new ArrayList<>();
	ArrayList<String> arExt = new ArrayList<>();
	ArrayList<String> arInte = new ArrayList<>();
	ArrayList<String> arSeat = new ArrayList<>();
	ArrayList<String> arConve = new ArrayList<>();
	ArrayList<String> arInfo = new ArrayList<>();
	ArrayList<String> arTPrice = new ArrayList<>();
	//rs5 - trim 개수
	ArrayList<String> artrimCnt = new ArrayList<>();
	//rs6 - option
	ArrayList<String> arOpt = new ArrayList<>();
	ArrayList<String> arOName = new ArrayList<>();
	ArrayList<String> arOPrice = new ArrayList<>();
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from adminCar where bidx = ?";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,bidx_);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			bidx = rs.getString("bidx");		
			cname = rs.getString("cname");		
		}
		
		sql = "select * from adminCar a join color c on a.cname=c.cname where a.cname = ?";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cname);
		
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
		
		sql = "select * from wheel where cname = ?";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cname);
		
		rs3 = psmt.executeQuery();
		
		while(rs3.next()){
			wheelname = rs3.getString("wheelname");
			arwheelname.add(wheelname);
			
			wheelimg = rs3.getString("wheelimg");
			arwheelimg.add(wheelimg);
		}

		sql = "select * from trims where cname = ?";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cname);
		
		rs4 = psmt.executeQuery();
		
		while(rs4.next()){
			trim = rs4.getString("trim");
			arTrim.add(trim);
			
			pt = rs4.getString("pt");
			arPt.add(pt);
			
			Tsafe = rs4.getString("Tsafe");
			arTsafe.add(Tsafe);
			
			safe = rs4.getString("safe");
			arSafe.add(safe);
			
			ext = rs4.getString("ext");
			arExt.add(ext);
			
			inte = rs4.getString("inte");
			arInte.add(inte);
			
			seat = rs4.getString("seat");
			arSeat.add(seat);
			
			conve = rs4.getString("conve");
			arConve.add(conve);
			
			info = rs4.getString("info");
			arInfo.add(info);
			
			TPrice = rs4.getString("TPrice");
			arTPrice.add(TPrice);
		}
		
		sql = "select count(trim) from opt where trim = ? and cname = ?";
		
		for(int i=0; i<arTrim.size(); i++){
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1,arTrim.get(i));
			psmt.setString(2,cname);
			
			rs5 = psmt.executeQuery();
			
			if(rs5.next()){				
				trimCnt = rs5.getString("count(trim)");
				artrimCnt.add(trimCnt);
			}
		}
	
		System.out.println(artrimCnt);
		
		sql = "select * from opt where cname = ?";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cname);
		
		rs6 = psmt.executeQuery();
		
		while(rs6.next()){
			opt = rs6.getString("opt");
			arOpt.add(opt);
			
			oName = rs6.getString("oName");
			arOName.add(oName);
			
			oPrice = rs6.getString("oPrice");
			arOPrice.add(oPrice);
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
		if(rs4 != null){
			rs4.close();
		}
		if(rs5 != null){
			rs5.close();
		}
		if(rs6 != null){
			rs6.close();
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
			<h3>트림 선택</h3>
			<hr>
			<div>
				<%int trimNum = 0; %>
				<%
					for(int i=0; i<arTrim.size(); i++){
						if(i == 0){
				%>
					<label>
						<input type="radio" name="trim" value="<%=trimNum++%>" checked onchange="choiceTrim(this)"><%=arTrim.get(i)%> [<%=arTPrice.get(i) %>만원]
					</label>
				<%
						}else{
				%>
					<label>
						<input type="radio" name="trim" value="<%=trimNum++%>" onchange="choiceTrim(this)"><%=arTrim.get(i)%> [<%=arTPrice.get(i) %>만원]
					</label>
				<%
						}
					} 
				%>
			</div>
			<h3>옵션 선택</h3>
			<hr>
				<%
					boolean optResult = true;
					int optCnt = 0;
					for(int i=0; i<arTrim.size(); i++){
						optResult = true;
						optCnt = 0;
				%>
					<div id="<%=i%>" style="display:none;">
				<%
						for(int j=0; j<Integer.parseInt(artrimCnt.get(i)); j++){
				%>
						<div>
							<label>
								<input type="checkbox" name="opt"><%=arOName.get(j)%> [<%=arOPrice.get(j) %>만원]
							</label>
						</div>
				<%
						}
						while(optResult){
							optCnt++;
							arOpt.remove(0);
							arOName.remove(0);
							arOPrice.remove(0);
								
							if(optCnt == Integer.parseInt(artrimCnt.get(i))){
								optResult = false;
							}
						}
				%>
					</div>
				<%
					}
				%>
		</article>
	</section>
	<script>
		//색상 선택
		function colorFn(obj){
			var value = $(obj).next().next().val();
			var html = "<img src='<%=request.getContextPath()%>/image/"+value+".jpg' alt='+value+' width='800px'>";
			console.log(value);
			var a = $(".carColor").find("div:eq(0)").html(html);
			console.log(a);
		}
		
		//휠 선택
		function wheelFn(obj){
			var value = $(obj).next().next().val();
			var html = "<div><img src='<%=request.getContextPath()%>/image/"+value+"' alt='+value+' class='wheelImg fWheel'><div>";
				html += "<div><img src='<%=request.getContextPath()%>/image/"+value+"' alt='+value+' class='wheelImg rWheel'><div>";
			$(".wheel").html(html);
		}
		
		//트림별 옵션 출력
		var trimVal = $("input:radio[name='trim']:checked").val();
		$("#"+trimVal+"").css("display","block");
		
		function choiceTrim(obj){
			trimVal = $(obj).val();
			console.log(trimVal);
			console.log($("#"+trimVal+""));
			<%
				for(int i=0; i<arTrim.size(); i++){
			%>
					if(<%=i%> == trimVal){
						$("#"+trimVal+"").css("display","block");
					}else{
						$("#"+<%=i%>+"").css("display","none");
					}
			<%
				}
			%>
		}
		
		//옵션 중복 선택 방지
	
	</script>
</body>
</html>