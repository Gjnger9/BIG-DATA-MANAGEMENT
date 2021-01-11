-- obiettvo: inserire post wordpress 
-- lezione : trascrizione + contenuti / autore + scuola + sezione 
-- 1: prendiamo i dati riguardanti la lezione 
with lezioneview as (
	select l.titolo as titolo, 
    l.trascrizione as trascrizione, 
    m.nome as materia, 
    arg.nome as argomento, 
    CONCAT(u.nome, ' ', u.cognome) as autore, 
    sc.nome as scuola,
	CONCAT(se.lettera,' ', se.anno) as sezione
    -- from lezione as l join materia as m on m.idmateria = l.idmateria
    from materia as m join argomento as arg on m.idmateria = arg.materia_idmateria 
		join aggrega as agg on agg.argomento_idargomento = arg.idargomento 
        join contenuto as cont on cont.idcontenuto = agg.contenuto_idcontenuto 
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
select * 
from  lezioneview
;
-- 3 inseriamo i dati nel post, recuperando l'id di quello inserito 