<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="passwordEncrypter.passwordEncrypter"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page language="java" import="passwordEncrypter.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@page import="EmailNotification.emailNotification"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Homepage</title>
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
#myInput {
  background-image: url('https://www.w3schools.com/css/searchicon.png');
  background-position: 10px 10px;
  background-repeat: no-repeat;
  font-size: 16px;
  padding: 12px 20px 12px 40px;
  border: 1px solid #ddd;
  margin-bottom: 12px;
}

.tab {
  overflow: hidden;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
}

/* Style the buttons inside the tab */
.tab button {
  background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current tablink class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  display: none;
  padding: 6px 12px;
  border: 1px solid #ccc;
  border-top: none;
  height: calc(100vh - 250px);
}

</style>
<body style="height: 100vh; width: 100vw; margin: 0px;">

	<%
		//String sessionUser = (String)session.getAttribute("username");
		//System.out.println(sessionUser);
		response.setHeader("Cache-Control","no-cache");
		response.setHeader("Cache-Control","no-store");
		response.setHeader("Pragma","no-cache");
		response.setDateHeader ("Expires", 0);
		if(session.getAttribute("username")==null){
			System.out.println("Session does not exist, redirecting to login page");
			response.sendRedirect("index.jsp");
		}
	%>
	
	<div style="display: flex; height:45px; background-color: #ededed; justify-content: space-between;">
		<div style="display: flex;">
			<label style="padding: 10px 0 0 10px; color: #0099ff; font-size: 20px;">Buy</label>
			<label style="padding: 10px 0 0 0; color: #00cc99; font-size: 20px;">Me</label>
			<label style="padding: 10px 0 0 0; color: #0099ff; font-size: 20px;">!</label>
		</div>			
		
		
		<form method="post" action="logout.jsp">
		    <input style="margin-top: 10px; margin-right: 10px;" type="submit" value="Logout">
		</form>
	</div>
	<div style="padding: 10px;">
		<h1>Welcome <span style="color: green"><%= session.getAttribute("username") %></span>!</h1>
		<div style="display: flex;">
			<span>Ready to sell a product?</span> &nbsp;
			<a href='seller.jsp'> Click here!</a>
		</div>		
	</div>
	
	<div class="tab">
  <button class="tablinks" onclick="openCity(event, 'myListings')">My Listings</button>
  <button class="tablinks" onclick="openCity(event, 'forSale')">For Sale</button>
  <button class="tablinks" onclick="openCity(event, 'myBids')">My Bids</button>
  <button class="tablinks" onclick="openCity(event, 'FAQ')">FAQ</button>
</div>

<div id="myListings" class="tabcontent">
  <input type="text" id="myInput1" onkeyup="filterTable('myListingsTable', this.value, document.getElementById('mySelect1').value)" placeholder="Search...">
    <select id="mySelect1" onchange="filterTable('myListingsTable', document.getElementById('myInput1').value, this.value)">
      <option value="0">All Columns</option>
      <option value="1">Product Name</option>
      <option value="3">Initial Price</option>
      <option value="4">Product Category</option>
      <option value="5">Auction Status</option>
    </select> &nbsp; &nbsp;
    <label><b>Sort By:</b></label>
    <select onchange="sortTable('myListingsTable', 'myListingsSortBy')" id="myListingsSortBy">
    		<option value="0">Choose Option</option>
	    	<option value="1">Product Name</option>
	      <option value="3">Initial Price</option>
	      <option value="4">Product Category</option>
	      <option value="5">Auction Status</option> 
    </select>
  
  <%
		DBHelper db = new DBHelper();	
		Connection connection = db.getConnection();
		try{
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("Select * from product p join auction a on p.productId = a.productId join category c on c.categoryName = p.categoryName where p.username='"+session.getAttribute("username")+"';");
			out.println("<div style='width: 100%;'>");
			out.println("<table id='myListingsTable'  style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>Product Name</th><th>Product Image</th><th>Initial Price</th><th>Product Category</th><th>Auction Status</th><th>Details</th></tr>");
			while(rs.next()){
			    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			    
			    LocalDateTime nowDateTime = LocalDateTime.now();
/* 			    dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
 */			    
/*  				LocalDateTime nowDate = LocalDateTime.now(); */
 /* 				   System.out.println("GETer" + dtf.format(now));  
 */				/* 
 				System.out.println(rs.getTime("startTime"));
 				System.out.println(rs.getDate("startTime"));
 				System.out.println(); */
/*  				System.out.println(nowTime.toLocalTime());
 */ 				
 				LocalDate currentDate = nowDateTime.toLocalDate();
 				LocalTime currentTime = nowDateTime.toLocalTime();
 				
			    LocalDateTime scheduleDateTime = rs.getTimestamp("startTime").toLocalDateTime();
			    
			    LocalDate scheduleDate = scheduleDateTime.toLocalDate();
 				LocalTime scheduleTime = scheduleDateTime.toLocalTime();
 				
/*  				System.out.println(scheduleDate.compareTo(currentDate));
 				System.out.println(currentTime.compareTo(scheduleTime));
 				 */

/* 			    SimpleDateFormat formatter6=new SimpleDateFormat("yyyy-MMM-dd HH:mm:ss");  

				String scheduleStart = rs.getString("startTime");
				System.out.println("HERE !! "+ formatter6); */
				out.println("<tr><td>"+ rs.getString("productName")+"</td>");
				out.println("<td>"+ rs.getString("productImages")+"</td>");
				out.println("<td>"+ rs.getString("initialPrice")+"</td>");
				out.println("<td>"+ rs.getString("categoryName")+"</td>");
				out.println("<td>"+ rs.getString("auctionStatus")+"</td>");
				
				out.println("<td><a href='product.jsp?auctionid="+rs.getString("auctionId")+"&productid="+ rs.getInt("productId")+"'> Details </td>");

				out.println("</tr>");
			}
			out.println("</table>");
			out.println("</div>");

		}
		catch (Exception e) {
	 		out.println(e.getMessage());

		}
		%>
</div>

<div id="forSale" class="tabcontent">
  <input type="text" id="myInput2" onkeyup="filterTable('forSaleTable', this.value, document.getElementById('mySelect2').value)" placeholder="Search...">
    <select id="mySelect2" onchange="filterTable('forSaleTable', document.getElementById('myInput2').value, this.value)">
      <option value="0">All Columns</option>
      <option value="1">Product Name</option>
      <option value="3">Initial Price</option>
      <option value="4">Product Category</option>
      <option value="5">Auction Status</option>
    </select>
    &nbsp; &nbsp;
    <label><b>Sort By:</b></label>
    <select onchange="sortTable('forSaleTable', 'forSaleSortBy')" id="forSaleSortBy">
    <option value="0">Choose Option</option>
	    <option value="1">Product Name</option>
	      <option value="3">Initial Price</option>
	      <option value="4">Product Category</option>
	      <option value="5">Auction Status</option> 
    </select>
  <%
		DBHelper db1 = new DBHelper();	
		Connection connection1 = db1.getConnection();
		try{
			Statement stmt1 = connection1.createStatement();
			ResultSet rs1 = stmt1.executeQuery("Select * from product p join auction a on p.productId = a.productId join category c on c.categoryName = p.categoryName");
			out.println("<div style='width: 100%;'>");
			out.println("<table id='forSaleTable' style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>Product Name </th> <th>Product Image</th><th>Initial Price</th><th>Product Category</th><th>Auction Status</th><th>Details</th><th>Set Alert</th></tr>");
			
			while(rs1.next()){
			    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
			    
			    LocalDateTime nowDateTime = LocalDateTime.now();				
 				LocalDate currentDate = nowDateTime.toLocalDate();
 				LocalTime currentTime = nowDateTime.toLocalTime();
 				
			    LocalDateTime scheduleDateTime = rs1.getTimestamp("startTime").toLocalDateTime();
			    LocalDate scheduleDate = scheduleDateTime.toLocalDate();
 				LocalTime scheduleTime = scheduleDateTime.toLocalTime();
 				
			    LocalDateTime scheduleEndDateTime = rs1.getTimestamp("endTime").toLocalDateTime();
 				LocalDate scheduleEndDate = scheduleEndDateTime.toLocalDate();
 				LocalTime scheduleEndTime = scheduleEndDateTime.toLocalTime();
/*  				System.out.println(scheduleEndDate.compareTo(currentDate));
 				System.out.println(scheduleEndTime.compareTo(currentTime)); */
 				
				out.println("<tr><td>"+ rs1.getString("productName")+"</td>");
				out.println("<td>"+ rs1.getString("productImages")+"</td>");
				out.println("<td>"+ rs1.getString("initialPrice")+"</td>");
				out.println("<td>"+ rs1.getString("categoryName")+"</td>");
				out.println("<td>"+ rs1.getString("auctionStatus")+"</td>");
				
				if((scheduleDate.compareTo(currentDate)<=0 && scheduleEndDate.compareTo(currentDate)>=0) && (scheduleTime.compareTo(currentTime)<=0 && scheduleEndTime.compareTo(currentTime)==1)){
					//auction start
					out.println("<td><a href='product.jsp?auctionid="+rs1.getString("auctionId")+"&productid="+ rs1.getInt("productId")+"'> Details </td>");
					Statement state=connection1.createStatement();
					ResultSet results=state.executeQuery("select * from alerts where auctionId="+rs1.getInt("auctionId")+";");
					while(results.next()){
						emailNotification.sendEmail(results.getString("emailId"),"Auction is Live NOW","Auction live now:"+rs1.getString("productName"));
					}
					
				}
				else if((scheduleEndDate.compareTo(currentDate) < 0) || (scheduleEndDate.compareTo(currentDate)<=0 && scheduleEndTime.compareTo(currentTime)<=0)) // auction stopped
				{
					int currentMax = rs1.getInt("currentMaxBid");
					float secretMinBid = rs1.getFloat("secretMinimumBid");
					
					if(secretMinBid <= currentMax)
					{
						//Bid won by maxBidUserName
						out.println("<td><a href='product.jsp?auctionid="+rs1.getString("auctionId")+"&productid="+ rs1.getInt("productId")+"'> Bid won by "+rs1.getString("maxBidUserName")+" </td>");
						Statement stmt5 = connection1.createStatement();
						ResultSet rs5 = stmt5.executeQuery("Select * from enduser e where e.username='"+rs1.getString("maxBidUserName")+"'");
						while (rs5.next()){
/* 	 						emailNotification.sendEmail(rs5.getString("emailId"),"Congratulations you won the auction!","You are the winner of the auction,check our website for more details");
 */						}

					}
					else
					{
						out.println("<td> No winner </td>");
					}
				}
				else {
					out.println("<td>Will be live soon</td>");
					out.println("<td><a href='alert.jsp?auctionId="+rs1.getString("auctionId")+"'> Alert Me </td>");



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
</div>



<div id="myBids" class="tabcontent">
  <input type="text" id="myInput3" onkeyup="filterTable('myBidsTable', this.value, document.getElementById('mySelect3').value)" placeholder="Search...">
    <select id="mySelect3" onchange="filterTable('myBidsTable', document.getElementById('myInput3').value, this.value)">
      <option value="0">All Columns</option>
      <option value="1">Product Name</option>
      <option value="3">Auction Status</option>
      <option value="4">Current Max Bid</option>
      <option value="5">Your Bid</option>
      <option value="6">Your Upper Limit</option>
    </select>
&nbsp; &nbsp;
    <label><b>Sort By:</b></label>
    <select onchange="sortTable('myBidsTable', 'myBidsSortBy')" id="myBidsSortBy">
    <option value="0">Choose Option</option>
	    <option value="1">Product Name</option>
	      <option value="3">Initial Price</option>
	      <option value="4">Product Category</option>
	      <option value="5">Auction Status</option> 
    </select>
  <%
		DBHelper db2 = new DBHelper();	
		Connection connection2 = db2.getConnection();
		try{
			Statement stmt2 = connection2.createStatement();
			ResultSet rs2 = stmt2.executeQuery("SELECT p.productId, a.auctionId, p.productImages, p.productName, a.auctionStatus, a.currentMaxBid, b.upperLimit, b.bidPrice FROM bidding b JOIN auction a ON b.auctionId = a.auctionId JOIN product p ON a.productId = p.productId WHERE a.endTime > NOW() AND b.username='"+session.getAttribute("username")+"';");
			out.println("<div style='width: 100%;'>");
			out.println("<table id='myBidsTable' style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>Product Name</th><th>Product Image</th><th>Auction Status</th><th>Current Max Bid</th><th>Your Bid</th></th><th>Your Upper Limit</th></tr>");
			while(rs2.next()){
				out.println("<tr><td>"+ rs2.getString("productName")+"</td>");
				out.println("<td>"+ rs2.getString("productImages")+"</td>");
				out.println("<td>"+ rs2.getString("auctionStatus")+"</td>");
				out.println("<td>"+ rs2.getString("currentMaxBid")+"</td>");
				out.println("<td>"+ rs2.getString("bidPrice")+"</td>");
				out.println("<td>"+ rs2.getString("upperLimit")+"</td>");

				out.println("<td><a href='product.jsp?auctionid="+rs2.getString("auctionId")+"&productid="+ rs2.getInt("productId")+"'> Details </td>");

				out.println("</tr>");
			}
			out.println("</table>");
			out.println("</div>");

		}
		catch (Exception e) {
	 		out.println(e.getMessage());

		}
		%> 
</div>

<div id="FAQ" class="tabcontent">
    
	<input placeholder="Search by keywords ..." id="faqSearchInput" style="width: 100%; margin-top: 10px;" onkeyup="filterFAQs(this.value)">
	
	<div style="width: 100%; margin-top: 10px;">
	 <%
		DBHelper db3 = new DBHelper();	
		Connection connection3 = db3.getConnection();
		try{
			Statement stmt3 = connection3.createStatement();
			ResultSet rs3 = stmt3.executeQuery("SELECT * from faq;");
			out.println("<div style='width: 100%;'>");
			out.println("<table id='faqTable' style='width: calc(100% - 25px); margin-left: 10px; '> <tr><th>Question</th><th>Answer</th></tr>");
			while(rs3.next()){
				out.println("<tr><td>"+ rs3.getString("question")+"</td>");
				out.println("<td>"+ rs3.getString("answer")+"</td>");

				out.println("</tr>");
			}
			out.println("</table>");
			out.println("</div>");

		}
		catch (Exception e) {
	 		out.println(e.getMessage());

		}
		%> 
	</div>
</div>

<script>
function filterTable(tableId, searchText, columnNum) {
	  var table = document.getElementById(tableId);
	  var rows = table.getElementsByTagName("tr");
	  for (var i = 1; i < rows.length; i++) {
	    var cells = rows[i].getElementsByTagName("td");
	    var found = false;
	    if (columnNum == 0) {
	      for (var j = 0; j < cells.length; j++) {
	        if (cells[j].innerHTML.toLowerCase().indexOf(searchText.toLowerCase()) > -1) {
	          found = true;
	          break;
	        }
	      }
	    } else {
	      if (cells[columnNum-1].innerHTML.toLowerCase().indexOf(searchText.toLowerCase()) > -1) {
	        found = true;
	      }
	    }
	    if (found) {
	      rows[i].style.display = "";
	    } else {
	      rows[i].style.display = "none";
	    }
	  }
	}

function filterFAQs( searchText, columnNum) {
	  var table = document.getElementById('faqTable');
	  var rows = table.getElementsByTagName("tr");
	  for (var i = 1; i < rows.length; i++) {
	    var cells = rows[i].getElementsByTagName("td");
	    var found = false;
	  
	      for (var j = 0; j < cells.length; j++) {
	        if (cells[j].innerHTML.toLowerCase().indexOf(searchText.toLowerCase()) > -1) {
	          found = true;
	          break;
	        }
	      }
	    
	    if (found) {
	      rows[i].style.display = "";
	    } else {
	      rows[i].style.display = "none";
	    }
	  }
	}

</script>
		
</body>




<script>
function openCity(evt, cityName) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " active";
  
}

function sortTable(tableId, sortById) {
	  var table, rows, switching, i, x, y, shouldSwitch;
	  table = document.getElementById(tableId);
	  switching = true;
	  var sortByName = document.getElementById(sortById);
	  
	  var sortByColumn = 0;
	 
	  
	  switch(sortByName.value){
	  	case 1:
	  		sortByColumn = 0;
	  	case 3:
	  		sortByColumn = 2;
	  	case 4:
	  		sortByColumn = 3;
	  	case 5:
	  		sortByColumn = 4;
		  
	  }
	  /*Make a loop that will continue until
	  no switching has been done:*/
	  while (switching) {
	    //start by saying: no switching is done:
	    switching = false;
	    rows = table.rows;
	    /*Loop through all table rows (except the
	    first, which contains table headers):*/
	    for (i = 1; i < (rows.length - 1); i++) {
	      //start by saying there should be no switching:
	      shouldSwitch = false;
	      /*Get the two elements you want to compare,
	      one from current row and one from the next:*/
	      x = rows[i].getElementsByTagName("TD")[sortByColumn];
	      y = rows[i + 1].getElementsByTagName("TD")[sortByColumn];
	      //check if the two rows should switch place:
	      if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
	        //if so, mark as a switch and break the loop:
	        shouldSwitch = true;
	        break;
	      }
	    }
	    if (shouldSwitch) {
	      /*If a switch has been marked, make the switch
	      and mark that a switch has been done:*/
	      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
	      switching = true;
	    }
	  }
	}

</script>
</html>