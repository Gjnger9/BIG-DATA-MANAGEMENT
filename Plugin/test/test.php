<?php

/**
* Plugin Name: Test plugin
* Plugin URI: https://mainwp.com
* Description: This plugin does some stuff with WordPress
* Version: 1.0.0
* Author: Your Name Here
* Author URI: https://mainwp.com
* License: GPL2
*/




if( ! defined ('ABSPATH') ) {
    die;
}

class TestPlugin
{

    function activate()
    {
        add_new_page();       //echo 'questo è un errore';
        //in genere usiamo questa funzione per l'attivazione di connessioni a db o creazione di custom post types (che non useremo)

    }

    function deactivate()
    {

        delete_old_page();
        //echo 'questo è un errore' che non vedremo;

    }

    function uninstall()
    {
    }





}



class Database{
    private $conn;

    //Per inserire i propri dati andare sotto
    public function __construct($servername , $username ,$password)
    {
        $this->conn = mysqli_connect($servername, $username, $password);
        // Check connection
        if (!$this->conn) {
            die("Connection failed: " . mysqli_connect_error());
        }
    }

    public function makeSelect($table){
        $sql = "SELECT * FROM wordpress.".$table;

        $result = mysqli_query($this->conn, $sql);

        $resultArray = array();
        while($row =mysqli_fetch_assoc($result))
        {
            $resultArray[] = $row;
        }

        return json_encode($resultArray);
    }

    //Usata per capire la connessione è stata gia aperta
    public function getConnection(){
        return $this->conn;
    }

    public function closeConnection(){
        mysqli_close($this->conn);
    }

}

function add_last_nav_item($items, $args) {
	$user = wp_get_current_user();
    ;

    //aggiunta elemento plugin con link alla directory del nostro plugin
    $items .= '<li><a id=999 href="'.get_site_url(null,"",null).'/wp-content/plugins/test/pages/next.html?userID='.$user->ID.'&nonce='.wp_create_nonce( 'wp_rest' ).'"> Old Plugin</a></li>';
    $items .= '<li><a id=998 href="'.get_site_url(null,"",null).'/pagina_plugin_new_lesson"> Shortcut Plugin Loris </a></li>';
    $items .= '<li><a id=997 href="'.get_site_url(null,"",null).'/plugin_homepage"> Vai Al Plugin </a></li>';
//non serve che lo mostriamo nella barra dell'indirizzo se riusciamo a darlo al js
//    $items .= '<li><a id=999 href="http://localhost/wordpress/wp-content/plugins/test/pages/next.html">Plugin</a></li>';

    return $items;
}

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
        <div>inserisci cloud word qui</div>
        <!-- /wp:freeform --></div>
    <!-- /wp:column -->

    <!-- wp:column {"verticalAlignment":"top"} -->
    <div class="wp-block-column is-vertically-aligned-top"><!-- wp:freeform -->
        <p>Trascrizione</p>
        <div>inserisci trascrizione qui</div>
        <!-- /wp:freeform -->

        <!-- wp:buttons -->
        <div class="wp-block-buttons"><!-- wp:button -->
            <div class="wp-block-button"><a class="wp-block-button__link">Avvia Ascolto</a></div>
            <!-- /wp:button --></div>
        <!-- /wp:buttons --></div>
    <!-- /wp:column --></div>
<!-- /wp:columns -->

<!-- wp:separator -->
<hr class="wp-block-separator"/>
<!-- /wp:separator -->

<div>
    <h4>Blocco contenuti</h4>
    <div>Inserisci contenuti qui</div>
</div>

<!-- wp:group -->
<div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:buttons -->
    <div class="wp-block-buttons"><!-- wp:button -->
        <div class="wp-block-button"><a class="wp-block-button__link">Annulla</a></div>
        <!-- /wp:button -->

        <!-- wp:button -->
        <div class="wp-block-button"><a class="wp-block-button__link">Salva</a></div>
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
}
/*
function variable_pass()
{
    if (is_single()) {
        wp_register_script(
            'prova',
            get_template_directory_uri() . '/js/hello.js',
            array(),
            null,
            true

        );
    };

    wp_enqueue_script('prova');
    $user = wp_get_current_user();
    $script_params = array(
        'nome' => $user->name,
        'id'=>$user->ID
    );

    wp_localize_script('prova', 'parametri', $script_params);
}

add_action('wp_enqueue_scripts', 'variable_pass');*/

function request($url,$method = 'GET', $argument = []){

    // use key 'http' even if you send the request to https://...
    $options = array(
        'http' => array(
            'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
            'method'  => $method,
            'content' => http_build_query($argument)
        )
    );
    $context  = stream_context_create($options);
    $result = file_get_contents($url, false, $context);
    if ($result === FALSE) {
        return $result;
    }

     return $result;

}


function my_enqueue_scripts() {
    wp_register_script( 'hello', 'http://localhost/wordpress/wp-content/plugins/test/pages/hello.js', array() ); //put any dependencies (including jQuery) into the array
    wp_enqueue_script( 'hello' );

    wp_localize_script( 'hello', 'WP_API_Settings', array(
        'endpoint' => esc_url_raw( rest_url() ),
        'nonce' => wp_create_nonce( 'wp_rest' )
    ) );
}

function enqueue_ajax_script_test()
{
    wp_enqueue_script('jquery');
    wp_enqueue_script( 'script_ajax_test', home_url("") . '/requests.js' );
    wp_localize_script( 'script_ajax_test', 'test_ajax', array(
        'url'      => admin_url( 'admin-ajax.php' ),
        'security' => wp_create_nonce('ajax_test_nonce_string')
    ));
}

function say_hello_test_callback()
{
    check_ajax_referer( 'ajax_test_nonce_string', 'security' );

    //wp_send_json( request("http://localhost:42069/readPersona"), 'GET' );
    $databaseConnection = new Database("localhost", "root", "");
    wp_send_json( $databaseConnection->makeSelect("persona") );
    $databaseConnection->closeConnection();
    die();
}
if (class_exists('TestPlugin')){
    $testPlugin = new TestPlugin();
}

add_filter( 'wp_nav_menu_items', 'add_last_nav_item', 10, 2);
add_action( 'wp_enqueue_scripts', 'my_enqueue_scripts' );

add_action( "wp_enqueue_scripts", "enqueue_ajax_script_test" );
// Utenti autenticati
add_action( 'wp_ajax_nopriv_say_hello_test', 'say_hello_test_callback' );
// Utenti non autenticati
add_action( 'wp_ajax_say_hello_test', 'say_hello_test_callback' );

register_activation_hook(__FILE__, array($testPlugin, 'activate'));
register_activation_hook(__FILE__, array($testPlugin, 'deactivate'));
