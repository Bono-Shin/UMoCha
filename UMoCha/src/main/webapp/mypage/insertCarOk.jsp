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
	String trimCnt = request.getParameter("trimCnt");
	System.out.println(trimCnt);
	String trim = null;
	ArrayList<String> T = new ArrayList<>();
	for(int i=0; i<Integer.parseInt(trimCnt); i++){
		trim = request.getParameter("trim"+i);
		System.out.println(trim);
		T.add(trim);
		System.out.println(T.get(i));
	}
	String trimPrice = request.getParameter("trimPrice");
	String pt = request.getParameter("pt");
	String Tsafe = request.getParameter("Tsafe");
	String safe = request.getParameter("safe");
	String ext = request.getParameter("ext");
	String inte = request.getParameter("inte");
	String seat = request.getParameter("seat");
	String conve = request.getParameter("conve");
	String info = request.getParameter("info");
	String opt = request.getParameter("opt");
	
	
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	/*
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "insert into member(id,PASSWORD,name,addr,phone,email,type) values(?,?,?,?,?,?,?)";
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,id);
		psmt.setString(2,pass);
		psmt.setString(3,name);
		psmt.setString(4,addr);
		psmt.setString(5,phone);
		psmt.setString(6,email);
		psmt.setString(7,type);
		
		int result = psmt.executeUpdate();
		
		if(result > 0){
			response.sendRedirect(request.getContextPath());
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
	*/
%>