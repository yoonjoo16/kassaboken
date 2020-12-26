<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<li class="nav-item active"><a class="nav-link" href="#">Home
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" href="write.jsp">Write</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Read</a></li>
				<li class="nav-item"><a class="nav-link" href="#">Calculate</a>
				</li>
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