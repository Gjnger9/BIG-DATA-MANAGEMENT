<?php
function add_new_page() {
//    $fileNewLesson =  fopen("plugin_new_lesson.html", "r");
//    $filePluginHome = fopen("plugin_home.html", "r");

// = fread($fileNewLesson, filesize("../pages/plugin_new_lesson.html"));
//    $fileContentNewLesson = file_get_contents("plugin_new_lesson.html", false, null, 0, filesize("plugin_new_lesson.html") );
//    $fileContentPluginHome = fread($filePluginHome, filesize("../pages/plugin_home.html"));
//    $linesNewLesson = file("./plugin_new_lesson.html");
//    $htmlNewLesson = implode('', file("plugin_new_lesson.html"));
   $contentNewLesson = '[new_page]';


//   $contentHomepage = '[script][homepage]';
    $contentHomepage = '[homepage]';

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