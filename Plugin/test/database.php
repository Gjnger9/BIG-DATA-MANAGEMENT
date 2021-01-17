<?php


class Database{
    private $conn;

    //Per inserire i propri dati andare sotto
    public function __construct($servername , $username ,$password)
    {
        $this->conn = mysqli_connect($servername, $username, $password, 'wordpress' );
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



	public function addLezione($idprofessore,  $idsezione, $titolo, $trascrizione, $idmateria, $idargomento){
	    $sql = "INSERT INTO `wordpress`.`lezione` (  `data`, `professore_idprofessore` , `sezione_idsezione`, `titolo`, `trascrizione`,`materia_idmateria`,`argomento_idargomento` ) 
			VALUES
 			(  '". date("Y-m-d H:i:s") ."', '". $idprofessore ."',   '". $idsezione ."', '". $titolo."', '". $trascrizione ."',  " . $idmateria . ",  " . $idargomento. "   );";

	    GLOBAL $wpdb;
		$lesson_id=0;
		$id=0;
        if (mysqli_query($this->conn, $sql)) {

            $newLesson = array (
                'post_title' => $titolo,
                'post_status' => 'publish',
                'post_type' => 'post'
            );

            $id = wp_insert_post($newLesson) ;
            echo "post id " . $id;
            if ( $id ) //id false su fallimento ->  id su successo
            {
/*
	            $num1 = 3;
	            $mum2 = 2;
	            $sql = "  call test_procedure ('$num1' , '$mum2');";
            	*/
                $lesson_id = mysqli_insert_id($this->conn);
	            echo  ' idlezione ' . $lesson_id;
               // $syncsql = "CALL sync_lesson_to_post('$lesson_id' , '$id' );";// chiamiamo la procedura di sincronizzazione con gli id del nuovo post e della nuova lezione
	           //  $wpdb->show_errors(false);
	          //  $wpdb->query($syncsql);
	            //mysqli_query($this->conn, $syncsql);

                $wpdb->query("UPDATE  `wordpress`.`lezione` SET wp_post_id = " . $id . " WHERE idlezione = " . $lesson_id);
			//	mysqli_query($this->conn, "UPDATE  `wordpress`.`lezione` SET wp_post_id = " . $id . " WHERE idlezione = " . $lesson_id);
            } else {
                echo "Lesson created successfully, couldn't sync post";
            }

            echo "New record created successfully";


        } else {

            echo mysqli_error($this->conn);
        }
		return array($lesson_id, $id);
    }

	public function readLezioni($id_professore)
	{
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

		$result = mysqli_query($this->conn, $sql);
//            echo $sql;
		if( !$result ) { // se errore
			die(  mysqli_error( $this->conn ));
		}
		$resultArray = array();
		while ($row = mysqli_fetch_assoc($result)) {
			$resultArray[] = $row;
		}

		return json_encode($resultArray);
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
        $sql = "SELECT * FROM `wordpress`.`lezione` WHERE idlezione =".$param.";";



        $result = mysqli_query($this->conn, $sql);
        $contenuto = $this->readContenuto($param);

        if( !$result ) { // se errore
            die(  mysqli_error( $this->conn ));
        }
        $resultArray = array();
        while ($row = mysqli_fetch_assoc($result)) {
            $resultArray[] = $row;
        }

//        echo $resultArray;

        return array(json_encode($resultArray),$contenuto);
//        return $resultArray;
    }
    public function readContenuto($param)
    {
        $sql = "SELECT * FROM `wordpress`.`contenuto` WHERE lezione_idlezione =".$param.";";


        $result = mysqli_query($this->conn, $sql);

        if( !$result ) { // se errore
            die(  mysqli_error( $this->conn ));
        }
        $resultArray = array();
        while ($row = mysqli_fetch_assoc($result)) {
            $resultArray[] = $row;
        }

        return json_encode($resultArray);
    }

    public function read_lezioni_filtrate($param, $id_professore,$hisOwn)
    {
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
        $owner_sql = "EXISTS (SELECT * FROM wordpress.lezione as l
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
                WHERE ";

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

        if($hisOwn =="true"){
            $sql.= "lez.professore_idprofessore = ".$id_professore." ";
        }else{
            $sql.=" TRUE ";
        }
        $sql.=" AND ";
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
        $result = mysqli_query($db=$this->conn, $sql);
        if(!$result){
            die(mysqli_error($db));
        }
        $resultArray = array();
        while ($row = mysqli_fetch_assoc($result)) {
            $resultArray[] = $row;
        }
//
        return json_encode($resultArray);
//        echo json_encode("okkokokokokokok");
//        die(json_encode($resultArray));

    }



    public function read_argomenti_materia($param)
    {
        if($param!=null) {
            $sql = "SELECT arg.* FROM wordpress.argomento AS arg
                JOIN wordpress.materia AS m ON m.idmateria = arg.materia_idmateria
                WHERE m.nome = '" . $param . "';";
        }else
            $sql = "SELECT * FROM wordpress.argomento";


        $result = mysqli_query($this->conn, $sql);

        $resultArray = array();
        while ($row = mysqli_fetch_assoc($result)) {
            $resultArray[] = $row;
        }

        return json_encode($resultArray);
    }


	public function addContenuto( $lesson_id, $titolo, $percorso, $idprofessore ,$tipo ){
		$sql = "INSERT INTO `wordpress`.`contenuto` ( `lezione_idlezione` , `titolo`, `data_creazione`, `percorso`, `professore_idprofessore`, `tipo`, `data_accettazione`) 
		VALUES ( '".$lesson_id."','". $titolo."', '". date("Y-m-d H:i:s") ."', '". $percorso."', '". $idprofessore ." ' , '".$tipo."', ' ". date("Y-m-d H:i:s") ."')";

		//echo $sql;

		if (mysqli_query($this->conn, $sql)) {
			echo "New record created successfully \n";
		} else {
			echo mysqli_error($this->conn);
		}
	}
    public function updateContenuto( $idcontenuto, $titolo, $tipo="update" ){
        if($tipo == "update")
            $sql = "UPDATE `wordpress`.`contenuto` SET `titolo` = '".$titolo."' WHERE (`idcontenuto` = ".$idcontenuto.");";
        else
            $sql = "UPDATE `wordpress`.`contenuto` SET `data_accettazione` = NULL WHERE (`idcontenuto` = ".$idcontenuto.");";

        echo $sql;

        if (mysqli_query($this->conn, $sql)) {
            echo "New record created successfully";
        } else {
            echo mysqli_error($this->conn);
        }
    }

    public function updateLezione( $idlezione,$trascrizione){
        GLOBAL $wpdb;
        $sql = "UPDATE `wordpress`.`lezione` SET `trascrizione` = '".$trascrizione."' WHERE (`idlezione` = ".$idlezione.");";
        echo $sql;

        if (mysqli_query($this->conn, $sql)) {
            $query_for_id = "SELECT wp_post_id FROM `wordpress`.`lezione` WHERE `idlezione` =".$idlezione." ;";
            $results = $wpdb->get_results($query_for_id);
            $post_id = $results[0]->wp_post_id;
            $syncsql = "CALL sync_lesson_to_post('$idlezione' , '$post_id' );";// chiamiamo la procedura di sincronizzazione con gli id del nuovo post e della nuova lezione
            $wpdb->query($syncsql);
            echo "POstIDio: ". $post_id ."\n";
            echo "New record created successfully";
        } else {
            echo mysqli_error($this->conn);
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