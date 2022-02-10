<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<!-- MultipartRequest 사용을 위한 import -->
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%
	//이미지 받기 위한 준비1
	String directory = "C:/Users/311/git/UMoCha/UMoCha/src/main/webapp/image"; //저장경로
	int imgSize = 100*1024*1024; //사이즈
	
	String carimgsub ="";
	String carimg = "";
	String carpaintsub = "";
	String carpaint = "";
	String wheelname = "";
	String wheelimg = "";
	String carimgCnt = "";
	String wheelCnt = "";
	String maincarimg = "";
	
	//이미지 받기 위한 준비2
	MultipartRequest multi = new MultipartRequest(request,directory,imgSize,"UTF-8",new DefaultFileRenamePolicy());
	
	carimgCnt = multi.getParameter("carimgCnt");
	wheelCnt = multi.getParameter("wheelCnt");
	
	ArrayList<String> arcarimgsub = new ArrayList<>();
	ArrayList<String> arcarimg = new ArrayList<>();
	ArrayList<String> arcarpaintsub = new ArrayList<>();
	ArrayList<String> arcarpaint = new ArrayList<>();
	ArrayList<String> arwheelname = new ArrayList<>();
	ArrayList<String> arwheelimg = new ArrayList<>();
	
	//maincarimg
	maincarimg = multi.getFilesystemName("maincarimg");
	
	//carimg
	for(int i=0; i<=Integer.parseInt(carimgCnt); i++){
		carimgsub = multi.getParameter("carimgsub"+i);
		arcarimgsub.add(carimgsub);
		
		carimg = multi.getFilesystemName("carimg"+i);
		arcarimg.add(carimg);
		
		carpaintsub = multi.getParameter("carpaintsub"+i);	
		arcarpaintsub.add(carpaintsub);
		
		carpaint = multi.getFilesystemName("carpaint"+i);
		arcarpaint.add(carpaint);
	}
		
	//wheel
	for(int i=0; i<=Integer.parseInt(wheelCnt); i++){
		wheelname = multi.getParameter("wheelname"+i);
		arwheelname.add(wheelname);
		
		wheelimg = multi.getFilesystemName("wheelimg"+i);
		arwheelimg.add(wheelimg);
	}

	request.setCharacterEncoding("UTF-8");
	
	String cmake = multi.getParameter("cmake");
	String cname = multi.getParameter("cname");
	String price1 = multi.getParameter("price1");
	String price2 = multi.getParameter("price2");
	//옵션 개수 배열 변환 된 값 받아오기
	String optArray = multi.getParameter("optArray");	
	//트림 개수 받기
	String trimCnt = multi.getParameter("trimCnt");	
	//트림이 한 개라면 트림 cnt 0으로 받기
	if(trimCnt == null){
		trimCnt = "0";
	}
	
	//trim
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
	
	//option
	String opt = null;
	String OName = null;
	String OPrice = null;
	String optno = null;
	
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
		
		trim = multi.getParameter("trim"+i);
		artrim.add(trim);
		
		trimPrice = multi.getParameter("trimPrice"+i);
		artrimPrice.add(trimPrice);
		
		pt = multi.getParameter("pt"+i);
		arpt.add(pt);
		
		Tsafe = multi.getParameter("Tsafe"+i);
		arTsafe.add(Tsafe);
		
		safe = multi.getParameter("safe"+i);
		arsafe.add(safe);
		
		ext = multi.getParameter("ext"+i);
		arext.add(ext);
		
		inte = multi.getParameter("inte"+i);
		arinte.add(inte);
		
		seat = multi.getParameter("seat"+i);
		arseat.add(seat);
		
		conve = multi.getParameter("conve"+i);
		arconve.add(conve);
		
		info = multi.getParameter("info"+i);
		arinfo.add(info);
	}
	
	//옵션 개수 배열로 받아 온 것 잘라내기
	String aroptArray[] = optArray.split(",");
	//옵션 n개를 넣기 위한 ArrayList
	ArrayList<String> aropt = new ArrayList<>();
	ArrayList<String> arOName = new ArrayList<>();
	ArrayList<String> arOPrice = new ArrayList<>();
	ArrayList<String> aroptno = new ArrayList<>();
	
	//이름으로 구분해서 옵션 받기
	for(int i=0; i<=Integer.parseInt(trimCnt); i++){
		for(int j=0; j<=Integer.parseInt(aroptArray[i]); j++){
			opt = multi.getParameter("opt"+i+"-"+j);
			aropt.add(opt);
			
			OName = multi.getParameter("OName"+i+"-"+j);
			arOName.add(OName);
			
			OPrice = multi.getParameter("OPrice"+i+"-"+j);
			arOPrice.add(OPrice);

			optno = multi.getParameter("optno"+i+"-"+j);
			aroptno.add(optno);
			
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
		
		String sql = "insert into adminCar(make,cname,price1,price2,image) values(?,?,?,?,?)";
										//make,image,cname,trim,opt,color,price1,price2
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,cmake);
		psmt.setString(2,cname);
		psmt.setString(3,price1);
		psmt.setString(4,price2);
		psmt.setString(5,maincarimg);
		
		result = psmt.executeUpdate();
		
		sql = "insert into Trims(CName,trim,pt,Tsafe,safe,ext,inte,seat,conve,info,TPrice) values(?,?,?,?,?,?,?,?,?,?,?)";
		
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
		
		sql = "insert into opt(CName,OName,opt,OPrice,trim,optno) values(?,?,?,?,?,?)";
		
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
				psmt.setString(6,aroptno.get(j));
			
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
		
		//이미지 정보 db에 넣기
		sql = "insert into color(cname,route,carimgsub,carimg,carpaintsub,carpaint) values(?,?,?,?,?,?)";
		
		psmt = conn.prepareStatement(sql);
		
		for(int i=0; i<=Integer.parseInt(carimgCnt); i++){
			psmt.setString(1,cname);
			psmt.setString(2,directory);
			psmt.setString(3,arcarimgsub.get(i));
			psmt.setString(4,"/"+arcarimg.get(i));
			psmt.setString(5,arcarpaintsub.get(i));
			psmt.setString(6,"/"+arcarpaint.get(i));
			
			result = psmt.executeUpdate();
		}
		
		sql = "insert into wheel(cname,route,wheelname,wheelimg) values(?,?,?,?)";
		
		psmt = conn.prepareStatement(sql);
		
		for(int i=0; i<=Integer.parseInt(wheelCnt); i++){
			psmt.setString(1,cname);
			psmt.setString(2,directory);
			psmt.setString(3,arwheelname.get(i));
			psmt.setString(4,"/"+arwheelimg.get(i));
			
			result = psmt.executeUpdate();
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