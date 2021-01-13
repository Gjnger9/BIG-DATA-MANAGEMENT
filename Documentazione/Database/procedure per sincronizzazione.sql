CREATE DEFINER=`root`@`localhost` PROCEDURE `sync_lesson_to_post`(
	in idlezione int, 
    in wp_post_id int
)
BEGIN
	with lezioneview as (
	select l.titolo as titolo, 
    l.trascrizione as trascrizione, 
    m.nome as materia, 
    arg.nome as argomento, 
    CONCAT(u.nome, ' ', u.cognome) as autore, 
    sc.nome as scuola,
	CONCAT(se.lettera,' ', se.anno) as sezione
    from lezione as l join materia as m on m.idmateria = l.materia_idmateria
        join argomento as arg on m.idmateria = arg.materia_idmateria 
        join lezione as l on cont.lezione_idlezione=l.idlezione
        join sezione as se on se.idsezione = l.sezione_idsezione 
        join scuola as sc on scuola.idscuola=sezione.scuola_idscuola
        join professore as p on p.idprofessore = lezione.professore_idprofessore 
        join utente as u on u.idutente=p.utente_idutente
    where idlezione=@idlezione
),
-- 2 prendiamo i dati che riguardano i contenuti 
contenutoview as(
	select cont.titolo, cont.tipo, cont.percorso
	from contenuto as cont 
	where cont.idlezione=@idlezione
    ) 

UPDATE wp_posts
	SET post_title= (
		
        lezioneview.title
        
        ) ,
        post_content=
        CONCAT(
			-- trascrizione 
            '
            <!-- wp:paragraph --><p>', 
            lezioneview.trascrizione,
            '</p><!-- /wp:paragraph -->',
            '<!-- wp:group -->
			 <div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:paragraph -->
			 <p><strong>ELENCO CONTENUTI</strong></p>
			 <!-- /wp:paragraph --></div></div>
			 <!-- /wp:group -->
			 
			 <!-- wp:columns -->
			 <div class="wp-block-columns"><!-- wp:column {"width":"100%"} -->
			 <div class="wp-block-column" style="flex-basis:100%"><!-- wp:columns {"verticalAlignment":"center"} -->
			 <div class="wp-block-columns are-vertically-aligned-center"><!-- wp:column {"verticalAlignment":"center","width":"100%"} -->
			 <div class="wp-block-column is-vertically-aligned-center" style="flex-basis:100%"><!-- wp:group -->
			 <div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:group -->
			 <div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:columns -->
			 <div class="wp-block-columns"><!-- wp:column {"width":"100%"} -->
			 <div class="wp-block-column" style="flex-basis:100%"></div>
			 <!-- /wp:column --></div>
			 <!-- /wp:columns -->
			 
			 <!-- wp:columns {"align":"full"} -->
			 <div class="wp-block-columns alignfull"><!-- wp:column -->
			 <div class="wp-block-column"><!-- wp:paragraph -->
			 <p>LINKS', 
				(select contenutoview.titolo, contenutoview.percorso
                from contenutoview 
                where tipo='link')
                ,
                ''
            
        )
	where ID=@wp_post_id;



END