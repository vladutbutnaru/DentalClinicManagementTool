function endAppointment(nrOperatii, idMedic, idProgramare) {

	var allOptions = document.getElementsByClassName("filter-option pull-left");
	var price = document.getElementById("pret").value;
	var operatii = [];
	for(let i = 0; i<nrOperatii; i++){
	if (operatii != null) {
		var operatiiSplit = allOptions[i].innerHTML.split(",");
		for(let j = 0; j<operatiiSplit.length;j++)
			operatii.push(operatiiSplit[j]);
	}
	}
var generateInvoice = 0;
var sendInvoiceViaEmail = 0;
	if(document.getElementById("generateInvoice").checked){
	generateInvoice=1;
	
}
	
	if(document.getElementById("sendInvoice").checked){
		sendInvoiceViaEmail = 1;
	}
	$.get("EndAppointmentServlet", {
		idProgramare : idProgramare,
		idMedic : idMedic,
		nrOperatii : nrOperatii,
		produse : operatii,
		generateInvoice : generateInvoice,
		sendInvoiceViaEmail : sendInvoiceViaEmail,
		price : price
		

	}, function(data) {
		location.href = data;

	});

}
function showPrice(){
	if(document.getElementById("pretDiv").style.display == "none")
		document.getElementById("pretDiv").style.display="";
	else
		document.getElementById("pretDiv").style.display="none";
	
	
}
