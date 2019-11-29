<?php
    include_once 'connect.php';

    $input = $_POST['Ritem'];

    $sql = "DELETE FROM item WHERE id='$input';";

    mysqli_query($conn, $sql);

    header("Location: proj1.php");