<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>
<%@ page import = "UMoCha.*" %>
<%@ page import = "java.util.*" %>

<%
	String cname_ = request.getParameter("cname");

	String bidx = "";
	String cname = "";
	String img = "";
	//rs2 - trim
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
	//rs3 - trim 개수 구하기
	String trimCnt = "";
	//rs4 - option
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
	int result = 0;
	
	//rs2 - trim
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
	//rs3 - trim별 옵션 개수
	ArrayList<String> artrimCnt = new ArrayList<>();
	//rs4 - option
	ArrayList<String> arOpt = new ArrayList<>();
	ArrayList<String> arOName = new ArrayList<>();
	ArrayList<String> arOPrice = new ArrayList<>();
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from adminCar where cname = ?";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cname_);
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			bidx = rs.getString("bidx");		
			cname = rs.getString("cname");		
			img = rs.getString("image");		
		}
		
		sql = "select * from trims where cname = ?";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cname);
		
		rs2 = psmt.executeQuery();
		
		while(rs2.next()){
			trim = rs2.getString("trim");
			arTrim.add(trim);
			
			pt = rs2.getString("pt");
			arPt.add(pt);
			
			Tsafe = rs2.getString("Tsafe");
			arTsafe.add(Tsafe);
			
			safe = rs2.getString("safe");
			arSafe.add(safe);
			
			ext = rs2.getString("ext");
			arExt.add(ext);
			
			inte = rs2.getString("inte");
			arInte.add(inte);
			
			seat = rs2.getString("seat");
			arSeat.add(seat);
			
			conve = rs2.getString("conve");
			arConve.add(conve);
			
			info = rs2.getString("info");
			arInfo.add(info);
			
			TPrice = rs2.getString("TPrice");
			arTPrice.add(TPrice);
		}
		
		sql = "select count(trim) from opt where trim = ? and cname = ?";
		
		for(int i=0; i<arTrim.size(); i++){
			psmt = conn.prepareStatement(sql);
			
			psmt.setString(1,arTrim.get(i));
			psmt.setString(2,cname);
			
			rs3 = psmt.executeQuery();
			
			if(rs3.next()){				
				trimCnt = rs3.getString("count(trim)");
				artrimCnt.add(trimCnt);
			}
		}
	
		System.out.println(artrimCnt);
		
		sql = "select * from opt where cname = ?";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cname);
		
		rs4 = psmt.executeQuery();
		
		while(rs4.next()){
			opt = rs4.getString("opt");
			arOpt.add(opt);
			
			oName = rs4.getString("oName");
			arOName.add(oName);
			
			oPrice = rs4.getString("oPrice");
			arOPrice.add(oPrice);
		}
		
		sql = "update adminCar set hit = hit+1 where cname like '%"+cname+"%'";
		
		psmt = conn.prepareStatement(sql);
		
		result = psmt.executeUpdate();
		
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
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트림 상세 보기</title>
<style>
	.bb{
		color : blue;
	}
	
	table{
		border-collapse : collapse;
	}
</style>
</head>
<body>
	<table border="1">
		<thead>
			<tr>
				<th width="100px">트림</th>
				<th width="300px">가격</th>
				<th>내용</th>
			</tr>
		</thead>
		<tbody>
		<%
			int trimCheck = 1; 
			
			for(int i=0; i<arTrim.size(); i++){ 
		%>
			<tr>
				<th><%=arTrim.get(i) %></th>
				<td><%=arTPrice.get(i) %>만원</td>
				<td>
				<%if(i == 0){ %>
					<b class="bb">[기본 품목]</b><br><br>
				<%
					}else if(trimCheck == i){
				%>
					<b class="bb">[<%=arTrim.get(i-1) %> 품목 외]</b><br><br>
				<%	
					trimCheck++;
					}
				%>
				<%if(!(arPt.get(i).equals(""))){ %>
					<b>파워 트레인</b> : <%=arPt.get(i) %><br><br>
				<%}%>
				<%if(!(arTsafe.get(i).equals(""))){ %>
					<b>안전  기술</b> : <%=arTsafe.get(i) %><br><br>
				<%}%>
				<%if(!(arSafe.get(i).equals(""))){ %>
					<b>안전  사양</b> : <%=arSafe.get(i) %><br><br>
				<%}%>
				<%if(!(arExt.get(i).equals(""))){ %>
					<b>외장  사양</b> : <%=arExt.get(i) %><br><br>
				<%}%>
				<%if(!(arInte.get(i).equals(""))){ %>
					<b>내장  사양</b> : <%=arInte.get(i) %><br><br>
				<%}%>
				<%if(!(arSeat.get(i).equals(""))){ %>
					<b>시트  사양</b> : <%=arSeat.get(i) %><br><br>
				<%}%>
				<%if(!(arConve.get(i).equals(""))){ %>
					<b>편의  사양</b> : <%=arConve.get(i) %><br><br>
				<%}%>
				<%if(!(arInfo.get(i).equals(""))){ %>	
					<b>인포테인먼트</b> : <%=arInfo.get(i) %><br><br>
				<%}%>
				</td>
			</tr>
			<tr>
				<th rowspan="<%=artrimCnt.get(i)%>">옵션</th>
			<%for(int j=0; j<Integer.parseInt(artrimCnt.get(i)); j++){ %>
				<td><%=arOName.get(j) %> (<%=arOPrice.get(j) %>만원)</td>
				<td><%=arOpt.get(j) %></td>
			</tr>
		<%
			}
		}
		%>
		</tbody>
	</table>
</body>
</html>