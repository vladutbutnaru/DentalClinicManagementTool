function addProductt(){
	var numeProdus = document.getElementById("numeProdusModal").value;
	var um = document.getElementById("umModal").value;
	var cantitateProdus = document.getElementById("cantitateModal").value;
	var idCabinet = document.getElementById("idCabinet").value;
	var idDcotor = document.getElementById("idDoctor").value;
	var maximumValue = document.getElementById("cantitateMaxima").value;
	
	$.post("AddProductInStockServlet", {
		numeProdus:numeProdus,
		um:um,
		cantitateProdus:cantitateProdus,
		idCabinet:idCabinet,
		idDoctor:idDoctor,
		maximumValue:maximumValue
		
		
		
	}	, function( data ) {
		location.href="stocuri.jsp";

	});

	
}