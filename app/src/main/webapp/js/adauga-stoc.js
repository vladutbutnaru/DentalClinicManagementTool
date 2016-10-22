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