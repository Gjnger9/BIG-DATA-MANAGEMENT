<?php

function shortcodes_init() {
    add_shortcode('lessons', 'lessons_shortcode_function');

}
//parametri non credo ci servano  ($atts, $content, $tag)
//https://kinsta.com/it/blog/shortcode-wordpress/  <  tutte le informazioni necessarie qui
function lessons_shortcode_function() {
    //funzione per creare la pagina html con le query
    $output = '<h1>SHORTCODE NE ABBIAMO?'. date("h:i:sa") .  '</h1>';
    return $output;

}

