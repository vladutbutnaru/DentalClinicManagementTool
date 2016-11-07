function updateStock(){
	var stocks = document.getElementsByClassName("form-control");
	var stockValues = [];
	for(let i = 0; i<stocks.length ; i++){
		
		stockValues.push(stocks[i].value);
	
		
	}
	var idProgramare = document.getElementById("idProgramare").value;
	
	$.get("AddStocks", {
		idProgramare : idProgramare,
		stockValues : stockValues	

	}, function(data) {
		location.href = "home.jsp";

	});
	
	
	
	
}
function addProduct(){
	var numeProdus = document.getElementById("numeProdusModal").value;
	var um = document.getElementById("umModal").value;
	var cantitate = document.getElementById("cantitateModal").value;
	var idCabinet = document.getElementById("idCabinet").value;
	var idDoctor = document.getElementById("idDoctor").value;
	var maximumValue = document.getElementById("cantitateMaxima").value;
	$.post("AddProductInStockServlet", {
		numeProdus : numeProdus,
		um : um,
		cantitate : cantitate,
		idCabinet : idCabinet,
		idDoctor : idDoctor,
		maximumValue : maximumValue

	}, function(data) {
		location.href = "stocuri.jsp";

	});
	
	
	
}