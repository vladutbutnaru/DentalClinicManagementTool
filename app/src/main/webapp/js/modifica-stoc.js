function changeStock(){
	var cantitateNoua = document.getElementById("cantitateStoc").value;
	var productId = document.getElementById("productId").value;
	$.get("ChangeStock",
			{
		productId : productId,
			    valoare : cantitateNoua,
			    productId : productId			   

			}
			, function( data ) {
			location.href="stocuri.jsp";

			});
	
	
	
}