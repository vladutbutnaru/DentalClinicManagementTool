<!DOCTYPE html>
<html lang="en">
<%@page import="ro.dcmt.data.beans.*"%>
<%@page import="ro.dcmt.utils.*" %>
<%@page import="ro.dcmt.data.controllers.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<head>
<%
	String email = null;
	User currentUser = new User();
	Cabinet cabinet = new Cabinet();
	UserService us = new UserService();
	PacientService ps = new PacientService();
	CabinetService cs = new CabinetService();

	OperatieService os = new OperatieService();
	Cookie[] cookies = request.getCookies();
	ArrayList<Programare> programariNoi;
	ArrayList<Programare> programariViitoare;
	ArrayList<Operatie> operatiiCabinet = new ArrayList<Operatie>();
	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("user"))
				email = cookie.getValue();
		}
	} else {

		response.sendRedirect("login.jsp");
		return;

	}
	if (email == null) {

		response.sendRedirect("login.jsp");
		return;

	} else {

		currentUser = (User) us.getAllByColumn("email", email).get(0);
		cabinet = (Cabinet) cs.getById(currentUser.getId());

	}
	programariNoi = ProgramariService.getNewAppointmentsForDoctor(currentUser.getId());
	programariViitoare = ProgramariService.getFutureAppointments(currentUser.getId());
	operatiiCabinet = os.getOperatiiForCabinet(currentUser.getIdCabinet());
	ArrayList<Operatie> operatii;
	long diffDaysSubscription =TimeUtils.differenceNowAndTimestamp(currentUser.getExpirationDate());
	String subscriptionType = "Abonament ";
	if(currentUser.getSubscriptionType() == Configuration.STANDARD_SUBSCRIPTION)
		subscriptionType+= "Standard";
	if(currentUser.getSubscriptionType() == Configuration.ELITE_SUBSCRIPTION)
		subscriptionType+= "Elite";
	if(currentUser.getSubscriptionType() == Configuration.BETA_TESTER)
		subscriptionType+= "Beta";
	if(currentUser.getSubscriptionType() == Configuration.FREE_TRIAL)
		subscriptionType+= "Trial";
	int expirationMonth = currentUser.getExpirationDate().getMonth()+1;
	int expirationYear = currentUser.getExpirationDate().getYear() + 1900;
	String expirationText = currentUser.getExpirationDate().getDate() + "/" + expirationMonth + "/" + expirationYear;
%>

<!-- META SECTION -->
<title>DCMT - <%=currentUser.getFirstName() + " " + currentUser.getLastName()%>
	interfata de administrare
</title>
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
				<li><a href="home.jsp"><span class="fa fa-desktop"></span>
						<span class="xn-text">Privire generala</span></a></li>
				<li class="xn-openable active"><a href="#"><span
						class="fa fa-files-o"></span> <span class="xn-text">Pacienti</span></a>
					<ul>
						<li><a href="pacienti.jsp"><span class="fa fa-users"></span>
								Lista Pacienti </a></li>
						<li class="active"><a href="programare-noua.jsp"><span
								class="fa fa-check-circle"></span> Programare noua</a></li>
						<li><a href="calendar-programari.jsp"><span
								class="fa fa-calendar"></span> Agenda programari</a></li>


					</ul></li>
				<li class="xn-openable"><a href="#"><span
						class="fa fa-file-text-o"></span> <span class="xn-text">Cabinet</span></a>
					<ul>
						<li ><a href="invoices.jsp"><span
								class="fa fa-book"></span>Facturi</a></li>
						<li><a href="stocuri.jsp"> <span
								class="fa fa-tasks"></span>Stoc produse
						</a></li>
						<li><a href="suppliers.jsp"> <span
								class="fa fa-truck"></span>Furnizori
						</a></li>
						
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
				<!-- SUBSCRIPTION INFO -->
				<li class="xn-icon-button pull-right">
                        <a href="#"><span class="fa fa-tasks"></span></a>
                        <div class="informer informer-success"></div>
                        <div class="panel panel-primary animated zoomIn xn-drop-left xn-panel-dragging ui-draggable">
                            <div class="panel-heading ui-draggable-handle">
                                <h3 class="panel-title"><span class="fa fa-tasks"></span> Abonament</h3>                                
                                <div class="pull-right">
                                    <span class="label label-success">Cont activ</span>
                                </div>
                            </div>
                            <div class="panel-body list-group scroll mCustomScrollbar _mCS_3 mCS-autoHide" style="height: 100px;"><div id="mCSB_3" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" tabindex="0"><div id="mCSB_3_container" class="mCSB_container" style="position:relative; top:0; left:0;" dir="ltr">                                
                                <a class="list-group-item" href="#">
                                    <strong><%=subscriptionType %></strong>
                                    <div class="progress progress-small progress-striped active">
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="<%=diffDaysSubscription %>" style="width: <%=((double)diffDaysSubscription / 30.0) * 100%>%;"><%=diffDaysSubscription + " zile" %></div>
                                    </div>
                                    <small class="text-muted">Expira la <%=expirationText %></small>
                                </a>
                                                   
                            </div><div id="mCSB_3_scrollbar_vertical" class="mCSB_scrollTools mCSB_3_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: block;"><div class="mCSB_draggerContainer"><div id="mCSB_3_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px; display: block; height: 132px; max-height: 190px;" oncontextmenu="return false;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div>     
                            <div class="panel-footer text-center">
                                <a href="abonament.jsp">Prelungeste acum</a>
                            </div>                            
                        </div>                        
                    </li>
				
				<!-- END SUBSCRIPTION INFO -->
				<!-- MESSAGES -->
				<li class="xn-icon-button pull-right bootstro"
					data-bootstro-title="Programari neaprobate"
					data-bootstro-placement="bottom"
					data-bootstro-content="Aici veti gasi programarile nou create si neaprobate."
					data-bootstro-step="5"><a href="#"><span
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
									operatii = os.getOperatiiForAppointment(p.getIdOperatii());
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
				<li><a href="#">Pacienti</a></li>
				<li class="active">Programare noua</li>

			</ul>
			<!-- END BREADCRUMB -->

			<!-- PAGE CONTENT WRAPPER -->
			<div class="page-content-wrap">

				<div class="row">
					<div class="col-md-12">

						<form class="form-horizontal">
							<div class="panel panel-default">
								<div class="panel-heading">
									<h3 class="panel-title">
										Formular <strong>programare noua</strong>
									</h3>

								</div>
								<div class="panel-body">
									<p>Folositi acest formular pentru a crea o programare noua</p>
								</div>
								<div class="panel-body">

									<div class="form-group">
										<label class="col-md-3 col-xs-12 control-label">Nume Complet
											Pacient ("Prenume Nume")</label>
										<div class="col-md-6 col-xs-12">
											<div class="input-group">
												<input type="text" id="numePacient" class="form-control"
													placeholder="eg. Ion Popescu"> <span
													class="input-group-btn">
													<button class="btn btn-default" type="button"
														onClick="javascript:searchPacient()">Cauta
														pacient</button>
													<button class="btn btn-default" type="button"
														data-toggle="modal" data-target="#modalAdaugaPacient">Adauga
														pacient</button>
												</span>
											</div>
											<span class="help-block">Folositi butonul "Cauta
												pacient" pentru a-l cauta in pacientii existenti</span>
										</div>
									</div>

									<div class="form-group">
										<label class="col-md-3 col-xs-12 control-label">Data
											programarii</label>
										<div class="col-md-6 col-xs-12">
											<div class="input-group">
												<span class="input-group-addon"><span
													class="fa fa-calendar"></span></span> <input type="text"
													class="form-control datepicker" id="dataProgramare"
													value="2016-11-01">
											</div>
											<span class="help-block">Click pe casuta pentru a
												afisa calendarul</span>
										</div>
									</div>

									<div class="form-group">
										<label class="col-md-3 col-xs-12 control-label">Ora
											programarii</label>
										<div class="col-md-6 col-xs-12">
											<div class="input-group bootstrap-timepicker">
												<input type="text" id="timpProgramare"
													class="form-control timepicker24"> <span
													class="input-group-addon"><span
													class="glyphicon glyphicon-time"></span></span>
											</div>
											<span class="help-block">Click pe casuta pentru a
												afisa ceasul </span>
										</div>
									</div>
									<input type="hidden" value="<%=currentUser.getId()%>"
										id="doctorID" />
									<div class="form-group">
										<label class="col-md-3 col-xs-12 control-label">Operatii</label>
										<div class="col-md-6 col-xs-12">

											<select multiple id="operatiiProgramare"
												class="form-control select">
												<%
													for (Operatie o : operatiiCabinet) {
												%>
												<option value="<%=o.getId()%>"><%=o.getTitlu()%></option>
												<%
													}
												%>
											</select>
										</div>

									</div>
								</div>

								<div class="form-group">
									<label class="col-md-3 col-xs-12 control-label">Comentariul
										programarii</label>
									<div class="col-md-6 col-xs-12">
										<textarea class="form-control" rows="5"
											id="comentariuProgramare"></textarea>
										<span class="help-block">Adauga comentarii pentru
											aceasta programare</span>
									</div>
								</div>

								<div class="form-group">
									<label class="col-md-3 col-xs-12 control-label">Notificari
										pacient</label>
									<div class="col-md-6 col-xs-12">
										<label class="check"> <input type="checkbox"
											class="icheckbox" checked="checked" id="notificationMobile" />
											Dentistul Meu Mobile App
										</label> <label class="check" id="phoneNumber"> <input
											type="checkbox" class="icheckbox" checked="checked"
											id="notificationSMS" /> SMS

										</label> <label class="check" id="pacientEmail"> <input
											type="checkbox" class="icheckbox" checked="checked"
											id="notificationEmail" /> Email

										</label> <span class="help-block">Selectati tipurile de
											notificari pentru pacient</span>
									</div>
								</div>

							</div>
						</form>
						<div class="panel-footer">
							<button class="btn btn-default">Sterge campurile</button>
							<button class="btn btn-primary pull-right"
								onClick="javascript:createAppointment()">Salveaza
								programarea</button>
						</div>
					</div>

				</div>
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


	<!--  MODAL ADD PATIENT -->
	<div class="modal" id="modalAdaugaPacient" tabindex="-1" role="dialog"
		aria-labelledby="defModalHead" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<h3>Adauga pacient nou</h3>
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-md-2 control-label">Prenume</label>
							<div class="col-md-10">
								<input type="text" class="form-control" placeholder="Ion" id="prenumePacientModal">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label">Nume de familie</label>
							<div class="col-md-10">
								<input type="text" class="form-control" placeholder="Popescu" id="numePacientModal">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label">Oras</label>
							<div class="col-md-10">
								<input type="text" class="form-control" placeholder="Bucuresti" id="orasPacient">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label">Email</label>
							<div class="col-md-10">
								<input type="text" class="form-control"
									placeholder="ion.popescu@gmail.com" id="emailPacient">
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label">Numar de telefon</label>
							<div class="col-md-10">
								<input type="text" class="form-control"
									placeholder="0722 222 222" id="numarTelefonPacient">
							</div>
						</div>


					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Inchide</button>
					<button type="button" class="btn btn-default"
						onClick="javascript:addPatient();">Salveaza pacient</button>
				</div>
			</div>
		</div>
	</div>



	<!-- END MODAL ADD PATIENT -->

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
	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap-timepicker.min.js"></script>
	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap-file-input.js"></script>
	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap-select.js"></script>
	<script type="text/javascript"
		src="js/plugins/tagsinput/jquery.tagsinput.min.js"></script>
	<!-- END THIS PAGE PLUGINS -->

	<!-- START TEMPLATE -->

	<script type="text/javascript" src="js/programare.js"></script>
	<script type="text/javascript" src="js/plugins.js"></script>
	<script type="text/javascript" src="js/actions.js"></script>
	<!-- END TEMPLATE -->
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






