
jQuery(document).ready( function (){
function readFromDb(param,callback) {
    jQuery.ajax({
        type: "GET",
        url: vars.url,
        data: {
            action : 'read',
            param: param,
            nonce : vars.security
        },
        success: function (data){

            showLessons(JSON.parse(data))
            // fottiti(data)
        }
        // error: function (error) {
        //     // Azioni da eseguire in caso di errore chiamata
        //     console.log("errore");
        //     console.log(error);
        // }
    });
}
// console.log("ok");
// console.log(r)
readFromDb("lezione");

// window.=function(){
//     readFromDb("lezione");
//
//
// }
function showLessons(data) {
    // Azioni da eseguire in caso di successo chiamata
    //TODO: Avvertire l'utente che tutto è andato bene
    console.log("ok");
    // console.log(data);
    // callback();

    let divLezioni=document.getElementById("elencolezioni");

    let ul = document.createElement("ul");
    let br = document.createElement("br");
    // let label = document.createElement("label");
    let button = document.createElement("button");
        // while(divLezioni == null)
        //     divLezioni=document.getElementById("elencolezioni");
    // let deev = document.createElement("div");
    // deev.innerText = "fatto";
    // divLezioni.appendChild(deev);
    // console.log("ookokok");
    let dropdown = document.getElementsByClassName("dropdown")

    console.log(dropdown.item(1).getElementsByClassName("dropdown-content").item(0).getE)
    for(let i=0;i<data.length; i++) {
        let obj = data[i];
        console.log(obj);

        let divLezioni=document.getElementById("elencolezioni");

        let ul = document.createElement("ul");
        let br = document.createElement("br");
        // let label = document.createElement("label");
        let button = document.createElement("button");
        // divLezioni=document.getElementById("elencolezioni");

        ul.innerText = "LEZIONE "+obj.idlezione+" \n Titolo Lezione: "+obj.titolo;
        // // label.innerText = "Anteprima lezione";
        button.innerText = "MODIFICA LEZIONE";
        // ul.appendChild(br);
        // // ul.appendChild(label)
        ul.appendChild(br);
        ul.appendChild(button);
        //
        divLezioni.appendChild(ul);
        // // console.log(obj.titolo);
    //
    }




}
})