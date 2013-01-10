<?php
include 'ImagesVO.php';
class ImagesService {
/**
* save a new 
*
* @param  ImagesVO images
* @return null
	
**/
	function create( $images) 
	{
		$works_id = $images->works_id;
		$url = $images->url;
		$dbh = mysql_connect('localhost', 'root', '');
		$query = "INSERT INTO `Portfolio_sasky10`.`images` (works_id, url) VALUES ('$works_id', '$url')";
		$result = mysql_query($query, $dbh);
	}
/**
* retrieve all s from the database 
*
*
* @return array
**/
	function retrieve() 
	{
		$dbh = mysql_connect('localhost', 'root', '');
		$query = 'SELECT * FROM `Portfolio_sasky10`.`images`';
		$result = mysql_query($query, $dbh);
		$Array = array();
		while ($row = mysql_fetch_array($result)) {
			$images = new ImagesVO();
			$images->works_id = $row['works_id'];
			$images->url = $row['url'];
			array_push($Array, $images);
		}
		return $Array;
	}

/**
* delete a  from the database
*
* @param int $id
* @return null
**/
	function delete($id) {
		$dbh = mysql_connect('localhost', 'root', '');
		$query = "DELETE FROM `Portfolio_sasky10`.`images` WHERE id = $id LIMIT 1";
		$result = mysql_query($query,$dbh);
	}
}
?>