<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	String cmake = request.getParameter("cmake");
	String cname = request.getParameter("cname");
	String price1 = request.getParameter("price1");
	String price2 = request.getParameter("price2");
	String bidx = request.getParameter("bidx");
	//옵션 개수 배열 변환 된 값 받아오기
	String optArray = request.getParameter("optArray");	

	//트림 개수 받기
	String trimCnt = request.getParameter("trimCnt");
	//트림이 한 개라면 트림 cnt 0으로 받기
	if(trimCnt == null){
		trimCnt = "0";
	}
	//trim
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
	//option
	String opt = null;
	String OName = null;
	String OPrice = null;
	String optno = null;
	
	//트림 n개를 추가하기 위한 ArrayList
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
	
	//트림 이름으로 구분해서 받기
	for(int i=0; i<=Integer.parseInt(trimCnt); i++){
		
		trim = request.getParameter("trim"+i);
		artrim.add(trim);
		
		trimPrice = request.getParameter("trimPrice"+i);
		artrimPrice.add(trimPrice);
		
		pt = request.getParameter("pt"+i);
		arpt.add(pt);
		
		Tsafe = request.getParameter("Tsafe"+i);
		arTsafe.add(Tsafe);
		
		safe = request.getParameter("safe"+i);
		arsafe.add(safe);
		
		ext = request.getParameter("ext"+i);
		arext.add(ext);
		
		inte = request.getParameter("inte"+i);
		arinte.add(inte);
		
		seat = request.getParameter("seat"+i);
		arseat.add(seat);
		
		conve = request.getParameter("conve"+i);
		arconve.add(conve);
		
		info = request.getParameter("info"+i);
		arinfo.add(info);
	}
	
	//옵션 개수 배열로 받아 온 것 잘라내기
	String aroptArray[] = optArray.split(",");
	//옵션 n개를 넣기 위한 ArrayList
	ArrayList<String> aropt = new ArrayList<>();
	ArrayList<String> arOName = new ArrayList<>();
	ArrayList<String> arOPrice = new ArrayList<>();
	ArrayList<String> aroptno = new ArrayList<>();
	
	//이름으로 구분해서 옵션 받기
	for(int i=0; i<=Integer.parseInt(trimCnt); i++){
		for(int j=0; j<Integer.parseInt(aroptArray[i]); j++){
			opt = request.getParameter("opt"+i+"-"+j);
			aropt.add(opt);
			
			OName = request.getParameter("OName"+i+"-"+j);
			arOName.add(OName);
			
			OPrice = request.getParameter("OPrice"+i+"-"+j);
			arOPrice.add(OPrice);
			
			optno = request.getParameter("optno"+i+"-"+j);
			aroptno.add(optno);
	
		}
	}
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	int result = 0;
	int result1 = 0;
	int result2 = 0;
	
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "update adminCar set price1 = ?, price2 = ? where bidx = ?";
									
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,price1);
		psmt.setString(2,price2);
		psmt.setString(3,bidx);
		
		result = psmt.executeUpdate();
		
		sql = "update Trims set pt = ?, Tsafe = ?, safe = ?, ext = ?, inte = ?, seat = ?, conve = ?, info = ?, TPrice = ? where trim = ?";
		
		psmt = conn.prepareStatement(sql);
		
		//트림 db에 입력
		for(int i=0; i<=Integer.parseInt(trimCnt); i++){
			psmt.setString(1,arpt.get(i));
			psmt.setString(2,arTsafe.get(i));
			psmt.setString(3,arsafe.get(i));
			psmt.setString(4,arext.get(i));
			psmt.setString(5,arinte.get(i));
			psmt.setString(6,arseat.get(i));
			psmt.setString(7,arconve.get(i));
			psmt.setString(8,arinfo.get(i));
			psmt.setString(9,artrimPrice.get(i));
			psmt.setString(10,artrim.get(i));
			
			result1 = psmt.executeUpdate();
			
		}
		
		sql = "update opt set opt = ?, OPrice = ? where trim = ? and optno = ?";
		
		psmt = conn.prepareStatement(sql);
				
		//옵션 db에 입력
		int optnoCnt = 0;
		boolean Ono = true;
		
		for(int i=0; i<=Integer.parseInt(trimCnt); i++){
			optnoCnt = 0;
			Ono = true;
			
			for(int j=0; j<Integer.parseInt(aroptArray[i]); j++){
				psmt.setString(1,aropt.get(j));
				psmt.setString(2,arOPrice.get(j));
				psmt.setString(3,artrim.get(i));
				psmt.setString(4,aroptno.get(j));
				
				result2 = psmt.executeUpdate();
			}
			
			while(Ono){
				aroptno.remove(0);
				aropt.remove(0);
				
				if(optnoCnt == (Integer.parseInt(aroptArray[i])-1)){
					Ono = false;
				}
				
				optnoCnt++;
			}
		}
		
		
		if(result >0 ||result1 > 0||result2 > 0){
			response.sendRedirect(request.getContextPath()+"/car/car.jsp?bidx="+bidx);
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