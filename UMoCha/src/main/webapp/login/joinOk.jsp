<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "org.json.simple.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String addr = request.getParameter("addr");
	String phone = request.getParameter("phone");
	String type = request.getParameter("type");
	String email = request.getParameter("email");
	
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
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
		
		//-------------------------------- 여기까지가 회원가입 ---------------------------
				
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