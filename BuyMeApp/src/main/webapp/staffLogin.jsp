<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BuyMe</title>
</head>
<style>
  .required:after {
    content:" *";
    color: red;
  }
</style>
<body style="height: 100vh; width: 100vw; margin: 0px;">
	<%System.out.println("HERE = " + request.getAttribute("errorMessage")); %>	

	<div style="height: 100%; width: 100%; background-image: linear-gradient(to right,#0099ff, #e6f5ff);
 display: flex; justify-content: center;">
	<form method = "post" action = "staffLoginVerification.jsp" style="height: 300px; width: 300px; padding: 8px;
	 background-color: #e6f5ff; margin-top: 10%; border-style: groove; border-color: #b3e0ff">
	 <div style="display: flex;">
	 <h1 style="color: #0099ff; margin-left: 25%">Buy</h1>
	 <h1 style="color: #00cc99">Me</h1>
	 <h1 style="color: #0099ff">!</h1>
	 <h1 style="color: #00cc99">(Staff)</h1>
	 </div>
		<p>
	     <label style="font-weight: 600" class="required">Staff username: </label><br>
	     <input type="text" id="username" name = "username" required
	      placeholder="Please enter username" style="width: 98%"/>
	    </p>
	    <p>
	     <label style="font-weight: 600" class="required">Password: </label><br>
	     <input type="password" id="pwd" name = "pwd" required
	       placeholder="Please enter password" style="width: 98%"/>
	    </p>
	    <div style="text-align: center;">
	    	<input type="submit" id="registerSubmit" value="Sign In" />	&nbsp;
	    
	    </div>

	    <% if (session.getAttribute("errorMessage") == null ) { %>
         <p> </p>
      <% } else { %>
         <p style="color:red"> Invalid Credentials</p>
         <%session.setAttribute("errorMessage", null); %>
      <% } %>
	   
	</form>
</div>
    
</body>
</html>

<%
	//if(response.getAttribute("errorMessage") != null && request.getAttribute("errorMessage").equals("Invalid user or password"))
		//out.println("Hello"+request.getAttribute("errorMessage"));
%>
