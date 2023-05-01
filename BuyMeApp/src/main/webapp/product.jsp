<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="javax.mail.PasswordAuthentication" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.internet.AddressException" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Details Page</title>
</head>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th {
  background-color: #96D4D4;
}

td{
	text-align: center;
}
</style>
<body>
	<%
 	DBHelper dbhelper = new DBHelper();
	Connection connection = dbhelper.getConnection();
	Statement stmt = connection.createStatement();
	String productID = request.getParameter("productid");
 	ResultSet rs = stmt.executeQuery("select * from product where productId = " + "'"+productID+"'");
	while(rs.next()){
		out.println("Dimension - " + rs.getString("dimensions")+"</br>");
		out.println("Weight - " + rs.getString("weight") +"</br>");
		out.println("ProductImages - " + rs.getString("productImages") +"</br>"+"</br>");
/* 		out.println(rs.getString("dimensions"));
 */	}
	String auctionId = request.getParameter("auctionid");
	ResultSet rs1 = stmt.executeQuery("select currentMaxBid, incrementPrice, initialPrice from auction where auctionId = " + "'"+auctionId+"'");
	rs1.next();
 	int currentMaxBid = rs1.getInt("currentMaxBid");
 	int increment = rs1.getInt("incrementPrice");
 	int initialPrice = rs1.getInt("initialPrice");
 	rs1 = stmt.executeQuery("select maxBidUserName from auction where auctionId = " + "'"+auctionId+"'");
 	rs1.next();
 	String maxBidUserName = rs1.getString("maxBidUserName");
 	
	rs1 = stmt.executeQuery("select * from bidding where username = " + "'"+session.getAttribute("username")+"'");
	float userMaxLimit = 0;
	rs1.last();
	int count = rs1.getRow();
	rs1.first();
	
	if(count > 0) {
/* 		rs1.next();
 *//* 		System.out.println(rs1.getFloat("upperLimit"));
 */		userMaxLimit = rs1.getFloat("upperLimit");

	}
/*  	out.println(maxBidUserName);
 */
 	int newBid = currentMaxBid;
 	if(newBid == 0) {
 		newBid = initialPrice-increment; // This takes care of increment for the first time bid by any user.
 	}
 	else {
	 	rs1 = stmt.executeQuery("select * from bidding where auctionId = " + "'"+auctionId+"'");
	 	rs1.last();
	 	int row_count = rs1.getRow();
	 	rs1.first();
/* 		int maxLimit = rs1.getInt("maxLimit");
 */
	 	
	 	if(row_count > 1) {
	 		//update currentMax Bid in database table bid based on upper limits.
	 		rs1 = stmt.executeQuery("select * from bidding where auctionId = " + "'"+auctionId+"' order by upperLimit desc limit 1 offset 1");
			rs1.next();
			
	 		newBid = (int)rs1.getFloat("upperLimit");
			if(newBid+increment<=currentMaxBid)	{
				newBid=currentMaxBid;
			}
					
	 	}
		
	/* 	rs1 = stmt.executeQuery("select * from bidding where auctionId = " + "'"+auctionId+"'");
	 	rs1.last();
	 	int number_of_bidders = rs1.getRow();
	 	rs1.first(); */
	 	
	 	/* if(row_count > 0){
	 		int amount = currentMaxBid;
	 		while(amount<maxLimit) {
	 			amount+=increment;
	 		}
	 		newBid = amount;
	 	} */
/* 		newBid = newBid+increment;
 */		 
	 	
 	}

	%>
	<form action="bidInsert.jsp" method="post" style="padding: 8px">
		  <label for="currentbid"><b>Current Bid on this product :</b></label><br>
		  <input type="text" id="currentbid" name="currentbid" disabled value = "<%=currentMaxBid%>"><br><br>
		  <!-- <label for="myBid">Put your bid higher than current bid:</label><br>
		  <input type="text" id="myBid" name="myBid"><br> -->
		  
		   <label ><b>Select Bidding Type:</b></label><br>
		   <input type="radio" onclick="javascript:bidTypeChange(this.id,<%= newBid + increment %>);" name="manualBid" id="manualBid" value=1/>Manual Bid&nbsp;&nbsp;
		   <input type="radio" onclick="javascript:bidTypeChange(this.id, <%= newBid + increment %>);" name="autoBid" id="autoBid" value=0/>Auto Bid<br>
		  
		  <input type="text" id="mybid" name="mybid" hidden value = "<%=newBid + increment%>">		  
		  <div style="padding-left: 25px; padding-top: 8px;">
			  <label for="uplimit" id="upLimitLabel" style="display:none">Enter Upper Limit</label>
			  <input type="text" id="uplimit" name="uplimit" style="display:none"><br>
			  <label for="bidBuyerSide" id="bidBuyerSideLabel" style="display:none">Bid Increment Buyer Side:</label>
			  <input type="number" id="bidBuyerSide" name="bidBuyerSide" style="display:none"><br>
		  </div>
		  <input type="text" id="mybidincrement" name="increment" hidden value = "<%=increment%>">		  
		  <input type="text" id="auctionId" name="auctionId" hidden value = "<%=auctionId%>">
		  <input type="text" id="username" name="username" hidden value = "<%=session.getAttribute("username")%>">
<!-- 		  || (userMaxLimit >= currentMaxBid)
 -->		  
 		  <%if(session.getAttribute("username").equals(maxBidUserName)){ %>
		   <input type="submit" disabled value = "Set New Bid for $<%=newBid + increment%>">
		  <%} else {%>
		  	<input type="submit" value = "Set New Bid  for $<%=newBid + increment%>">
		  <% }%>
		 
	</form>
	
	<%
	DBHelper dbhelper2 = new DBHelper();
	Connection connection2 = dbhelper.getConnection();
	
	String auctionID = request.getParameter("auctionid");
 	
 	
 	try{
 		Statement stmt2 = connection2.createStatement();
		ResultSet rs2 = stmt2.executeQuery("select * from bidding where auctionId = " + "'"+auctionID+"'");
		out.println("<div style='width: 100%;'>");
		out.println("<table id='biddersTable' style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>Bidder</th><th>Bid Price</th><th>Is Winner?</th></tr>");
		while(rs2.next()){
			out.println("<tr><td>"+ rs2.getString("username")+"</td>");
			out.println("<td>"+ rs2.getString("bidPrice")+"</td>");
			
			if(rs2.getString("didWin") == null){
				out.println("<td>No</td>");
			}
			else{
				out.println("<td>"+ rs2.getString("didWin")+"</td>");
			}			
			out.println("</tr>");
		}
		out.println("</table>");
		out.println("</div>");

	}
	catch (Exception e) {
 		out.println(e.getMessage());

	}
		
	%>
</body>
<script type="text/javascript">

function bidTypeChange(id, currentPrice) {
	
	if(id == 'manualBid'){
		document.getElementById('manualBid').checked = true;
		document.getElementById('uplimit').style.display = 'none';
		document.getElementById('upLimitLabel').style.display = 'none';
		document.getElementById('bidBuyerSide').style.display = 'none';
		document.getElementById('bidBuyerSideLabel').style.display = 'none';
		document.getElementById('autoBid').checked = false;
		document.getElementById('uplimit').value = currentPrice;
	}
	else{
		document.getElementById('autoBid').checked = true;
		document.getElementById('uplimit').style.display = 'block';
		document.getElementById('upLimitLabel').style.display = 'block';
		document.getElementById('bidBuyerSide').style.display = 'block';
		document.getElementById('bidBuyerSideLabel').style.display = 'block';
		document.getElementById('manualBid').checked = false;
		document.getElementById('uplimit').value ='';
	}

}
</script>
</html>