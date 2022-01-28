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
	String optArray = request.getParameter("optArray");	
	String trimCnt = request.getParameter("trimCnt");	
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
	ArrayList<String> aropt = new ArrayList<>();
	ArrayList<String> arOName = new ArrayList<>();
	ArrayList<String> arOPrice = new ArrayList<>();
	
	String aroptArray[] = optArray.split("-"); //???
	
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
		
		opt = request.getParameter("opt"+i);
		aropt.add(opt);
		
		OName = request.getParameter("OName"+i);
		arOName.add(OName);
		
		OPrice = request.getParameter("OPrice"+i);
		arOPrice.add(OPrice);
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
		
		String sql = "insert into adminCar(make,cname,price1,price2) values(?,?,?,?)";
										//make,image,cname,trim,opt,color,price1,price2
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cmake);
		psmt.setString(2,cname);
		psmt.setString(3,price1);
		psmt.setString(4,price2);
		
		result = psmt.executeUpdate();
		
		sql = "insert into Trims(CName,trim,pt,Tsafe,safe,ext,inte,seat,conve,info,TPrice) values(?,?,?,?,?,?,?,?,?,?,?)";
		
		psmt = conn.prepareStatement(sql);
		
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
		
		for(int i=0; i<=Integer.parseInt(trimCnt); i++){
			psmt.setString(1,cname);
			psmt.setString(2,arOName.get(i));
			psmt.setString(3,aropt.get(i));
			psmt.setString(4,arOPrice.get(i));
			psmt.setString(5,artrim.get(i));
			
			result = psmt.executeUpdate();
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