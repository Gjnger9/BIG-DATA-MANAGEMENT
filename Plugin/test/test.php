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



//abspath è fino alla root di wordpress
if( ! defined ('ABSPATH') ) {
    die;
}

include 'createpages.php';
include 'database.php';
include 'requestManager.php';
include 'shortcodes.php';


class TestPlugin
{

    function activate()
    {
        add_new_page();       //echo 'questo è un errore';
        //in genere usiamo questa funzione per l'attivazione di connessioni a db o creazione di custom post types (che non useremo)
        create_db();
    }

    function deactivate()
    {

        delete_old_page();
        //echo 'questo è un errore' che non vedremo;

    }

    function uninstall()
    {
        //clear db
    }





}


function add_last_nav_item($items, $args) {
	$user = wp_get_current_user();
    ;

    //aggiunta elemento plugin con link alla directory del nostro plugin
    $items .= '<li><a id=999 href="'.get_site_url(null,"",null).'/wp-content/plugins/test/pages/next.html?userID='.$user->ID.'&nonce='.wp_create_nonce( 'wp_rest' ).'"> Old Plugin</a></li>';
    $items .= '<li><a id=998 href="'.get_site_url(null,"",null).'/pagina_plugin_new_lesson"> Shortcut Plugin Loris </a></li>';
    $items .= '<li><a id=997 href="'.get_site_url(null,"",null).'/plugin_homepage"> Vai Al Plugin </a></li>';
//non serve che lo mostriamo nella barra dell'indirizzo se riusciamo a darlo al js
//    $items .= '<li><a id=999 href="http://localhost/wordpress/wp-content/plugins/test/pages/next.html">Plugin</a></li>';

    return $items;
}

function my_enqueue_scripts() {
    wp_register_script( 'hello', 'http://localhost/wordpress/wp-content/plugins/test/pages/hello.js', array() ); //put any dependencies (including jQuery) into the array
    wp_enqueue_script( 'hello' );

    wp_localize_script( 'hello', 'WP_API_Settings', array(
        'endpoint' => esc_url_raw( rest_url() ),
        'nonce' => wp_create_nonce( 'wp_rest' )
    ) );
}

function enqueue_ajax_script_test()
{
    wp_enqueue_script('jquery');
    wp_enqueue_script('script_ajax_requests', '/wp-content/plugins/test/pages/ajax_query.js');
    wp_enqueue_script( 'script_ajax_test', '/wp-content/plugins/test/pages/requests.js' );
    wp_enqueue_script( 'anychartBase', 'https://cdn.anychart.com/releases/v8/js/anychart-base.min.js"' );
    wp_enqueue_script( 'anychartTagCloud', 'https://cdn.anychart.com/releases/v8/js/anychart-tag-cloud.min.js' );
    wp_enqueue_script( 'webScraper',   '/wp-content/plugins/test/pages/web_scraper.js' );
    wp_enqueue_script( 'trascrizione', '/wp-content/plugins/test/pages/trascrizione.js' );
    wp_localize_script( 'script_ajax_test', 'test_ajax', array(
        'url'      => admin_url( 'admin-ajax.php' ),
        'security' => wp_create_nonce('ajax_test_nonce_string')
    ));
    wp_localize_script('script_ajax_requests', 'vars', array(
        'url'      => admin_url( 'admin-ajax.php' ),
        'security' => wp_create_nonce('nonce-requests')
    ));
}

add_action( "wp_enqueue_scripts", 'enqueue_ajax_script_test' );
add_filter( 'wp_nav_menu_items', 'add_last_nav_item', 10, 2);
add_action( 'wp_enqueue_scripts', 'my_enqueue_scripts' );


add_action('init', 'shortcodes_init');


if (class_exists('TestPlugin')){
    $testPlugin = new TestPlugin();
}
register_activation_hook(__FILE__, array($testPlugin, 'activate'));
register_deactivation_hook(__FILE__, array($testPlugin, 'deactivate'));
