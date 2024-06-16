<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String errorMessage = "";

    if (request.getMethod().equalsIgnoreCase("POST")) {
        boolean isValid = true;

        // Validate username
// asdsad
        if (username != null && !username.matches("^[a-zA-Z]+$")) {
            errorMessage += "Username should not contain numbers.<br>";
            isValid = false;
        }

        // Validate password
        if (password != null && !(password.length() >= 8 && password.matches(".*[A-Z].*") && password.matches(".*[a-z].*"))) {
            errorMessage += "Password must be at least 8 characters long and contain at least one uppercase and one lowercase letter.<br>";
            isValid = false;
        }

        // Validate email
        String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
        Pattern emailPattern = Pattern.compile(emailRegex);
        Matcher emailMatcher = emailPattern.matcher(email);
        if (email != null && !emailMatcher.matches()) {
            errorMessage += "Invalid email format.<br>";
            isValid = false;
        }

        if (isValid) {
            // If valid, redirect to success page or process the data
            // Here, we will just display a success message
            out.println("<p>User successfully submitted!</p>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Submit User</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/styles.css">
</head>
<body>
    <div class="header">
        <h1>Submit User</h1>
        <p>Fill out the form below to submit a new user</p>
    </div>
    <div class="container">
        <div class="content">
            <form action="index.jsp" method="post">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="<%= username != null ? username : "" %>" required>
                
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= email != null ? email : "" %>" required>
                
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                
                <input type="submit" value="Submit">
            </form>
            <% if (!errorMessage.isEmpty()) { %>
                <div class="error-messages">
                    <%= errorMessage %>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
