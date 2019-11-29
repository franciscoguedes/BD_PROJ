<?php

    include_once 'connect.php';

    $input = $_POST['EPcorreção'];

    list($email, $numero, $data_hora, $texto) = explode(",", $input);

    $sql = "UPDATE proposta_de_correcao SET texto='$texto' WHERE email='$email' AND nro='$numero';";

    mysqli_query($conn, $sql);
    

    header("Location: proj1.php");