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