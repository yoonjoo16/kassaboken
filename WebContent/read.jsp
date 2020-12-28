<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="cashbook.CashbookDAO"%>
<%@ page import="cashbook.Cashbook"%>
<%@ page import="cashbook.PlaceDAO"%>
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
	if(userID == null || !(userID.equals("Yoonjoo") || userID.equals("Erik") || userID.equals("guest"))) {
		%>
		<script>
		location.href = 'login.jsp';
		</script>
		<%
	}
	%>
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
				<li class="nav-item active"><a class="nav-link" href="main.jsp">Home
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="read.jsp">Read</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Calculate</a></li>

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
		<div class="row justify-content-md-center">
			<form method="post" action="read.jsp">
				<div class="btn-group btn-group-toggle" data-toggle="buttons"
					id="years">
					<label class="btn btn-primary disabled"> <input
						type="radio" name="year" value="0000" disabled> Year
					</label> <label class="btn btn-secondary"> <input type="radio"
						name="year" value="2019"> 2019
					</label> <label class="btn btn-secondary"> <input type="radio"
						name="year" value="2020" checked> 2020
					</label> <label class="btn btn-secondary"> <input type="radio"
						name="year" value="2021"> 2021
					</label>
				</div>


				<div class="btn-group btn-group-toggle" data-toggle="buttons"
					id="months">
					<label class="btn btn-primary disabled"> <input
						type="radio" name="month" id="option1" disabled> Month
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
		<div class="row justify-content-between">
			<div class="col-auto mr-auto">
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
								onchange="categoryChange(this)">
								<option selected>Category</option>
								<option value="supermarket" name="supermarket">Supermarket</option>
								<option value="restaurant" name="restaurant">Restaurant</option>
								<option value="alcohol" name="alcohol">Alcohol</option>
								<option value="apotek" name="apotek">Apotek</option>
								<option value="hobby" name="hobby">Hobby</option>
								<option value="travel" name="travel">Travel</option>
							</select> <select class="form-control form-control-md mb-3" id="place"
								name="place">
								<option></option>
							</select>
						</div>

						<div class="input-group mb-3 col ">
							<div class="input-group-prepend">
								<span class="input-group-text">SEK</span>
							</div>
							<input type="text" class="form-control"
								aria-label="Amount" name="belopp">
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
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
	<script type="text/javascript">
		$('#datetimepicker1').datetimepicker({
			format : 'YYYY-MM-DD',
			defalutDate : new Date()
		});
	</script>

	<script>
		function categoryChange(e) {
			switch (e.value) {
			case "supermarket":
				var d = [ "ICA", "Lidl", "Coop", "Handlarn", "Lokchan", "Etc" ];
				break;
			case "alcohol":
				var d = [ "Systembolaget", "Pub", "Etc" ];
				break;
			case "restaurant":
				var d = [ "Hamburger", "Pizza", "Asian food", "Kebab/falafel",
						"Swedish food", "Etc" ];
				break;
			case "apotek":
				var d = [ "Apotea", "Etc" ];
				break;
			case "hobby":
				var d = [ "Bowling", "Etc" ];
				break;
			case "travel":
				var d = [ "Skånetrafiken", "SJ", "Flight ticket", "Ferry",
						"Etc" ];
				break;
			}
			var target = document.getElementById("place");
			target.options.length = 0;

			for (x in d) {
				var opt = document.createElement("option");
				opt.value = d[x];
				opt.name = d[x];
				opt.innerHTML = d[x];
				target.appendChild(opt);
			}
		}
	</script>

</body>
</html>