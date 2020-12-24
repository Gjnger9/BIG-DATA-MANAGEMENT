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
  	

    $items .= '<li><a id=999 href="http://localhost/wordpress/wp-content/plugins/test/pages/next.html?userID='.$user->ID.'">Plugin</a></li>';
  	
  return $items;
}
add_filter( 'wp_nav_menu_items', 'add_last_nav_item', 10, 2);

?>


