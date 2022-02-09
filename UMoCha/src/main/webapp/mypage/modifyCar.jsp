<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "UMoCha.*" %>

<% Member insertCarLogin = (Member)session.getAttribute("loginUser"); %>

<%
	request.setCharacterEncoding("UTF-8");
	
	String cname_ = request.getParameter("cname");
	
	//adminCar - rs
	String make = "";
	String cname = "";
	String price1 = "";
	String price2 = "";
	String image = "";
	
	//trim - rs2
	String trim = null;
	String trimPrice = null;
	String pt = null;
	String Tsafe = null;
	String safe = null;
	String ext = null;
	String inte = null;
	String seat = null;
	String conve = null;
	String info = null;
	ArrayList<String> artrim = new ArrayList<>();
	ArrayList<String> artrimPrice  = new ArrayList<>();
	ArrayList<String> arpt = new ArrayList<>();
	ArrayList<String> arTsafe = new ArrayList<>();
	ArrayList<String> arsafe = new ArrayList<>();
	ArrayList<String> arext = new ArrayList<>();
	ArrayList<String> arinte = new ArrayList<>();
	ArrayList<String> arseat = new ArrayList<>();
	ArrayList<String> arconve = new ArrayList<>();
	ArrayList<String> arinfo = new ArrayList<>();
	
	//trim 별 개수 - rs3
	String trimCnt = "";
	ArrayList<String> arTrimCnt = new ArrayList<>();
	
	//opt - rs4
	String opt = null;
	String OName = null;
	String OPrice = null;
	ArrayList<String> aropt = new ArrayList<>();
	ArrayList<String> arOName = new ArrayList<>();
	ArrayList<String> arOPrice = new ArrayList<>();
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	ResultSet rs4 = null;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from adminCar where cname = ? and delYN = 'n'";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cname_);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			cname = rs.getString("cname");
			make = rs.getString("make");
			price1 = rs.getString("price1");
			price2 = rs.getString("price2");
			image = rs.getString("image");
		}
		
		
		sql = "select * from trims where cname = ?";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cname_);
		
		rs2 = psmt.executeQuery();
		
		while(rs2.next()){
			trim = rs2.getString("trim");
			artrim.add(trim);
			
			trimPrice = rs2.getString("TPrice");
			artrimPrice.add(trimPrice);
			
			pt = rs2.getString("pt");
			arpt.add(pt);
			
			Tsafe = rs2.getString("Tsafe");
			arTsafe.add(Tsafe);
			
			safe = rs2.getString("safe");
			arsafe.add(safe);
			
			ext = rs2.getString("ext");
			arext.add(ext);
			
			inte = rs2.getString("inte");
			arinte.add(inte);
			
			seat = rs2.getString("seat");
			arseat.add(seat);
			
			conve = rs2.getString("conve");
			arconve.add(conve);
			
			info = rs2.getString("info");
			arinfo.add(info);
			
		}
		
		sql = "select count(trim) from opt where trim = ?";
		
		for(int i=0; i<artrim.size(); i++){
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,artrim.get(i));
			
			rs3 = psmt.executeQuery();
			
			if(rs3.next()){
				trimCnt = rs3.getString("count(trim)");
				arTrimCnt.add(trimCnt);
			}
		}

		sql = "select * from opt where cname = ?";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cname);
		
		rs4 = psmt.executeQuery();
		
		while(rs4.next()){
			opt = rs4.getString("opt");
			aropt.add(opt);
			
			OName = rs4.getString("OName");
			arOName.add(OName);
			
			OPrice = rs4.getString("OPrice");
			arOPrice.add(OPrice);
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
	}
	
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유모차[당신이 찾는 모든 차]-차량 업데이트</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<style>
	#insertCarTit{
		position : relative;
		left : 80px;
		background-color : gray;
		width : 800px;
	}
	
	#insertCarAt{
		margin : auto;
		width : 500px;
	}
	
	#imgD{
		border : 1px solid black;
	}
	
	textarea{
		width : 500px;
		height : 100px;
	}
	
	.price{
		width : 130px;
	}
	
	#priceD{
		margin-bottom : 30px;
	}
	
	.allD{
		margin-bottom : 20px;
	}
	
	#inSub{
		width : 300px;
		height : 40px;
		position : relative;
		left : 90px;
	}
	
	#cmake{
		width : 200px;
		height : 50px;
	}
</style>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<% if(insertCarLogin != null){%>
	<%@ include file = "/header.jsp" %>
	<%@ include file = "/nav.jsp" %>
	<section>
	<%@ include file = "/aside.jsp" %>
	<%@ include file = "/asideLeft.jsp" %>
		<article id="insertCarTit"><div><h2>차량 업데이트</h2></div></article>
		<article id="insertCarAt">
			<form action="#" method="post" enctype="multipart/form-data">
				<div class="allD">
					[제조사]<br>
					<div id="cmake"><%=make %></div>
				</div>
				<div class="allD">
					[차량 이름] <span></span><br>
					<input type="text" name="cname" value="<%=cname%>">
				</div>
				<div id="priceD" class="allD">
					[차량 가격] <span></span><br>
					<input type="text" name="price1" class="price" value="<%=price1%>">만원 
					~ 
					<input type="text" name="price2" class="price" value="<%=price2%>">만원
				</div>
				<%
					int TCnt = 0;
					boolean TO = true;
					for(int i=0; i<artrim.size(); i++){
						TCnt = 0;
						TO = true;
				%>
				<div>
				<div class="allD">
					<!-- n개의 트림이 있음 -->
					<div class="allD">
						[트림 이름] <span></span><br>
						<input type="text" name="trim<%=i%>" value="<%=artrim.get(i)%>">
					</div>
					<div class="allD">
						[트림 가격] <span></span><br>
						<input type="text" name="trimPrice<%=i%>" value="<%=artrimPrice.get(i)%>">만원
					</div>
					<div class="allD">
						[파워트레인] <span></span><br>
						<textarea name="pt<%=i%>"><%=arpt.get(i)%></textarea>
					</div>
					<div class="allD">
						[안전 기술] <span></span><br>
						<textarea name="Tsafe<%=i%>"><%=arTsafe.get(i)%></textarea>
					</div>
					<div class="allD">
						[안전] <span></span><br>
						<textarea name="safe<%=i%>"><%=arsafe.get(i)%></textarea>
					</div>
					<div class="allD">
						[외관] <span></span><br>
						<textarea name="ext<%=i%>"><%=arext.get(i)%></textarea>
					</div>
					<div class="allD">
						[내장] <span></span><br>
						<textarea name="inte<%=i%>"><%=arinte.get(i)%></textarea>
					</div>
					<div class="allD">
						[시트] <span></span><br>
						<textarea name="seat<%=i%>"><%=arseat.get(i)%></textarea>
					</div>
					<div class="allD">
						[편의] <span></span><br>
						<textarea name="conve<%=i%>"><%=arconve.get(i)%></textarea>
					</div>
					<div class="allD">
						[인포테인먼트] <span></span><br>
						<textarea name="info<%=i%>"><%=arinfo.get(i)%></textarea>
					</div>
					<%for(int j=0; j<Integer.parseInt(arTrimCnt.get(i)); j++){ %>
					<div class="allD">
						<!-- n개의 옵션 -->
						[차량 옵션] <span></span><br>
						옵션 이름 : <input type="text" name="OName<%=i%>-<%=j%>" value="<%=arOName.get(j)%>"><br>
						옵션 가격 : <input type="text" name="OPrice<%=i%>-<%=j%>" value="<%=arOPrice.get(j)%>">만원<br><br>
						<내용><br>
						<textarea name="opt<%=i%>-<%=j%>"><%=aropt.get(j)%>"</textarea>
						<input type='hidden' name='optCnt' value="<%=j%>">
					</div>
				</div>
				<div class="allD">
					<input type="button" value="옵션 추가" onclick="addOpt(this)">
					<input type="button" value="옵션 제거" onclick="delOpt(this)">
				</div>
				</div>
				<%		
						}
					
						while(TO){
							TCnt++;
							
							arOName.remove(0);
							arOPrice.remove(0);
							aropt.remove(0);
							
							if(TCnt == Integer.parseInt(arTrimCnt.get(i))){
								TO = false;
							}
						}
					} 
				%>
				<div class="allD">
					<input type="button" value="트림 추가" onclick="addTrim(this)">
					<input type="button" value="트림 제거" onclick="delTrim(this)">
				</div>
				<div id="imgD" class="allD">
					<div class="allD">
						[차량 메인 이미지 삽입]<br>
						<input type="file" name="maincarimg">
					</div>
					<div class="allD">
						[차량 색상 이미지 삽입]<br>
						<div>
							- 색상 이름 : <input type="text" name="carimgsub0"><br>
							<input type="file" name="carimg0">
							<input type="hidden" name="carimgCnt" value="0">
						</div>
						<input type="button" value="추가" onclick="insertCarimg(this)">
						<input type="button" value="삭제" onclick="delCarimg(this)">
					</div>
					<div class="allD">
						[카페인트 이미지 삽입]<br>
						<div>
							- 카페인트 이름 : <input type="text" name="carpaintsub0"><br>
							<input type="file" name="carpaint0">
						</div>
						<input type="button" value="추가" onclick="insertCarpaint(this)">
						<input type="button" value="삭제" onclick="delCarpaint(this)">
					</div>
					<div>
						[차량 휠 이미지 삽입]<br>
						<div>
							- 휠 이름 : <input type="text" name="wheelname0"><br>
							<input type="file" name="wheelimg0">
							<input type="hidden" name="wheelCnt" value="0">
						</div>
						<input type="button" value="추가" onclick="insertWheel(this)">
						<input type="button" value="삭제" onclick="delWheel(this)">
					</div>
				</div>
				<div>
					<input type="submit" value="수정" id="inSub" onclick="carSub(); return false;">
				</div>
			</form>
		</article>
	</section>
	<script>
	
		function carSub(){
			var result = true;
			
				optArray[arCnt] = optCnt;
				console.log("optArray="+optArray);
		
			if(result){
				
				var html = "<input type='hidden' name='optArray' value='"+optArray+"'>";
					html += "<input type='hidden' name='trimCnt' value='"+trimCnt+"'>";
				$("form").append(html);
				
				document.frm.submit();	
			}
			
		}
		
		var trimCnt = 0;
		var optCnt = 0;
		var arCnt = 0;
		
		var optArray = new Array();
		
		//트림 추가
		function addTrim(obj){
			
				optArray[arCnt] =  optCnt;
				arCnt++;
				optCnt=-1;
				trimCnt++;
				optCnt++;
			var html = "<div>";
				html += "<div class='allD'>";
				html += "<div class='allD'>";
				html += "[트림 이름] <span></span><br>";
				html += "<input type='text' name='trim"+trimCnt+"'>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[트림 가격] <span></span><br>";
				html += "<input type='text' name='trimPrice"+trimCnt+"'>만원";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[파워트레인] <span></span><br>";
				html += "<textarea name='pt"+trimCnt+"'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[안전 기술] <span></span><br>";
				html += "<textarea name='Tsafe"+trimCnt+"'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[안전] <span></span><br>";
				html += "<textarea name='safe"+trimCnt+"'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[외관] <span></span><br>";
				html += "<textarea name='ext"+trimCnt+"'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[내장] <span></span><br>";
				html += "<textarea name='inte"+trimCnt+"'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[시트] <span></span><br>";
				html += "<textarea name='seat"+trimCnt+"'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[편의] <span></span><br>";
				html += "<textarea name='conve"+trimCnt+"'></textarea><br>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[인포테인먼트] <span></span><br>";
				html += "<textarea name='info"+trimCnt+"'></textarea>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "[차량 옵션] <span></span><br>";
				html += "옵션 이름 : <input type='text' name='OName"+trimCnt+"-"+optCnt+"'><br>";
				html += "옵션 가격 : <input type='text' name='OPrice"+trimCnt+"-"+optCnt+"'>만원<br><br>";
				html += "<내용><br>";
				html += "<textarea name='opt"+trimCnt+"-"+optCnt+"'></textarea>";
				html += "<input type='hidden' name='optCnt' value='"+optCnt+"'>";
				html += "</div>";
				html += "</div>";
				html += "<div class='allD'>";
				html += "<input type='button' value='옵션 추가' onclick='addOpt(this)'>";
				html += "<input type='button' value='옵션 제거' onclick='delOpt(this)'>";
				html += "</div>";
				html += "</div>";
				//트림 추가 개수 정보 저장
				console.log("trimCnt="+trimCnt);
			
				$(obj).parent().before(html);
				
				
				console.log("optCnt="+optCnt);
				console.log("optArray="+optArray);
		}
		
		function delTrim(obj){
			arCnt--;
			optCnt=0;
			trimCnt--;
			$(obj).parent().prev().remove();
		}
		
		//옵션 추가
		function addOpt(obj){
			optCnt++;
		var html = "<div class='allD'>";
			html += "[차량 옵션] <span></span><br>";
			html += "옵션 이름 : <input type='text' name='OName"+trimCnt+"-"+optCnt+"'><br>";
			html += "옵션 가격 : <input type='text' name='OPrice"+trimCnt+"-"+optCnt+"'>만원<br><br>";
			html += "<내용><br>";
			html += "<textarea name='opt"+trimCnt+"-"+optCnt+"'></textarea>";
			html += "<input type='hidden' name='optCnt' value='"+optCnt+"'>";
			html += "</div>";
			console.log("optCnt="+optCnt);
			console.log("optArray="+optArray);
			
			$(obj).parent().prev().append(html);
		
		}
		
		function delOpt(obj){
			optCnt--;
			$(obj).parent().prev().find("div:nth-last-child(1)").remove();
		}
		
		var carimgCnt = 0;
		var carpaintCnt = 0;
		var wheelCnt = 0;
		
		//차량 색상 이미지
		function insertCarimg(obj){
			carimgCnt++;
			var html = "<div>";
				html += "- 색상 이름 : <input type='text' name='carimgsub"+carimgCnt+"'><br>";
				html += "<input type='file' name='carimg"+carimgCnt+"'>";
				html += "<input type='hidden' name='carimgCnt' value="+carimgCnt+">";
				html += "</div>";
			
			$(obj).before(html);
		}
		
		function delCarimg(obj){
			carimgCnt--;
			$(obj).prev().prev().remove();
		}
		
		//카페인트
		function insertCarpaint(obj){
			carpaintCnt++;
			var html = "<div>";
				html += "- 카페인트 이름 : <input type='text' name='carpaintsub"+carpaintCnt+"'><br>";
				html += "<input type='file' name='carpaint"+carpaintCnt+"'>";
				html += "</div>";
			
			$(obj).before(html);
		}
		
		function delCarpaint(obj){
			carpaintCnt--;
			$(obj).prev().prev().remove();
		}
		
		//wheel
		function insertWheel(obj){
			wheelCnt++;
			var html = "<div>";
				html += "- 휠 이름 : <input type='text' name='wheelname"+wheelCnt+"'><br>";
				html += "<input type='file' name='wheelimg"+wheelCnt+"'>";
				html += "<input type='hidden' name='wheelCnt' value="+wheelCnt+">";
				html += "</div>";
				
			$(obj).before(html);
		}
		
		function delWheel(obj){
			wheelCnt--;
			$(obj).prev().prev().remove();
		}
		
	</script>
	<%
	}else{
		response.sendRedirect(request.getContextPath());
	}
	%>
</body>
</html>