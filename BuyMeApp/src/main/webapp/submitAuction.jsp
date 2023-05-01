<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page language="java"  import="java.time.format.DateTimeFormatter.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Submit </title>
</head>
<body>
	<div style="height: 35px; background-color: #ededed; text-align: center; padding-top: 10px;">
		<a href="home.jsp" style="float:'left';display: inline-block; width: 30px; height: 30px; margin-right: 10px; text-align: center; line-height: 30px; background-color: #ccc; color: #fff; text-decoration: none;"><span style="font-size: 1.5em;">&#8962;</span></a>
		<label style="font-weight: 600; color: #0099ff; font-size: 18px">Earn money!</label>
		<label style="font-weight: 600; color: #00cc99; font-size: 18px">Sell your product by filling the form below.. </label>
		</div>
	<%
	
 	DBHelper dbhelper = new DBHelper();
	Connection connection = dbhelper.getConnection();
	try{
		Statement stmt = connection.createStatement();
		String username = request.getParameter("username");
		String productName = request.getParameter("productName");
		String category = request.getParameter("category");
		float initialPrice = Float.parseFloat(request.getParameter("startingPrice"));
		float secretMinimumBid = Float.parseFloat(request.getParameter("secretPrice"));
		float incrementPrice = Float.parseFloat(request.getParameter("minIncrement"));
		String startTime = request.getParameter("auctionStartTime");
		String endTime = request.getParameter("auctionEndTime");
		
		PreparedStatement ps1=connection.prepareStatement("INSERT INTO product(productName, username, categoryName) VALUES (?,?,?)",Statement.RETURN_GENERATED_KEYS);
		ps1.setString(1,productName);
		ps1.setString(2,username);
		ps1.setString(3, category);
		
		int rowsAffected=ps1.executeUpdate();
		if(rowsAffected>0){
			out.println("New product added successfully!");
			ResultSet rs=ps1.getGeneratedKeys();
			int generatedProductId=0;
			if(rs.next()){
				generatedProductId = rs.getInt(1);
			}

			PreparedStatement ps2=connection.prepareStatement("INSERT INTO auction(productId, username, initialPrice, secretMinimumBid, incrementPrice, startTime, endTime) VALUES(?,?,?,?,?,?,?)");
			ps2.setInt(1, generatedProductId);
			ps2.setString(2, username);
			ps2.setFloat(3, initialPrice);
			ps2.setFloat(4,secretMinimumBid);
			ps2.setFloat(5, incrementPrice);
			ps2.setString(6, startTime);
			ps2.setString(7, endTime);
			int rowsAffected2=ps2.executeUpdate();
			if(rowsAffected2>0){
				out.println("Auction Created Successfully!");
			}
			else{
				out.println("Auction could not be created!");
			}
			
		}
		else{
			out.println("Product could not be added!");
		}
	

	}catch(Exception e){
 		out.println(e.getMessage());
 	}
	%>
</body>
</html>