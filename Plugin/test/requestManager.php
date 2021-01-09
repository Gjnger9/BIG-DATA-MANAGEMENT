<?php

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

function save_callback()
{
check_ajax_referer( 'ajax_test_nonce_string', 'security' );

echo "Links: ".print_r($_REQUEST[links]);
echo "Video: ".print_r($_REQUEST[videos]);
echo "Documenti: ".print_r($_REQUEST[documents]);

die();
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

add_action( 'wp_ajax_nopriv_say_hello_test', 'say_hello_test_callback' );
// Utenti non autenticati
add_action( 'wp_ajax_say_hello_test', 'say_hello_test_callback' );
//Salvataggio
// Utenti autenticati
add_action( 'wp_ajax_nopriv_save', 'save_callback' );
// Utenti non autenticati (da cancellare)
add_action( 'wp_ajax_save', 'save_callback' );