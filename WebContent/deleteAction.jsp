<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="cashbook.Cashbook"%>
<%@ page import="cashbook.CashbookDAO"%>
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
	String db = "";
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
		db = "cashbook";
	}else if(userID.equals("guest")){
		db = "cashbook_guest";
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
	CashbookDAO cashbookDAO = new CashbookDAO(db);
	String date = cashbookDAO.getDateById(id);
	String year = date.substring(0, 4);
	String month = date.substring(5, 7);

	int result = cashbookDAO.delete(id);
	if (result == -1) {
		script.println("<script>");
		script.println("alert('Failed to delete');");
		script.println("history.back()");
		script.println("</script>");
	} else {
		script.println("<script>");
		script.println("location.href ='read.jsp?year=" + year + "&month=" + month + "'");
		script.println("</script>");
	}
	%>
</body>
</html>