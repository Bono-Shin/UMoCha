<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	String midx = request.getParameter("midx");
	String pass = request.getParameter("pass");
	String addr = request.getParameter("addr");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	int result = 0;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "update member set password = ?, addr = ?, phone = ?, email = ?  where delYN = 'n' and blackYN ='n' and midx = "+midx;
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,pass);
		psmt.setString(2,addr);
		psmt.setString(3,phone);
		psmt.setString(4,email);
		
		result = psmt.executeUpdate();
		
		if(result > 0){
			response.sendRedirect("normalUserInfo.jsp");
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
	}
%>