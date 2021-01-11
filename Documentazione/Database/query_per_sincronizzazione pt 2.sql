-- approccio differente per query sincronizzazione più furbo 
-- creazione del post con i metadati 
-- è opportuno che venga creato in php con la wp_insert_post per coerenza
-- e poi aggiornamento con trascrizione e contenuto 
-- conversione date to gmt : select DATEADD(hour,DATEDIFF (hour, GETDATE(), GETUTCDATE()), 	`MyLocalDateTime`) as GmtDateTime
select * from wp_posts;

UPDATE wp_posts
	SET post_title='' ,
		post_name='',
        post_content=''
	where ID=@postid;