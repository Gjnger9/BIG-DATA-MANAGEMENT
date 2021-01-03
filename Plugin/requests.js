//Il primo argomaneto è la funzione di callback
function makeRequest(callback){
	jQuery.ajax({
		type: "POST",
		url : test_ajax.url,
		data: {
			action: 'say_hello_test',
			security : test_ajax.security,
			//valore_trasmesso : 'Hello world!'
		},
		success: function( data ) {
			// Azioni da eseguire in caso di successo chiamata
			console.log(data);
			callback(JSON.parse(data));
		},
		error: function( error ) {
			// Azioni da eseguire in caso di errore chiamata
			console.log(error);
		}
	});
}

function addElementToPersonaTable(array){
	console.log(array);
	htmlToAppend = "<tbody>";
			
	for(var i = 0; i < array.length; i ++){
		//Per inserire l'ID
		htmlToAppend = htmlToAppend + "<tr>";
		htmlToAppend = htmlToAppend + "<td> "+ array[i].idpersona+" </td>";
		
		//Per inserire la email
		htmlToAppend = htmlToAppend + "<td> "+ array[i].email+" </td>";
		
		//Per inserire il nome
		htmlToAppend = htmlToAppend + "<td> "+ array[i].nome+" </td>";
		
		//Per inserire il cognome
		htmlToAppend = htmlToAppend + "<td> "+ array[i].cognome+" </td>";
		
		//Per inserire il telefono
		htmlToAppend = htmlToAppend + "<td> "+ array[i].telefono+" </td>";
		htmlToAppend = htmlToAppend + "</tr>";
	}
	
	htmlToAppend = htmlToAppend + "</tbody>";
	
	//Vede se la tabella è vuota
	if(!jQuery( "#table-Users" ).find("tbody"))
		//Se non è vuota sostituisce il valore
		jQuery( "#table-Users" ).find("tbody").replaceWith( htmlToAppend );
	else
		//Altrimenti lo aggiorna
		jQuery( "#table-Users" ).find("table").append( htmlToAppend );
	
	return 0;
}

jQuery(document).ready(function($){
     $('#get-Users').on('click', function() {
			makeRequest(addElementToPersonaTable);
	});
});
