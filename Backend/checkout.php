<?php
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

// Takes raw data from the request
$json = file_get_contents('php://input');

// Converts it into a PHP object
$data = json_decode($json);

//UPDATE product SET storage = storage - 1 WHERE product.id = $obj->id;

foreach ($data as $obj) {
       $sql = "UPDATE product SET storage = storage - 1 WHERE product.id = $obj->id;";
       mysqli_query($conn,$sql);
       }


$conn->close();
?>