<!DOCTYPE html>
<%@page import="ro.dcmt.data.controllers.OperatieService"%>
<html lang="en">
<head>


<%@page import="ro.dcmt.data.beans.*"%>

<%@page import="ro.dcmt.data.controllers.*"%>
<%@page import="ro.dcmt.utils.*" %>
<%@page import="ro.dcmt.data.controllers.PacientService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>

<%
	String email = null;
	User currentUser = new User();
	Cabinet cabinet = new Cabinet();
	UserService us = new UserService();
	PacientService ps = new PacientService();
	OperatieService os = new OperatieService();
	ProgramariService progs = new ProgramariService();
	CabinetService cs = new CabinetService();

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
	int programareID = Integer.parseInt(request.getParameter("programare"));
	Programare programare = (Programare) progs.getById(programareID);
	Pacient pacient = (Pacient) ps.getById(programare.getIdUser());
	ArrayList<Operatie> operatiiProgramare = os.getOperatiiForAppointment(programare.getIdOperatii());
	ArrayList<Produs> inventarDoctor = InventarService.getInventarForDoctor(currentUser.getId());
	ArrayList<Operatie> operatii;
	int num = 0;
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
<title>DCMT - Finalizare programare</title>
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
				<li><a href="home.jsp"><span class="fa fa-desktop"></span>
						<span class="xn-text">Privire generala</span></a></li>
				<li class="xn-openable active"><a href="#"><span
						class="fa fa-files-o"></span> <span class="xn-text">Pacienti</span></a>
					<ul>
						<li><a href="pacienti.jsp"><span class="fa fa-users"></span>
								Lista Pacienti </a></li>
						<li><a href="programare-noua.jsp"><span
								class="fa fa-check-circle"></span> Programare noua</a></li>
						<li class="active"><a href="calendar-programari.jsp"><span
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
						<li><a href="layout-nav-toggled.html"> <span
								class="fa fa-truck"></span>Furnizori
						</a></li>
						<li><a href="layout-nav-top.html"> <span
								class="fa fa-money"></span>Plati utilitare
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
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="<%=diffDaysSubscription %>" style="width: <%=(diffDaysSubscription / 30) * 100%>%;"><%=diffDaysSubscription + " zile" %></div>
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
				<li><a href="#">Programare</a></li>
				<li class="active">Finalizeaza programare</li>
			</ul>
			<!-- END BREADCRUMB -->

			<!-- PAGE CONTENT WRAPPER -->
			<div class="page-content-wrap">
				<!-- START WIZARD WITH SUBMIT BUTTON -->
				<div class="block">
					<h4>Finalizare programare</h4>
					<form
						action="javascript:endAppointment(<%=operatiiProgramare.size()%>,<%=currentUser.getId()%>,<%=programare.getId()%>)"
						role="form" class="form-horizontal">
						<div class="wizard show-submit">
							<ul>
								<li><a href="#step-1"> <span class="stepNumber">1</span>
										<span class="stepDesc">Pacient<br /> <small>Date
												personale</small></span>
								</a></li>
								<li><a href="#step-2"> <span class="stepNumber">2</span>
										<span class="stepDesc">Stocuri<br /> <small>Actualizare
												stocuri</small></span>
								</a></li>
								<li><a href="#step-3"> <span class="stepNumber">3</span>
										<span class="stepDesc">Facturare<br /> <small>Optiuni
												de facturare</small></span>
								</a></li>
							</ul>
							<div id="step-1">

								<div class="form-group">
									<label class="col-md-2 control-label">Nume</label>
									<div class="col-md-10">
										<input type="text" class="form-control" readonly
											placeholder="Ion"
											value="<%=pacient.getFirstName() + " " + pacient.getLastName()%>"
											id="numePacient">
									</div>
								</div>

								<div class="form-group">
									<label class="col-md-2 control-label">Oras</label>
									<div class="col-md-10">
										<input type="text" class="form-control"
											placeholder="Bucuresti" id="orasPacient" readonly
											value="<%=pacient.getCity()%>">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Email</label>
									<div class="col-md-10">
										<input type="text" class="form-control"
											placeholder="ion.popescu@gmail.com" id="emailPacient"
											readonly value="<%=pacient.getEmail()%>">
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Numar de telefon</label>
									<div class="col-md-10">
										<input type="text" class="form-control"
											placeholder="0722 222 222" id="numarTelefonPacient" readonly
											value="<%=pacient.getPhoneNumber()%> ">
									</div>
								</div>

							</div>
							<div id="step-2">
								<br />
								<div class="col-md-6">
									<br /> <br />
									<%
										for (Operatie operatie : operatiiProgramare) {
									%>
									<!-- PANEL OPERATIE -->
									<div class="panel panel-warning" id="operatie">
										<div class="panel-heading ui-draggable-handle">
											<h3 class="panel-title"><%=operatie.getTitlu()%></h3>
											<ul class="panel-controls">
												<li><a href="#" class="panel-fullscreen"><span
														class="fa fa-expand"></span></a></li>
												<li><a href="#" class="panel-collapse"><span
														class="fa fa-angle-down"></span></a></li>

											</ul>
										</div>
										<div class="form-group">

											<label class="col-md-2 control-label">Produse</label>
											<div class="col-md-9">
												<select multiple class="form-control select"
													data-live-search="true"
													id="produseOperatie<%=operatie.getId()%>">
													<%
														for (Produs produs : inventarDoctor) {
													%>
													<option class="productOption"
														value="<%=operatie.getId()%>,<%=produs.getID()%>">
														<%=produs.getNumeProdus()%></option>
													<%
														}
													%>
												</select>

											</div>

										</div>

										<div class="panel-footer"></div>
									</div>
									<!--  END PANEL OPERATIE -->
									<%
										}
									%>
								</div>
							</div>
							<div id="step-3">



								<div class="form-group">
									<div class="col-md-4">

										<label class="switch"> Genereaza factura      <input
											type="checkbox" onClick="showPrice()"
											id="generateInvoice" /> <span></span>

										</label>
									</div>

								</div>

								<div class="form-group" style="display: none" id="pretDiv">
									<label class="col-md-2 control-label">Pret total:</label>
									<div class="col-md-4    ">
										<input type="text"
											class="validate[required,custom[integer],min[1] form-control"
											id="pret" /> <span class="help-block">Valoare minima
											1</span>
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-4">
									
										<label class="switch"> Trimite factura prin Email pacientului     <input
											type="checkbox"
												id="sendInvoice" /> <span></span>

										</label>
									</div>

								</div>



							</div>
					</form>
				</div>
				<!-- END WIZARD WITH SUBMIT BUTTON -->


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
					<p>Are you sure you want to log out?</p>
					<p>Press No if youwant to continue work. Press Yes to logout
						current user.</p>
				</div>
				<div class="mb-footer">
					<div class="pull-right">
						<a href="pages-login.html" class="btn btn-success btn-lg">Yes</a>
						<button class="btn btn-default btn-lg mb-control-close">No</button>
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

	<!-- THIS PAGE PLUGINS -->
	<script type='text/javascript' src='js/plugins/icheck/icheck.min.js'></script>
	<script type="text/javascript"
		src="js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>

	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap-datepicker.js"></script>
	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap-file-input.js"></script>
	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap-select.js"></script>
	<script type="text/javascript"
		src="js/plugins/tagsinput/jquery.tagsinput.min.js"></script>
	<script type="text/javascript"
		src="js/plugins/smartwizard/jquery.smartWizard-2.0.min.js"></script>
	<script type='text/javascript'
		src='js/plugins/jquery-validation/jquery.validate.js'></script>
	<!-- END THIS PAGE PLUGINS -->

	<!-- START TEMPLATE -->

	<script type="text/javascript" src="js/finalizeaza-programare.js"></script>
	<script type="text/javascript" src="js/plugins.js"></script>
	<script type="text/javascript" src="js/actions.js"></script>
	<!-- END TEMPLATE -->
	<!-- END SCRIPTS -->
	<script type="text/javascript">
		var jvalidate = $("#jvalidate").validate({
			ignore : [],
			rules : {

				pret : {

					min : 1

				}

			}
		});
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






