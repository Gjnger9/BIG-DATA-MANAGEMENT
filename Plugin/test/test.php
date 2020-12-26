<?php

/**
* Plugin Name: Test plugin
* Plugin URI: https://mainwp.com
* Description: This plugin does some stuff with WordPress
* Version: 1.0.0
* Author: Your Name Here
* Author URI: https://mainwp.com
* License: GPL2
*/


function add_last_nav_item($items, $args) {
	$user = wp_get_current_user();

    //aggiunta elemento plugin con link alla directory del nostro plugin
    $items .= '<li><a id=999 href="http://localhost/wordpress/wp-content/plugins/test/pages/next.html?userID='.$user->ID.'&nonce='. wp_create_nonce( 'wp_rest' ).'"> Plugin</a></li>';

//non serve che lo mostriamo nella barra dell'indirizzo se riusciamo a darlo al js
//    $items .= '<li><a id=999 href="http://localhost/wordpress/wp-content/plugins/test/pages/next.html">Plugin</a></li>';

    return $items;
}
/*
function variable_pass()
{
    if (is_single()) {
        wp_register_script(
            'prova',
            get_template_directory_uri() . '/js/hello.js',
            array(),
            null,
            true

        );
    };

    wp_enqueue_script('prova');
    $user = wp_get_current_user();
    $script_params = array(
        'nome' => $user->name,
        'id'=>$user->ID
    );

    wp_localize_script('prova', 'parametri', $script_params);
}

add_action('wp_enqueue_scripts', 'variable_pass');*/
function my_enqueue_scripts() {
    wp_register_script( 'hello', 'http://localhost/wordpress/wp-content/plugins/test/pages/hello.js', array() ); //put any dependencies (including jQuery) into the array
    wp_enqueue_script( 'hello' );

    wp_localize_script( 'hello', 'WP_API_Settings', array(
        'endpoint' => esc_url_raw( rest_url() ),
        'nonce' => wp_create_nonce( 'wp_rest' )
    ) );
}

add_filter( 'wp_nav_menu_items', 'add_last_nav_item', 10, 2);
add_action( 'wp_enqueue_scripts', 'my_enqueue_scripts' );

?>


