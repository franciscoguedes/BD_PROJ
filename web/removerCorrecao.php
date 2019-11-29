<?php
    include_once 'connect.php';

    $input = $_POST['Rcorreção'];

    list($email, $numero, $anomalia_id) = explode(",", $input);

    $sql = "DELETE FROM correcao WHERE email = '$email' AND nro = '$numero' AND anomalia_id = '$anomalia_id';";

    mysqli_query($conn, $sql);

    header("Location: proj1.php");