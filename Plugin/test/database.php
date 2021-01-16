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

	public function read($param)
	{
		$sql = "SELECT * FROM `wordpress`.`" . $param . "`;";


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

    public function read_lezioni_filtrate($param)
    {
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

function create_db () {
    $link = mysqli_connect("localhost", "root", "password");

    $sql  = file_get_contents (ABSPATH."wp-content/plugins/test/create_things.sql"  );


    mysqli_multi_query($link, $sql);

}