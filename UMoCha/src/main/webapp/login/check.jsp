<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@ page import = "java.sql.*" %>

<%
	String id = request.getParameter("id");
	

	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	int check = 0;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from member where id = ?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,id);		
		
		rs = psmt.executeQuery();
		
		if(rs.next()){
			check = 1;
		}
		
		out.print(check);
				
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