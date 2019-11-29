<html>
    <body>
<?php
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist190716";
        $password = "dfud2820";
        $dbname = $user;

        $db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $latitude = $_REQUEST['Latitude'];
        $longitude = $_REQUEST['Longitude'];
        $x = $_REQUEST['x'];
        $y = $_REQUEST['y'];
        $maxlatitude = $latitude + $x;
        $minlatitude = $latitude - $x;
        $maxlongitude = $longitude + $y;
        $minlongitude = $longitude - $y;
    
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        $sql = "SELECT anomalia_id, zona, imagem, lingua, ts, descrição, tem_anomalia_redação FROM (anomalia JOIN incidencia on anomalia.id = incidencia.anomalia_id)tabel1 JOIN 
            item on tabel1.item_id = item.id)tabel2 NATURAL JOIN local_publico)final WHERE final.ts > CURRENT_TIMESTAMP - INTERVAL '3 months' AND
            final.latitude BETWEEN :minlatitude AND :maxlatitude AND final.longitude BETWEEN :minlongitude AND :maxlongitude;";
    
        $result = $db->prepare($sql);
        $result->execute([':minlatitude' => $minlatitude, ':maxlatitude' => $maxlatitude, ':minlongitude' => $minlongitude, ':maxlongitude' => $maxlongitude]);
    
        echo ("Anomalias");
        echo("<table border=\"0\" cellspacing=\"5\">\n");
        foreach($result as $row)
        {
            echo("<tr>\n");
            echo("<td>{$row['anomalia_id']}</td>\n");
            echo("<td>{$row['zona']}</td>\n");
            echo("<td>{$row['imagem']}</td>\n");
            echo("<td>{$row['lingua']}</td>\n");
            echo("<td>{$row['ts']}</td>\n");
            echo("<td>{$row['descrição']}</td>\n");
            echo("<td>{$row['tem_anomalia_redação']}</td>\n");
            echo("</tr>\n");
        }
        echo("</table>\n");
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
        
