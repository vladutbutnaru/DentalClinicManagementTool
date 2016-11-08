<!DOCTYPE html>
<%@page import="ro.dcmt.utils.Configuration"%>
<html lang="en">
<head>
<%@page import="ro.dcmt.data.beans.Cabinet"%>
<%@page import="ro.dcmt.data.beans.User"%>
<%@page import="ro.dcmt.data.beans.Programare"%>
<%@page import="ro.dcmt.data.beans.Operatie"%>
<%@ page import="ro.dcmt.data.beans.Pacient"%>
<%@ page import="ro.dcmt.data.beans.Produs"%>
<%@page import="ro.dcmt.utils.TimeUtils" %>
<%@page import="ro.dcmt.data.controllers.CabinetService"%>
<%@page import="ro.dcmt.data.controllers.ProgramariService"%>
<%@page import="ro.dcmt.data.controllers.UserService"%>
<%@page import="ro.dcmt.data.controllers.PacientService"%>
<%@page import="ro.dcmt.data.controllers.OperatieService"%>
<%@page import="ro.dcmt.data.controllers.InventarService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>

<%@page import="java.sql.Timestamp"%>

<%
	String email = null;
	User currentUser = new User();
	Cabinet cabinet = new Cabinet();
	UserService us = new UserService();
	PacientService ps = new PacientService();
	CabinetService cs = new CabinetService();
	Cookie[] cookies = request.getCookies();
	ArrayList<Programare> programariNoi;
	OperatieService os = new OperatieService();
	ArrayList<Programare> programariViitoare;
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
	ArrayList<Produs> produseInventar = InventarService.getInventarForDoctor(currentUser.getId());
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
<title>Dental Studio - <%=currentUser.getFirstName() + " " + currentUser.getLastName()%>
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
				<li class="xn-logo"><a href="home.jsp">DCMT</a> <a href="#"
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
							<a href="front-end/contacts.html"
								class="profile-control-right"><span class="fa fa-envelope"></span></a>
						</div>
					</div></li>
				<li class="xn-title">Navigatie</li>
				<li class="active"><a href="#"><span class="fa fa-desktop"></span>
						<span class="xn-text">Privire generala</span></a></li>
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
				<li class="xn-openable"><a href="#"><span
						class="fa fa-file-text-o"></span> <span class="xn-text">Cabinet</span></a>
					<ul>
						<li><a href="invoices.jsp"><span class="fa fa-book"></span>Facturi</a></li>
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
					data-bootstro-step="12"><a href="#"><span
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
				<li class="active">Privire generala</li>
			</ul>
			<!-- END BREADCRUMB -->

			<!-- PAGE CONTENT WRAPPER -->
			<div class="page-content-wrap">

				<!-- START WIDGETS -->
				<div class="row">
					<div class="col-md-3">

						<!-- START WIDGET SLIDER -->

						<div class="widget widget-default widget-carousel bootstro"
							data-bootstro-title="Widgetul 'Statistici'"
							data-bootstro-placement="bottom"
							data-bootstro-content="In acest widget puteti vizualiza numarul total de programari, programarile viitoare si numarul de pacienti noi."
							data-bootstro-step="1">
							<div class="owl-carousel animated swing" id="owl-example">
								<div>
									<div class="widget-title">Total programari</div>
									<div class="widget-subtitle"><%=new Date().toString()%></div>
									<div class="widget-int"><%=ProgramariService.getCountofAppointmentsForDoctor(currentUser.getId())%>
									</div>
								</div>
								<div>
									<div class="widget-title">Programari vitioare</div>
									<div class="widget-subtitle">Total programari viitoare</div>
									<div class="widget-int"><%=programariViitoare.size()%></div>
								</div>
								<div>
									<div class="widget-title">Pacienti noi</div>
									<div class="widget-subtitle">In aceasta luna</div>
									<div class="widget-int"><%=ProgramariService.getNumberOfNewPatients(currentUser.getId())%></div>
								</div>
							</div>


						</div>
						<!-- END WIDGET SLIDER -->

					</div>
					<div class="col-md-3">

						<!-- START WIDGET MESSAGES -->
						<div class="widget widget-default widget-item-icon bootstro animated swing"
							data-bootstro-title="Widgetul 'Notificari'"
							data-bootstro-placement="bottom"
							data-bootstro-content="In acest widget puteti vizualiza numarul de notificari noi pe care le-ati primit."
							data-bootstro-step="2">
							<div class="widget-item-left">
								<span class="fa fa-envelope"></span>
							</div>
							<div class="widget-data">
								<div class="widget-int num-count"><%=programariNoi.size()%></div>
								<div class="widget-title">Notificari</div>
								<div class="widget-subtitle">In casuta dumneavoastra</div>
							</div>

						</div>
						<!-- END WIDGET MESSAGES -->

					</div>
					<div class="col-md-3">

						<!-- START WIDGET REGISTRED -->
						<div class="widget widget-default widget-item-icon bootstro animated swing"
							data-bootstro-title="Widgetul 'Programari din aplicatie'"
							data-bootstro-placement="bottom"
							data-bootstro-content="In acest widget puteti vizualiza numarul total de programari create din aplicatie mobila <b>Dentistul Meu</b>."
							data-bootstro-step="3">
							<div class="widget-item-left">
								<span class="fa fa-user"></span>
							</div>
							<div class="widget-data">
								<div class="widget-int num-count"><%=ProgramariService.getProgramariFromApp(currentUser.getId())%></div>
								<div class="widget-title">Total programari din aplicatie</div>
								<div class="widget-subtitle">Dentistul Meu Mobile App</div>
							</div>

						</div>
						<!-- END WIDGET REGISTRED -->

					</div>
					<div class="col-md-3">

						<!-- START WIDGET CLOCK -->
						<div class="widget widget-danger widget-padding-sm bootstro animated swing"
							data-bootstro-title="Widgetul 'Plantificator'"
							data-bootstro-placement="bottom"
							data-bootstro-content="In acest widget, folosind butoanele de mai sus, puteti stabili programari viitoare."
							data-bootstro-step="4">
							<div class="widget-big-int plugin-clock">00:00</div>
							<div class="widget-subtitle plugin-date">Se incarca...</div>

							<div class="widget-buttons widget-c3">
								<div class="col">
									<a href="programare-noua.jsp"><span class="fa fa-clock-o"></span></a>
								</div>
								<div class="col">
									<a href="#"><span class="fa fa-bell"></span></a>
								</div>
								<div class="col">
									<a href="calendar-programari.jsp"><span
										class="fa fa-calendar"></span></a>
								</div>
							</div>
						</div>
						<!-- END WIDGET CLOCK -->

					</div>
				</div>
				<!-- END WIDGETS -->

				<div class="row">
					<div class="col-md-8">

						<!-- START SALES BLOCK -->
						<div class="panel panel-default animated fadeInUp bootstro "
							data-bootstro-title="Widgetul 'Status Pacienti'"
							data-bootstro-placement="bottom"
							data-bootstro-content="In acest widget gasiti informatii despre pacientii cabinetului dumneavoastra."
							data-bootstro-step="5">
							<div class="panel-heading">
								<div class="panel-title-box">
									<h3>Status Pacienti</h3>
									<span>Statusul pacientilor din aria alocata</span>
								</div>
								<ul class="panel-controls panel-controls-title">
									<li>
										<div id="reportrange" class="dtrange">
											<span></span><b class="caret"></b>
										</div>
									</li>
									<li><a href="#" class="panel-fullscreen rounded"><span
											class="fa fa-expand"></span></a></li>
								</ul>

							</div>
							<div class="panel-body">
								<div class="row stacked">
									<div class="col-md-4">
										<div class="progress-list">
											<div class="pull-left">
												<strong>Pacienti</strong>
											</div>
											<div class="pull-right">75%</div>
											<div class="progress progress-small progress-striped active">
												<div class="progress-bar progress-bar-primary"
													role="progressbar" aria-valuenow="50" aria-valuemin="0"
													aria-valuemax="100" style="width: 75%;">75%</div>
											</div>
										</div>
										<div class="progress-list">
											<div class="pull-left">
												<strong>Materiale</strong>
											</div>
											<div class="pull-right">450/500</div>
											<div class="progress progress-small progress-striped active">
												<div class="progress-bar progress-bar-primary"
													role="progressbar" aria-valuenow="50" aria-valuemin="0"
													aria-valuemax="100" style="width: 90%;">90%</div>
											</div>
										</div>
										<div class="progress-list">
											<div class="pull-left">
												<strong class="text-danger">Pacienti pierduti</strong>
											</div>
											<div class="pull-right">25/500</div>
											<div class="progress progress-small progress-striped active">
												<div class="progress-bar progress-bar-danger"
													role="progressbar" aria-valuenow="50" aria-valuemin="0"
													aria-valuemax="100" style="width: 5%;">5%</div>
											</div>
										</div>
										<div class="progress-list">
											<div class="pull-left">
												<strong class="text-warning">Pacienti astazi</strong>
											</div>
											<div class="pull-right">75/150</div>
											<div class="progress progress-small progress-striped active">
												<div class="progress-bar progress-bar-warning"
													role="progressbar" aria-valuenow="50" aria-valuemin="0"
													aria-valuemax="100" style="width: 50%;">50%</div>
											</div>
										</div>
										<p>
											<span class="fa fa-warning"></span> Datele se actualizeaza la
											finalul fiecarei ore. Puteti sa o faceti manual apasand
											butonul refresh al browserului
										</p>
									</div>
									<div class="col-md-8">
										<div id="dashboard-map-seles"
											style="width: 100%; height: 200px"></div>
									</div>
								</div>
							</div>
						</div>
						<!-- END SALES BLOCK -->

					</div>
					<div class="col-md-4">

						<!-- START PROJECTS BLOCK -->
						<div class="panel panel-default animated fadeInUp bootstro" 
							data-bootstro-title="Widgetul 'Stocuri'"
							data-bootstro-placement="bottom"
							data-bootstro-content="In acest widget gasiti informatii despre stocurile reale ale cabinetului dumneavoastra."
							data-bootstro-step="6" ">
							<div class="panel-heading">
								<div class="panel-title-box">
									<h3>Stocuri</h3>
									<span>Privire generala</span>
								</div>
								<ul class="panel-controls" style="margin-top: 2px;">
									<li><a href="#" class="panel-fullscreen"><span
											class="fa fa-expand"></span></a></li>
									<li><a href="#" class="panel-refresh"><span
											class="fa fa-refresh"></span></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown"><span class="fa fa-cog"></span></a>
										<ul class="dropdown-menu">
											<li><a href="#" class="panel-collapse"><span
													class="fa fa-angle-down"></span> Micsoreaza</a></li>

										</ul></li>
								</ul>
							</div>
							<div class="panel-body panel-body-table">

								<div class="table-responsive">
									<table class="table table-bordered table-striped">
										<thead>
											<tr>
												<th width="50%">Produs</th>
												<th width="20%">Stare</th>
												<th width="30%">Cantitate</th>
											</tr>
										</thead>
										<tbody>
											<%
												int nr = 0;
												for (Produs produs : produseInventar) {
													if (nr < 6) {
											%>
											<tr>
												<td><strong><%=produs.getNumeProdus()%></strong></td>
												<%
													if (produs.getCantitateProdus() <= 0) {
												%>
												<td><span class="label label-danger">Stoc zero!</span></td>
												<%
													} else {
												%>
												<%
													if ((produs.getCantitateProdus() / produs.getMaxValue()) * 100 < 70
																		&& (((produs.getCantitateProdus() / produs.getMaxValue()) * 100) >= 35)) {
												%>
												<td><span class="label label-warning">Stoc mediu</span></td>
												<%
													}
												%>
												<%
													if ((produs.getCantitateProdus() / produs.getMaxValue()) * 100 < 35) {
												%>
												<td><span class="label label-danger">Stoc mic</span></td>
												<%
													}
												%>
												<%
													if ((produs.getCantitateProdus() / produs.getMaxValue()) * 100 >= 70) {
												%>
												<td><span class="label label-success">Stoc
														suficient</span></td>
												<%
													}
															}
												%>
												<td>
													<%
														if (produs.getCantitateProdus() > 0) {
													%>
													<div
														class="progress progress-small progress-striped active">

														<div class="progress-bar progress-bar-success"
															role="progressbar"
															aria-valuenow="<%=produs.getCantitateProdus()%>"
															aria-valuemin="0"
															aria-valuemax="<%=produs.getMaxValue()%>"
															style="width:  <%=(produs.getCantitateProdus() / produs.getMaxValue()) * 100%>%;"><%=produs.getCantitateProdus()%></div>
													</div> <%
 	} else {
 %>
													<div
														class="progress progress-small progress-striped active">

														<div class="progress-bar progress-bar-danger"
															role="progressbar"
															aria-valuenow="<%=produs.getCantitateProdus()%>"
															aria-valuemin="0"
															aria-valuemax="<%=produs.getMaxValue()%>"
															style="width: 1%;"><%=produs.getCantitateProdus()%></div>
													</div> <%
 	}
 %>
												</td>
											</tr>
											<%
												}
													nr++;
												}
											%>


										</tbody>
									</table>
								</div>

							</div>
						</div>
						<input type="hidden" id="doctorID" value="<%=currentUser.getId() %>"/>
						<!-- END PROJECTS BLOCK -->

					</div>
				</div>

				<div class="row">
					<div class="col-md-4">

						<!-- START SALES & EVENTS BLOCK -->
						<div class="panel panel-default animated fadeInUp bootstro" 
							data-bootstro-title="Widgetul 'Vanzari'"
							data-bootstro-placement="bottom"
							data-bootstro-content="In acest widget gasiti informatii despre media operatiilor si programarilor din ultima luna."
							data-bootstro-step="7">
							<div class="panel-heading">
								<div class="panel-title-box">
									<h3>Vanzari</h3>
									<span>Programari & Operatii</span>
								</div>
								<ul class="panel-controls" style="margin-top: 2px;">
									<li><a href="#" class="panel-fullscreen"><span
											class="fa fa-expand"></span></a></li>
									<li><a href="#" class="panel-refresh"><span
											class="fa fa-refresh"></span></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown"><span class="fa fa-cog"></span></a>
										<ul class="dropdown-menu">
											<li><a href="#" class="panel-collapse"><span
													class="fa fa-angle-down"></span> Micsoreaza</a></li>

										</ul></li>
								</ul>
							</div>
							<div class="panel-body padding-0">
								<div class="chart-holder" id="dashboard-line-1"
									style="height: 200px;"></div>
							</div>
						</div>
						<!-- END SALES & EVENTS BLOCK -->

					</div>
					<div class="col-md-4">

						<!-- START USERS ACTIVITY BLOCK -->
						<div class="panel panel-default animated fadeInUp bootstro" 
							data-bootstro-title="Widgetul 'Pacienti'"
							data-bootstro-placement="bottom"
							data-bootstro-content="In acest widget gasiti informatii despre istoricul pacientilor noi versus pacienti fideli."
							data-bootstro-step="8">
							<div class="panel-heading">
								<div class="panel-title-box">
									<h3>Pacienti</h3>
									<span>Noi vs fideli</span>
								</div>
								<ul class="panel-controls" style="margin-top: 2px;">
									<li><a href="#" class="panel-fullscreen"><span
											class="fa fa-expand"></span></a></li>
									<li><a href="#" class="panel-refresh"><span
											class="fa fa-refresh"></span></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown"><span class="fa fa-cog"></span></a>
										<ul class="dropdown-menu">
											<li><a href="#" class="panel-collapse"><span
													class="fa fa-angle-down"></span> Micsoreaza</a></li>

										</ul></li>
								</ul>
							</div>
							<div class="panel-body padding-0">
								<div class="chart-holder" id="dashboard-bar-1"
									style="height: 200px;"></div>
							</div>
						</div>
						<!-- END USERS ACTIVITY BLOCK -->

					</div>
					<div class="col-md-4">

						<!-- START VISITORS BLOCK -->
						<div class="panel panel-default animated fadeInUp bootstro" 
							data-bootstro-title="Widgetul 'Operatii'"
							data-bootstro-placement="bottom"
							data-bootstro-content="In acest widget gasiti informatii despre media operatiilor din ultima luna. "
							data-bootstro-step="9">
							<div class="panel-heading">
								<div class="panel-title-box">
									<h3>Operatii</h3>
									<span>Operatii (ultima luna)</span>
								</div>
								<ul class="panel-controls" style="margin-top: 2px;">
									<li><a href="#" class="panel-fullscreen"><span
											class="fa fa-expand"></span></a></li>
									<li><a href="#" class="panel-refresh"><span
											class="fa fa-refresh"></span></a></li>
									<li class="dropdown"><a href="#" class="dropdown-toggle"
										data-toggle="dropdown"><span class="fa fa-cog"></span></a>
										<ul class="dropdown-menu">
											<li><a href="#" class="panel-collapse"><span
													class="fa fa-angle-down"></span> Micsoreaza</a></li>

										</ul></li>
								</ul>
							</div>
							<div class="panel-body padding-0">
								<div class="chart-holder" id="dashboard-donut-1"
									style="height: 200px;"></div>
							</div>
						</div>
						<!-- END VISITORS BLOCK -->

					</div>
				</div>

				<!-- START DASHBOARD CHART -->
				<div class="block-full-width bootstro" 
							data-bootstro-title="Widgetul 'Chart'"
							data-bootstro-placement="top"
							data-bootstro-content="In acest widget gasiti informatii despre numarul pacientilor si a operatiilor pe zile."
							data-bootstro-step="10" >
					<div id="dashboard-chart"
						style="height: 250px; width: 100%; float: left;"></div>
					<div class="chart-legend">
						<div id="dashboard-legend"></div>
					</div>
				</div>
				<!-- END DASHBOARD CHART -->

			</div>
			<!-- END PAGE CONTENT WRAPPER -->
		</div>
		<!-- END PAGE CONTENT -->
	</div>
	<!-- END PAGE CONTAINER -->
	<!--  MODALS -->
	<div class="modal" id="modal_programare_noua" tabindex="-1"
		role="dialog" aria-labelledby="defModalHead" aria-hidden="true"
		style="display: none;">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">�</span><span class="sr-only">Inchide</span>
					</button>
					<h4 class="modal-title" id="defModalHead">Adauga programare
						noua</h4>
				</div>
				<div class="modal-body">

					<div class="col-md-12">
						<div class="input-group">
							<input type="text" class="form-control"
								placeholder="Nume Pacient (eg. Ion Petreanu)"> <span
								class="input-group-btn">
								<button class="btn btn-default" type="button">Cauta in
									lista de pacienti!</button>
							</span>
						</div>
					</div>
					<br /> <br />

					<div class="form-group">
						<div class="col-md-5">
							<div class="input-group">
								<input type="text" class="form-control" value="01-01-2016"
									id="dp-4" data-date="01-01-2016" data-date-format="dd-mm-yyyy"
									data-date-viewmode="months"> <span
									class="input-group-addon add-on"><span
									class="glyphicon glyphicon-calendar"></span></span>
							</div>
						</div>
					</div>

					<br /> <br />
					<div class="form-group">
						<div class="col-md-5">
							<div class="input-group bootstrap-timepicker">
								<input type="text" class="form-control timepicker"> <span
									class="input-group-addon"><span
									class="glyphicon glyphicon-time"></span></span>
							</div>
						</div>
					</div>
					<br /> <br />







				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" data-dismiss="modal">Salveaza</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Inchide</button>
				</div>
			</div>
		</div>
	</div>


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
	<!-- END TEMPLATE -->
	<!-- END SCRIPTS -->
</body>
</html>






