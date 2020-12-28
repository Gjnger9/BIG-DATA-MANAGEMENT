
let baseUrl = "http://www.google.it/search?q=";
let maxDocument = 3;

/**
 * Get HTML asynchronously
 * @param  {String}   url      The URL to get HTML from
 * @param  {Function} callback A callback funtion. Pass in "response" variable to use returned HTML.
 */
var getHTML = function ( url, callback ) {

    // Feature detection
    if ( !window.XMLHttpRequest ) return;

    // Create new request
    var xhr = new XMLHttpRequest();

    // Setup callback
    xhr.onload = function() {
        if ( callback && typeof( callback ) === 'function' ) {
            callback( this.responseXML );
        }
    }

    // Get the HTML
    xhr.open( 'GET', url );
    xhr.responseType = 'document';
    xhr.send();

};

function Ricerca() {
    var termine = document.ricerca.cerca.value;
    RicercaDocomunti(termine);
    RicercaVideo(termine);
    RicercaLink(termine);
}

function RicercaDocomunti(termine){
    getHTML( baseUrl + termine + " filetype:pdf", function (response) {
        var someElem = document.querySelector( '#pdf' );
        var someOtherElem = response.querySelector( '#search' );
        if(someOtherElem) {
            myarray = get_all_link(someOtherElem);
            someElem.innerHTML = clean_data("Documenti");
            console.log("Ricerca andata male");
        }
    });
}

function RicercaVideo(termine){
    getHTML( baseUrl + termine + " site:youtube.com", function (response) {
        var someElem = document.querySelector( '#video' );
        var someOtherElem = response.querySelector( '#search' );
        if(someOtherElem) {
            myarray = get_all_link(someOtherElem);
            someElem.innerHTML = clean_data("Video");
        }else{
            console.log("Ricerca andata male");
        }
    });
}

function RicercaLink(termine){
    getHTML( baseUrl + termine + ' ' , function (response) {
        var someElem = document.querySelector( '#link' );
        var someOtherElem = response.querySelector( '#search' );
        if(someOtherElem) {
            myarray = get_all_link(someOtherElem);
            someElem.innerHTML = clean_data("Link");
        }else{
            console.log("Ricerca andata male");
        }
    });
}

function get_all_link(someOtherElem){
	var classElem = someOtherElem.getElementsByClassName("yuRUbf");
	var x = []
	for (var i=0; i<classElem.length; i++){
		var links = classElem[i].querySelectorAll("a");
		x.push(links[0]);
	}
	var myarray = []
	for (var i=0; i<maxDocument; i++){
		var nametext = x[i].textContent;
		var cleantext = nametext.replace(/\s+/g, ' ').trim();
		var cleanlink = x[i].href;
		myarray.push([cleantext,cleanlink]);
	}
	return myarray;
}

function clean_data(type){
	var table = '<h3>'+type+'</h3><table><thead><th>Name</th><th>Links</th></thead><tbody>';
            for (var i=0; i<maxDocument; i++) {
                table += '<tr><td>' + myarray[i][0] + '</td><td>' + myarray[i][1] + '</td></tr>';
            }
            return table;
}