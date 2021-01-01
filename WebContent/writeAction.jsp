<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
 
<%@ page import="cashbook.CashbookDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>

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
	String db = "";
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	if(userID == null) {
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
	
	if(request.getParameter("belopp") == null || request.getParameter("datum") == null || request.getParameter("place") == null ||
				request.getParameter("category") == null ||request.getParameter("category").equals("") ||
				request.getParameter("belopp").equals("") || request.getParameter("datum").equals("") || request.getParameter("place").equals("")) {
				script.println("<script>");
				script.println("alert('Check if you filled everything');");
				script.println("history.back()");
				script.println("</script>");
			} else {
				CashbookDAO cashbookDAO = new CashbookDAO(db);		
				
				String datum = request.getParameter("datum");
				String category = request.getParameter("category");
				String place = request.getParameter("place");
				int belopp = Integer.parseInt(request.getParameter("belopp"));
				int result = cashbookDAO.write(userID,datum,category,place,belopp);
				if(result == -1) {		
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
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>