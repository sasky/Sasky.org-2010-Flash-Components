<?php


error_reporting( E_ALL | E_STRICT );

ini_set( "display_errors", "on" );

require_once 'Zend/Amf/Server.php';
require_once 'include/services/ImagesService.php';
require_once 'include/services/WorksService.php';



// Instantiate the server
$server = new Zend_Amf_Server();

$server->setClass('WorksService');
$server->setClassMap('WorksVO', 'WorksVO');
$server->setClass('ImagesService');
$server->setClassMap('ImagesVO', 'ImagesVO');


$server->setProduction(false);



$response = $server->handle();
echo $response;
?>