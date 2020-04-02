<?php
header('Content-Type: image/jpg');
$imgid = $_GET['id'];
readfile("img/$imgid.jpg");

?>