<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; color: #333; margin: 50px; }
        .container { background-color: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h1 { color: #d33; }
        p { margin-bottom: 10px; }
        a { color: #007bff; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="container">
    <h1>Error Occurred!</h1>
    <p><strong>Status Code:</strong> <%= request.getAttribute("javax.servlet.error.status_code") %></p>
    <p><strong>Message:</strong> <%= request.getAttribute("javax.servlet.error.message") %></p>
    <p><strong>Error Type:</strong> <%= request.getAttribute("javax.servlet.error.exception_type") %></p>
    <p>Please try again or contact support if the problem persists.</p>
    <p><a href="${pageContext.request.contextPath}/">Go to Home Page</a></p>
</div>
</body>
</html>

