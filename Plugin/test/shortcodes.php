<?php

function shortcodes_init() {
    add_shortcode('lessons', 'lessons_shortcode_function');
    add_shortcode('sidebar', 'sidebar_shortcode_function');
    add_shortcode('new_page', 'new_lesson_page_shortcode_function');
//    add_shortcode('script','shortcode_scripts');
    add_shortcode('homepage', 'homepage_shortcode_function');
	add_shortcode('edit_lesson_page', 'edit_lesson_shortcode_function');
}
//parametri non credo ci servano  ($atts, $content, $tag)
//https://kinsta.com/it/blog/shortcode-wordpress/  <  tutte le informazioni necessarie qui
function lessons_shortcode_function() {
    //funzione per creare la pagina html con le query
    $output = '<h1>SHORTCODE NE ABBIAMO? '. date("h:i:sa") .  '</h1>
        <script src="trascrizione.js"></script>';
    return $output;

}

function sidebar_shortcode_function() {


	wp_enqueue_style("style");


    $sidebar = '
        <div id = "sidebar"> 

            <p>  test sidebar    </p>
            
        </div>
    
    
    ';
    $position ='<div style= "position: relative; left:600px">
        '. $sidebar .'
    </div>';

    return $position;

}

function new_lesson_page_shortcode_function () {

	wp_enqueue_style("style");

	$page = '
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        
    <div id = "mainview" class = "row" style="display: table">
      <input type="text" id="lessonTitle" name="l" value="" placeholder="Inserisci il titolo della lezione" style="width: 500px;">
     
     <div  class = "column left" style="background-color:#f5f5f5;" >
     
     
     <!-- wp:search {"label":"Cerca","buttonText":"Cerca"} /-->
     <input type="search" id="wp-block-search__input" class="wp-block-search__input" name="s" value="" placeholder="Cerca" required=""><button type="submit" class="wp-block-search__button ">Cerca</button>
     '.

        create_materia_dropdown() .
        '<br>' .
        create_scuola_dropdown() .
        '<br>' .
        create_argomento_dropdown()
        //codice per creare le liste di filtraggio
        .'
       <button type="submit" class="wp-block-search__button " id="filtra">Filtra</button>
        <div class="wp-block-buttons" style="position: absolute ; bottom: 10px"><!-- wp:button -->
        <div class="wp-block-button"><a class="wp-block-button__link" href="/wordpress/pagina_plugin_new_lesson">Nuova Lezione</a></div>
        <!-- /wp:button --></div>
     
     </div>   
       <div  class = "column right">
        
        <!-- wp:group -->
         <div class="wp-block-group"><div class="wp-block-group__inner-container">
         <!-- wp:columns {"verticalAlignment":"top"} -->
         
                <h4>Trascrizione</h4>
                <div id="trascrizione"></div>
                <!-- /wp:freeform -->
          
                <h4>Cloud Word</h4>
                <div id="cloudword" style="object-fit: cover;width: auto; height: auto;" ></div>

            <!-- /wp:column -->
        
            <!-- wp:column {"verticalAlignment":"top"} -->
        
        
                <!-- wp:buttons -->
                <div class="wp-block-buttons"><!-- wp:button -->
                    <div id="toggleReg" class="wp-block-button"><a class="wp-block-button__link">Avvia Ascolto</a></div>
                    <!-- /wp:button --></div>
       
    
        <!-- /wp:columns -->
        
        <!-- wp:separator -->
        <hr class="wp-block-separator"/>
        <!-- /wp:separator -->
      <!--  <div align="left">
    <form name="ricerca">
        <b>Campo di ricerca</b>
        <input type="text" name="cerca"  id="searchfield">
        <input type="button" value="Cerca" onClick="Ricerca()">

    </form>
</div>-->
        
        <div >
           <h4>Ricerca</h4>
            <div id="pdf"></div>
            <div id="link"></div>
            <div id="video"></div>
        </div>
        
        <!-- wp:group -->
        <div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:buttons -->
            <div class="wp-block-buttons"><!-- wp:button -->
                <div id="cancelButton" class="wp-block-button"><a class="wp-block-button__link">Annulla</a></div>
                <!-- /wp:button -->
        
                <!-- wp:button -->
                <div id="saveButton" class="wp-block-button"><a class="wp-block-button__link">Salva</a></div>
                <!-- /wp:button --></div>
            <!-- /wp:buttons --></div></div>
        <!-- /wp:group --></div></div></div>
';
    return $page;
}

function homepage_shortcode_function () {

	wp_enqueue_style("style");

	$page = '
        <meta name="viewport" content="width=device-width, initial-scale=1">
       
    <div id = "mainview" class = "row" style="display: table">
     
     <div  class = "column left" style="background-color:#f5f5f5;" >
     
     
     <!-- wp:search {"label":"Cerca","buttonText":"Cerca"} /-->
     <input type="search" id="wp-block-search__input" class="wp-block-search__input" name="s" value="" placeholder="Cerca" required=""><button type="submit" class="wp-block-search__button ">Cerca</button>
     ' .

        create_materia_dropdown() .
        '<br>' .
        create_scuola_dropdown() .
        '<br>' .
        create_argomento_dropdown()
      //codice per creare le liste di filtraggio




     .'
        <button type="submit" class="wp-block-search__button " id="filtra">Filtra</button>
        <div class="wp-block-buttons" style="position: absolute ; bottom: 10px"><!-- wp:button -->
        <div class="wp-block-button"><a class="wp-block-button__link" href="/wordpress/pagina_plugin_new_lesson">Nuova Lezione</a></div>
        <!-- /wp:button --></div>
     
     </div>        <!-- my end column -->  
       <div  class = "column right" id="elencolezioni">
        
        </div>     <!-- my end column --> 
    </div>


    ';
    return $page;
}

function edit_lesson_shortcode_function () {

	wp_enqueue_style("style");

	$page = ' <div id="trascrizione">
<p>Trascrizione</p>
</div>

<!-- wp:group -->
<div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:columns {"align":"full"} -->
<div class="wp-block-columns alignfull"><!-- wp:column -->
<div class="wp-block-column"><!-- wp:freeform -->
<div id="link">
<p>Link</p>
</div>
<!-- /wp:freeform --></div>
<!-- /wp:column -->

<!-- wp:column -->
<div class="wp-block-column"><!-- wp:freeform -->
<div id="documenti">
<p>Documenti</p>
<div> </div>
</div>
<!-- /wp:freeform --></div>
<!-- /wp:column -->

<!-- wp:column -->
<div class="wp-block-column"><!-- wp:freeform -->
<div id="video">
<p>Video</p>
</div>
<!-- /wp:freeform --></div>
<!-- /wp:column --></div>
<!-- /wp:columns --></div></div>

<!-- /wp:group -->

<div class="wp-block-buttons"><!-- wp:button -->
<div id="cancelButton" class="wp-block-button"  ><a class="wp-block-button__link"  onclick="history.back()" >Indietro</a></div>
<!-- /wp:button -->

<!-- wp:button -->
<div id="saveButton" class="wp-block-button"><a class="wp-block-button__link">Salva</a></div>
<!-- /wp:button --></div>


' ;

	return $page;

}

function create_materia_dropdown () {
    GLOBAL $wpdb;


    $materia_dropdown ='
     <select style="width: 280px" class="dropdown" name="scuola">
        <option selected="">Materia</option>

        ' ;

    $materie = $wpdb->get_results("SELECT * FROM materia", OBJECT);


    foreach ($materie as $materia) {
        $materia_dropdown.= '<option> '. $materia->nome . '</option>';
    }

    $materia_dropdown.='</select>';

    return $materia_dropdown;
}

function create_scuola_dropdown () {
    GLOBAL $wpdb;


    $scuola_dropdown ='
     <select style="width: 280px" class="dropdown" name="scuola">
        <option selected="">Scuola</option>



      <!--  <div class="dropdown">
          <button class="wp-block-button dropbtn">Scuola</button>

         <div class="dropdown-content">-->
        ' ;

    $scuole = $wpdb->get_results("SELECT * FROM scuola", OBJECT);


    foreach ($scuole as $scuola) {
        $scuola_dropdown.= '<option>'.  $scuola->nome . '</option>';
    }

    $scuola_dropdown.='</select>';

    return $scuola_dropdown;
}

//todo create argomento dropdown

function create_argomento_dropdown () {
    GLOBAL $wpdb;


    $argomento_dropdown ='
          <select style="width: 280px" class="dropdown" name="scuola">
        <option selected="">Argomento</option>

      
        ' ;

    $argomenti = $wpdb->get_results("SELECT * FROM argomento", OBJECT);


    foreach ($argomenti as $argomento) {
        $argomento_dropdown.= '<option> '. $argomento->nome . '</option>';
    }

    $argomento_dropdown.='</select>';

    return $argomento_dropdown;
}

function shortcode_scripts(){

    $script = '<script src= "'.ABSPATH.'"wp-content/plugin/test/pages/ajax_query.js"></script>';
    return $script;

}