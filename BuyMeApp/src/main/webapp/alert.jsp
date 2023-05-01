<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import = "com.dbhelper.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
 	DBHelper dbhelper = new DBHelper();
	Connection connection = dbhelper.getConnection();
	Statement stmt = connection.createStatement();
	String auctionId = request.getParameter("auctionId");
	String username=session.getAttribute("username").toString();
 	ResultSet rs = stmt.executeQuery("select * from enduser where username = " + "'"+username+"'");
	while(rs.next()){
		String emailId = rs.getString("emailId");
	    Statement stmt1 = connection.createStatement();
	    String sql = "INSERT INTO alerts(username, emailId, auctionId) VALUES ('" + username + "','" + emailId + "','" + auctionId + "')";
	    int rows = stmt1.executeUpdate(sql);
 }
	response.sendRedirect("home.jsp");

	%>

</body>
</html>