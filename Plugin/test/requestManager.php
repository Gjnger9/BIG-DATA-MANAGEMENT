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

    $databaseConnection = new Database("localhost", "root", "");

    //Per test
    $idprofessore = 1;
    $idutente = 4;
    $idsezione = 1;
    $titolo = "Titolo di prova";
    $idlezione = rand();

    $trascrizione = $_REQUEST[trascrizione];

    $databaseConnection->addLezione($idlezione,  $idprofessore, $idutente, $idsezione, $titolo, $trascrizione);
    foreach ($_REQUEST[links] as &$contenuto) {
        $databaseConnection->addContenuto(rand(),  $contenuto[0], $contenuto[1], $idprofessore, $idlezione);
    }
    foreach ($_REQUEST[videos] as &$contenuto) {
        $databaseConnection->addContenuto(rand(),  $contenuto[0], $contenuto[1], $idprofessore, $idlezione);
    }
    foreach ($_REQUEST[documents] as &$contenuto) {
        $databaseConnection->addContenuto(rand(),  $contenuto[0], $contenuto[1], $idprofessore, $idlezione);
    }
    $databaseConnection->closeConnection();

    //echo "Links: ".print_r($_REQUEST[links]);
    //echo "Video: ".print_r($_REQUEST[videos]);
    //echo "Documenti: ".print_r($_REQUEST[documents]);
    //echo "Trascrizione: ".print_r($_REQUEST[trascrizione]);

    die();
}

function read_callback()
{
    check_ajax_referer('nonce-requests', 'nonce');
//    if(!wp_verify_nonce($_REQUEST[nonce],'nonce-requests')){
//        die("FOLD");
//    }

    $databaseConnection = new Database("localhost", "root", "password");
//        $param = "lezioni";
    $param = $_REQUEST['param'];
//        echo $param;
    wp_send_json($data = $databaseConnection->read($param));
//    GLOBAL $wpdb;
//    wp_send_json(json_encode($wpdb->get_results("SELECT * from ".$param,OBJECT)));
    $databaseConnection->closeConnection();

    //echo "Links: ".print_r($_REQUEST[links]);
    //echo "Video: ".print_r($_REQUEST[videos]);
    //echo "Documenti: ".print_r($_REQUEST[documents]);
    //echo "Trascrizione: ".print_r($_REQUEST[trascrizione]);
//    wp_send_json( $param);

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

add_action( 'wp_ajax_nopriv_read', 'read_callback' );
add_action( 'wp_ajax_read', 'read_callback' );