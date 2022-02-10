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
	String opt = null;
	String OName = null;
	String OPrice = null;
	
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
	
	//이름으로 구분해서 옵션 받기
	for(int i=0; i<=Integer.parseInt(trimCnt); i++){
		for(int j=0; j<=Integer.parseInt(aroptArray[i]); j++){
			opt = request.getParameter("opt"+i+"-"+j);
			aropt.add(opt);
			
			OName = request.getParameter("OName"+i+"-"+j);
			arOName.add(OName);
			
			OPrice = request.getParameter("OPrice"+i+"-"+j);
			arOPrice.add(OPrice);
			
		}
	}
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	int result = 0;
	
	
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "update adminCar set price1 = ?, price2 = ? where bidx = ?";
									
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,price1);
		psmt.setString(2,price2);
		psmt.setString(3,bidx);
		
		result = psmt.executeUpdate();
		
		sql = "update Trims set pt = ?, Tsafe = ?, safe = ?, ext = ?, inte = ?, seat = ?, conve = ?, info = ?, TPrice = ?";
		
		psmt = conn.prepareStatement(sql);
		
		//트림 db에 입력
		for(int i=0; i<=Integer.parseInt(trimCnt); i++){
			psmt.setString(1,cname);
			psmt.setString(2,artrim.get(i));
			psmt.setString(3,arpt.get(i));
			psmt.setString(4,arTsafe.get(i));
			psmt.setString(5,arsafe.get(i));
			psmt.setString(6,arext.get(i));
			psmt.setString(7,arinte.get(i));
			psmt.setString(8,arseat.get(i));
			psmt.setString(9,arconve.get(i));
			psmt.setString(10,arinfo.get(i));
			psmt.setString(11,artrimPrice.get(i));
			
			result = psmt.executeUpdate();
		}
		
		sql = "insert into opt(CName,OName,opt,OPrice,trim) values(?,?,?,?,?)";
		
		psmt = conn.prepareStatement(sql);
		
		//옵션 개수 카운트
		int cnt = 0;
		//while문 빠져나올 키
		boolean arresult = true;
		
		//옵션 db에 입력
		for(int i=0; i<=Integer.parseInt(trimCnt); i++){
			arresult = true;
			cnt = 0;
			for(int j=0; j<=Integer.parseInt(aroptArray[i]); j++){
				psmt.setString(1,cname);
				psmt.setString(2,arOName.get(j));
				psmt.setString(3,aropt.get(j));
				psmt.setString(4,arOPrice.get(j));
				psmt.setString(5,artrim.get(i));
			
				result = psmt.executeUpdate();
			}
			//옵션 개수만큼 index(0) 삭제 -> 다음 for문에서 index(0)은 다음 트림의 첫 번째 옵션
			while(arresult){
				aropt.remove(0);
				arOName.remove(0);
				arOPrice.remove(0);
				if(cnt == Integer.parseInt(aroptArray[i])){
					arresult = false;
				}
				cnt++;
			}
		}
		
		if(result > 0){
			response.sendRedirect("carList.jsp");
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