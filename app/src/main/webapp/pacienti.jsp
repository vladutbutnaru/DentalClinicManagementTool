<!DOCTYPE html>
<html lang="en">
<head>
<%@page import="ro.dcmt.data.beans.Cabinet"%>
<%@page import="ro.dcmt.data.beans.User"%>
<%@page import="ro.dcmt.data.beans.Programare"%>
<%@ page import="ro.dcmt.data.beans.Pacient"%>
<%@page import="ro.dcmt.data.controllers.CabinetService"%>
<%@page import="ro.dcmt.data.controllers.ProgramariService"%>
<%@page import="ro.dcmt.data.controllers.UserService"%>
<%@page import="ro.dcmt.data.controllers.PacientService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>

<%
	String email = null;
	User currentUser = new User();
	Cabinet cabinet = new Cabinet();
	UserService us = new UserService();
	PacientService ps = new PacientService();
	ProgramariService progs = new ProgramariService();
	CabinetService cs = new CabinetService();
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("user"))
				email = cookie.getValue();
		}
	}
	if (email == null){
		response.sendRedirect("login.jsp");
	return;
	}
	else {

		currentUser = (User) us.getAllByColumn("email", email).get(0);
		cabinet = (Cabinet) cs.getById(currentUser.getId());

	}
	ArrayList<Programare> programariNoi = ProgramariService.getNewAppointmentsForDoctor(currentUser.getId());
	int numOfPacients = ProgramariService.getCountofPacientsForDoctor(currentUser.getId());

	
%>
<!-- META SECTION -->
<title>DCMT - Lista Pacienti</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link rel="icon" href="favicon.ico" type="image/x-icon" />
<!-- END META SECTION -->

<!-- CSS INCLUDE -->
<link rel="stylesheet" type="text/css" id="theme"
	href="css/theme-default.css" />
<!-- EOF CSS INCLUDE -->
</head>
<body>
	<!-- START PAGE CONTAINER -->
	<div class="page-container">

		<!-- START PAGE SIDEBAR -->
		<div class="page-sidebar">
			<!-- START X-NAVIGATION -->
			<ul class="x-navigation">
				<li class="xn-logo"><a href="index.html">DCMT - Lista
						pacienti</a> <a href="#" class="x-navigation-control"></a></li>
				<li class="xn-profile"><a href="#" class="profile-mini"> <img
						src="<%=currentUser.getImagine().getName()%>"
						alt="<%=currentUser.getFirstName()%>" />
				</a>
					<div class="profile">
						<div class="profile-image">
							<img src="<%=currentUser.getImagine().getName()%>"
								alt="<%=currentUser.getFirstName()%>" />
						</div>
						<div class="profile-data">
							<div class="profile-data-name">
								Dr.
								<%=currentUser.getFirstName() + " " + currentUser.getLastName()%>
							</div>
							<div class="profile-data-title"><%=cabinet.getNume()%>
							</div>
						</div>
						<div class="profile-controls">
							<a href="javascript:void(0);"
								onclick="bootstro.start('.bootstro');"
								class="profile-control-left"><span class="fa fa-info"></span></a>
							<a href="bootstro.start('.bootstro');"
								class="profile-control-right"><span class="fa fa-envelope"></span></a>
						</div>
					</div></li>
			<li class="xn-title">Navigatie</li>
				<li><a href="home.jsp"><span
						class="fa fa-desktop"></span> <span class="xn-text">Privire
							generala</span></a></li>
				<li class="xn-openable active"><a href="#"><span
						class="fa fa-files-o"></span> <span class="xn-text">Pacienti</span></a>
					<ul>
						<li class="active"><a href="pacienti.jsp"><span class="fa fa-users"></span>
								Lista Pacienti </a></li>
						<li><a href="programare-noua.jsp"><span
								class="fa fa-check-circle"></span> Programare noua</a></li>
						<li><a href="calendar-programari.jsp"><span
								class="fa fa-calendar"></span> Agenda programari</a></li>


					</ul></li>
				<li class="xn-openable"><a href="#"><span
						class="fa fa-file-text-o"></span> <span class="xn-text">Cabinet</span></a>
					<ul>
						<li><a href="layout-nav-top.html">Agenda programari</a></li>
						<li><a href="layout-boxed.html">Stoc produse</a></li>
						<li><a href="layout-nav-toggled.html">Furnizori</a></li>
						<li><a href="layout-nav-top.html">Plati utilitare</a></li>
					</ul></li>
				

			</ul>
			<!-- END X-NAVIGATION -->
		</div>
		<!-- END PAGE SIDEBAR -->

		<!-- PAGE CONTENT -->
		<div class="page-content">

			<!-- START X-NAVIGATION VERTICAL -->
			<ul class="x-navigation x-navigation-horizontal x-navigation-panel">
				<!-- TOGGLE NAVIGATION -->
				<li class="xn-icon-button"><a href="#"
					class="x-navigation-minimize"><span class="fa fa-dedent"></span></a>
				</li>
				<!-- END TOGGLE NAVIGATION -->
				<!-- SEARCH -->
				<li class="xn-search">
					<form role="form">
						<input type="text" name="search" placeholder="Cauta pacienti..." />
					</form>
				</li>
				<!-- END SEARCH -->
				<!-- SIGN OUT -->
				<li class="xn-icon-button pull-right"><a href="#"
					class="mb-control" data-box="#mb-signout"><span
						class="fa fa-sign-out"></span></a></li>
				<!-- END SIGN OUT -->
				<!-- MESSAGES -->
				<li class="xn-icon-button pull-right"><a href="#"><span
						class="fa fa-calendar-check-o"></span></a>
					<div class="informer informer-danger"><%=programariNoi.size()%></div>
					<div
						class="panel panel-primary animated zoomIn xn-drop-left xn-panel-dragging">
						<div class="panel-heading">
							<h3 class="panel-title">
								<span class="fa fa-calendar-check-o"></span> Programari noi
							</h3>
							<div class="pull-right">
								<span class="label label-danger"><%=programariNoi.size()%>
									neaprobate</span>
							</div>
						</div>
						<div class="panel-body list-group list-group-contacts scroll"
							style="height: 200px;">

							<%
								Pacient pacientProgramare;
								for (Programare p : programariNoi) {

									pacientProgramare = (Pacient) ps.getById(p.getIdUser());
							%>
							<a href="pacient.jsp?id=<%=pacientProgramare.getId()%>"
								class="list-group-item">
								<div class="list-group-status status-online"></div> <img
								src="<%=pacientProgramare.getImagine().getName()%>"
								class="pull-left" alt="<%=pacientProgramare.getFirstName()%>" />
								<span class="contacts-title"><%=pacientProgramare.getFirstName() + " " + pacientProgramare.getLastName()%>
							</span>
								<p><%=p.getIdOperatii()%></p>
							</a>

							<%
								}
							%>
						</div>
						<div class="panel-footer text-center">
							<a href="pages-messages.html">Vezi toate programarile</a>
						</div>
					</div></li>
				<!-- END MESSAGES -->

			</ul>
			<!-- END X-NAVIGATION VERTICAL -->

			<!-- START BREADCRUMB -->
			<ul class="breadcrumb">
				<li><a href="#">Acasa</a></li>
				<li><a href="#">Finante</a></li>
				<li class="active">Lista Pacienti</li>
			</ul>
			<!-- END BREADCRUMB -->

			<!-- PAGE TITLE -->
			<div class="page-title">
				<h2>
					<span class="fa fa-users"></span> Lista pacienti <small><%=numOfPacients %>
						pacienti</small>
				</h2>
			</div>
			<!-- END PAGE TITLE -->

			<!-- PAGE CONTENT WRAPPER -->
			<div class="page-content-wrap">

				
				<div class="row">
				<%for(Pacient p : ps.getPacientiForDoctor(currentUser.getId())){%>				
					
				
					<div class="col-md-3">
						<!-- CONTACT ITEM -->
						<div class="panel panel-default">
							<div class="panel-body profile">
								<div class="profile-image">
									<img src="<%=p.getImagine().getName() %>" alt="imagine pacient" />
								</div>
								<div class="profile-data">
									<div class="profile-data-name"><%=p.getFirstName() + " " + p.getLastName() %></div>
									<div class="profile-data-title">Pacient</div>
								</div>
								<div class="profile-controls">
									<a href="pacient.jsp?id=<%=p.getId() %>" class="profile-control-left"><span
										class="fa fa-info"></span></a> 
								</div>
							</div>
							<div class="panel-body">
								<div class="contact-info">
									<p>
										<small>Telefon mobil</small><br /><%=p.getPhoneNumber() %>
									</p>
									<p>
										<small>Email</small><br /><%=p.getEmail() %>
									</p>
									
								</div>
							</div>
						</div>
						<!-- END CONTACT ITEM -->
					</div>
					<%} %>
					
				
				</div>
				

			</div>
			<!-- END PAGE CONTENT WRAPPER -->
		</div>
		<!-- END PAGE CONTENT -->
	</div>
	<!-- END PAGE CONTAINER -->

	<!-- MESSAGE BOX-->
	<div class="message-box animated fadeIn" data-sound="alert"
		id="mb-signout">
		<div class="mb-container">
			<div class="mb-middle">
				<div class="mb-title">
					<span class="fa fa-sign-out"></span> Log <strong>Out</strong> ?
				</div>
				<div class="mb-content">
					<p>Esti sigur ca vrei sa te deloghezi?</p>
					<p>Apasa DA daca vrei sa confirmi sau NU pentru a continua sesiunea de lucru.</p>
				</div>
				<div class="mb-footer">
					<div class="pull-right">
						<a href="logout.jsp" class="btn btn-success btn-lg">Da</a>
						<button class="btn btn-default btn-lg mb-control-close">Nu</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END MESSAGE BOX-->

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

	<!-- START THIS PAGE PLUGINS-->
	<script type='text/javascript' src='js/plugins/icheck/icheck.min.js'></script>
	<script type="text/javascript"
		src="js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>
	<!-- END THIS PAGE PLUGINS-->

	

	<script type="text/javascript" src="js/plugins.js"></script>
	<script type="text/javascript" src="js/actions.js"></script>
	<!-- END TEMPLATE -->

	<!-- END SCRIPTS -->
</body>
</html>






