
jQuery(document).ready( function (){

    //FOOOOOOOOOTER
    let footer = document.getElementById("footer");
    footer.hidden = true;
    //FOOOOOOOOOTER
    //console.log(window.location.pathname);
    if (window.location.pathname!=="/wordpress/plugin_homepage/") {
        return;
    }


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

                showLessons(JSON.parse(data))

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

                // console.log(JSON.parse(data));
                showLessons(JSON.parse(data),hisOwn)
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


    // console.log("ok");
    // console.log(r)
    // console.log(wp_get_current_user());
    readLezioniFromDb();
    checkFilters();

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
        let materiaValue = null;
        let scuolaValue = null;
        let argomentoValue = null;
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
            // console.log(scuolaValue);
        }
        argomentoDropdown.onchange=function (){
            argomentoValue = argomentoDropdown.value;
            if(argomentoDropdown.selectedIndex===0)
                argomentoValue = null;
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




        let filtraButton = document.getElementById("filtra");

        filtraButton.onclick = function(){
            console.log("filtraggio lezione per : " +materiaValue,scuolaValue,argomentoValue);
            let param = {
                materia: materiaValue,
                scuola: scuolaValue,
                argomento: argomentoValue
            };
            readLezioniFiltrate(param,cb.checked);
            // console.log(cb.checked);
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
            // let label = document.createElement("label");
            let button = document.createElement("button");
            // divLezioni=document.getElementById("elencolezioni");

            ul.innerText = "LEZIONE "+obj.idlezione+" \n Titolo Lezione: "+obj.titolo;
            // // label.innerText = "Anteprima lezione";
            button.innerText = "MODIFICA LEZIONE";
            if(obj.is_owner === "0"){
                button.disabled = true;
            }
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
            ul.appendChild(br);
            ul.appendChild(button);
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
            let option = document.createElement("option");
            option.text = obj.nome;
            dropdown.add(option);
        }

    }

})