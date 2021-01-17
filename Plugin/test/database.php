<?php


class Database{
    private $conn ;
    //Per inserire i propri dati andare sotto
    public function __construct($servername , $username ,$password)
    {
        $this->conn = mysqli_connect($servername, $username, $password, 'wordpress' );
        // Check connection
        if (!$this->conn) {
            die("Connection failed: " . mysqli_connect_error());
        }
    }
// ok wpdb
    public function makeSelect($table){
        GLOBAL $wpdb;
    	$sql = "SELECT * FROM wordpress.".$table;

        $result = $wpdb->query($sql, ARRAY_A);

        if(check_error())
        	die($wpdb->last_error);

        return json_encode($result );
    }
//ok wpdb
	public function addLezione($idprofessore,  $idsezione, $titolo, $trascrizione, $idmateria, $idargomento){

	    GLOBAL $wpdb;

		$wpdb->insert(
			'lezione',
			array (
				'data' => date("Y-m-d H:i:s"),
				'professore_idprofessore' => $idprofessore,
				'sezione_idsezione' =>  $idsezione,
				'titolo' => $titolo,
				'trascrizione' => $trascrizione,
				'materia_idmateria' => $idmateria,
				'argomento_idargomento' => $idargomento
			));
		$lesson_id=$wpdb->insert_id;

		if(!check_error()) {

            $newLesson = array (
                'post_title' => $titolo,
                'post_status' => 'publish',
                'post_type' => 'post'
            );

            $id = wp_insert_post($newLesson) ;
            echo "post id " . $id ."\n";
            if ( $id ) //id false su fallimento ->  id su successo
            {

	            echo  ' idlezione ' . $lesson_id . '\n';

                $wpdb->query("UPDATE  `wordpress`.`lezione` SET wp_post_id = " . $id . " WHERE idlezione = " . $lesson_id);

            } else {
                echo "Lesson created successfully, couldn't sync post";
            }

            echo "New record created successfully";


        } else {

           die($wpdb->last_error);
        }

		return array($lesson_id, $id);
    }
//ok wpdb
	public function read($param)
	{
		GLOBAL $wpdb;


		$sql = "SELECT * FROM `wordpress`.`" . $param . "`;";

		//array associativo ritorna praticamente un json, basta fare encode

		$result =$wpdb->get_results($sql, ARRAY_A);

		if(check_error()) //true=c'è errore
			die($wpdb->last_error);
		return json_encode($result);
	}

    public function readLezione($param)
    {

	    GLOBAL $wpdb;
        $sql = "SELECT * FROM `wordpress`.`lezione` WHERE idlezione =".$param.";";


	    $result =$wpdb->get_results($sql, ARRAY_A);
        $contenuto = $this->readContenuto($param);

	    if(check_error()) //true=c'è errore
		    die($wpdb->last_error);


        return array(json_encode($result),$contenuto);

    }
    public function readContenuto($param)
    {
	    GLOBAL $wpdb;
        $sql = "SELECT * FROM `wordpress`.`contenuto` WHERE lezione_idlezione =".$param.";";


	    $result =$wpdb->get_results($sql, ARRAY_A);
	    if(check_error()) //true=c'è errore
		    die($wpdb->last_error);

        return json_encode($result);
    }

    public function read_lezioni_filtrate($param)
    {

    	GLOBAL $wpdb;
//          $param =[
//              "materia" => "matematica",
////              "scuola" => "scuola1",
//              "argomento" => "derivate"
//          ];
//            $materia = $param[0]="matem"
        $sql = "SELECT l.*
                
                FROM `wordpress`.`lezione` AS l
					JOIN `wordpress`.`materia` AS m ON m.idmateria = l.materia_idmateria
                    JOIN `wordpress`.`argomento`AS arg on arg.materia_idmateria = m.idmateria
                   
                    
                    JOIN `wordpress`.`sezione` AS se ON se.idsezione = l.sezione_idsezione
                    JOIN `wordpress`.`scuola` AS sc ON sc.idscuola = se.scuola_idscuola
                WHERE ";

        if(($materia=$param["materia"])!=null){
            $sql.=" m.nome = '".$materia."' ";
        }else{
            $sql.= " TRUE " ;
        }
        $sql.=" AND ";
        if(($scuola=$param["scuola"])!=null){
            $sql.= "sc.nome = '".$scuola."' ";
        }else{
            $sql.= " TRUE " ;
        }
        $sql.=" AND ";
        if(($argomento=$param["argomento"])!=null){
            $sql.=" arg.nome = '".$argomento."' ";
        }else{
            $sql.= " TRUE " ;
        }
        $sql.=";";
//        $sql = "SELECT * FROM `wordpress`.`lezione`;";
//        echo $sql;
	    $result =$wpdb->get_results($sql, ARRAY_A);
	    if(check_error()) //true=c'è errore
		    die($wpdb->last_error);

//
        return json_encode($result);
//        echo json_encode("okkokokokokokok");
//        die(json_encode($resultArray));

    }


//ok wpdb
    public function read_argomenti_materia($param)
    {
    	GLOBAL $wpdb;
        if($param!=null) {
            $sql = "SELECT arg.* FROM wordpress.argomento AS arg
                JOIN wordpress.materia AS m ON m.idmateria = arg.materia_idmateria
                WHERE m.nome = '" . $param . "';";
        }else
            $sql = "SELECT * FROM wordpress.argomento";

	    $result =$wpdb->get_results($sql, ARRAY_A);
	    if(check_error()) //true=c'è errore
		    die($wpdb->last_error);
        return json_encode($result);
    }


	public function addContenuto( $lesson_id, $titolo, $percorso, $idprofessore ,$tipo ){
/*		$sql = "INSERT INTO `wordpress`.`contenuto` ( `lezione_idlezione` , `titolo`, `data_creazione`, `percorso`, `professore_idprofessore`, `tipo`, `data_accettazione`)
		VALUES ( '".$lesson_id."','". $titolo."', '". date("Y-m-d H:i:s") ."', '". $percorso."', '". $idprofessore ." ' , '".$tipo."', ' ". date("Y-m-d H:i:s") ."')";

		//echo $sql;*/


		GLOBAL $wpdb;

		$wpdb->insert(
			'contenuto',
			array (
				'lezione_idlezione' =>$lesson_id,
				'titolo' => $titolo,
				'data_creazione' => date("Y-m-d H:i:s") ,
				'percorso' =>  $percorso,
				'professore_idprofessore' => $idprofessore,
				'tipo' => $tipo,
				'data_accettazione' => date("Y-m-d H:i:s"),

			));

		if (!check_error()) {
			echo "New content created successfully \n";
		} else {
			echo die("Could not create new content \n");
		}
	}
    public function updateContenuto( $idcontenuto, $titolo, $tipo="update" ){
        if($tipo == "update")
            $sql = "UPDATE `wordpress`.`contenuto` SET `titolo` = '".$titolo."' WHERE (`idcontenuto` = ".$idcontenuto.");";
        else
            $sql = "UPDATE `wordpress`.`contenuto` SET `data_accettazione` = NULL WHERE (`idcontenuto` = ".$idcontenuto.");";

        echo $sql;

        GLOBAL $wpdb;

        $wpdb-> query("$sql") ;

        if (!check_error()) {
            echo "Content  updated successfully \n";

            //sync lesson after every content update
	        $query_for_id = "SELECT l.idlezione as  idlezione, l.wp_post_id as wp_post_id FROM 
							lezione as l join contenuto as c on l.idlezione=c.lezione_idlezione
							WHERE `idcontenuto` =".$idcontenuto."
							LIMIT 1;";
	        $results = $wpdb->get_results($query_for_id);
	        $idlezione = $results[0]->idlezione;
	        $post_id = $results[0]->wp_post_id;
	        $syncsql = "CALL sync_lesson_to_post('$idlezione' , '$post_id' );";// chiamiamo la procedura di sincronizzazione con gli id del nuovo post e della nuova lezione
	        $wpdb->query($syncsql);
	        if (!check_error()) {
		        echo "Lesson synced   successfully \n";
	        } else {
	        	echo "Lesson not synced" . $wpdb->last_error;
	        }
        } else {
            die ("Could not update content \n " . $wpdb->last_error );
        }
    }

    public function updateLezione( $idlezione,$trascrizione){
        GLOBAL $wpdb;
        $sql = "UPDATE `wordpress`.`lezione` SET `trascrizione` = '".$trascrizione."' WHERE (`idlezione` = ".$idlezione.");";
        echo $sql;
		$wpdb->query($sql);

        if (!check_error()) {
            $query_for_id = "SELECT wp_post_id FROM `wordpress`.`lezione` WHERE `idlezione` =".$idlezione." ;";
            $results = $wpdb->get_results($query_for_id);
            $post_id = $results[0]->wp_post_id;
            $syncsql = "CALL sync_lesson_to_post('$idlezione' , '$post_id' );";// chiamiamo la procedura di sincronizzazione con gli id del nuovo post e della nuova lezione
            $wpdb->query($syncsql);
            echo "POstIDio: ". $post_id ."\n";
            echo "New record created successfully";
        } else {
            die($wpdb->last_error);
        }
    }

    //Usata per capire la connessione è stata gia aperta
    public function getConnection(){
        return $this->conn;
    }

    public function closeConnection(){
        mysqli_close($this->conn);
    }

}

//per pagina modifica lezione
function get_lesson_and_contents () {
	$data="";




	return json_encode($data);
}
include 'create_db.php';

function create_db () {
	GLOBAL $_PASSWORD_DB_;
	$_PASSWORD_DB_ = "root";
   // $link = mysqli_connect("localhost", "root", $_PASSWORD_DB_);

	create_db_wpdb();
    // $sql  = file_get_contents (ABSPATH."wp-content/plugins/test/create_procedure.sql"  );



    // mysqli_multi_query($link, $sql);

}
function check_error() {
	GLOBAL $wpdb;
	if ($wpdb->last_error != "") {

		return true;

	} else {

		return false;

	}
}