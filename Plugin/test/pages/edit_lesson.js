//popolamento e modifica lezione su edit_lesson_page

var files = null;

var images = [];
function readLezione(param,callback) {
    jQuery.ajax({
        type: "GET",
        url: vars.url,
        data: {
            action : 'read_lezione',
            param: param,
            nonce : vars.security
        },
        success: function (data){
            // console.log(data);
            // console.log(JSON.parse(data));
            //
            // showLessons(JSON.parse(data))
            // fottiti(data)
            modifyLezione(data);
        },
        error: function (error) {
            // Azioni da eseguire in caso di errore chiamata
            console.log("errore");
            console.log(error);
        }
    });
}

function modifyLezioneDb(idlezione,trascrizione, titolo, callback) {
    jQuery.ajax({
        type: "POST",
        url: vars.url,
        data: {
            action : 'update_lezione',
            titolo: titolo,
            idlezione : idlezione,
            trascrizione: trascrizione,
            nonce : vars.security
        },
        success: function (data){
            window.alert("Lezione Modificata Con Successo");
            console.log("MODIFICATO");
            console.log(data);
            // console.log(JSON.parse(data));
            //
            // showLessons(JSON.parse(data))
            // fottiti(data)
            // modifyLezione(data);
        },
         error: function (error) {
        //     // Azioni da eseguire in caso di errore chiamata
             window.alert("Non è stato possibile modificare la lezione");
          //     console.log("errore");
        //     console.log(error);
        // }
    }});
}

function removeLezioneDb(idlezione,callback) {
    jQuery.ajax({
        type: "POST",
        url: vars.url,
        data: {
            action : 'remove_lezione',
            idlezione : idlezione,
            nonce : vars.security
        },
        success: function (data){
            console.log("rimossa lezione "+idlezione);
            console.log(data);
            // console.log(JSON.parse(data));
            //
            // showLessons(JSON.parse(data))
            // fottiti(data)
            // modifyLezione(data);
        }
        // error: function (error) {
        //     // Azioni da eseguire in caso di errore chiamata
        //     console.log("errore");
        //     console.log(error);
        // }
    });
}

function modifyContenutoDb(idcontenuto,titolo,tipo,callback) {
    jQuery.ajax({
        type: "POST",
        url: vars.url,
        data: {
            action : 'update_contenuto',
            idcontenuto : idcontenuto,
            titolo : titolo,
            tipo : tipo,
            nonce : vars.security
        },
        success: function (data){
            console.log("MODIFICATO");
            console.log(data);
            alert("Operazione effettuata con successo");
            // console.log(JSON.parse(data));
            //
            // showLessons(JSON.parse(data))
            // fottiti(data)
            // modifyLezione(data);
        },
        error: function (error) {
            // Azioni da eseguire in caso di errore chiamata
            console.log("errore");
            alert("Operazione fallita: " + error);
            console.log(error);
        }
    });
}


jQuery(document).ready(() =>
{
    if (window.location.pathname!=="/wordpress/edit_lesson_page/") {
        return;
    }
    //recupero dati di modifica lezione dalla pagina
    // console.log("SIAMO DENTROOOO")

    //FOOOOOOOOOTER
    let footer = document.getElementById("footer");
    if (footer) footer.hidden = true;
    //FOOOOOOOOOTER
    var files;

    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const idLezione = urlParams.get('id');
    readLezione(idLezione);

    console.log(idLezione)



})

function modifyLezione(data){

    // console.log("OK")
    // console.log(lezione)
    // console.log(data);
    let lezione = JSON.parse(data[0])[0];
    if(lezione == null) {
        console.log("NULL")
        alert("La lezione che stai cercando non esiste.")
        window.location.replace(window.location.hostname + "/plugin_homepage");
        return;
    }
    let contenuti = JSON.parse(data[1]);

    let contenutiModificati=[];

    let isOwner = parseInt(lezione.is_owner);


    // getCurrentUser();

    console.log();
    console.log(contenuti);

    let titoloData = lezione.titolo;
    let trascrizioneData = lezione.trascrizione;

    let titoloDiv = document.getElementById("titolo");
    let innerTitoloDiv =  document.createElement("div");
    let trascrizioneDiv = document.getElementById("trascrizione");
    let innerTrascrizioneDiv = document.createElement("div");
    innerTitoloDiv.innerText= titoloData;
    innerTrascrizioneDiv.innerText = trascrizioneData;
    // innerTrascrizioneDiv.contentEditable = true;
    trascrizioneDiv.appendChild(innerTrascrizioneDiv);
    titoloDiv.appendChild(innerTitoloDiv)

    let linkDiv = document.getElementById("link");
    let linkTable = document.createElement("table");
    // linkTable.style = "width: 100%"

    let documentiDiv = document.getElementById("documenti");
    let documentiTable = document.createElement("table");

    let videoDiv = document.getElementById("video");
    let videoTable = document.createElement("table");
    dataArray = [];
    //let imagesdiv = document.getElementById("immagini");

    // let table = document.createElement("table");

    for(let i=0; i<contenuti.length; i++ ){
        let contenuto = contenuti[i];

        // console.log(contenuto);

        if(contenuto.data_accettazione == null){
            continue;
        }
        let DIVPROVA = document.createElement("div");
        let DIV = document.getElementById("content");

        let tr1 = document.createElement("tr");
        // console.log(contenuto.idcontenuto);
        tr1.id = contenuto.idcontenuto;
        let tdl = document.createElement("td");
        let tdr = document.createElement("td");
        let modButton = document.createElement("td");
        let rmButton = document.createElement("td");
        let modificaContenutoButton = document.createElement("button");
        let rimuoviContenutoButton = document.createElement("button");
        modificaContenutoButton.innerText = "Modifica";
        rimuoviContenutoButton.innerText = "Rimuovi";

        //Imposto la dimenzione dei pulsanti
        modificaContenutoButton.style.height = "50px";
        rimuoviContenutoButton.style.height = "50px";
        modificaContenutoButton.style.width = "200px";
        rimuoviContenutoButton.style.width = "200px";

        // checkbox.innerText = "Rimuovi: ";
        tdl.innerText = contenuto.titolo;
        tdl.style.maxWidth= "600px";
        // console.log(contenuto.titolo);
        // tdl.innerText = "CI SONO";
        // tdl.contentEditable = true;
        tdr.innerText = contenuto.percorso;
        tdr.style.maxWidth= "600px";

            // checkbox.appendChild(label);
        tr1.appendChild(tdl);
        tr1.appendChild(tdr);
        if(isOwner ) {

            tdl.contentEditable = true;
            modButton.appendChild(modificaContenutoButton);
            modButton.style.height = "50px";
            rmButton.appendChild(rimuoviContenutoButton);
            rmButton.style.height = "50px";
            tr1.appendChild(modButton);
            tr1.appendChild(rmButton)
        }
        // tr.appendChild(checkbox);


        // console.log(contenuto.tipo);
        switch(contenuto.tipo.split(' ').join('')) {

            case "link":
                linkTable.appendChild(tr1);


                break;
            case "documento":
                documentiTable.appendChild(tr1);

                break;
            case "video":
                videoTable.appendChild(tr1);

                break;
            case "immagine" :

                //abbiamo la serie di immagini in array
                dataArray.push (contenuto.percorso);
                console.log(dataArray);
            default:
                break;
        }




        modificaContenutoButton.onclick = function (){

            var confirm = window.confirm("Vuoi aggiornare il contenuto?");
            if(confirm) {



                let titolo = tdl.innerText;
                modifyContenutoDb(contenuto.idcontenuto, titolo, "update");
            }
        }

        rimuoviContenutoButton.onclick = function (){

            var confirm = window.confirm("Vuoi rimuovere il contenuto?");
            if(confirm) {


                let titolo = tdl.innerText;

                modifyContenutoDb(contenuto.idcontenuto, titolo, "remove");

                var parent = this.parentNode.parentNode;
                parent.parentNode.removeChild(parent);
            }
        }
        // DIVPROVA.innerText = contenuto.titolo;
        // DIV.appendChild(DIVPROVA);

    }
    linkTable.style = "width: 100%"

    linkDiv.appendChild(linkTable);
    documentiDiv.appendChild(documentiTable);
    videoDiv.appendChild(videoTable);
   // let   add_Document_button = document.createElement('input');

  //  add_Document_button.type = "file";
 //   add_Document_button.id="input";
    //add_Document_button.multiple="multiple";

    //add_Document_button.className("Btn");
    //add_Document_button.innerText="Aggiungi Documento";
//    add_Document_button.innerText = "Aggiungi Contenuto";

 //  videoDiv.appendChild(add_Document_button);




    let modificaButton = document.getElementById("modifyButton");
    let removeButton = document.getElementById("removeButton");

    if (isOwner){
        innerTitoloDiv.contentEditable = true;
        innerTrascrizioneDiv.contentEditable = true;
        modificaButton.style = "display: inline;";
        removeButton.style = "display: inline;"
    }
    modificaButton.onclick = function (){
        // files =  document.getElementById('input').files;
        // console.log(files);
        // // //va usato un for tradizionale, files è un array associativo
        // // for (file in files ) {
        // //     addContent(lezione.idlezione, file);
        // // }
        //
        // for (let i=0;  i<files.length;  i++){
        //     console.log(files[i]);
        //     //fileAPI per inviare il contenuto del file
        // }


        modifyLezioneDb(lezione.idlezione, innerTrascrizioneDiv.textContent, innerTitoloDiv.textContent);

        // console.log(lezione.idlezione, innerTrascrizioneDiv.textContent)

    }

    removeButton.onclick = function (){

        var confirm = window.confirm("Vuoi davvero rimuovere la lezione?");
        if(confirm) {
            removeLezioneDb(lezione.idlezione);
            window.location.replace(window.location.hostname + "/plugin_homepage")
        }
        // console.log(window.location.hostname)

    }


    jQuery(function () {
        //Questa funione ogni 5 secondi aggiornerà l'immagine
        thisId = 0;

        intervalId = window.setInterval(function () {
            if (dataArray.length != 0) {
                //Aggiorna l'immagine
                jQuery('#image').attr('src', dataArray[thisId]);
                thisId++; //increment data array id
                if (thisId > dataArray.length - 1) thisId = 0; //repeat from start
            } else {
                //Se non ci sono immagini da visualizzare
                console.log("Ancora non ci sono immagini");
            }
        }, 5000);


    });


    // let modificaButton = document.getElementById("modifyButton");
    //
    // modificaButton.onclick = function (){
    //
    //     let trascrizioneMod= innerTrascrizioneDiv.innerText;
    //
    //     // console.log(linkTable.childNodes[0].childNodes[0].innerText);
    //
    //     for (let i=0; i<linkTable.childElementCount; i++){
    //
    //         // let row = linkTable.childNodes[i].childNodes[1].innerText;
    //         let row = linkTable.childNodes[i];
    //         let idcontenuto = row.id;
    //         let titolo = row.childNodes[0].innerText;
    //         // let percorso = row.childNodes[1].innerText;
    //
    //         // console.log(titolo);
    //         // console.log(row);
    //         // console.log(idcontenuto);
    //         let contenutoMod = {
    //             idcontenuto:  idcontenuto,
    //             titolo : titolo,
    //             cancellato : cancellato
    //
    //         }
    //         contenutiModificati.add()
    //
    //     }
    //     for (let i=0; i<documentiTable.childElementCount; i++){
    //
    //         // let row = linkTable.childNodes[i].childNodes[1].innerText;
    //         let row = documentiTable.childNodes[i];
    //         let idcontenuto = row.id;
    //         let titolo = row.childNodes[0].innerText;
    //         // let percorso = row.childNodes[1].innerText;
    //
    //         // console.log(titolo, percorso);
    //         // console.log(row);
    //
    //     }
    //     for (let i=0; i<videoTable.childElementCount; i++){
    //
    //         // let row = linkTable.childNodes[i].childNodes[1].innerText;
    //         let row = videoTable.childNodes[i];
    //         let idcontenuto = row.id;
    //         let titolo = row.childNodes[0].innerText;
    //         // let percorso = row.childNodes[1].innerText;
    //
    //         // console.log(titolo, percorso);
    //         // console.log(row);
    //
    //
    //
    //     }
    //     // console.log(lezione.idlezione);
    //
    //
    // }

    function addContent(idLezione, file) {
        console.log( "yes");
        //files = document.getElementById('input').files;
        console.log("TODO: AGGIUNGERE FILES A LEZIONE   " + idLezione);
        console.log(file);

    }


}

