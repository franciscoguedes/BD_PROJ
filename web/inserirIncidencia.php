<?php
    include_once 'connect.php';

    $input = $_Post['Iincidência'];

    list($anomalia_id, $item_id, $email) = explode(",", $input);

    $sql = "INSERT INTO incidencia (anomalia_id, item_id, email) VALUES ('$anomalia_id', '$item_id', '$email');";

    mysql_query($conn, $sql);

    header("Location: proj1.php");