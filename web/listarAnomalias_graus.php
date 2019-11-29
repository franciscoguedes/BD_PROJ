<?php
    include_once 'connect.php';

    $latitude = $_Post['Latitude'];
    $longitude = $_POST['Longitude'];
    $x = $_POST['x'];
    $y = $_Post['y'];
    $maxlatitude = $latitude + $x;
    $minlatitude = $latitude - $x;
    $maxlongitude = $longitude + $y;
    $minlongitude = $longitude - $y;

    $sql = "SELECT anomalia_id, zona, imagem, lingua, ts, descrição, tem_anomalia_redação FROM (anomalia JOIN incidencia on anomalia.id = incidencia.anomalia_id)tabel1 JOIN 
            item on tabel1.item_id = item.id)tabel2 NATURAL JOIN local_publico)final WHERE final.ts > CURRENT_TIMESTAMP - INTERVAL '3 months' AND
            final.latitude BETWEEN $minlatitude AND $maxlatitude AND final.longitude BETWEEN $minlongitude AND $maxlongitude;";

    mysql_query($conn, $sql);

    header("Location: proj1.php");