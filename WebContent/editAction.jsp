<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="cashbook.CashbookDAO"%>
<%@ page import="cashbook.PlaceDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JKassaboken</title>
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
			|| request.getParameter("place") == null || request.getParameter("belopp").equals("") || request.getParameter("user").equals("")
			|| request.getParameter("datum").equals("") || request.getParameter("place").equals("")) {
		script.println("<script>");
		script.println("alert('Check if you filled everything');");
		script.println("history.back()");
		script.println("</script>");
	}else {
		CashbookDAO cashbookDAO = new CashbookDAO();
		PlaceDAO placeDAO = new PlaceDAO();
		String user = request.getParameter("user");
		if(!(user.equals("Erik") || user.equals("Yoonjoo"))){
			script.println("<script>");
			script.println("alert('Check if you wrote right person, Erik or Yoonjoo.');");
			script.println("history.back()");
			script.println("</script>");
		}
		String datum = request.getParameter("datum");
		int place_id = placeDAO.getIdByPlace(request.getParameter("place"),request.getParameter("category"));
		int belopp = Integer.parseInt(request.getParameter("belopp"));
		int result = cashbookDAO.update(id, user, datum, place_id, belopp);
		if (result == -1) {
			script.println("<script>");
			script.println("alert('Failed');");
			script.println("history.back()");
			script.println("</script>");
		} else {
			script.println("<script>");
			String year = datum.substring(0,4);
			String month = datum.substring(5,7);
			script.println("location.href ='read.jsp?year="+year+"&month="+month+"'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>