<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.*" %>
<%@ page import = "UMoCha.*" %>
<%@ page import = "org.json.simple.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");
	
	String url = "jdbc:mysql://localhost:3306/mysql?serverTimezone=UTC";
	String user = "root";
	String userPass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,user,userPass);
		
		String sql = "select password from member where name = ? and phone = ? and id = ?";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,name);		
		psmt.setString(2,phone);	
		psmt.setString(3,id);	
		
		rs = psmt.executeQuery();
		JSONArray list = new JSONArray();
		
		if(rs.next()){
			JSONObject jobj = new JSONObject();
			jobj.put("pass",rs.getString("password"));
			jobj.put("id",id);
			
			list.add(jobj);
			out.print(list.toJSONString());
		}else{
			out.print(list.toJSONString(null));
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