<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="com.BidSystem" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert Bid Info</title>
</head>
<body>
	<%
	
 	DBHelper dbhelper = new DBHelper();
	Connection connection = dbhelper.getConnection();
	try{
		Statement stmt = connection.createStatement();
		String auctionId = request.getParameter("auctionId");
		String username = request.getParameter("username");
		String mybid = request.getParameter("mybid");
		String upperLimit = request.getParameter("uplimit");
		String bidIncBuyerSide = request.getParameter("bidBuyerSide");
		int increment = Integer.parseInt(request.getParameter("increment"));
		ResultSet rs = stmt.executeQuery("select * from bidding where username = " + "'"+username+"' and"+" auctionId = '"+auctionId+"'" );
		
		rs.last();
		int no_records = rs.getRow();
		rs.first();
		
		rs = stmt.executeQuery("select currentMaxBid from auction where auctionId = '"+auctionId+"'");
		rs.next();
		
		int currentMaxBid = rs.getInt("currentMaxBid");
/* 		out.println(currentMaxBid);
 */		if(no_records > 0)
		{
			PreparedStatement ps1 = connection.prepareStatement("update bidding set bidPrice=?, upperLimit=?, bidIncrement=? where username = ?");
			ps1.setString(1, mybid);
			ps1.setString(2, upperLimit);
			ps1.setString(3, bidIncBuyerSide);
			ps1.setString(4, username);
			ps1.executeUpdate();

		}
		else
		{
			int rs1 = stmt.executeUpdate("insert into bidding(auctionId, username, bidPrice, upperLimit, bidIncrement) values("+"'"+auctionId+"',"+"'"+username+"',"+"'"+mybid+"', '"+upperLimit+"','"+bidIncBuyerSide+"')");
		}
 
 		//auto bidding logic for current max -----
 		/* rs =stmt.executeQuery("select * from bidding where auctionId = '"+auctionId+"' where upperLimit '" + upperLimit +"'");
 		rs.last();
 		no_records = rs.getRow();
 		rs.first();
		if(no_records > 0){
			
		}
		else */
 /* 		response.sendRedirect("home.jsp");
 */
 		ResultSet rs1 = stmt.executeQuery("select * from bidding where auctionId = " + "'"+auctionId+"'");
		rs1.last();
		int row_count = rs1.getRow();
		rs1.first();
	/* 		int maxLimit = rs1.getInt("maxLimit");
	*/			
		if(row_count > 1) {
			//update currentMax Bid in database table bid based on upper limits.

/* 			rs1.next();
			
			
			float newBid = (int)rs1.getFloat("upperLimit");	 */	
			
			
			//second highest;
			rs1 = stmt.executeQuery("select * from bidding where auctionId = " + "'"+auctionId+"' order by upperLimit desc limit 2 offset 0");
			rs1.next();
			int highestAmount = (int)rs1.getFloat("upperLimit");
			rs1.next();
			int secondHighestAmount = (int)rs1.getFloat("upperLimit");
			
			
			int bidamt = Integer.parseInt(mybid);
			System.out.println("Mybid = "+bidamt);
			System.out.println("currentMaxBid = "+currentMaxBid);
			System.out.println("secondHighestAmount = "+secondHighestAmount);

			if(secondHighestAmount + increment <= currentMaxBid) {
		 		stmt.executeUpdate("update auction set currentMaxBid = '"+mybid+"', maxBidUserName = '"+ username +"' where auctionId = '" + auctionId +"'");
			}
		 	else {
				bidamt = Math.min(highestAmount, secondHighestAmount + increment);
				if(bidamt <= currentMaxBid) {
					bidamt = Integer.parseInt(mybid);
				}
		 	}
			
			//find name of highest bidder;
			rs1 = stmt.executeQuery("select * from bidding where auctionId = " + "'"+auctionId+"' order by upperLimit desc limit 1 offset 0");
			rs1.next();
			System.out.println(rs1.getString("username"));			
			
	 		stmt.executeUpdate("update auction set currentMaxBid = '"+ bidamt +"', maxBidUserName = '"+ rs1.getString("username") +"' where auctionId = '" + auctionId +"'");

		}
		else{
	 		stmt.executeUpdate("update auction set currentMaxBid = '"+mybid+"', maxBidUserName = '"+ username +"' where auctionId = '" + auctionId +"'");
		}
	
 		BidSystem bs=new BidSystem();
 		bs.AutoBid(username, auctionId);
	}catch(Exception e){
 		out.println(e.getMessage());
 	}
	%>
</body>
</html>