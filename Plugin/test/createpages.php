<?php
function add_new_page() {
//    $fileNewLesson =  fopen("plugin_new_lesson.html", "r");
//    $filePluginHome = fopen("plugin_home.html", "r");

// = fread($fileNewLesson, filesize("../pages/plugin_new_lesson.html"));
//    $fileContentNewLesson = file_get_contents("plugin_new_lesson.html", false, null, 0, filesize("plugin_new_lesson.html") );
//    $fileContentPluginHome = fread($filePluginHome, filesize("../pages/plugin_home.html"));
//    $linesNewLesson = file("./plugin_new_lesson.html");
//    $htmlNewLesson = implode('', file("plugin_new_lesson.html"));
   $contentNewLesson = '<!-- wp:columns {"verticalAlignment":"top"} -->
<div class="wp-block-columns are-vertically-aligned-top"><!-- wp:column {"verticalAlignment":"top"} -->
    <div class="wp-block-column is-vertically-aligned-top"><!-- wp:freeform -->
        <p>Cloud Word</p>
        <div id="cloudword" >inserisci cloud word qui</div>
        <!-- /wp:freeform --></div>
    <!-- /wp:column -->

    <!-- wp:column {"verticalAlignment":"top"} -->
    <div class="wp-block-column is-vertically-aligned-top"><!-- wp:freeform -->
        <p>Trascrizione</p>
        <div id="trascrizione">inserisci trascrizione qui</div>
        <!-- /wp:freeform -->

        <!-- wp:buttons -->
        <div class="wp-block-buttons"><!-- wp:button -->
            <div id="toggleReg" class="wp-block-button"><a class="wp-block-button__link">Avvia Ascolto</a></div>
            <!-- /wp:button --></div>
        <!-- /wp:buttons --></div>
    <!-- /wp:column --></div>
<!-- /wp:columns -->

<!-- wp:separator -->
<hr class="wp-block-separator"/>
<!-- /wp:separator -->

<div>
    <h4>Blocco contenuti</h4>
    <div id="pdf"></div>
    <div id="link"></div>
    <div id="video"></div>
</div>

<!-- wp:group -->
<div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:buttons -->
    <div class="wp-block-buttons"><!-- wp:button -->
        <div class="wp-block-button"><a class="wp-block-button__link">Annulla</a></div>
        <!-- /wp:button -->

        <!-- wp:button -->
        <div id="saveButton" class="wp-block-button"><a class="wp-block-button__link">Salva</a></div>
        <!-- /wp:button --></div>
    <!-- /wp:buttons --></div></div>
<!-- /wp:group -->

<!-- wp:paragraph -->
<p></p>
<!-- /wp:paragraph -->';


   $contentHomepage = '<!-- wp:group -->
 <div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:paragraph -->
 <p>Blocco di lezioni</p>
 <!-- /wp:paragraph -->
 
 <!-- wp:group -->
 <div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:group -->
 <div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:paragraph -->
 <p>Elenco Lezioni</p>
 <!-- /wp:paragraph -->
 
 <!-- wp:group -->
 <div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:html -->
 <ul> LEZIONE X 
 <br> Anteprima Lezione
 <br> 
  <button type="button">Modifica Lezione</button> 
 </ul>
 <ul> LEZIONE X 
 <br> Anteprima Lezione
 <br> 
  <button type="button">Modifica Lezione</button> 
 </ul>
 
 <ul> LEZIONE X 
 <br> Anteprima Lezione
 <br> 
  <button type="button">Modifica Lezione</button> 
 </ul>
 <ul> LEZIONE X 
 <br> Anteprima Lezione
 <br> 
  <button type="button">Modifica Lezione</button> 
 </ul>
 </li>
 <!-- /wp:html -->
 
 <!-- wp:paragraph -->
 <p></p>
 <!-- /wp:paragraph --></div></div>
 <!-- /wp:group --></div></div>
 <!-- /wp:group --></div></div>
 <!-- /wp:group -->
 
 <!-- wp:buttons -->
 <div class="wp-block-buttons"><!-- wp:button -->
 <div class="wp-block-button"><a class="wp-block-button__link" href="/wordpress/pagina_plugin_new_lesson">Nuova Lezione</a></div>
 <!-- /wp:button --></div>
 <!-- /wp:buttons --></div></div>
 <!-- /wp:group -->
 
 <!-- wp:paragraph -->
 <p></p>
 <!-- /wp:paragraph -->';

    //aggiunta elemento plugin con link alla directory del nostro plugin
    $postNewLesson = array (
        'post_title' => 'Pagina Plugin Nuova Lezione',
        'post_content' => $contentNewLesson,
        'post_status' => 'publish',
        'post_name' => 'pagina_plugin_new_lesson',
        'post_type' => 'page'
    );
    $postHomepage = array (
        'post_title' => 'Plugin Homepage',
        'post_content' => $contentHomepage,
        'post_status' => 'publish',
        'post_name' => 'plugin_homepage',
        'post_type' => 'page'
    );

//non serve che lo mostriamo nella barra dell'indirizzo se riusciamo a darlo al js
//    $items .= '<li><a id=999 href="http://localhost/wordpress/wp-content/plugins/test/pages/next.html">Plugin</a></li>';

    wp_insert_post($postNewLesson);
    wp_insert_post($postHomepage);
}

function delete_old_page() {

    //todo: eliminazione pagina creata dalla activate
    //get post id
    // wp_post_delete('postid'=...);

    $homepageToDelete = get_page_by_title('Plugin Homepage', $output = OBJECT, 'page');
   wp_delete_post($homepageToDelete->ID, true);
    $newpageToDelete = get_page_by_title('Pagina Plugin Nuova Lezione' , $output = OBJECT, 'page');
    wp_delete_post($newpageToDelete->ID, true);

}