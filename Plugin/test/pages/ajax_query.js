
jQuery(document).ready( function (){

    //FOOOOOOOOOTER
    let footer = document.getElementById("footer");
    if (footer) footer.hidden = true;
    //FOOOOOOOOOTER
    //console.log(window.location.pathname);
    if (window.location.pathname!=="/wordpress/plugin_homepage/") {
        return;
    }

    let newLesson = document.getElementById("/wordpress/pagina_plugin_new_lesson");
    console.log(newLesson)
    if (newLesson) newLesson.onclick = function () {
        window.location = "/wordpress/pagina_plugin_new_lesson"; 
    };

    var currentLessons = [];

    function getCurrentUser(param,callback) {
        jQuery.ajax({
            type: "GET",
            url: vars.url,
            data: {
                action : 'get_current_user',
                // param: param,
                nonce : vars.security
            },
            success: function (data){
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
    function readLezioniFromDb(param,callback) {
        jQuery.ajax({
            type: "GET",
            url: vars.url,
            data: {
                action : 'read',
                // param: param,
                nonce : vars.security
            },
            success: function (data){
                // console.log(data);
                // console.log(JSON.parse(data));

                // showLessons(JSON.parse(data))
                currentLessons = JSON.parse(data);
                console.log(currentLessons);
                showLessons(currentLessons);

            }
            // error: function (error) {
            //     // Azioni da eseguire in caso di errore chiamata
            //     console.log("errore");
            //     console.log(error);
            // }
        });
    }

    function readLezioniFiltrate(param,hisOwn,callback) {
        jQuery.ajax({
            type: "GET",
            url: vars.url,
            data: {
                action : 'read_lezioni_filtrate',
                param: param,
                hisOwn : hisOwn,
                nonce : vars.security
            },
            success: function (data){

                // showLessons(JSON.parse(data))

                console.log(data);
                currentLessons = JSON.parse(data);
                showLessons(currentLessons,hisOwn)
            },
            error: function (error) {
                // Azioni da eseguire in caso di errore chiamata
                console.log("errore");
                console.log(error);
            }
        });
    }

    function argMateria(param,dropdown) {
        jQuery.ajax({
            type: "GET",
            url: vars.url,
            data: {
                action : 'read_argomenti_materia',
                param: param,
                nonce : vars.security
            },
            success: function (data){

                // showLessons(JSON.parse(data))
                // return JSON.parse(data);

                // console.log(JSON.parse(data));
                // showLessons(JSON.parse(data))
                clearDropdown(dropdown,"Argomento");
                fillDropdown(dropdown,JSON.parse(data));
            },
            error: function (error) {
                // Azioni da eseguire in caso di errore chiamata
                console.log("errore");
                console.log(error);
            }
        });
    }

    //todo read sezScuola()
    function sezScuola(param,dropdown) {
        jQuery.ajax({
            type: "GET",
            url: vars.url,
            data: {
                action : 'read_sezioni_scuola',
                param: param,
                nonce : vars.security
            },
            success: function (data){

                // showLessons(JSON.parse(data))
                // return JSON.parse(data);

                // console.log(JSON.parse(data));
                // showLessons(JSON.parse(data))
                clearDropdown(dropdown,"Sezione");
                console.log(JSON.parse(data))
                fillDropdown(dropdown,JSON.parse(data));
            },
            error: function (error) {
                // Azioni da eseguire in caso di errore chiamata
                console.log("errore");
                console.log(error);
            }
        });
    }
    // console.log("ok");
    // console.log(r)
    // console.log(wp_get_current_user());
    readLezioniFromDb();
    // console.log("LEZIONI:");
    // console.log(currentLessons);
    checkFilters();
    // showLessons(currentLessons);

    // window.=function(){
    //     readFromDb("lezione");
    //
    //
    // }

    function checkFilters(){
        let dropdown = document.getElementsByClassName("dropdown");
        let materiaDropdown = dropdown.item(0);
        let scuolaDropdown = dropdown.item(1);
        let argomentoDropdown = dropdown.item(2);
        let sezioneDropdown = dropdown.item(3);
        let materiaValue = null;
        let scuolaValue = null;
        let argomentoValue = null;
        let sezioneValue = null;


        materiaDropdown.onchange=function (){

                materiaValue = materiaDropdown.value;
                if(materiaDropdown.selectedIndex===0)
                    materiaValue = null;
                // console.log(materiaValue);

                // clearDropdown(argomentoDropdown,"Argomento");

                argMateria(materiaValue,argomentoDropdown);


            }
            scuolaDropdown.onchange=function (){
                scuolaValue = scuolaDropdown.value;
                if(scuolaDropdown.selectedIndex===0)
                    scuolaValue = null;


                sezScuola(scuolaValue, sezioneDropdown);
            // console.log(scuolaValue);
        }
        argomentoDropdown.onchange=function (){
            argomentoValue = argomentoDropdown.value;
            if(argomentoDropdown.selectedIndex===0)
                argomentoValue = null;
            // console.log(argomentoValue);
        }

        sezioneDropdown.onchange=function (){
            sezioneValue = sezioneDropdown.value;
            if(sezioneDropdown.selectedIndex===0)
                sezioneValue = null;
            // console.log(argomentoValue);
        }

        let divCheckbox = document.getElementById("checkbox");
        let label = document.createElement("label");
        let cb = document.createElement("input");
        cb.type = "checkbox";
        // cb.name = "checkbox kosadkokdo";
        // cb.value = "kokookokk";

        label.appendChild(cb)
        cb.after("TUE LEZIONI");
        // label.appendChild("ciaociaoc");
        divCheckbox.appendChild(label);

        let divDatePicker = document.getElementById("datepicker");
        let datePickerStart = document.createElement("input");
        let datePickerEnd = document.createElement("input");
        datePickerStart.type = "date";
        datePickerEnd.type = "date";

        let t = document.createElement("table");
        let tr1 = document.createElement("tr");
        let tr2 = document.createElement("tr");
        let td1 = document.createElement("td");
        let td2 = document.createElement("td");

        td1.appendChild(datePickerStart);
        td2.appendChild(datePickerEnd);
        tr1.appendChild(td1);
        tr2.appendChild(td2);
        t.appendChild(tr1);
        t.appendChild(tr2);
        divDatePicker.appendChild(t);
        // divDatePicker.appendChild(datePickerStart);
        // // divDatePicker.appendChild("\n");
        // divDatePicker.appendChild(datePickerEnd);
        datePickerStart.before("DA: ");
        datePickerEnd.before("A: ");

        let filtraButton = document.getElementById("filtra");

        filtraButton.onclick = function(){
            console.log("filtraggio lezione per : " +materiaValue,scuolaValue,argomentoValue);
            let param = {
                materia: materiaValue,
                scuola: scuolaValue,
                argomento: argomentoValue,
                sezione: sezioneValue,
                dataInizio : datePickerStart.value,
                dataFine : datePickerEnd.value
            };
            readLezioniFiltrate(param,cb.checked);

            // console.log(datePickerStart.value==="", datePickerEnd.value);
        }




    }








    function showLessons(data) {
        // Azioni da eseguire in caso di successo chiamata
        //TODO: Avvertire l'utente che tutto è andato bene
        // console.log("ok");
        // console.log(data);
        // callback();

        let divLezioni=document.getElementById("elencolezioni");
        divLezioni.innerHTML="";
        //
        // let ul = document.createElement("ul");
        // let br = document.createElement("br");
        // // let label = document.createElement("label");
        // let button = document.createElement("button");
            // while(divLezioni == null)
            //     divLezioni=document.getElementById("elencolezioni");
        // let deev = document.createElement("div");
        // deev.innerText = "fatto";
        // divLezioni.appendChild(deev);
        // console.log("ookokok");

        for(let i=0;i<data.length; i++) {
            let obj = data[i];
            console.log(obj);

            // let divLezioni=document.getElementById("elencolezioni");

            let ul = document.createElement("ul");
            let br = document.createElement("br");
            let h4 = document.createElement("h4");
            let p = document.createElement("p");
            // let label = document.createElement("label");
            let button = document.createElement("button");
            // divLezioni=document.getElementById("elencolezioni");

            h4.innerText = "LEZIONE: " + obj.titolo;
            p.innerText = obj.trascrizione.substring(0, 140);
            if (obj.trascrizione.length > 140) p.innerText = p.innerText + "...";
            // // label.innerText = "Anteprima lezione";
            button.innerText = "VISUALIZZA DETTAGLI";
            // if(obj.is_owner === "0"){
            //     button.disabled = true;
            // }
            button.onclick=function() {
                console.log(obj.is_owner);
                // if(obj.is_owner !== "0"){
                    window.location = window.location.hostname + "/edit_lesson_page?id=" + obj.idlezione;
                // }else {
                //     console.log("NON SEI IL PROPRIETARIO!");
                //     button.disabled = true;
                // }
            }
                // console.log( window.location.hostname + "/wordpress/edit_lesson_page?id=" + obj.idlezione )
                // window.location = window.location.hostname + "/edit_lesson_page?id=" + obj.idlezione;


            // ul.appendChild(br);
            // // ul.appendChild(label)
            ul.appendChild(h4);
            ul.appendChild(p)
            //ul.appendChild(li);
            ul.appendChild(br);
            ul.appendChild(button);

            ul.style.textAlign = "center";
            ul.style.border = "thin solid black";
            ul.style.padding = "2%";
            //
            divLezioni.appendChild(ul);
            // // console.log(obj.titolo);
        //
        }





    }

    function clearDropdown(dropdown,text){

        for(opt in dropdown.options) {

            dropdown.remove(opt.index);
        }
        var option = document.createElement("option");
        option.text = text;
        dropdown.add(option);

    }

    function fillDropdown(dropdown,data){
        for(let i=0;i<data.length; i++) {
            let obj = data[i];
            console.log(obj);

            let option = document.createElement("option");

            option.id = obj.id;

            option.text = obj.nome;
            console.log(option);
            dropdown.add(option);
        }

    }

    let right = document.getElementById("right-sidebar-inner");
    // right.innerText = "destraaaaaaaaa";
    let dropdown = document.createElement("select");
    dropdown.className = "dropdown";
    //
    let opt1 = document.createElement("option");
    opt1.value = "data";
    opt1.text = "Data";
    let opt2 = document.createElement("option");
    opt2.value = "titolo";
    opt2.text = "Titolo";
    let opt3 = document.createElement("option");
    opt3.value = "sezione";
    opt3.text = "Sezione";

    dropdown.appendChild(opt1);
    dropdown.appendChild(opt2);
    dropdown.appendChild(opt3);
    // let options = ["Data", "Titolo", "Sezione"];
    // fillDropdown(dropdown,options)

    //Se riesce lo mette a destra, altrimenti a sinistra
    if (right) right.appendChild(dropdown);
    else document.getElementsByClassName("left")[0].insertBefore(dropdown, document.getElementsByClassName("left")[0].firstChild);
    dropdown.before("Ordina per:");

    dropdown.onchange=function (){

        console.log(dropdown.value);

        let sortfn;
        switch (dropdown.value){
            case "data":
            sortfn= function (a,b){
                // console.log(a.data- b.data);
                return new Date(b["data"])-new Date(a["data"]);
            };
                break;
            case "titolo":
                sortfn= function (a,b){
                    // console.log(a.titolo.toString()-b.titolo.toString());
                    // return (a.titolo)-(b.titolo);
                    a = a.titolo.toLowerCase();
                    b = b.titolo.toLowerCase();

                    return (a < b) ? -1 : (a > b) ? 1 : 0;
                };
                break;
            case "sezione":
                sortfn= function (a,b){
                    return a.sezione-b.sezione;
                };
                break;
            default:
                break;
        }

        currentLessons.sort(sortfn);
        console.log(currentLessons);

        showLessons(currentLessons);

    }

})