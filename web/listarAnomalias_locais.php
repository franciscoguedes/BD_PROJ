<?php

    include_once 'connect.php';

    $local1 = $_Post['Local1'];
    list($latitude1, $longitude1) = explode(",", $local1);
    $local2 = $_Post['Local2'];
    list($latitude2, $longitude2) = explode(",", $local2);

    $sql = "SELECT anomalia_id, zona, imagem, lingua, ts, descrição, tem_anomalia_redação FROM (anomalia JOIN incidencia on anomalia.id = incidencia.anomalia_id)anin JOIN item on item.id = anin.item_id)quase
            NATURAL JOIN local_publico)final WHERE final.latitude BETWEEN '$latitude1' AND '$latitude2' AND final.longitude BETWEEN '$longitude1' AND
            '$longitude2') ;";

    mysql_query($conn, $sql);

    header("Location: proj1.php");