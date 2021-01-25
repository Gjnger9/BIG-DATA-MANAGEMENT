let baseUrl = "http://www.google.it/search?q=";
let baseUrlImages = "http://www.google.it/search?q=";
let maxDocument = 3;
var arrayLink, arrayVideo, arrayDocumenti;
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

function Ricerca(termine) {
    RicercaLink(termine);
    RicercaVideo(termine);
    RicercaDocomunti(termine);
    RicercaImmagine(termine);
}

function RicercaDocomunti(termine){
    getHTML( baseUrl + termine + " filetype:pdf", function (response) {
        var someElem = document.querySelector( '#pdf' );
        var someOtherElem = response.querySelector( '#search' );
        if(someOtherElem) {
            myarray = get_all_link(someOtherElem);
            if (!myarray) {
                arrayDocumenti = null;
                console.log("Ricerca andata male");
                return false;
            }

            someElem.innerHTML = clean_data("pdf");
            //Trasformarla in una tabella wordpress
            someElem.classList.add("is-style-stripes");
            someElem.classList.add("wp-block-table");
              arrayDocumenti = myarray;
              console.log(arrayDocumenti);
        } else
            console.log("Ricerca andata male");
    });
}

function RicercaVideo(termine){
    getHTML( baseUrl + termine + " site:youtube.com", function (response) {
        var someElem = document.querySelector( '#video' );
        var someOtherElem = response.querySelector( '#search' );
        if(someOtherElem) {
            myarray = get_all_link(someOtherElem);
            if (!myarray) {
                arrayVideo = null;
                console.log("Ricerca andata male");
                return false;
            }

            someElem.innerHTML = clean_data("Video");
            //Trasformarla in una tabella wordpress
            someElem.classList.add("is-style-stripes");
            someElem.classList.add("wp-block-table");
              arrayVideo = myarray;
            console.log(arrayVideo);
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
            if (!myarray) {
                arrayLink = null;
                console.log("Ricerca andata male");
                return false;
            }

            someElem.innerHTML = clean_data("Link");
            //Trasformarla in una tabella wordpress
            someElem.classList.add("is-style-stripes");
            someElem.classList.add("wp-block-table");

            arrayLink = myarray;

            console.log(arrayLink);
        }else{
            console.log("Ricerca andata male");
        }
    });
}

function RicercaImmagine(termine) {
    let cercare = termine[0];
    if (termine.length > 1) cercare = cercare + termine[1];
    getHTML("https://it.images.search.yahoo.com/search/images;_ylt=AwrJQ4yLIgxg5GEAfqkbDQx.;_ylu=Y29sbwNpcjIEcG9zAzEEdnRpZAMEc2VjA3BpdnM-?p="+cercare+"&fr2=piv-web&fr=sfp", function (response) {
        var someElem = document.querySelector('#image');
        //Trovo tutti i div che contengono le immagini
        var someOtherElem = response.querySelector("#results");
        console.log(someOtherElem);
        if (someOtherElem ) {
            //Prendo l'immagine del primo elemento
            console.log(someOtherElem);
            let image = someOtherElem.getElementsByTagName("img");
            console.log(jQuery(image[0]).attr("data-src") );
            someElem.src = jQuery(image[0]).attr("data-src");
        } else
            console.log("Ricerca andata male");
    });
}

function get_all_link(someOtherElem){
    var classElem = someOtherElem.getElementsByClassName("yuRUbf");
    //console.log(classElem);
    var x = []
    for (var i=0; i<classElem.length; i++){
        var links = classElem[i].querySelectorAll("a");
        //console.log(links);
        x.push(links[0]);
    }
    var myarray = []
    for (var i=0; i<maxDocument; i++){
        if (x[i]) var nametext = x[i].textContent;
        else {
            console.log(x[i]);
            continue;
        }
        var cleantext = nametext.replace(/\s+/g, ' ').trim();
        var cleanlink = x[i].href;
        myarray.push([cleantext,cleanlink]);
    }
    return myarray;
}
// generazione link per contenuti: inserimento di pulsanti accept/reject --- default accept -> pulsante reject;
function clean_data(type){
    var table = '<h3>'+type+'</h3><table><thead><th>Name</th><th>Links</th></thead><tbody>';
    for (var i = 0; i < maxDocument; i++) {
        if (!myarray) return table;
        table += '<tr><td>' + myarray[i][0] + '</td><td> <a class="link" href="' + myarray[i][1] + '" target="_blank" >' + myarray[i][1] + '</a>' +

            '</br> <button id="reject" > Reject </button>' +
            '</td></tr>';
    }
    return table;
}

