<?php

    include_once 'connect.php';

    $sql = "SELECT * FROM utilizador;";

    mysqli_query($conn, $sql);

    header("Location: proj1.php");