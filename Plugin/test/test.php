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
    $items .= '<li><a id=999 href="'.get_site_url(null,"",null).'/wp-content/plugins/test/pages/next.html?userID='.$user->ID.'&nonce='.wp_create_nonce( 'wp_rest' ).'"> Plugin</a></li>';

//non serve che lo mostriamo nella barra dell'indirizzo se riusciamo a darlo al js
//    $items .= '<li><a id=999 href="http://localhost/wordpress/wp-content/plugins/test/pages/next.html">Plugin</a></li>';

    return $items;
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


add_filter( 'wp_nav_menu_items', 'add_last_nav_item', 10, 2);
add_action( 'wp_enqueue_scripts', 'my_enqueue_scripts' );

add_action( "wp_enqueue_scripts", "enqueue_ajax_script_test" );
// Utenti autenticati
add_action( 'wp_ajax_nopriv_say_hello_test', 'say_hello_test_callback' );
// Utenti non autenticati
add_action( 'wp_ajax_say_hello_test', 'say_hello_test_callback' );


