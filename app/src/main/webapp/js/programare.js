var loaded = 0;
function searchPacient(){
	
var numePacient = document.getElementById("numePacient").value;
console.log(numePacient);
$.get( "GetPacientByNameServlet",{ name : numePacient}, function( data ) {
   var phoneNumber = data.split(",")[0];
  var email = data.split(",")[1];
  console.log(data);
  if(data!=null && phoneNumber!=undefined && email !=undefined){
	if(loaded==0){
  $('#phoneNumber').append("(" + phoneNumber + ")");
  $('#pacientEmail').append("(" + email + ")");
	}
  loaded=1;
  }
  else{
	  alert("Pacientul nu a fost gasit. Verificati datele sau, daca este un pacient nou, adaugati-l in sistem.");
	  
  }
});

}

function createAppointment(){
var numePacient = document.getElementById("numePacient").value;
var dataProgramare = document.getElementById("dataProgramare").value;
var oraProgramare = document.getElementById("timpProgramare").value;
var doctorID = document.getElementById("doctorID").value;
var comentariuProgramare = document.getElementById("comentariuProgramare").value;
var values = $('#operatiiProgramare').val();
var operatii = [];
for(let i = 0; i<values.length;i++){
	operatii.push(values[i]);
	
}

var notificationSMS = 0;
var notificationEmail = 0;
var notificationMobile = 0;
if(document.getElementById("notificationSMS").checked)
notificationSMS=1;
if(document.getElementById("notificationEmail").checked)
notificationEmail=1;
if(document.getElementById("notificationMobile").checked)
notificationMobile=1;

$.get("AddAppointmentServlet",
{
    numePacient : numePacient,
    dataProgramare : dataProgramare,
    oraProgramare : oraProgramare,
    values : operatii,
    notificationSMS : notificationSMS,
    notificationEmail : notificationEmail,
    notificationMobile : notificationMobile,
    doctorID : doctorID,
    comentariuProgramare: comentariuProgramare

}
, function( data ) {





});

location.href="home.jsp";
}

function addPatient(){
	var prenume = document.getElementById("prenumePacientModal").value;
	var nume = document.getElementById("numePacientModal").value;
	var oras = document.getElementById("orasPacient").value;
	var email = document.getElementById("emailPacient").value;
	var numarTelefon = document.getElementById("numarTelefonPacient").value;
	
	$.get( "AddPatientServlet",{ 
		
		prenume : prenume,
		nume : nume,
		oras : oras,
		email : email,
		numarTelefon : numarTelefon	
	
	}, function( data ) {
		$("[data-dismiss=modal]").trigger({ type: "click" });
		return;
	});
	
	
	
}



