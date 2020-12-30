<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="calculator.Calculator"%>
<%@ page import="calculator.CalculatorDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>

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
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	if (userID == null) {
		script.println("<script>");
		script.println("alert('Please log in');");
		script.println("location.href='login.jsp");
		script.println("</script>");
	} else if (!(userID.equals("Erik") || userID.equals("Yoonjoo"))) {
		script.println("<script>");
		script.println("alert('Guest cannot delete this')");
		script.println("history.back()");
		script.println("</script>");
	}

	int id = 0;
	if (request.getParameter("id") != null) {
		id = Integer.parseInt(request.getParameter("id"));
	}
	if (id == 0) {
		script.println("<script>");
		script.println("alert('Not valid')");
		script.println("location.href='read.jsp'");
		script.println("</script>");
	}
	CalculatorDAO calDAO = new CalculatorDAO();
	
	int result = calDAO.delete(id);
	if (result == -1) {
		script.println("<script>");
		script.println("alert('Failed to delete');");
		script.println("history.back()");
		script.println("</script>");
	} else {
		script.println("<script>");
		script.println("location.href ='calculate.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>