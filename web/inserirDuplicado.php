<?php
    include_once 'connect.php';

    $input = $_Post['Iduplicado'];

    list($item1, $item2) = explode(",", $input);

    $sql = "INSERT INTO duplicado (item1, item2) VALUES ('$item1', '$item2');";

    mysql_query($conn, $sql);

    header("Location: proj1.php");