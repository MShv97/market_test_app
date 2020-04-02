<?php
header('Content-Type: application/json');

$servername = "fdb23.awardspace.net";
$username = "3373619_marketdb";
$password = "hlween963";
$dbname = "3373619_marketdb";

// Create connection
$conn = mysqli_connect($servername, $username, $password,$dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$sql = "SELECT * FROM product";
$result = mysqli_query($conn,$sql);

$json_array = array();

$i = "Name";
while($row = mysqli_fetch_assoc($result)){
	$json_array[] = $row;
}
echo json_encode($json_array);


$conn->close();
?>