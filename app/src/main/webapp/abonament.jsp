<!DOCTYPE html>
<html lang="en">
<head>
<%@page import="ro.dcmt.data.beans.*"%>
<%@page import="ro.dcmt.utils.*" %>
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
	Cookie[] cookies = request.getCookies();
	ArrayList<Programare> programariNoi;
	InvoiceService is = new InvoiceService();
	OperatieService os = new OperatieService();
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
<title>DCMT - Abonamentul tau</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta charset="UTF-8">
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
				<li><a href="home.jsp"><span class="fa fa-desktop"></span> <span
						class="xn-text">Privire generala</span></a></li>
				<li class="xn-openable"><a href="#"><span
						class="fa fa-files-o"></span> <span class="xn-text">Pacienti</span></a>
					<ul>
						<li><a href="pacienti.jsp"><span class="fa fa-users"></span>
								Lista Pacienti </a></li>
						<li><a href="programare-noua.jsp"><span
								class="fa fa-check-circle"></span> Programare noua</a></li>
						<li><a href="calendar-programari.jsp"><span
								class="fa fa-calendar"></span> Agenda programari</a></li>


					</ul></li>
				<li class="xn-openable active"><a href="#"><span
						class="fa fa-file-text-o"></span> <span class="xn-text">Cabinet</span></a>
					<ul>
						<li class="active"><a href="invoices.jsp"><span
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
				<li><a href="home.jsp">Acasa</a></li>
				<li><a href="#">Abonament</a></li>
			</ul>
			<!-- END BREADCRUMB -->

			<div class="page-title">
				<h2>
					<span class="fa fa-arrow-circle-o-left"></span> Abonament
				</h2>
			</div>

			<!-- PAGE CONTENT WRAPPER -->
			<div class="page-content-wrap">

				<div class="row">
					<div class="col-md-12">

						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">
									Abonamentul tau</h3>
							</div>
							<div class="panel-body">
						<div class="progress">
                                         <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="<%=diffDaysSubscription %>" style="width: <%=(diffDaysSubscription / 30) * 100%>%;">
                                        <%=diffDaysSubscription + " zile ramase" %>
                                        </div>
                                    </div>
						
						<h2><b><%=subscriptionType %></b></h2>
						<h2>Expira la <b><%=expirationText %></b></h2>
						<div class="row">
                        <!-- PRICING TABLE -->
                        <div class="col-md-4">

                            <div class="panel panel-success push-up-20">
                                <div class="panel-body panel-body-pricing">
                                    <h2>Standard<br><small>&#8364;99 / luna sau &#8364;1000 / an</small></h2>                                
                                    <p><span class="fa fa-caret-right"></span> Management pacienti</p>
                                    <p><span class="fa fa-caret-right"></span> Notificari email</p>
                                    <p><span class="fa fa-caret-right"></span> Suport live in platforma</p>
                                    <p><span class="fa fa-caret-right"></span> Actualizari gratuite</p>
                                    <p><span class="fa fa-caret-right"></span> Aparitie in aplicatia mobile</p>
                                    <p><span class="fa fa-caret-right"></span> Notificari Mobile</p>
                                    <p><span class="fa fa-caret-right"></span> Management Stocuri</p>
                                    <p><span class="fa fa-caret-right"></span> Statistici de performanta</p>
                                    <p><span class="fa fa-caret-right"></span> Rapoarte inteligente</p>
                                    <p class="text-muted">Dedicat medicilor care vor un sistem complet de management</p>
                                </div>
                                <div class="panel-footer">                                 
                                    <button class="btn btn-success btn-block">Schimba</button>
                                </div>
                            </div>

                        </div>

                        <div class="col-md-4">

                            <div class="panel panel-danger">
                                <div class="panel-body panel-body-pricing">
                                    <h2>Elite<br><small>&#8364;149 / luna sau &#8364;1500 / an</small></h2>                                
                                    <p><span class="fa fa-caret-right"></span> Toate beneficiile pachetului Standard</p>
                                    <p><span class="fa fa-caret-right"></span> Acces la actualizari dedicate</p>
                                    <p><span class="fa fa-caret-right"></span> Agent tehnic dedicat</p>
                                    <p><span class="fa fa-caret-right"></span> Sincronizare stocuri</p>
                                    <p><span class="fa fa-caret-right"></span> Moderare recenzii din aplicatia Mobile</p>
                                    <p><span class="fa fa-caret-right"></span> Distinctii in functie de performanta</p>          
                                    <p><span class="fa fa-caret-right"></span> Acces la cele mai bune oferte ale furnizorilor de echipamente medicale</p>       
                                                        
                                    <p class="text-muted">Dedicat medicilor care vor sa inoveze</p>
                                </div>
                                <div class="panel-footer"> 
                                    <button class="btn btn-danger btn-block">Prelungeste</button>
                                </div>
                            </div>

                        </div>                    

                        <div class="col-md-4">

                            <div class="panel panel-warning push-up-20">
                                <div class="panel-body panel-body-pricing">
                                    <h2>Clinica<br><small>&#8364;599 / luna sau &#8364;6000 / an</small></h2>                                
                                    <p><span class="fa fa-caret-right"></span> Pana la 8 licente Elite</p>
                                    <p><span class="fa fa-caret-right"></span> Posibilitatea personalizarii platformei</p>
                                    <p><span class="fa fa-caret-right"></span> Training on-site</p>                                    
                                    <p class="text-muted">Dedicat clinicilor de elita din Romania</p>
                                </div>
                                <div class="panel-footer"> 
                                    <button class="btn btn-warning btn-block">Upgrade</button>
                                </div>
                            </div>

                        </div>                          
                        <!-- END PRICING TABLE-->
                    </div>
						
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

	<!--  END MODALS -->
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
		src="js/plugins/scrolltotop/scrolltopcontrol.js"></script>

	<script type="text/javascript" src="js/plugins/morris/raphael-min.js"></script>
	<script type="text/javascript" src="js/plugins/morris/morris.min.js"></script>
	<script type="text/javascript" src="js/plugins/rickshaw/d3.v3.js"></script>
	<script type="text/javascript"
		src="js/plugins/rickshaw/rickshaw.min.js"></script>
	<script type='text/javascript'
		src='js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js'></script>
	<script type='text/javascript'
		src='js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js'></script>
	<script type='text/javascript'
		src='js/plugins/bootstrap/bootstrap-datepicker.js'></script>
	<script type="text/javascript" src="js/plugins/owl/owl.carousel.min.js"></script>

	<script type="text/javascript" src="js/plugins/moment.min.js"></script>
	<script type="text/javascript"
		src="js/plugins/daterangepicker/daterangepicker.js"></script>
	<script type="text/javascript"
		src="js/plugins/tour/bootstrap-tour.min.js"></script>
	<script type="text/javascript" src="js/plugins/tour/bootstro.min.js"></script>
	<!-- END THIS PAGE PLUGINS-->
	<script type="text/javascript"
		src="js/plugins/tagsinput/jquery.tagsinput.min.js"></script>
	<!-- START TEMPLATE -->
	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap-select.js"></script>
	<script type="text/javascript"
		src="js/plugins/bootstrap/bootstrap-timepicker.min.js"></script>
	<script type="text/javascript" src="js/plugins.js"></script>
	<script type="text/javascript" src="js/actions.js"></script>

	<script type="text/javascript" src="js/demo_dashboard.js"></script>
	<!-- END TEMPLATE -->
	<!-- END SCRIPTS -->
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






