<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setPropertyname="user" property="userID" />
<jsp:setPropertyname="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kassaboken</title>
</head>
<body>
	<%	
	String userID = null;
	PrintWriter script = response.getWriter();
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null) {
		script.println("<script>");
		script.println("alert('You're already logging in');");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPassword());	
	if(result == 1) {
		session.setAttribute("userID", user.getUserID());
		script.println("<script>");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}else if(result == 0) {
		script.println("<script>");
		script.println("alert('Wrong password. Check it again.');");
		script.println("history.back()");
		script.println("</script>");
	}else if(result == -1) {
		script.println("<script>");
		script.println("alert('Not found. Check your ID again.');");
		script.println("history.back()");
		script.println("</script>");
	}else if(result == -2) {
		script.println("<script>");
		script.println("alert('Database error');");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>