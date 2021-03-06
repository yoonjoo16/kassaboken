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
				<li class="nav-item"><a class="nav-link" href="main.jsp">Home
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="read.jsp">Read</a></li>
				<li class="nav-item"><a class="nav-link" href="calculate.jsp">Calculate</a>
				</li>
								<%
				String userID = null;
				if(session.getAttribute("userID") != null) {
					userID = (String) session.getAttribute("userID");
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('Hi, " + userID + "! You don't need to log in again.');");
					script.println("location.href='main.jsp'");
					script.println("</script>");
				}
				else {
			%>
				<li class="nav-item active"><a class="nav-link" href="login.jsp">Log
						in</a></li>
				<%
		}
		%>
			</ul>
		</div>
	</nav>

	<div class="container">
		<div class="col-lg-6">
			<form method="post" action="loginAction.jsp">
				<h3 style="text-align: center;">Login</h3>
				<div class="form-group">
					<input type="text" class="form-control" placeholder="ID"
						name="userID" maxlength="20">
				</div>
				<div class="form-group">
					<input type="password" class="form-control" placeholder="Password"
						name="userPassword" maxlength="20">
				</div>
				<input type="submit" class="btn btn-primary form-control"
					value="Login">
			</form>
		</div>
		<div class="col-lg-6">
			<p class="card-text">*If you are guest, write "guest" both for ID
				and password.</p>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>