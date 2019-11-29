<?php
    include_once 'connect.php';

    $input = $_POST['Ranomalia'];

    $sql = "DELETE FROM anomalia WHERE id='$input';";

    mysqli_query($conn, $sql);

    header("Location: proj1.php");