$('#datetimepicker1').datetimepicker({
			format : 'YYYY-MM-DD',
			defalutDate : new Date()
		});

$('#datetimepicker2').datetimepicker({
			format : 'YYYY-MM-DD',
			defalutDate : new Date()
		});

$('#exampleModal').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget) 
			var modal = $(this)
			modal.find('.modal-body input[name="datum"]').val(button.data('datum'));
			modal.find('.modal-body input[name="id"]').val(button.data('id'));
			modal.find('.modal-body input[name="belopp"]').val(button.data('amount'));	
			
			$(".modal-body #user-modal").val(button.data('user'));
			$(".modal-body #category-modal").val(button.data('category'));
			categoryChange_modal(button.data('category'));
			$(".modal-body #place-modal").val(button.data('place'));
			$(".modal-body #category-modal").change(function(){
				var sel = $(".modal-body #category-modal option:selected").val();
				categoryChange_modal(sel);
			})

})

$('#calModal').on('show.bs.modal', function(event) {
		var button = $(event.relatedTarget) 
		var modal = $(this)
		modal.find('.modal-body input[name="id"]').val(button.data('id'));
		modal.find('.modal-body input[name="datum"]').val(button.data('datum'));
		modal.find('.modal-body input[name="desc"]').val(button.data('desc'));
		modal.find('.modal-body input[name="belopp"]').val(button.data('belopp'));	
		
		$(".modal-body #user-modal").val(button.data('user'));
		$(".modal-body #category-modal").val(button.data('category'));

})

$('#history').collapse()


		
function categoryChange(e) {
			switch (e) {
			case "Supermarket":
				var d = [ "ICA", "Lidl", "Coop", "Handlarn", "Lokchan", "Etc" ];
				break;
			case "Alcohol":
				var d = [ "Systembolaget", "Pub", "Etc" ];
				break;
			case "Restaurant":
				var d = [ "Hamburger", "Pizza", "Asian food", "Kebab/falafel",
						"Swedish food", "Etc" ];
				break;
			case "Apotek":
				var d = [ "Apotea", "Etc" ];
				break;
			case "Hobby":
				var d = [ "Bowling", "Etc" ];
				break;
			case "Travel":
				var d = [ "Skånetrafiken", "SJ", "Flight ticket", "Ferry",
						"Etc" ];
				break;
			}
			var target = document.getElementById("place");
			target.options.length = 0;

			for (x in d) {
				var opt = document.createElement("option");
				opt.value = d[x];
				opt.name = d[x];
				opt.innerHTML = d[x];
				target.appendChild(opt);
			}
		}
		
function categoryChange_modal(e) {
			switch (e) {
			case "Supermarket":
				var d = [ "ICA", "Lidl", "Coop", "Handlarn", "Lokchan", "Etc" ];
				break;
			case "Alcohol":
				var d = [ "Systembolaget", "Pub", "Etc" ];
				break;
			case "Restaurant":
				var d = [ "Hamburger", "Pizza", "Asian food", "Kebab/falafel",
						"Swedish food", "Etc" ];
				break;
			case "Apotek":
				var d = [ "Apotea", "Etc" ];
				break;
			case "Hobby":
				var d = [ "Bowling", "Etc" ];
				break;
			case "Travel":
				var d = [ "Skånetrafiken", "SJ", "Flight ticket", "Ferry",
						"Etc" ];
				break;
			}
			var target = document.getElementById("place-modal");
			target.options.length = 0;
			for (x in d) {
				var opt = document.createElement("option");
				opt.value = d[x];
				opt.name = d[x];
				opt.innerHTML = d[x];
				target.appendChild(opt);
			}
		}