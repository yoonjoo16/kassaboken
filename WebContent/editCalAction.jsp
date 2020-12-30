<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
	if (request.getParameter("belopp") == null || request.getParameter("datum") == null || request.getParameter("user") == null
			|| request.getParameter("category") == null || request.getParameter("belopp").equals("") || request.getParameter("user").equals("")
			|| request.getParameter("datum").equals("") || request.getParameter("category").equals("")) {
		script.println("<script>");
		script.println("alert('Check if you filled everything');");
		script.println("history.back()");
		script.println("</script>");
	}else {
		CalculatorDAO calDAO = new CalculatorDAO();
		String user = request.getParameter("user");
		if(!(user.equals("Erik") || user.equals("Yoonjoo"))){
			script.println("<script>");
			script.println("alert('Check if you wrote right person, Erik or Yoonjoo.');");
			script.println("history.back()");
			script.println("</script>");
		}   	
		String datum = request.getParameter("datum");
		String category = request.getParameter("category");
		String desc = request.getParameter("desc");
		int belopp = Integer.parseInt(request.getParameter("belopp"));
		int result = calDAO.update(id, user, datum, belopp, category, desc);
		if (result == -1) {
			script.println("<script>");
			script.println("alert('Failed');");
			script.println("history.back()");
			script.println("</script>");
		} else {
			script.println("<script>");
			script.println("alert('Done!');");
			script.println("location.href ='calculate.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>