	function categoryChange(e) {
		var supermarket = ["ICA","Lidl","Coop","Handlarn"];
		var restaurant = ["Hamburger","Pizza"];
		var target = document.getElementById("place");
		
		if(e.value == "supermarket") var d = supermarket;
		else if(e.value == "restaurant") var d = restaurant;
		
		target.options.length = 0;

		for (x in d) {
			var opt = document.createElement("option");
			opt.value = d[x];
			opt.name = d[x];
			opt.innerHTML = d[x];
			target.appendChild(opt);
		}	
		
	}