<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@page import="ro.dcmt.data.beans.*"%>

<%@page import="ro.dcmt.data.controllers.*"%>
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
	OperatieService os = new OperatieService();
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("user"))
				email = cookie.getValue();
		}
	}
	if (email == null) {
		response.sendRedirect("login.jsp");
		return;
	} else {

		currentUser = (User) us.getAllByColumn("email", email).get(0);
		cabinet = (Cabinet) cs.getById(currentUser.getId());

	}
	ArrayList<Programare> programariNoi = ProgramariService.getNewAppointmentsForDoctor(currentUser.getId());

	Pacient selectedPacient = (Pacient) ps.getById(Integer.parseInt(request.getParameter("id")));
	ArrayList<Programare> programariPacient = ProgramariService
			.getAppointmentsForPatient(selectedPacient.getId());
	ArrayList<User> doctors = progs.getDoctorsForPatient(selectedPacient.getId());
	ArrayList<Operatie> operatii;
%>
<!-- META SECTION -->
<title>DCMT - Informatii pacient</title>
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
	<div class="page-container">
		<!-- START PAGE SIDEBAR -->
		<div class="page-sidebar">
			<!-- START X-NAVIGATION -->
			<ul class="x-navigation">
				<li class="xn-logo"><a href="index.html">DCMT</a> <a href="#"
					class="x-navigation-control"></a></li>
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
				<li class="xn-openable"><a href="#"><span
						class="fa fa-files-o"></span> <span class="xn-text">Pacienti</span></a>
					<ul>
						<li><a href="pacienti.jsp"><span
								class="fa fa-users"></span> Lista Pacienti </a></li>
						<li><a href="pages-profile.html"><span class="fa fa-file-text-o"></span>
								Facturi</a></li>
						
						
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
		<div class="page-content">
			<!-- END PAGE SIDEBAR -->
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
								int unaproovedProgramari = 0;
								for (Programare p : programariNoi) {
									operatii = os.getOperatiiForAppointment(p.getIdOperatii());
									pacientProgramare = (Pacient) ps.getById(p.getIdUser());
									if (pacientProgramare.getId() == selectedPacient.getId())
										unaproovedProgramari++;
							%>
							<a href="pacient.jsp?id=<%=pacientProgramare.getId()%>"
								class="list-group-item">
								<div class="list-group-status status-online"></div> <img
								src="<%=pacientProgramare.getImagine().getName()%>"
								class="pull-left" alt="<%=pacientProgramare.getFirstName()%>" />
								<span class="contacts-title"><%=pacientProgramare.getFirstName() + " " + pacientProgramare.getLastName()%>
							</span>
							
								<p>
								<%for(Operatie o : operatii){ %>
								<%=o.getTitlu() + ", "%>
								<%} %>
								<%=p.getData() %>
								</p>
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
				<li class="active">Informatii pacient</li>
			</ul>
			<!-- END BREADCRUMB -->

			<div class="page-content-wrap">

				<div class="row">
					<div class="col-md-3">

						<div class="panel panel-default">
							<div class="panel-body profile"
								style="background: url('assets/images/gallery/music-4.jpg') center center no-repeat;">
								<div class="profile-image">
									<img src="<%=selectedPacient.getImagine().getName()%>"
										alt="Nadia Ali" />
								</div>
								<div class="profile-data">
									<div class="profile-data-name"><%=selectedPacient.getFirstName() + " " + selectedPacient.getLastName()%></div>
									<div class="profile-data-title" style="color: #FFF;">Pacient</div>
								</div>

							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-6">
										<button class="btn btn-info btn-rounded btn-block">
											<span class="fa fa-check"></span> Pacient mobile
										</button>
									</div>

								</div>
							</div>
							<div class="panel-body list-group border-bottom">
								<a href="#" class="list-group-item active"><span
									class="fa fa-bar-chart-o"></span> Istoric programari <span
									class="badge badge-default">18</span></a>

							</div>
							<div class="panel-body">

								<h4 class="text-title">Medici la care a apelat</h4>
								<div class="row">
									<%
										int i = 1;

										for (User doctor : doctors) {
									%>

									<div class="col-md-4 col-xs-4">
										<a href="#" class="friend"> <img
											src="<%=doctor.getImagine().getName()%>" /> <span><%=doctor.getFirstName() + " " + doctor.getLastName()%></span>
										</a>
									</div>

									<%
										i++;
											if (i % 3 == 0) {
									%>
								</div>
								<div class="row">
									<%
										}

										}
									%>

								</div>

							</div>
						</div>

					</div>

					<div class="col-md-9">

						<!-- START TIMELINE -->
						<div class="timeline timeline-right">
							<%
								if (unaproovedProgramari > 0) {
							%>
							<!-- START TIMELINE ITEM -->
							<div class="timeline-item timeline-main">
								<div class="timeline-date">Programari nevalidate</div>
							</div>
							<!-- END TIMELINE ITEM -->
							<%
								}
							%>

							<%
								for (Programare p : programariNoi) {
									if (p.getIdUser() == selectedPacient.getId()) {
							%>

							<!-- START TIMELINE ITEM -->
							<div class="timeline-item timeline-item-right">
								<div class="timeline-item-info"><%=p.getData().toString()%></div>
								<div class="timeline-item-icon">
									<span class="fa fa-calendar-plus-o"></span>
								</div>
								<div class="timeline-item-content">
									<div class="timeline-heading padding-bottom-0">
										<img src="<%=selectedPacient.getImagine().getName()%>" /> <a
											href="#"><%=selectedPacient.getFirstName() + " " + selectedPacient.getLastName()%></a>
										doreste sa programeze operatiile <a href="#">Consult,
											Detartraj, Albire Dentara</a>
									</div>
									<div class="timeline-body">
										<img src="assets/images/gallery/nature-6.jpg" width="200"
											class="img-text" align="left" />
										<h4>Va rugam sa raspundeti cererii pacientului de a
											realiza o programare</h4>
										<p>
											<button type="button" class="btn btn-success"
												data-toggle="tooltip" data-placement="bottom" title=""
												data-original-title="Adaugati programarea in calendarul dumneavoastra si notificati pacientul"
												onClick="location.href = 'ApproveAppointmentServlet?id=<%=p.getId()%>&idPacient=<%=selectedPacient.getId()%>'">Aprobati
												programarea</button>
											<button type="button" class="btn btn-info mb-control"
												data-toggle="tooltip" data-placement="bottom" title=""
												data-original-title="Contactati pacientul pentru a reprograma"
												data-box="#message-box-info">Contactati pacientul</button>
											<button type="button" class="btn btn-danger"
												data-toggle="tooltip" data-placement="bottom" title=""
												data-original-title="Stergeti programarea si notificati pacientul"
												onClick="location.href = 'RejectAppointmentServlet?id=<%=p.getId()%>&idPacient=<%=selectedPacient.getId()%>'">
												Respinge programarea</button>
										</p>


									</div>

								</div>
							</div>
							<!-- END TIMELINE ITEM -->



							<%
								}
								}
							%>


							<!-- START TIMELINE ITEM -->
							<div class="timeline-item timeline-main">
								<div class="timeline-date">Istoric medical</div>
							</div>
							<!-- END TIMELINE ITEM -->

							<%
								for (Programare p : programariPacient) {
									User doctorProgramare = (User) us.getById(p.getIdDoctor());
									Cabinet cabinetProgramare = (Cabinet) cs.getById(doctorProgramare.getIdCabinet());
							%>
							<!-- START TIMELINE ITEM -->
							<div class="timeline-item timeline-item-right">
								<div class="timeline-item-info"><%=p.getData().toString()%></div>
								<div class="timeline-item-icon">
									<span class="fa fa-calendar-plus-o"></span>
								</div>
								<div class="timeline-item-content">
									<div class="timeline-heading padding-bottom-0">
										<img src="<%=doctorProgramare.getImagine().getName()%>" /> <a
											href="#"><%=doctorProgramare.getFirstName() + " " + doctorProgramare.getLastName()%></a>
										a executat operatia de <a href="#">Extractie dentara</a>
									</div>
									<div class="timeline-body">
										<img src="assets/images/gallery/nature-6.jpg" width="200"
											class="img-text" align="left" />
										<h4><%=cabinetProgramare.getNume() + " " + cabinetProgramare.getOras()%>
										</h4>
										<p><%=p.getComentariu()%></p>


									</div>
									<div class="timeline-footer">
										<a href="#">Detalii</a>
										<div class="pull-right">
											<a href="#"><span class="fa fa-money"></span> 500 RON</a> <a
												href="#"><span class="fa fa-clock-o"></span> 2 zile</a>
										</div>
									</div>
								</div>
							</div>
							<!-- END TIMELINE ITEM -->
							<%
								}
							%>




							<!-- START TIMELINE ITEM -->
							<div class="timeline-item timeline-main">
								<div class="timeline-date">
									<a href="#"><span class="fa fa-child"></span></a>
								</div>
							</div>
							<!-- END TIMELINE ITEM -->
						</div>
						<!-- END TIMELINE -->

					</div>

				</div>

			</div>
			<!-- END PAGE CONTENT WRAPPER -->
		</div>
		<!-- END PAGE CONTAINER -->
	</div>
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
					<p>Apasa DA daca vrei sa confirmi sau NU pentru a continua
						sesiunea de lucru.</p>
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
	<!-- MESSAGE BOX-->
	<div class="message-box message-box-info animated fadeIn"
		id="message-box-info">
		<div class="mb-container">
			<div class="mb-middle">
				<div class="mb-title">
					<span class="fa fa-check"></span> Contactati pacientul acum!
				</div>
				<div class="mb-content">

					<p>
						Il puteti contacta direct la numarul de telefon:
						<%=selectedPacient.getPhoneNumber()%>.
					</p>
					<p>
						Il puteti contacta la adresa de email:
						<%=selectedPacient.getEmail()%>.
					</p>

				</div>
				<div class="mb-footer">
					<button class="btn btn-default btn-lg pull-right mb-control-close"
						onClick="approveAppointment()">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- END MESSAGE BOX-->
	<!-- BLUEIMP GALLERY -->
	<div id="blueimp-gallery"
		class="blueimp-gallery blueimp-gallery-controls">
		<div class="slides"></div>
		<h3 class="title"></h3>
		<a class="prev">‹</a> <a class="next">›</a> <a class="close">×</a> <a
			class="play-pause"></a>
		<ol class="indicator"></ol>
	</div>
	<!-- END BLUEIMP GALLERY -->

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

	<script type="text/javascript"
		src="js/plugins/blueimp/jquery.blueimp-gallery.min.js"></script>
	<!-- END THIS PAGE PLUGINS-->


	<script type="text/javascript" src="js/plugins.js"></script>
	<script type="text/javascript" src="js/actions.js"></script>
	<!-- END TEMPLATE -->

	<script>
		document.getElementById('links').onclick = function(event) {
			event = event || window.event;
			var target = event.target || event.srcElement, link = target.src ? target.parentNode
					: target, options = {
				index : link,
				event : event,
				onclosed : function() {
					setTimeout(function() {
						$("body").css("overflow", "");
					}, 200);
				}
			}, links = this.getElementsByTagName('a');
			blueimp.Gallery(links, options);
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

	<!-- END SCRIPTS -->
</body>
</html>






