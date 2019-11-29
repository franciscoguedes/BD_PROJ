<?php

    include_once 'connect.php';

    $input = $_POST['RPcorreção'];

    list($email, $numero) = explode(",", $input);

    $sql = "DELETE FROM proposta_de_correcao WHERE email = '$email' AND nro= '$numero';";

    mysqli_query($conn, $sql);

    header("Location: proj1.php");