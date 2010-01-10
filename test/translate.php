#!/usr/bin/php
<?
  require_once '../encheferizer.php';
  $e = new encheferizer();
  
  $source = fopen( "american-english", "r" );
  $target = fopen( "php-out", "w" );
  
  while ( ! feof( $source ) ) {
      $buffer = fgets( $source, 4096 );
      fwrite( $target, $e->encheferize( $buffer ) );
  }
  fclose( $source );
  fclose( $target );
?>