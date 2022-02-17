<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "UMoCha.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>

<% Member consultUser = (Member)session.getAttribute("loginUser"); %>

<%
	String cname = request.getParameter("cname");
	String make = request.getParameter("make");
	String carColor = request.getParameter("carColor");
	String carTrim = request.getParameter("carTrim");
	String carOpt = request.getParameter("carOpt");
	String oCnt = request.getParameter("oCnt");
	String carPrice = request.getParameter("carPrice");
	
	if(carOpt != null && carOpt != ""){
		carOpt = carOpt.substring(0,carOpt.length()-1);
	}else{
		carOpt = "";
	}
	
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	int result = 0;
	
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "insert into consult(midx,cname,make,carColor,carTrim,carOpt,carPrice) values(?,?,?,?,?,?,?);";
		
		psmt = conn.prepareStatement(sql);
		
		psmt.setInt(1,consultUser.getMidx());
		psmt.setString(2,cname);
		psmt.setString(3,make);
		psmt.setString(4,carColor);
		psmt.setString(5,carTrim);
		psmt.setString(6,carOpt);
		psmt.setString(7,carPrice);
		
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
