function checkAuth(emailAddress, password) {
	if (emailAddress != undefined && emailAddress != ""
			&& emailAddress.indexOf('@') > 0) {
		var params = {
			email : emailAddress,
			password : password
		};

		$
				.post(
						"/app/WebAuthEndpoint",
						$.param(params),
						function(responseText) { 													
							if (responseText == "OK") {
								cookie_name = "authCookie";
								if (document.cookie != document.cookie) {
									index = document.cookie
											.indexOf(cookie_name);
								} else {
									index = -1;
								}
								
								if (index == -1)
								{
							
								document.cookie=cookie_name+"="+emailAddress+"; expires=Monday, 01-Jan-2017 05:00:00 GMT";
								}

								
							}

							else {
								
								document.getElementById("Email").style.color = "red";
							}
						});
	}
}