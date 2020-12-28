<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
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
				<%
				if (userID != null &&(userID.equals("Yoonjoo") || userID.equals("Erik") || userID.equals("guest"))) {
				%>

				<li class="nav-item dropdown"><a href="#"
					class="nav-link dropdown-toggle" data-toggle="dropdown"
					role="button" aria-haspopup="true" aria-expanded="false"> <%=userID%>
						<span class="caret"></span></a>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="logoutAction.jsp">Log out</a>
					</div></li>

				<%
			} else {
			%>
				<li class="nav-item"><a class="nav-link" href="login.jsp">Log
						in</a></li>
				<%
		}
		%>
			</ul>
		</div>
	</nav>

	<div class="container">
		<div class="jumbotron">
			<%
			if (userID == null) {
			%>
			<h1 class="display-4">Hello!</h1>
			<p class="lead">This is a cashbook for Yoonjoo and Erik.</p>
			<hr class="my-4">
			<p>If you are curious how it works, please log in and browse it.</p>
			<a class="btn btn-primary btn-lg" href="login.jsp" role="button">Log
				in</a>
			<%
			} else if (userID.equals("guest")) {
			%>
			<h1 class="display-4">Hello guest!</h1>
			<p class="lead">This is a cashbook for Yoonjoo and Erik.</p>
			<hr class="my-4">
			<p>Because you are logged in as a guest, the data will be loaded
				from a mock database.</p>
			<p>If you are Erik or Yoonjoo, please log out and log in again.</p>
			<a class="btn btn-primary btn-lg" href="read.jsp" role="button">Browse
				cashbook</a>
			<%
			} else if (userID.equals("Yoonjoo") || userID.equals("Erik")) {
			%>
			<h1 class="display-4">
				Hello,
				<%=userID%>!
			</h1>
			<p class="lead">This is a cashbook for you.</p>
			<hr class="my-4">
			<p>Don't forget to calculate your debt and pay!</p>
			<a class="btn btn-primary btn-lg" href="read.jsp" role="button">Start
				cashbook</a>
			<%
			} else {
			%>
			<h1 class="display-4">Hello!</h1>
			<p class="lead">This is a cashbook for Yoonjoo and Erik.</p>
			<hr class="my-4">
			<p>If you are curious how it works, please log in and browse it.</p>
			<a class="btn btn-primary btn-lg" href="login.jsp" role="button">Log
				in</a>
			<%
			}
			%>

		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>