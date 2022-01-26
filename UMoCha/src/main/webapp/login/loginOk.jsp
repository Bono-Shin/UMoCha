<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%@ page import = "java.sql.*" %>
<%@ page import = "UMoCha.*" %>

<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");

	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select * from member where id = ? and password = ?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,id);		
		psmt.setString(2,pass);		
		
		rs = psmt.executeQuery();
		
		Member m = null;
		
		while(rs.next()){
			m = new Member();
			m.setMidx(rs.getInt("midx"));
			m.setId(rs.getString("id"));
			m.setName(rs.getString("name"));
			m.setType(rs.getString("type"));
			
		}
		
		if(m != null){
			session.setAttribute("loginUser",m);
			response.sendRedirect(request.getContextPath());
		}else{
			response.sendRedirect("login.jsp");
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