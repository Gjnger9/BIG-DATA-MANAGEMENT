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


function get_current_user_callback()
{
//    global $_PASSWORD_DB_;
    check_ajax_referer('nonce-requests', 'nonce');
////    if(!wp_verify_nonce($_REQUEST[nonce],'nonce-requests')){
////        die("FOLD");
////    }
//    $param = $_REQUEST['param'];
////        echo "readLEzFiltr Dentro";
//    $databaseConnection = new Database("localhost", "root", $_PASSWORD_DB_);
////
//    wp_send_json($databaseConnection->read_lezioni_filtrate($param));
////
//    $databaseConnection->closeConnection();

    wp_send_json(wp_get_current_user());


    die();
}

function save_callback()
{

    //creazione post di wordpress con inserimento
 
	GLOBAL $wpdb;
    check_ajax_referer( 'ajax_test_nonce_string', 'security' );

    $databaseConnection = new Database( );

    //Per test
    $idprofessore = 1;
    $idutente = 4;
    $idsezione = 1;
    $titolo = "Titolo di prova";
	$idmateria=1;
	$idargomento=1;

	$trascrizione = $_REQUEST['trascrizione'];

	list($lesson_id, $post_id) = $databaseConnection->addLezione(   $idprofessore,   $idsezione, $titolo, $trascrizione, $idmateria, $idargomento );

	//if(!is_null($_REQUEST['links']))
    foreach ($_REQUEST['links'] as &$contenuto) {
        $databaseConnection->addContenuto( $lesson_id, $contenuto[0], $contenuto[1], $idprofessore, "link");
    }
   // if(!is_null($_REQUEST['videos']))
    foreach ($_REQUEST['videos'] as &$contenuto) {
        $databaseConnection->addContenuto( $lesson_id , $contenuto[0], $contenuto[1], $idprofessore, "video");
    }
//	if(!is_null($_REQUEST['documents']))
    foreach ($_REQUEST['documents'] as &$contenuto) {
        $databaseConnection->addContenuto( $lesson_id,  $contenuto[0], $contenuto[1], $idprofessore, "documento");
    }

   $syncsql = "CALL sync_lesson_to_post('$lesson_id' , '$post_id' );";// chiamiamo la procedura di sincronizzazione con gli id del nuovo post e della nuova lezione
   $wpdb->query($syncsql);


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

    $databaseConnection = new Database( );
//        $param = "lezioni";
//    $id_professore = '';
//    if($_REQUEST['param'])
//    $id_professore = $_REQUEST['param'];
    $id_professore = wp_get_current_user()->ID;
//        wp_send_json( "IIIIDDDDD:".$id_professore);
    $data = $databaseConnection->readLezioni($id_professore);
    wp_send_json($data);
//    echo $data;
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

function read_lezione_callback()
{
 
    check_ajax_referer('nonce-requests', 'nonce');
//    if(!wp_verify_nonce($_REQUEST[nonce],'nonce-requests')){
//        die("FOLD");
//    }

    $databaseConnection = new Database();
//        $param = "lezioni";
    $param = $_REQUEST['param'];
//        echo $param;
    wp_send_json($data = $databaseConnection->readLezione($param));
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
function read_contenuto_callback()
{
 
    check_ajax_referer('nonce-requests', 'nonce');
//    if(!wp_verify_nonce($_REQUEST[nonce],'nonce-requests')){
//        die("FOLD");
//    }

    $databaseConnection = new Database( );
//        $param = "lezioni";
    $param = $_REQUEST['param'];
//        echo $param;
    wp_send_json($data = $databaseConnection->readContenuto($param));
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

function read_lezioni_filtrate_callback()
{
 
    check_ajax_referer('nonce-requests', 'nonce');
//    if(!wp_verify_nonce($_REQUEST[nonce],'nonce-requests')){
//        die("FOLD");
//    }
    $param = $_REQUEST['param'];
    $his_own = $_REQUEST['hisOwn'];

//    echo $his_own;

//        echo "readLEzFiltr Dentro";
    $databaseConnection = new Database( );
//
    $id_professore = wp_get_current_user()->ID;
    wp_send_json($databaseConnection->read_lezioni_filtrate($param,$id_professore,$his_own));
//
    $databaseConnection->closeConnection();



    die();
}

function read_argomenti_materia_callback()
{
 
check_ajax_referer('nonce-requests', 'nonce');
//    if(!wp_verify_nonce($_REQUEST[nonce],'nonce-requests')){
//        die("FOLD");
//    }
    $param = $_REQUEST['param'];
//        echo "readLEzFiltr Dentro";
    $databaseConnection = new Database( );
//
    wp_send_json($databaseConnection->read_argomenti_materia($param));
//
    $databaseConnection->closeConnection();



    die();
}

function update_contenuto_callback()
{

    //creazione post di wordpress con inserimento
 

    check_ajax_referer( 'nonce-requests', 'nonce' );

    $databaseConnection = new Database( );
//
//    //Per test
//
//
//    $contenuto = $_REQUEST['param'];
    $idcontenuto = $_REQUEST['idcontenuto'];
    $titolo = $_REQUEST['titolo'];
    $tipo = $_REQUEST['tipo'];
    echo "titolo: " .$titolo ;

     $databaseConnection->updateContenuto($idcontenuto, $titolo,$tipo);
//
//     echo "Ok";



    $databaseConnection->closeConnection();



    die();
}

function update_lezione_callback()
{

    //creazione post di wordpress con inserimento
 

    check_ajax_referer( 'nonce-requests', 'nonce' );

    $databaseConnection = new Database( );
//
//    //Per test
//
//
//    $contenuto = $_REQUEST['param'];
//    $idcontenuto = $_REQUEST['idcontenuto'];
//    $titolo = $_REQUEST['titolo'];
//    $tipo = $_REQUEST['tipo'];
//    echo "titolo: " .$titolo ;
    $idlezione  = $_REQUEST['idlezione'];
    $trascrizione = $_REQUEST['trascrizione'];
//    $idpost = $_REQUEST['idpost'];

//    $databaseConnection->updateLezione($idlezione, $trascrizione,$idpost);
    $databaseConnection->updateLezione($idlezione, $trascrizione);
//
//     echo "Ok";



    $databaseConnection->closeConnection();



    die();
}

function remove_lezione_callback()
{

    //creazione post di wordpress con inserimento


    check_ajax_referer( 'nonce-requests', 'nonce' );

    $databaseConnection = new Database( );
//
//    //Per test
//
//
//    $contenuto = $_REQUEST['param'];
//    $idcontenuto = $_REQUEST['idcontenuto'];
//    $titolo = $_REQUEST['titolo'];
//    $tipo = $_REQUEST['tipo'];
//    echo "titolo: " .$titolo ;
    $idlezione  = $_REQUEST['idlezione'];
//    $trascrizione = $_REQUEST['trascrizione'];
//    $idpost = $_REQUEST['idpost'];

//    $databaseConnection->updateLezione($idlezione, $trascrizione,$idpost);
    $databaseConnection->removeLezione($idlezione);
//
//     echo "Ok";



    $databaseConnection->closeConnection();



    die();
}



function say_hello_test_callback()
{
 
    check_ajax_referer( 'ajax_test_nonce_string', 'security' );

    //wp_send_json( request("http://localhost:42069/readPersona"), 'GET' );
    $databaseConnection = new Database( );
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

add_action( 'wp_ajax_nopriv_read_lezioni_filtrate', 'read_lezioni_filtrate_callback' );
add_action( 'wp_ajax_read_lezioni_filtrate', 'read_lezioni_filtrate_callback' );
add_action( 'wp_ajax_nopriv_read_argomenti_materia', 'read_argomenti_materia_callback' );
add_action( 'wp_ajax_read_argomenti_materia', 'read_argomenti_materia_callback' );
add_action( 'wp_ajax_read_lezione', 'read_lezione_callback' );
add_action( 'wp_ajax_read_contenuto', 'read_contenuto_callback' );
add_action( 'wp_ajax_update_contenuto', 'update_contenuto_callback' );
add_action( 'wp_ajax_update_lezione', 'update_lezione_callback' );
add_action( 'wp_ajax_get_current_user', 'get_current_user_callback' );
add_action( 'wp_ajax_remove_lezione', 'remove_lezione_callback' );