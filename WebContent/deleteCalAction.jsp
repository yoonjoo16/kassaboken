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
	String calDB = "";
	PrintWriter script = response.getWriter();
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		script.println("<script>");
		script.println("alert('Please log in');");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	} 
	
	if(userID.equals("Yoonjoo") || userID.equals("Erik")){
		calDB = "calculator";
	}else if(userID.equals("guest")){
		calDB = "calculator_guest";
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
	CalculatorDAO calDAO = new CalculatorDAO(calDB);

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