<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
</head>
<body style="height: 100vh; width: 100vw; margin: 0px;">

    <!-- // Take input of First name, last name, username, address, phone no and date of birth
    // Redirect to login page -->
    <div style="height: 100%; width: 100%; background-image: linear-gradient(to right,#0099ff, #e6f5ff);
    display: flex; justify-content: center;">
        <form method="post" action="signupcontroller.jsp" style="height: 400px; width: 300px; padding: 10px;
        background-color: #e6f5ff; margin-top: 10%; border-style: groove; border-color: #b3e0ff">
            <label for="fname">First Name:</label><br>
            <input type="text" id="fname" name="fname" required><br>
            <label for="lname">Last Name:</label><br>
            <input type="text" id="lname" name="lname" required><br>
            <label for="username">Username:</label><br>
            <input type="text" id="username" name="username" required><br>
            <label for="address">Address:</label><br>
            <input type="text" id="address" name="address" required><br>
            <label for="phone">Phone Number:</label><br>
            <input type="text" id="phone" name="phone" required><br>
            <label for="dob">Date of Birth:</label><br>
            <input type="date" id="dob" name="dob" required><br>
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" required><br>
            <label for="pwd">Password:</label><br>
            <input type="password" id="pwd" name="pwd" required><br>
            <label for="cpwd">Confirm Password:</label><br>
            <input type="password" id="cpwd" name="cpwd" required><br>
            <br>
            <label for="cpwd">Secret Key:</label><br>
            <input type="password" id="sid" name="sid"><br>
            <input type="submit" value="Submit">
        </form>
    </div>
	
</body>
</html>