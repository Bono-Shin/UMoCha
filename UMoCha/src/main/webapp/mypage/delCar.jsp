<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.*"%>

<%
	String bidx = request.getParameter("bidx");

	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	int result = 0;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "update adminCar set delYN = 'y' where bidx = ?";
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,bidx);
		
		result = psmt.executeUpdate();
		
		if(result > 0){
			out.print(result);
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