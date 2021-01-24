var stopwords = ["", "c'è", "a", "abbastanza", "abbia", "abbiamo", "abbiano", "abbiate", "accidenti", "ad", "adesso", "affinché", "agl", "agli", "ahime", "ahimè", "ai", "al", "alcuna", "alcuni", "alcuno", "all", "alla", "alle", "allo", "allora", "altre", "altri", "altrimenti", "altro", "altrove", "altrui", "anche", "ancora", "anni", "anno", "ansa", "anticipo", "assai", "attesa", "attraverso", "avanti", "avemmo", "avendo", "avente", "aver", "avere", "averlo", "avesse", "avessero", "avessi", "avessimo", "aveste", "avesti", "avete", "aveva", "avevamo", "avevano", "avevate", "avevi", "avevo", "avrai", "avranno", "avrebbe", "avrebbero", "avrei", "avremmo", "avremo", "avreste", "avresti", "avrete", "avrà", "avrò", "avuta", "avute", "avuti", "avuto", "basta", "ben", "bene", "benissimo", "brava", "bravo", "buono", "c", "caso", "cento", "certa", "certe", "certi", "certo", "che", "chi", "chicchessia", "chiunque", "ci", "ciascuna", "ciascuno", "cima", "cinque", "cio", "cioe", "cioè", "circa", "citta", "città", "ciò", "co", "codesta", "codesti", "codesto", "cogli", "coi", "col", "colei", "coll", "coloro", "colui", "come", "cominci", "comprare", "comunque", "con", "concernente", "conclusione", "consecutivi", "consecutivo", "consiglio", "contro", "cortesia", "cos", "cosa", "cosi", "così", "cui", "d", "da", "dagl", "dagli", "dai", "dal", "dall", "dalla", "dalle", "dallo", "dappertutto", "davanti", "degl", "degli", "dei", "del", "dell", "della", "delle", "dello", "dentro", "detto", "deve", "devo", "di", "dice", "dietro", "dire", "dirimpetto", "diventa", "diventare", "diventato", "dopo", "doppio", "dov", "dove", "dovra", "dovrà", "dovunque", "due", "dunque", "durante", "e", "ebbe", "ebbero", "ebbi", "ecc", "ecco", "ed", "effettivamente", "egli", "ella", "entrambi", "eppure", "era", "erano", "eravamo", "eravate", "eri", "ero", "esempio", "esse", "essendo", "esser", "essere", "essi", "ex", "fa", "faccia", "facciamo", "facciano", "facciate", "faccio", "facemmo", "facendo", "facesse", "facessero", "facessi", "facessimo", "faceste", "facesti", "faceva", "facevamo", "facevano", "facevate", "facevi", "facevo", "fai", "fanno", "farai", "faranno", "fare", "farebbe", "farebbero", "farei", "faremmo", "faremo", "fareste", "faresti", "farete", "farà", "farò", "fatto", "favore", "fece", "fecero", "feci", "fin", "finalmente", "finche", "fine", "fino", "forse", "forza", "fosse", "fossero", "fossi", "fossimo", "foste", "fosti", "fra", "frattempo", "fu", "fui", "fummo", "fuori", "furono", "futuro", "generale", "gente", "gia", "giacche", "giorni", "giorno", "giu", "già", "gli", "gliela", "gliele", "glieli", "glielo", "gliene", "grande", "grazie", "gruppo", "ha", "haha", "hai", "hanno", "ho", "i", "ie", "ieri", "il", "improvviso", "in", "inc", "indietro", "infatti", "inoltre", "insieme", "intanto", "intorno", "invece", "io", "l", "la", "lasciato", "lato", "le", "lei", "li", "lo", "lontano", "loro", "lui", "lungo", "luogo", "là", "ma", "macche", "magari", "maggior", "mai", "male", "malgrado", "malissimo", "me", "medesimo", "mediante", "meglio", "meno", "mentre", "mesi", "mezzo", "mi", "mia", "mie", "miei", "mila", "miliardi", "milioni", "minimi", "mio", "modo", "molta", "molti", "moltissimo", "molto", "momento", "mondo", "ne", "negl", "negli", "nei", "nel", "nell", "nella", "nelle", "nello", "nemmeno", "neppure", "nessun", "nessuna", "nessuno", "niente", "no", "noi", "nome", "non", "nondimeno", "nonostante", "nonsia", "nostra", "nostre", "nostri", "nostro", "novanta", "nove", "nulla", "nuovi", "nuovo", "o", "od", "oggi", "ogni", "ognuna", "ognuno", "oltre", "oppure", "ora", "ore", "osi", "ossia", "ottanta", "otto", "paese", "parecchi", "parecchie", "parecchio", "parte", "partendo", "peccato", "peggio", "per", "perche", "perchè", "perché", "percio", "perciò", "perfino", "pero", "persino", "persone", "però", "piedi", "pieno", "piglia", "piu", "piuttosto", "più", "po", "po'", "pochissimo", "poco", "poi", "poiche", "possa", "possedere", "posteriore", "posto", "potrebbe", "preferibilmente", "presa", "press", "prima", "primo", "principalmente", "probabilmente", "promesso", "proprio", "puo", "pure", "purtroppo", "può", "qua", "qualche", "qualcosa", "qualcuna", "qualcuno", "quale", "quali", "qualunque", "quando", "quanta", "quante", "quanti", "quanto", "quantunque", "quarto", "quasi", "quattro", "quel", "quella", "quelle", "quelli", "quello", "quest", "questa", "queste", "questi", "questo", "qui", "quindi", "quinto", "realmente", "recente", "recentemente", "registrazione", "relativo", "riecco", "rispetto", "salvo", "sara", "sarai", "saranno", "sarebbe", "sarebbero", "sarei", "saremmo", "saremo", "sareste", "saresti", "sarete", "sarà", "sarò", "scola", "scopo", "scorso", "se", "secondo", "seguente", "seguito", "sei", "sembra", "sembrare", "sembrato", "sembrava", "sembri", "sempre", "senza", "sette", "si", "sia", "siamo", "siano", "siate", "siete", "sig", "solito", "solo", "soltanto", "sono", "sopra", "soprattutto", "sotto", "spesso", "sta", "stai", "stando", "stanno", "starai", "staranno", "starebbe", "starebbero", "starei", "staremmo", "staremo", "stareste", "staresti", "starete", "starà", "starò", "stata", "state", "stati", "stato", "stava", "stavamo", "stavano", "stavate", "stavi", "stavo", "stemmo", "stessa", "stesse", "stessero", "stessi", "stessimo", "stesso", "steste", "stesti", "stette", "stettero", "stetti", "stia", "stiamo", "stiano", "stiate", "sto", "su", "sua", "subito", "successivamente", "successivo", "sue", "sugl", "sugli", "sui", "sul", "sull", "sulla", "sulle", "sullo", "suo", "suoi", "tale", "tali", "talvolta", "tanto", "te", "tempo", "terzo", "th", "ti", "titolo", "tra", "tranne", "tre", "trenta", "triplo", "troppo", "trovato", "tu", "tua", "tue", "tuo", "tuoi", "tutta", "tuttavia", "tutte", "tutti", "tutto", "uguali", "ulteriore", "ultimo", "un", "una", "uno", "uomo", "va", "vai", "vale", "vari", "varia", "varie", "vario", "verso", "vi", "vicino", "visto", "vita", "voi", "volta", "volte", "vostra", "vostre", "vostri", "vostro", "è"];



function saveRequest(callback, array) {

  //  if (document.getElementById("lessonTitle").value == "Inserire il titolo della lezione" || !document.getElementById("lessonTitle").value) {
    //    console.log("Inserire titolo");
    //    return false;
//    }
//    if (document.getElementsByClassName("dropdown").item(0).value === "Materia") {
//        console.log("Selezionare materia");
//        return false;
//    }
//    if (document.getElementsByClassName("dropdown").item(1).value === "Scuola") {
//        console.log("Selezionare scuola");
//        return false;
//    }
//    if (document.getElementsByClassName("dropdown").item(2).value === "Argomento") {
//        console.log("Selezionare argomento");
//        return false;
//    }
    jQuery.ajax({
        type: "POST",
        url: test_ajax.url,
        data: {
            action: 'save',
            security: test_ajax.security,
            titolo: array.titolo,
            idmateria: array.idmateria,
            idsezione: array.idsezione,
            annodicorso: array.annodicorso,
            idargomento: array.idargomento,
            newargomento: array.newargomento,
            links: arrayLink,
            videos: arrayVideo,
            documents: arrayDocumenti,
            trascrizione: array.trascrizione

        },
        success: function (data) {
            // Azioni da eseguire in caso di successo chiamata
            //TODO: Avvertire l'utente che tutto è andato bene
            console.log("ok");
            console.log(data);
            callback();
        },
        error: function (error) {
            // Azioni da eseguire in caso di errore chiamata
            console.log("errore");
            console.log(error);
        }
    });
}

jQuery(document).ready(function() {
    if (window.location.pathname!=="/wordpress/pagina_plugin_new_lesson/") {
        return;
    }

    var textarea =document.getElementById("trascrizione");
    var button = document.getElementById("toggleReg");
    var saveButton = document.getElementById("saveButton");
    var cancelButton = document.getElementById("cancelButton");

    console.log(cancelButton);

    button.onclick = toggleStartStop;
    saveButton.onclick = saveToDatabase;
    cancelButton.onclick = resetPage;

   // console.log(stopwords);

    var recognizing;
    var recognition = new webkitSpeechRecognition();
    recognition.continuous = true;
    reset();
    // recognition.onend = reset;
    var result;

    recognition.onresult = function (event) {

        for (var i = event.resultIndex; i < event.results.length; ++i) {
            if (event.results[i].isFinal) {
                // if (textarea.innerHTML == 'inserisci trascrizione qui')
                //     textarea.innerHTML = '';
                textarea.innerHTML += event.results[i][0].transcript + ' ';
            }
        }
        const text = textarea.innerHTML;

        result = text.toLowerCase().split(" ").reduce((hash, word) => {
            if(!stopwords.includes(word)) {
                hash[word] = hash[word] || 0;
                hash[word]++;
            }
            return hash;
        }, {});

        //to be sorted by value
        var keys = Object.keys(result);
        keys.sort(function(a, b) {
            return result[a] - result[b]
        }).reverse();

        console.log(result);
        //sorted words
        console.log(keys);
        //limite alle prime 10 parole da cercare
        Ricerca(keys.slice(0, 10))
        console.log(keys.slice(0, 10));
        searchfield = keys.slice(0,10).toString();
             //
           resetDiv();
              cloud();

    }
    recognition.onend = function (){
        if(recognizing) {
            recognition.stop();
            recognition.start();
        }

    }
    recognition.onaudioend = function () {
        if(recognizing) {
            recognition.stop();
            recognition.start();
        }

    }
    function reset() {
        recognizing = false;
        recognition.stop();
        button.innerHTML = "<a class=\"wp-block-button__link\" rel=\"\"> Avvia Ascolto </a >";
        // document.getElementById("container").innerHTML = "";

    }


    function cloud() {
        anychart.onDocumentReady(function () {

            var data = [];
            for (obj in result) {

                let row = {"x": obj,"value":result[obj]};
                data.push(row)

            }
            console.log(data);


    // create a tag (word) cloud chart
            var chart = anychart.tagCloud(data);
    // set a chart title
            chart.title('Parole più usate')
            // set an array of angles at which the words will be laid out
            chart.angles([0])
            // enable a color range
            chart.colorRange(true);
            // set the color range length
            chart.colorRange().length('80%');
            // display the word cloud chart
            chart.colorRange().labels(false);
            chart.container("cloudword");
            chart.draw();
        });
    }
        function resetDiv() {
            document.getElementById("cloudword").innerHTML = "";
    }

    /*****************************************************************************************
     * 
     *                             BUTTON FUNCTION
     * 
     * ***************************************************************************************/

    function toggleStartStop() {
        if (recognizing) {
            recognition.stop();
            reset();
        } else {
            recognition.start();
            recognizing = true;
            button.innerHTML = "<a class=\"wp-block-button__link\" rel=\"\"> Ferma Ascolto </a >";
        }
    }

    function saveToDatabase() {
        // if (textarea.innerHTML != '') {
        //     console.log(arrayDocumenti);
        //     console.log(arrayVideo);
        //     console.log(arrayLink);
        //     console.log( document.getElementById("trascrizione").innerHTML );
            var lesson = prepareLesson();
            // for (let prop in lesson){
            //     // console.log(lesson[prop]);
            //     if(lesson[prop]==='')
            //         alert("manca "+ prop);
            // }
            // saveRequest(resetPage,lesson);
        // } else {
        //     console.log("error");
        // }
    }


    function resetPage() {
        document.getElementById("trascrizione").innerHTML = '';
        document.getElementById("cloudword").innerHTML = "";
        document.getElementById("link").innerHTML = "";
        document.getElementById("pdf").innerHTML = "";
        document.getElementById("video").innerHTML = "";
        document.getElementById("image").src = "";
        recognition.stop();
        reset();
    }

    function prepareLesson(){

        var canSave = true;

        var titoloInput = document.getElementById("lessonTitle");
        var titolo= titoloInput.value;
        // titoloInput.onchange = titoloInput.style.removeProperty('background');

        // console.log(titolo);


        var dropdowns = document.getElementsByClassName("dropdown");

        var scuolaDropdown = dropdowns["scuola"];
        var idscuola = scuolaDropdown.options[scuolaDropdown.selectedIndex].id
        // scuolaDropdown.onchange = scuolaDropdown.style.removeProperty('background');


        var materiaDropdown = dropdowns["materia"];
        var idmateria = materiaDropdown.options[materiaDropdown.selectedIndex].id




        var sezioneDropdown = dropdowns["sezione"];
        var idsezione = sezioneDropdown.options[sezioneDropdown.selectedIndex].id
        if(sezioneDropdown.selectedIndex!==0)
        var annoDiCorso = sezioneDropdown.options[sezioneDropdown.selectedIndex].value.charAt(0);
        else {
            // sezioneDropdown.style.setProperty('background','#f59393');
            annoDiCorso = '';
        }

        // console.log(annoDiCorso)
        var trascrizioneInput= document.getElementById("trascrizione");
        var trascrizione = trascrizioneInput.innerHTML;
        // console.log(trascrizione)


        var argomentoInput = document.getElementById("argomentotext");
        var argomentoValue = argomentoInput.value;

            // console.log(argomentoinput.style)
        var argomentoList = document.getElementById("argomentolist");
        var idargomento = -1;
        // var newArgomento = '';
        for(let i=0; i<argomentoList.options.length; i++){
            let opt = argomentoList.options[i];
            if(opt.value === argomentoValue){
                // console.log (opt.value, opt.id)
                idargomento = opt.id;
            }
            // console.log(opt)
        }

        if(titolo === '') {
            titoloInput.style.setProperty('background', '#f59393');
            canSave = false;
        }else{
            titoloInput.style.removeProperty('background');
        }
        if(idscuola === '') {
            scuolaDropdown.style.setProperty('background', '#f59393');
            canSave = false;
        }else{
            scuolaDropdown.style.removeProperty('background');
        }
        if(idmateria === '') {
            materiaDropdown.style.setProperty('background', '#f59393');
            canSave = false;
        }else{
            materiaDropdown.style.removeProperty('background');
        }
        if(idsezione === '') {
            sezioneDropdown.style.setProperty('background', '#f59393');
            canSave = false;
        }else{
            sezioneDropdown.style.removeProperty('background');
        }
        if(trascrizione === '') {
            console.log("trascrizione vuotaaaaaa")
            // trascrizioneInput.style.setProperty('background','#f59393');
            canSave = false;
        }
            // else{
        //     trascrizioneInput.style.removeProperty('background');
        // }
        if(argomentoValue === '') {
            argomentoInput.style.setProperty('background', '#f59393');
            canSave = false;
        }else{
            argomentoInput.style.removeProperty('background');
        }


        if(canSave) {
            var lesson = {
                titolo: titolo,
                idmateria: idmateria,
                idsezione: idsezione,
                annodicorso: annoDiCorso,
                idargomento: idargomento,
                newargomento: argomentoValue,
                trascrizione: trascrizione
            }
            saveRequest(resetPage, lesson);
        }else{
            alert("Parametri mancanti o lezione vuota. Prova a cliccare su \"Avvia ascolto\".");
        }
        return null;
    }



    // var argomentoValue = document.getElementById("argomentotext").value;
    // var argomentoList = document.getElementById("argomentolist");

    // argomentoList.onclick = function (){
    //     console.log(argomentoList.options.value);
    // }




})