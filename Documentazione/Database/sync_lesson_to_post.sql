CREATE DEFINER=`root`@`localhost` PROCEDURE `sync_lesson_to_post`(
	in idlezione int, 
    in wp_post_id int
)
BEGIN
	with lezioneview as ( 
    select l.titolo as titolo, 
    l.trascrizione as trascrizione, 
    m.nome as materia, 
    group_concat(arg.nome ) as argomento, 
    CONCAT(u.nome, ' ', u.cognome) as autore, 
    sc.nome as scuola,
	CONCAT(se.lettera,' ', se.anno) as sezione
    from lezione as l join materia as m on m.idmateria = l.materia_idmateria
        join argomento as arg on m.idmateria = arg.materia_idmateria 
        join sezione as se on se.idsezione = l.sezione_idsezione 
        join scuola as sc on sc .idscuola=se.scuola_idscuola
        join professore as p on p.idprofessore = l.professore_idprofessore 
        join utente as u on u.idutente=p.utente_idutente
	where l.idlezione= idlezione
    group by l.idlezione
) ,
-- select * from lezioneview;  
 
-- 2 prendiamo i dati che riguardano i contenuti 
htmllinkview as (
		 select  GROUP_CONCAT(new_content.links separator "<br>" ) as allLinks
from ( 
	select  CONCAT ( '<a href = "', percorso , '"  data-type="URL" data-id="link" target="_blank" rel="noreferrer noopener">  ', titolo , ' </a> ')  as  links
	from contenuto  
    where contenuto.tipo="link" and contenuto.lezione_idlezione=idlezione
    ) as new_content
),
htmldocumentoview as (
		 select  GROUP_CONCAT(new_content.links separator "<br>" ) as allLinks
from ( 
	select  CONCAT ( '<a href = "', percorso , '" data-type="URL" data-id="link" target="_blank" rel="noreferrer noopener" >  ', titolo , ' </a> ')  as  links
	from contenuto  
    where contenuto.tipo="documento" and contenuto.lezione_idlezione=idlezione
    ) as new_content
),
htmlvideoview as (
		 select  GROUP_CONCAT(new_content.links separator "<br>" ) as allLinks
from ( 
	select  CONCAT ( '<a href = "', percorso , '" data-type="URL" data-id="link" target="_blank" rel="noreferrer noopener"  >  ', titolo , ' </a> ')  as  links
	from contenuto  
    where contenuto.tipo="video" and contenuto.lezione_idlezione=idlezione
    ) as new_content
)

-- SELECT trascrizione from lezioneview ;
 
UPDATE wp_posts
	SET  post_content=
        CONCAT(
			-- trascrizione 
            '
            <!-- wp:paragraph --><p>', 
            ( select trascrizione from lezioneview) ,
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
			 <p>LINKS </br> ', 
				(select * from htmllinkview)
                ,
                '</p>',
				'<!-- /wp:paragraph --></div>
				 <!-- /wp:column -->
				 
				 <!-- wp:column -->
				 <div class="wp-block-column"><!-- wp:paragraph -->
				 <p>DOCUMENTI </br>',
                 (select * from htmldocumentoview),
                 '</p> ', '<!-- /wp:paragraph --></div>
				 <!-- /wp:column -->
				 
				 <!-- wp:column -->
				 <div class="wp-block-column"><!-- wp:paragraph -->
				 <p>VIDEO </br>',
                 (select * from htmlvideoview), 
                 '</p>' ,
                 ' <!-- /wp:paragraph --></div>
				 <!-- /wp:column --></div>
				 <!-- /wp:columns --></div></div>
				 <!-- /wp:group --></div></div>
				 <!-- /wp:group -->
				</div>
				 <!-- /wp:column --></div>
				 <!-- /wp:columns --></div>
				 <!-- /wp:column --></div>
				 <!-- /wp:columns -->
				 
				 <!-- wp:group -->
				 <div class="wp-block-group"><div class="wp-block-group__inner-container"><!-- wp:paragraph -->
				 <p> Scuola - ', (select scuola from lezioneview), '</br>Classe - ',
                 (select sezione from lezioneview) , '</br>Professore - ',
                 (select autore from lezioneview),
                 '</p>
				 <!-- /wp:paragraph --></div></div><!-- /wp:group -->
                 '
        )
	where ID= wp_post_id;
 
END