<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="cashbook.CashbookDAO"%>
<%@ page import="cashbook.Cashbook"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.time.YearMonth"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<link rel="stylesheet"
	href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />
<title>Kassaboken</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null || !(userID.equals("Yoonjoo") || userID.equals("Erik") || userID.equals("guest"))) {
	%>
	<script>
		location.href = 'login.jsp';
	</script>
	<%
	}
	%>

	<%
	CashbookDAO cashbookDAO = new CashbookDAO();
	int year = YearMonth.now().getYear();
	int month = YearMonth.now().getMonthValue();
	if (request.getParameter("year") != null && request.getParameter("month") != null) {
		year = Integer.parseInt(request.getParameter("year").trim());
		month = Integer.parseInt(request.getParameter("month").trim());
	}
	%>
	<!-------------------- Nav bar ---------------------------------->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="main.jsp">Kassaboken</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="main.jsp">Home
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item active"><a class="nav-link" href="read.jsp">Read</a></li>
				<li class="nav-item"><a class="nav-link" href="calculate.jsp">Calculate</a></li>

				<ul class="nav navbar-pills navbar-right">
					<li class="nav-item dropdown"><a href="#"
						class="nav-link dropdown-toggle" data-toggle="dropdown"
						role="button" aria-haspopup="true" aria-expanded="false"> <%=userID%>
							<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<a class="dropdown-item" href="logoutAction.jsp">Log out</a></li>

				</ul>

			</ul>
		</div>
	</nav>

	<div class="container">

		<!-------------------- load ---------------------------------->
		<div class="row justify-content-md-center">
			<form method="post" action="read.jsp">
				<div class="btn-group btn-group-toggle" data-toggle="buttons"
					id="years">
					<label class="btn btn-primary disabled"> <input
						type="radio" name="year" value="0000" disabled> Year
					</label> 
					<%for(int i = 2019; i < 2022; i++){
						%>
						<label class="btn btn-secondary">
						<%if(year == i) { %>
						<input type="radio" name="year" value="<%=i%>" checked>
						<%
						}else{ 
						%>
						<input type="radio" name="year" value="<%=i%>">
						<% }%>
						<%=i%>
						</label>						
					<% }%>
				</div>


				<div class="btn-group btn-group-toggle" data-toggle="buttons"
					id="months" >
					<label class="btn btn-primary disabled"> <input
						type="radio" name="month" id="option1" disabled> Month
					</label> 
					<%for(int i = 1; i < 13; i++){
						%>
						<label class="btn btn-secondary">
						<%if(month == i) { %>
						<input type="radio" name="month" value="<%=i%>" checked>
						<%
						}else{ 
						%>
						<input type="radio" name="month" value="<%=i%>">
						<% }%>
						<%=i%>
						</label>						
					<% }%>
				</div>
				<input class="btn btn-primary" type="submit" value="Load">
			</form>
		</div>
		<br>

		<div class="row justify-content-between">
			<div class="col-auto mr-auto">

				<div class="alert alert-info" role="alert">
					<%=year%>
					-
					<%=month%>
				</div>
			</div>
			<div class="col-auto">
				<button class="btn btn-danger" type="button" data-toggle="collapse"
					data-target="#collapseExample" aria-expanded="false"
					aria-controls="collapseExample">Add</button>
			</div>
		</div>

		<!-------------------- Add ---------------------------------->
		<div class="collapse" id="collapseExample">
			<div class="card card-body">
				<form method="post" action="writeAction.jsp">
					<div class="row">
						<div class="form-group col">
							<div class="input-group date" id="datetimepicker1"
								data-target-input="nearest">
								<input type="text" class="form-control datetimepicker-input"
									data-target="#datetimepicker1" name="datum">
								<div class="input-group-append" data-target="#datetimepicker1"
									data-toggle="datetimepicker">
									<div class="input-group-text">
										<i class="fa fa-calendar"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="input-group col-5">
							<select class="form-control form-control-md mb-3" id="category"
								name="category" onchange="categoryChange(this.value)">
								<option selected>Category</option>
								<option value="Supermarket" name="supermarket">Supermarket</option>
								<option value="Restaurant" name="restaurant">Restaurant</option>
								<option value="Alcohol" name="alcohol">Alcohol</option>
								<option value="Apotek" name="apotek">Apotek</option>
								<option value="Hobby" name="hobby">Hobby</option>
								<option value="Travel" name="travel">Travel</option>
							</select> <select class="form-control form-control-md mb-3" id="place"
								name="place">
								<option></option>
							</select>
						</div>
						<div class="input-group mb-3 col ">
							<div class="input-group-prepend">
								<span class="input-group-text">SEK</span>
							</div>
							<input type="text" class="form-control" aria-label="Amount"
								name="belopp">
							<div class="input-group-append">
								<span class="input-group-text">.00</span>
							</div>
						</div>
					</div>
					<input type="submit" class="btn btn-primary pull-right"
						value="Write">
				</form>
			</div>
		</div>
		<br>

		<!-------------------- table---------------------------------->
		<div class="row justify-content-md-center">
			<table class="table table-hover"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th
							style="background-clor: #eeeeee; text-align: center; width: 17%">Date</th>
						<th
							style="background-clor: #eeeeee; text-align: center; width: 17%">User</th>
						<th
							style="background-clor: #eeeeee; text-align: center; width: 17%">Amount</th>
						<th
							style="background-clor: #eeeeee; text-align: center; width: 17%">Place</th>
						<th
							style="background-clor: #eeeeee; text-align: center; width: 17%">Category</th>
						<th style="width: 15%"></th>
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
						<td><%=list.get(i).getPlace()%></td>
						<td><%=list.get(i).getCategory()%></td>
						<td>
							<button type="button" class="btn btn-primary btn-sm"
								data-toggle="modal" data-target="#exampleModal"
								data-id="<%=list.get(i).getId()%>"
								data-datum="<%=list.get(i).getDatum()%>"
								data-amount="<%=list.get(i).getAmount()%>"
								data-user="<%=list.get(i).getUserID()%>"
								data-place="<%=list.get(i).getPlace()%>"
								data-category="<%=list.get(i).getCategory() %>">Edit</button>

							&nbsp; <a href="deleteAction.jsp?id=<%=list.get(i).getId()%>"
							onclick="return confirm('Do you want to delete it?')"><svg
									xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-trash-fill"
									viewBox="0 0 16 16">
									<path
										d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1H2.5zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5zM8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5zm3 .5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 1 0z" /></svg>
						</a>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>

		<!---------------------- Modal --------------------------------->

		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Edit</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form method="post" action="editAction.jsp">
							<div class="row">
								<div class="form-group col">
									<input type="hidden" name="id">
									<div class="input-group date" id="datetimepicker2"
										data-target-input="nearest">
										<input type="text" class="form-control datetimepicker-input"
											data-target="#datetimepicker2" name="datum">
										<div class="input-group-append" data-target="#datetimepicker2"
											data-toggle="datetimepicker">
											<div class="input-group-text">
												<i class="fa fa-calendar"></i>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="input-group mb-3 col">
									<div class="input-group-prepend">
										<span class="input-group-text">User</span>
									</div>
									<input type="text" class="form-control" name="user">
								</div>
								<div class="input-group mb-3 col">
									<div class="input-group-prepend">
										<span class="input-group-text">SEK</span>
									</div>
									<input type="text" class="form-control" aria-label="Amount"
										name="belopp">
									<div class="input-group-append">
										<span class="input-group-text">.00</span>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="input-group col">
									<select class="form-control form-control-md mb-3"
										id="category-modal" onchange="categoryChange(this.value)"
										name="category">
										<option selected>Category</option>
										<option value="Supermarket">Supermarket</option>
										<option value="Restaurant">Restaurant</option>
										<option value="Alcohol">Alcohol</option>
										<option value="Apotek">Apotek</option>
										<option value="Hobby">Hobby</option>
										<option value="Travel">Travel</option>
									</select> <select class="form-control form-control-md mb-3"
										id="place-modal" name="place">
										<option></option>
									</select>
								</div>
							</div>

							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<input type="submit" class="btn btn-primary pull-right"
								value="Edit">
						</form>
					</div>
				</div>
			</div>
		</div>

	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
	<script src=js/script.js></script>

</body>
</html>