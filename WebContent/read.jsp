<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="cashbook.CashbookDAO"%>
<%@ page import="cashbook.Cashbook"%>
<%@ page import="java.util.ArrayList"%>

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


		<div class="btn-group btn-group-toggle" data-toggle="buttons"
			id="year">
			<label class="btn btn-primary disabled"> <input type="radio"
				name="options" id="option1" disabled> Year
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="option2"> 2019
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="option3"> 2020
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="option4"> 2021
			</label>
		</div>


		<div class="btn-group btn-group-toggle" data-toggle="buttons"
			id="month">
			<label class="btn btn-primary disabled"> <input type="radio"
				name="options" id="option1" checked> Month
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="1"> 1
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="2"> 2
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="3"> 3
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="4"> 4
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="5"> 5
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="6"> 6
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="7"> 7
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="8"> 8
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="9"> 9
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="10"> 10
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="11"> 11
			</label> <label class="btn btn-secondary"> <input type="radio"
				name="options" id="12"> 12
			</label>
		</div>
		<input class="btn btn-primary" type="submit" value="Load">

		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-clor: #eeeeee; text-align: center;">Date</th>
						<th style="background-clor: #eeeeee; text-align: center;">User</th>
						<th style="background-clor: #eeeeee; text-align: center;">Place</th>
						<th style="background-clor: #eeeeee; text-align: center;">Amount</th>
					</tr>
				</thead>
				<tbody>
					<%
					CashbookDAO cashbookDAO = new CashbookDAO();
					ArrayList<Cashbook> list = cashbookDAO.getList(2020, 12);

					for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getDatum()%></td>
						<td><%=list.get(i).getUserID()%></a></td>
						<td><%=list.get(i).getPlace_id()%></td>
						<td><%=list.get(i).getBelopp()%></td>
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