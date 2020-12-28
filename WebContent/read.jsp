<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="cashbook.CashbookDAO"%>
<%@ page import="cashbook.Cashbook"%>
<%@ page import="cashbook.PlaceDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.time.YearMonth" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Kassaboken</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="#">Kassaboken</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="main.jsp">Home
						<span class="sr-only">(current)</span>
				</a></li>
				<%
				if (userID.equals("guest")) {
				%>
				<li class="nav-item"><a class="nav-link" href="read.jsp">Read</a></li>
				<%
				} else if (userID.equals("Erik") || userID.equals("Yoonjoo")) {
				%>
				<li class="nav-item"><a class="nav-link" href="write.jsp">Write</a></li>
				<li class="nav-item"><a class="nav-link" href="read.jsp">Read</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Calculate</a></li>
				<%
				}
				%>
			</ul>
		</div>
	</nav>

	<div class="container">
		<div class="row justify-content-md-center">
		<form method="post" action="read.jsp">
			<div class="btn-group btn-group-toggle" data-toggle="buttons"
				id="years">
				<label class="btn btn-primary disabled"> <input type="radio"
					name="year" value="0000" disabled> Year
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="year" value="2019" > 2019
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="year" value="2020" checked> 2020
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="year" value="2021"> 2021
				</label>
			</div>


			<div class="btn-group btn-group-toggle" data-toggle="buttons"
				id="months">
				<label class="btn btn-primary disabled"> <input type="radio"
					name="month" id="option1" disabled> Month
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="1">1
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="2">2
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="3">3
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="4">4
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="5">5
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="6">6
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="7">7
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="8">8
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="9">9
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="10">10
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="11">11
				</label> <label class="btn btn-secondary"> <input type="radio"
					name="month" value="12" checked>12
				</label>
			</div>
			<input class="btn btn-primary" type="submit" value="Load">
		</form>
		</div>
		<br>
		<div class="row justify-content-md-center">
			<%
			CashbookDAO cashbookDAO = new CashbookDAO();
			PlaceDAO placeDAO = new PlaceDAO();
			int year = YearMonth.now().getYear();
			int month = YearMonth.now().getMonthValue();
			if (request.getParameter("year") != null && request.getParameter("month") != null) {
				year = Integer.parseInt(request.getParameter("year").trim());
				month = Integer.parseInt(request.getParameter("month").trim());
			}
			%>
			<div class="alert alert-info" role="alert">
				<%=year%> - <%=month%> 
			</div>
		</div>
		<div class="row justify-content-md-center">
			<table class="table table-striped "
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-clor: #eeeeee; text-align: center;">Date</th>
						<th style="background-clor: #eeeeee; text-align: center;">User</th>
						<th style="background-clor: #eeeeee; text-align: center;">Amount</th>
						<th style="background-clor: #eeeeee; text-align: center;">Place</th>
						<th style="background-clor: #eeeeee; text-align: center;">Category</th>
					</tr>
				</thead>
				<tbody>
					<%
					ArrayList<Cashbook> list = cashbookDAO.getList(year, month);

					for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getDatum()%></td>
						<td><%=list.get(i).getUserID()%></td>
						<td><%=list.get(i).getAmount()%> kr</td>
						<td><%=placeDAO.getPlaceByID(list.get(i).getPlace_id())%></td>
						<td><%=placeDAO.getCategoryByID(list.get(i).getPlace_id())%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>