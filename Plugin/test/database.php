<?php


class Database {

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

	public function readLezioni($id_professore)
	{
		GLOBAL $wpdb;
//	    if($id_professore == '')
//		    $sql = "SELECT * FROM `wordpress`.`lezione`;";
//        else
//            $sql = "SELECT *, EXISTS (SELECT * FROM wordpress.lezione AS l
//                JOIN wordpress.professore as p ON l.professore_idprofessore = p.idprofessore
//                JOIN wordpress.utente AS u ON p.utente_idutente = u.idutente
//                JOIN wordpress.wp_users as wp_u ON wp_u.ID = u.idutente
//                JOIN wordpress.wp_posts AS post ON post.post_author = wp_u.ID AND post.ID = l.wp_post_id
//                WHERE l.idlezione = lez.idlezione AND p.idprofessore = ".$id_professore.") as is_owner
//                FROM wordpress.lezione AS lez;";
        $sql="SELECT *, EXISTS (SELECT * FROM wordpress.lezione as l
                join wordpress.professore as p on l.professore_idprofessore = p.idprofessore
                join wordpress.utente as u on u.idutente = p.utente_idutente
                join wordpress.wp_users as wp_u on wp_u.ID = u.wp_id
                where wp_u.ID = ".$id_professore." and l.idlezione = lez.idlezione) as is_owner
                from wordpress.lezione as lez;";

		//array associativo ritorna praticamente un json, basta fare encode

		$result =$wpdb->get_results($sql, ARRAY_A);

		if(check_error()) //true=c'è errore
			die($wpdb->last_error);
		return json_encode($result);
	}

//    public function get_user_by_wp_id($wp_id)
//    {
//        $sql = "SELECT * FROM `wordpress`.`lezione` WHERE idlezione =".$wp_id.";";
//
//
//        $result = mysqli_query($this->conn, $sql);
//        $contenuto = $this->readContenuto($param);
//
//        if( !$result ) { // se errore
//            die(  mysqli_error( $this->conn ));
//        }
//        $resultArray = array();
//        while ($row = mysqli_fetch_assoc($result)) {
//            $resultArray[] = $row;
//        }
//
////        echo $resultArray;
//
//        return array(json_encode($resultArray),$contenuto);
////        return $resultArray;
//    }

    public function readLezione($param)
    {

	    GLOBAL $wpdb;
	   $id_professore = wp_get_current_user()->ID;
        $sql = "SELECT lez.*, EXISTS (SELECT * FROM wordpress.lezione as l
                join wordpress.professore as p on l.professore_idprofessore = p.idprofessore
                join wordpress.utente as u on u.idutente = p.utente_idutente
                join wordpress.wp_users as wp_u on wp_u.ID = u.wp_id
                where wp_u.ID = ".$id_professore." and l.idlezione = lez.idlezione) as is_owner FROM `wordpress`.`lezione`as lez WHERE lez.idlezione =".$param.";";


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

    public function read_lezioni_filtrate($param, $id_professore,$hisOwn)
    {
		//idprofessore è il wp user id
    	GLOBAL $wpdb;
//          $param =[
//              "materia" => "matematica",
////              "scuola" => "scuola1",
//              "argomento" => "derivate"
//          ];
//            $materia = $param[0]="matem"
//        $id_professore =
//        $owner_sql = "EXISTS (SELECT * FROM wordpress.lezione AS l
//                JOIN wordpress.professore as p ON l.professore_idprofessore = p.idprofessore
//                JOIN wordpress.utente AS u ON p.utente_idutente = u.idutente
//                JOIN wordpress.wp_users as wp_u ON wp_u.ID = u.idutente
//                JOIN wordpress.wp_posts AS post ON post.post_author = wp_u.ID AND post.ID = l.wp_post_id
//                WHERE l.idlezione = lez.idlezione AND p.idprofessore = ".$id_professore.") AS is_owner";
/*        $owner_sql = "EXISTS (SELECT * FROM wordpress.lezione as l
                join wordpress.professore as p on l.professore_idprofessore = p.idprofessore
                join wordpress.utente as u on u.idutente = p.utente_idutente
                join wordpress.wp_users as wp_u on wp_u.ID = u.wp_id
                where wp_u.ID = ".$id_professore." and l.idlezione = lez.idlezione) as is_owner
                ";

        $sql = "SELECT lez.*,".$owner_sql. "

                FROM `wordpress`.`lezione` AS lez
					JOIN `wordpress`.`materia` AS m ON m.idmateria = lez.materia_idmateria
                    JOIN `wordpress`.`argomento`AS arg on arg.materia_idmateria = m.idmateria
                    JOIN wordpress.professore as pr on pr.idprofessore = lez.professore_idprofessore

                    JOIN `wordpress`.`sezione` AS se ON se.idsezione = lez.sezione_idsezione
                    JOIN `wordpress`.`scuola` AS sc ON sc.idscuola = se.scuola_idscuola
                WHERE ";*/

//        $sql = "SELECT l.*
//
//                FROM `wordpress`.`lezione` AS l
//					JOIN `wordpress`.`materia` AS m ON m.idmateria = l.materia_idmateria
//                    JOIN `wordpress`.`argomento`AS arg on arg.materia_idmateria = m.idmateria
//
//
//                    JOIN `wordpress`.`sezione` AS se ON se.idsezione = l.sezione_idsezione
//                    JOIN `wordpress`.`scuola` AS sc ON sc.idscuola = se.scuola_idscuola
//                WHERE ";
		//sostituita precedente query con vista
	    $sql= "SELECT * from lesson_to_be_filtered where ";
        if($hisOwn =="true"){
            $sql.= "professore_idprofessore = ".$id_professore." ";
        }else{
            $sql.=" TRUE ";
        }
        $sql.=" AND ";
        if(($materia=$param["materia"])!=null){
            $sql.=" materia = '".$materia."' ";
        }else{
            $sql.= " TRUE " ;
        }
        $sql.=" AND ";
        if(($scuola=$param["scuola"])!=null){
            $sql.= "scuola = '".$scuola."' ";
        }else{
            $sql.= " TRUE " ;
        }
        $sql.=" AND ";
        if(($argomento=$param["argomento"])!=null){
            $sql.=" argomento = '".$argomento."' ";
        }else{
            $sql.= " TRUE " ;
        }
        $sql.=" AND ";
        if($param["dataInizio"]!=null){
            $dataInizio= new DateTime($param["dataInizio"]);
            if($param["dataFine"]!=null) {
                $dataFine = new DateTime($param["dataFine"]);
            }
            else {
                $dataFine = new DateTime(date("Y-m-d"));
            }
                $sql .= " data BETWEEN '" . $dataInizio->format("Y-m-d") . "' AND '" . $dataFine->format("Y-m-d") . "' ";

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

    public function getProfByIDUtente($idUser){
        GLOBAL $wpdb;

        $sql = "SELECT * FROM wordpress.professore WHERE utente_idutente = ".$idUser;
        $result = $wpdb->get_results($sql, ARRAY_A);

        if (!check_error()) {
            echo "Professore trovato";
            return $result;
        } else {
            echo "Professore non trovato";
            die($wpdb->last_error);
        }
    }

    public function getMateriaByName($nomeMateria){
        GLOBAL $wpdb;
        $sql = "SELECT * FROM wordpress.materia WHERE nome = '".$nomeMateria."';";
        $result = $wpdb->get_results($sql, ARRAY_A);

        if (!check_error()) {
            echo "Materia trovata";
            return $result;
        } else {
            echo "Materia non trovata";
            die($wpdb->last_error);
        }
    }

    public function getArgomanetoByName($NomeArgomento){
        GLOBAL $wpdb;
        $sql = "SELECT * FROM wordpress.argomento WHERE nome = '".$NomeArgomento."';";

        $result = $wpdb->get_results($sql, ARRAY_A);

        if (!check_error()) {
            echo "Argomento trovato";
            return $result;
        } else {
            echo "Argomento non trovato";
            die($wpdb->last_error);
        }
    }

    //Usata per capire la connessione è stata gia aperta
    public function getConnection(){
        // return $this->conn;
    }

    public function closeConnection(){
      //  mysqli_close($this->conn);
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