<?php
require_once'WorksVO.php';
//require_once 'include/services/Works.php';
class WorksService {
/**
* save a new 
*
* @param WorksVO $works
* @return string
**/
	function create( $works) 
	{
		//$id = $works->id;
		$title = $works->title;
		$blurb = $works->blurb;
		$tech = $works->tech;
		$url = $works->url;
		$dbh = mysql_connect('localhost', 'root', '');
		$query = "INSERT INTO `Portfolio_sasky10`.`works` (id, title, blurb, tech, url) VALUES (null, '$title', '$blurb', '$tech', '$url')";
		$result = mysql_query($query, $dbh);
		return "working";
	}
/**
* retrieve all s from the database 
*
*
* @return array
**/
	function retrieve() {
		$dbh = mysql_connect('localhost', 'root', '');
		$query = 'SELECT * FROM `Portfolio_sasky10`.`works`';
		$result = mysql_query($query, $dbh);
		$Array = array();
		while ($row = mysql_fetch_array($result)) {
			$Works = new WorksVO();
			$Works->id = $row['id'];
			$Works->title = $row['title'];
			$Works->blurb = $row['blurb'];
			$Works->tech = $row['tech'];
			$Works->url = $row['url'];
			array_push($Array, $Works);
		}
		return $Array;
	}
/**
* update a 
*
* @param Works $Works
* @return null
**/
	function update( $Works) {
		$id = $Works->id;
		$title = $Works->title;
		$blurb = $Works->blurb;
		$tech = $Works->tech;
		$url = $Works->url;
		$dbh = mysql_connect('localhost', 'root', '');
		$query = "UPDATE `Portfolio_sasky10`.`works` SET id = '$id', title = '$title', blurb = '$blurb', tech = '$tech', url = '$url' WHERE id = '$id'";
		$result = mysql_query($query, $dbh);
	}
/**
* delete a  from the database
*
* @param int $id
* @return null
**/
	function delete($id) {
		$dbh = mysql_connect('localhost', 'root', '');
		$query = "DELETE FROM `Portfolio_sasky10`.`works` WHERE id = $id LIMIT 1";
		$result = mysql_query($query,$dbh);
	}
}
?>