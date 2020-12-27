<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
 
<%@ page import="cashbook.CashbookDAO" %>
<%@ page import="cashbook.PlaceDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>

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
	if(session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	if(userID == null) {
		script.println("<script>");
		script.println("alert('Please log in');");
		script.println("location.href='login.jsp");
		script.println("</script>");
	} else {
		if(request.getParameter("belopp") == null) {
				script.println("<script>");
				script.println("alert('Check if you filled everything');");
				script.println("history.back()");
				script.println("</script>");
			} else {
				CashbookDAO cashbookDAO = new CashbookDAO();		
				PlaceDAO placeDAO = new PlaceDAO();
				String datum = request.getParameter("datum");
				int place_id = placeDAO.getIdByPlace(request.getParameter("place"));
				int belopp = Integer.parseInt(request.getParameter("belopp"));
				int result = cashbookDAO.write(userID,datum,place_id,belopp);
				if(result == -1) {		
					script.println("<script>");
					script.println("alert('Failed');");
					script.println("history.back()");
					script.println("</script>");
				} else {
					script.println("<script>");
					script.println("alert('Success');");
					script.println("location.href = 'write.jsp'");
					script.println("</script>");
				} 
			}	
	}
	
%>
</body>
</html>