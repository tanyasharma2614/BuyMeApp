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
<%@ page import="java.util.Properties" %>
<%@page import="EmailNotification.emailNotification"%>

<%
/* 	DBHelper dbhelper = new DBHelper();
 */
 	String username = request.getParameter("username");
	String password	= request.getParameter("pwd");
	if(username == null || password == null)
	{	
		//request.setAttribute("errorMessage", null);

		response.sendRedirect("index.jsp");

	}
 	DBHelper dbhelper = new DBHelper();
	Connection connection = dbhelper.getConnection();
	String firstName = "";
 	
 	try{
		Statement stmt = connection.createStatement();
		ResultSet rs = stmt.executeQuery("select * from enduser where username = " + "'"+username+"'"+" and password = "+ "'"+ passwordEncrypter.encrypt(password) +"'");
	
		System.out.println(rs.first());
	 	if(rs.first()) {
	 		firstName = rs.getString("firstName");
			session.setAttribute("username",username);
			//String sessionUser = (String)session.getAttribute("username");
			//out.println("Login Success, hello " + sessionUser);
			session.setAttribute("errorMessage", null);
			
			
/* 			emailNotification.sendEmail("tanyasharma2614@gmail.com","hi","hello");
 */			
 			response.sendRedirect("home.jsp");
 		}
		else
		{
			session.setAttribute("errorMessage", "Invalid username or password");
	        //response.sendRedirect("index.jsp");
			//request.getRequestDispatcher("index.jsp").forward(request, response);
			response.sendRedirect("index.jsp");
			//request.setAttribute("errorMessage", null);
			//response.sendRedirect("index.jsp");
		}
 	}catch(Exception e){
 		out.println(e.getMessage());
 	}
	dbhelper.closeConnection(connection);
%>

