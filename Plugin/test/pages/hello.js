window.onload=function() {

//console.log(WPAPI); <-esiste, ok
    const queryString = window.location.search;
//console.log(queryString);
//console.log("ci sono!")
    const urlParams = new URLSearchParams(queryString);
    const userID = urlParams.get("userID");
    const nonce = urlParams.get("nonce");
    console.log("User id: " + userID);
    console.log("Nonce: " + nonce)

   // var wp = new WPAPI({endpoint: 'http://localhost/wordpress/wp-json/'});
    var wp = new WPAPI({
        endpoint: 'http://localhost/wordpress/wp-json/',
        nonce: nonce
    });

    var h = document.createElement("h1");
    h.id="hello";
    document.body.appendChild(h);
    //per verificare successivamente le operazioni da fare sull'utente
    var login;

    var user = wp.users().me().get(function(err, data) {
        if(err) {
            console.log(err)
            h.innerHTML =  "Effettua l'accesso per proseguire";
            login=false;
        }
        else {
            console.log(data);
            h.innerHTML = "Hello   " + data.name;
            login=true;
        }

    });

}