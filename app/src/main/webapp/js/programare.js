function searchPacient(){
var numePacient = document.getElementById("numePacient").value;

$.get( "GetPacientByNameServlet",{ name : numePacient}, function( data ) {
   var phoneNumber = data.split(",")[0];
  var email = data.split(",")[1];
  if(data!=null && phoneNumber!=undefined && email !=undefined){

  $('#phoneNumber').append("(" + phoneNumber + ")");
  $('#pacientEmail').append("(" + email + ")");
 
  }
  else{
 $('#phoneNumber').html("<input type=\"checkbox\" class=\"icheckbox\" checked=\"checked\" /> SMS ");
 $('#pacientEmail').html("<input type=\"checkbox\" class=\"icheckbox\" checked=\"checked\" /> Email");
  }
});

}

function createAppointment(){
var numePacient = document.getElementById("numePacient").value;
var dataProgramare = document.getElementById("dataProgramare").value;
var oraProgramare = document.getElementById("timpProgramare").value;
var doctorID = document.getElementById("doctorID").value;
var values = $('#operatiiProgramare').val();

var notificationSMS;
var notificationEmail;
var notificationMobile;
if(document.getElementById("notificationSMS").checked)
notificationSMS=1;
if(document.getElementById("notificationEmail").checked)
notificationEmail=1;
if(document.getElementById("notificationMobile"))
notificationMobile=1;

$.get("AddAppointmentServlet",
{
    numePacient : numePacient,
    dataProgramare : dataProgramare,
    oraProgramare : oraProgramare,
    values : values,
    notificationSMS : notificationSMS,
    notificationEmail : notificationEmail,
    notificationMobile : notificationMobile,
    doctorID : doctorID

}
, function( data ) {
location.href="home.jsp";




});

  
}



