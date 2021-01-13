select * from contenuto;

select CONCAT ( '<a href = " ', GROUP_CONCAT(percorso SEPARATOR  '" > </a>  <br> <a href= " ')) as titoli 
from contenuto 
group by lezione_idlezione;

update wp_posts set post_content = (
select CONCAT ( '<a href = "', percorso , '" >  ', titolo , ' </a> ') 
from contenuto where contenuto.tipo='documento' and lezione_idlezione=2 ) where 
ID=217;

select  GROUP_CONCAT(new_content.links separator "<br>" ) as lin
from ( 
select  CONCAT ( '<a href = "', percorso , '" >  ', titolo , ' </a> ')  as  links
	from contenuto  ) as new_content
	
 ;

-- SUCCESS
with table_content as (
 select  GROUP_CONCAT(new_content.links separator "<br>" ) as allLinks
from ( 
	select  CONCAT ( '<a href = "', percorso , '" >  ', titolo , ' </a> ')  as  links
	from contenuto  ) as new_content
 )
 
-- select *  from table_content;
 update wp_posts set post_content = (select *  from table_content) where ID=217;
 
 
 
 with links_content as (
select  GROUP_CONCAT(new_content.links separator "<br>" ) as allLinks
from ( 
	select  CONCAT ( '<a href = "', percorso , '" >  ', titolo , ' </a> ')  as  links
	from contenuto  
      where contenuto.tipo="link" and contenutolezione_idlezione
    ) as new_content
 )
 
 select *  from links_content;
 update wp_posts set post_content = (select *  from links_content) where ID=217;
 
 
 