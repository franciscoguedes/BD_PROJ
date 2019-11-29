<?php
    include_once 'connect.php';

    $input = $_POST['Rlocal'];

    list($latitude, $longitude) = explode(",", $input);

    $sql = "DELETE FROM local_publico WHERE latitude='$latitude' AND longitude='$longitude';";

    mysqli_query($conn, $sql);

    header("Location: proj1.php");