//popolamento e modifica lezione su edit_lesson_page




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

function modifyLezioneDb(idlezione,trascrizione,callback) {
    jQuery.ajax({
        type: "POST",
        url: vars.url,
        data: {
            action : 'update_lezione',
            idlezione : idlezione,
            trascrizione: trascrizione,
            nonce : vars.security
        },
        success: function (data){
            console.log("MODIFICATO");
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
            // console.log(JSON.parse(data));
            //
            // showLessons(JSON.parse(data))
            // fottiti(data)
            // modifyLezione(data);
        },
        error: function (error) {
            // Azioni da eseguire in caso di errore chiamata
            console.log("errore");
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
    footer.hidden = true;
    //FOOOOOOOOOTER
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const idLezione = urlParams.get('id');
    readLezione(idLezione);

    console.log(idLezione)



})

function modifyLezione(data){

    // console.log("OK")
    // console.log(lezione)
    let lezione = JSON.parse(data[0])[0];
    let contenuti = JSON.parse(data[1]);

    let contenutiModificati=[];

    let isOwner = parseInt(lezione.is_owner);


    // getCurrentUser();

    console.log();
    console.log(contenuti);


    let trascrizioneData = lezione.trascrizione;


    let trascrizioneDiv = document.getElementById("trascrizione");
    let innerTrascrizioneDiv = document.createElement("div");
    innerTrascrizioneDiv.innerText = trascrizioneData;
    // innerTrascrizioneDiv.contentEditable = true;
    trascrizioneDiv.appendChild(innerTrascrizioneDiv);


    let linkDiv = document.getElementById("link");
    let linkTable = document.createElement("table");
    // linkTable.style = "width: 100%"

    let documentiDiv = document.getElementById("documenti");
    let documentiTable = document.createElement("table");

    let videoDiv = document.getElementById("video");
    let videoTable = document.createElement("table");


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
        let tr2 = document.createElement("tr");
        // console.log(contenuto.idcontenuto);
        tr1.id = contenuto.idcontenuto;
        let tdl = document.createElement("td");
        let tdr = document.createElement("td");
        let modificaContenutoButton = document.createElement("button");
        let rimuoviContenutoButton = document.createElement("button");
        modificaContenutoButton.innerText = "Modifica";
        rimuoviContenutoButton.innerText = "Rimuovi";

        // checkbox.innerText = "Rimuovi: ";
        tdl.innerText = contenuto.titolo;
        // console.log(contenuto.titolo);
        // tdl.innerText = "CI SONO";
        // tdl.contentEditable = true;
        tdr.innerText = contenuto.percorso;

            // checkbox.appendChild(label);
        tr1.appendChild(tdl);
        tr1.appendChild(tdr);
        if(isOwner ) {
            tdl.contentEditable = true;
            tr2.appendChild(modificaContenutoButton);
            tr2.appendChild(rimuoviContenutoButton);
        }
        // tr.appendChild(checkbox);


        // console.log(contenuto.tipo);
        switch(contenuto.tipo.split(' ').join('')) {

            case "link":
                linkTable.appendChild(tr1);
                linkTable.appendChild(tr2);


                break;
            case "documento":
                documentiTable.appendChild(tr1);
                documentiTable.appendChild(tr2);

                break;
            case "video":
                videoTable.appendChild(tr1);
                videoTable.appendChild(tr2);

                break;
            default:
                break;
        }


        modificaContenutoButton.onclick = function (){

            let titolo = tdl.innerText;
            modifyContenutoDb(contenuto.idcontenuto,titolo,"update");
        }

        rimuoviContenutoButton.onclick = function (){

            let titolo = tdl.innerText;

            modifyContenutoDb(contenuto.idcontenuto,titolo,"remove");
            location.reload();
        }
        // DIVPROVA.innerText = contenuto.titolo;
        // DIV.appendChild(DIVPROVA);

    }
    linkTable.style = "width: 100%"

    linkDiv.appendChild(linkTable);
    documentiDiv.appendChild(documentiTable);
    videoDiv.appendChild(videoTable);





    let modificaButton = document.getElementById("modifyButton");

    if (isOwner){
        innerTrascrizioneDiv.contentEditable = true;
        modificaButton.style = "display: inline;";
    }
    modificaButton.onclick = function (){

        modifyLezioneDb(lezione.idlezione, innerTrascrizioneDiv.textContent)

        // console.log(lezione.idlezione, innerTrascrizioneDiv.textContent)

    }

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


}

