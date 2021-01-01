<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="cashbook.CashbookDAO"%>
<%@ page import="cashbook.Cashbook"%>
<%@ page import="calculator.CalculatorDAO"%>
<%@ page import="calculator.Calculator"%>
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
	String cashDB = "";
	String calDB = "";
	if(userID.equals("Yoonjoo") || userID.equals("Erik")){
		cashDB = "cashbook";
		calDB = "calculator";
	}else if(userID.equals("guest")){
		cashDB = "cashbook_guest";
		calDB = "calculator_guest";
	}

	CashbookDAO cashbookDAO = new CashbookDAO(cashDB);
	CalculatorDAO calculatorDAO = new CalculatorDAO(calDB);
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
				<li class="nav-item"><a class="nav-link" href="read.jsp">Read</a></li>
				<li class="nav-item active"><a class="nav-link"
					href="calculate.jsp">Calculate</a></li>

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
		<%
		int erikSpent = cashbookDAO.getSum("Erik");
		int erikDebt = calculatorDAO.getSum("Erik", "debt");
		int erikSwish = calculatorDAO.getSum("Erik", "swish");
		int yoonjooSpent = cashbookDAO.getSum("Yoonjoo");
		int yoonjooDebt = calculatorDAO.getSum("Yoonjoo", "debt");
		int yoonjooSwish = calculatorDAO.getSum("Yoonjoo", "swish");

		int total = ((erikSpent + yoonjooSpent) / 2) - yoonjooSpent - yoonjooSwish + yoonjooDebt + erikSwish - erikDebt;
		%>

		<div class="row">
			<div class="col-2">
				<div class="nav flex-column nav-pills" id="v-pills-tab"
					role="tablist" aria-orientation="vertical">
					<a class="nav-link active" id="v-pills-home-tab" data-toggle="pill"
						href="#v-pills-home" role="tab" aria-controls="v-pills-home"
						aria-selected="true">Debt and Swish</a> <a class="nav-link"
						id="v-pills-profile-tab" data-toggle="pill"
						href="#v-pills-profile" role="tab" aria-controls="v-pills-profile"
						aria-selected="false">Chart</a>
				</div>
			</div>
			<div class="col-9">
				<div class="tab-content" id="v-pills-tabContent">
					<!-- ----------------Debt and History-------------------------->
					<div class="tab-pane fade show active" id="v-pills-home"
						role="tabpanel" aria-labelledby="v-pills-home-tab">
						<!-- ----------------alert-------------------------->
						<div class="alert alert-info" role="alert">
							<%
							if (total < 0) {
							%>Erik has to swish
							<%=total * (-1)%>
							kr to Yoonjoo.
							<%
							} else if (total > 0) {
							%>
							Yoonjoo has to swish
							<%=total%>
							kr to Erik.
							<%
							} else {
							%>
							Nothing!
							<%
							}
							%>
						</div>

						<!-- ----------------buttons-------------------------->
						<p>
								<button class="btn btn-outline-primary" type="button"
								data-toggle="collapse" data-target="#history"
								aria-expanded="false" aria-controls="collapseExample">
								History</button>
							<button class="btn btn-outline-primary" type="button"
								data-toggle="collapse" data-target="#summary"
								aria-expanded="true" aria-controls="collapseExample">
								Summary</button>
							<button class="btn btn-outline-primary" type="button"
								data-toggle="collapse" data-target="#swish"
								aria-expanded="false" aria-controls="collapseExample">
								Add</button>
						</p>
							<!------------------swish-------------------------->
						<div class="collapse" id="swish">
							<div class="card card-body">
								<form method="post" action="writeCalAction.jsp">
									<div class="row">
										<div class="form-group col">
											<div class="input-group date" id="datetimepicker1"
												data-target-input="nearest">
												<input type="text" class="form-control datetimepicker-input"
													data-target="#datetimepicker1" name="datum">
												<div class="input-group-append"
													data-target="#datetimepicker1" data-toggle="datetimepicker">
													<div class="input-group-text">
														<i class="fa fa-calendar"></i>
													</div>
												</div>
											</div>
										</div>
										<div class="input-group col-5">
											<select class="form-control form-control-md mb-3"
												id="category" name="category">
												<option selected>Category</option>
												<option value="Swish">Swish</option>
												<option value="Debt">Debt</option>
											</select> 
										</div>
										</div>
										<div class="row">
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
										<div class="input-group mb-3 col">
													<div class="input-group-prepend">
														<span class="input-group-text">Description</span>
													</div>
													<input type="text" class="form-control" name="desc" id="desc">
												</div>
									</div>
									<input type="submit" class="btn btn-primary pull-right"
										value="Add">
								</form>
							</div>

						</div>
						<!------------------history-------------------------->
						<div class="collapse" id="history">
							<table class="table table-hover"
								style="text-align: center; border: 1px solid #dddddd">
								<thead>
									<tr>
										<th
											style="background-clor: #eeeeee; text-align: center; width: 17%">User</th>
										<th
											style="background-clor: #eeeeee; text-align: center; width: 17%">Date</th>
										<th
											style="background-clor: #eeeeee; text-align: center; width: 17%">Amount</th>
										<th
											style="background-clor: #eeeeee; text-align: center; width: 17%">Category</th>
										<th
											style="background-clor: #eeeeee; text-align: center; width: 17%">Description</th>
										<th style="width: 15%"></th>
									</tr>
								</thead>
								<tbody>
									<%
									ArrayList<Calculator> list = calculatorDAO.getList();

									for (int i = 0; i < list.size(); i++) {
									%>
									<tr>
										<td><%=list.get(i).getUserID()%></td>
										<td><%=list.get(i).getDatum()%></td>
										<td><%=list.get(i).getBelopp()%> kr</td>
										<td><%=list.get(i).getCategory()%></td>
										<td>
											<%
											if (list.get(i).getDescription() == null) {
											%> &nbsp; <%
 } else {
 %> <%=list.get(i).getDescription()%> <%
 }
 %>
										</td>
										<td>
											<button type="button" class="btn btn-primary btn-sm"
												data-toggle="modal" data-target="#calModal"
												data-id="<%=list.get(i).getId()%>"
												data-datum="<%=list.get(i).getDatum()%>"
												data-belopp="<%=list.get(i).getBelopp()%>"
												data-user="<%=list.get(i).getUserID()%>"
												data-desc="<%=list.get(i).getDescription()%>"
												data-category="<%=list.get(i).getCategory()%>">Edit</button>

											&nbsp; <a
											href="deleteCalAction.jsp?id=<%=list.get(i).getId()%>"
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

						<div class="modal fade" id="calModal" tabindex="-1"
							aria-labelledby="calModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="calModalLabel">Edit</h5>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<form method="post" action="editCalAction.jsp">
											<div class="row">
												<div class="form-group col">
													<input type="hidden" name="id">
													<div class="input-group date" id="datetimepicker2"
														data-target-input="nearest">
														<input type="text"
															class="form-control datetimepicker-input"
															data-target="#datetimepicker2" name="datum">
														<div class="input-group-append"
															data-target="#datetimepicker2"
															data-toggle="datetimepicker">
															<div class="input-group-text">
																<i class="fa fa-calendar"></i>
															</div>
														</div>
													</div>
												</div>
												<div class="input-group col">
													<select class="form-control form-control-md mb-3"
														id="category-modal" name="category">
														<option value="Swish">Swish</option>
														<option value="Debt">Debt</option>
													</select>
												</div>
											</div>
											<div class="row">
												<div class="input-group col">
													<select class="form-control form-control-md mb-3"
														id="user-modal" name="user">
														<option value="Erik">Erik</option>
														<option value="Yoonjoo">Yoonjoo</option>
													</select>
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
												<div class="input-group mb-3 col">
													<div class="input-group-prepend">
														<span class="input-group-text">Description</span>
													</div>
													<input type="text" class="form-control" name="desc">
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
						<!------------------summary-------------------------->
						<div class="collapse" id="summary">
							<table class="table table-hover"
								style="text-align: center; border: 1px solid #dddddd">
								<thead>
									<tr>
										<th style="background-clor: #eeeeee; text-align: center;">User</th>
										<th style="background-clor: #eeeeee; text-align: center;">Spent</th>
										<th style="background-clor: #eeeeee; text-align: center;">Debt</th>
										<th style="background-clor: #eeeeee; text-align: center;">Swished</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>Erik</td>
										<td><%=erikSpent%> kr</td>
										<td><%=erikDebt%> kr</td>
										<td><%=erikSwish%> kr</td>
									</tr>
									<tr>
										<td>Yoonjoo</td>
										<td><%=yoonjooSpent%> kr</td>
										<td><%=yoonjooDebt%> kr</td>
										<td><%=yoonjooSwish%> kr</td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<!------------------swish ends-------------------------->
					</div>
					<!-- ----------------Chart-------------------------->
					<div class="tab-pane fade" id="v-pills-profile" role="tabpanel"
						aria-labelledby="v-pills-profile-tab">...</div>



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