<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html lang="en" class="body-full-height">
<head>
<!-- META SECTION -->
<title>Dental Studio - Autentificare</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link rel="icon" href="favicon.ico" type="image/x-icon" />
<!-- END META SECTION -->

<!-- CSS INCLUDE -->
<link rel="stylesheet" type="text/css" id="theme"
	href="css/theme-default.css" />
<!-- EOF CSS INCLUDE -->

<!-- Cookie Verification -->
<%
String userName = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
    if(cookie.getName().equals("user")) userName = cookie.getValue();
}
}
if(userName != null) response.sendRedirect("home.jsp");

%>
<!-- END OF Cookie Verification -->


</head>
<body>
	<button type="button" id="failButton" name="failButton" style="display:none" class="btn btn-danger mb-control"
		data-box="#message-box-sound-2">Fail</button>
	<div class="login-container">

		<div class="login-box animated fadeInDown">
			<div class="login-logo"></div>
			<div class="login-body">
				<div class="login-title">
					<strong>Bine ati venit</strong>, Introduceti datele
				</div>
				<form action="WebAuthEndpoint" method="post" class="form-horizontal">
					<div class="form-group">
						<div class="col-md-12">
							<input type="text" class="form-control"
								placeholder="Adresa de email" name="email" id="emailAddress" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12">
							<input type="password" class="form-control" placeholder="Parola"
								name="password" id="password" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-6">
							<a href="#" class="btn btn-link btn-block">Ati uitat parola?</a>
						</div>
						<div class="col-md-6">
							<button class="btn btn-info btn-block">Autentificare</button>
						</div>
					</div>
				</form>
			</div>
			<div class="login-footer">
				<div class="pull-left">&copy; 2016 Dental Studio</div>
				<div class="pull-right">
					<a href="front-end/index.html">Despre</a> | <a	href="front-end/contacts.html">Contact</a>
				</div>
			</div>
		</div>

	</div>
	<!-- danger with sound -->
	<div class="message-box message-box-danger animated fadeIn"
		data-sound="fail" id="message-box-sound-2">
		<div class="mb-container">
			<div class="mb-middle">
				<div class="mb-title">
					<span class="fa fa-times"></span> Parola gresita!
				</div>
				<div class="mb-content">
					<p>Parola pe care a-ti introdus-o este gresita, va rugam incercati din nou!</p>
				</div>
				<div class="mb-footer">
					<button class="btn btn-default btn-lg pull-right mb-control-close">Reincearca</button>
				</div>
			</div>
		</div>
	</div>
	<!-- end danger with sound -->
	<!-- START PRELOADS -->
	<audio id="audio-alert" src="audio/alert.mp3" preload="auto"></audio>
	<audio id="audio-fail" src="audio/fail.mp3" preload="auto"></audio>
	<!-- END PRELOADS -->

	<!-- START SCRIPTS -->
	<!-- START PLUGINS -->
	<script type="text/javascript" src="js/plugins/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="js/plugins/jquery/jquery-ui.min.js"></script>
	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap.min.js"></script>
	<!-- END PLUGINS -->

	<!-- THIS PAGE PLUGINS -->
	<script type='text/javascript' src='js/plugins/icheck/icheck.min.js'></script>
	<script type="text/javascript"
		src="js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>

	<script type='text/javascript' src='js/plugins/noty/jquery.noty.js'></script>
	<script type='text/javascript'
		src='js/plugins/noty/layouts/topCenter.js'></script>
	<script type='text/javascript' src='js/plugins/noty/layouts/topLeft.js'></script>
	<script type='text/javascript'
		src='js/plugins/noty/layouts/topRight.js'></script>

	<script type='text/javascript' src='js/plugins/noty/themes/default.js'></script>

	<!-- END PAGE PLUGINS -->

	<!-- START TEMPLATE -->
	

	<script type="text/javascript" src="js/plugins.js"></script>
	<script type="text/javascript" src="js/actions.js"></script>
	<!-- END TEMPLATE -->

<script type="text/javascript">
window.onload = function() {

<%
String failed = null;
 cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
    if(cookie.getName().equals("failed")) failed = cookie.getValue();
}
}
if(failed != null){

%>
document.getElementById("failButton").click();
<% } %>

};
</script>
<!--Start of Tawk.to Script-->
	<script type="text/javascript">
		var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
		(function() {
			var s1 = document.createElement("script"), s0 = document
					.getElementsByTagName("script")[0];
			s1.async = true;
			s1.src = 'https://embed.tawk.to/58075974cfdf421cf96b5639/default';
			s1.charset = 'UTF-8';
			s1.setAttribute('crossorigin', '*');
			s0.parentNode.insertBefore(s1, s0);
		})();
	</script>
	<!--End of Tawk.to Script-->
</body>
</html>






