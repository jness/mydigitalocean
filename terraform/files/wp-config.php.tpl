<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '{{ MYSQL_DATABASE }}' );

/** MySQL database username */
define( 'DB_USER', '{{ MYSQL_USERNAME }}' );

/** MySQL database password */
define( 'DB_PASSWORD', '{{ MYSQL_PASSWORD }}' );

/** MySQL hostname */
define( 'DB_HOST', '{{ MYSQL_HOST }}' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */

define('AUTH_KEY',         '&S>i$;NHvQ|[QY~DWCok^nMo:T1s_z Auts-|0*8o+a@2+eH%klB)kTx}g7J@-XM');
define('SECURE_AUTH_KEY',  'd6]`+XFG;V+!n,io-C:6+?=~*t=mG$Jab.b$d V`#VO@,QFYNUq~ls.F,i[k=>#j');
define('LOGGED_IN_KEY',    'h]0CH3^L+ed^9XJ^Fioq`xO&D},V5>TMpIW[(To%y0sD1)y~SRNzXm;m*H+`A`qW');
define('NONCE_KEY',        'xtc+$#3o1+5Jo-hkYoB@XAY7FPK}E1gCNZ!S=WDecXt[Y#a&?#>tKM{m~-|jv& c');
define('AUTH_SALT',        'WewEX1kICRN`.Tkf7X3nWcT,/o9&*l%lk:%P{/DgY#|7Cy:k_z-y1uiVL!B7?-qa');
define('SECURE_AUTH_SALT', 'CV/-Es6kDwwP]$n>({@o;M#Y,8GNjQ`{+Z?8llzQ:%*atI!Vsrgf aCkX}WhJuDW');
define('LOGGED_IN_SALT',   '_|-)JY)E7?@KwqhR ~#ku/G+,HMun9jf4nqq:4f6c|F)]-*j^$O.s;V&7?6OwQ9w');
define('NONCE_SALT',       'A]`;lTb ,XtBcI5cS]}u3I.[c]NWww&-KzAM;+;9Yu0Za0Lf[i;8uLIdg;o$-`(U');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
