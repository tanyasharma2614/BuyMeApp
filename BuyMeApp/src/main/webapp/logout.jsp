<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logged out</title>
</head>
<body>
	<%
		session.removeAttribute("username");
		session.invalidate();
		out.println("Logged out successfully!");
		response.sendRedirect("index.jsp");
	%>

</body>
</html>