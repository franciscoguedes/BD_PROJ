<html>
    <body>
<?php
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist190716";
        $password = "dfud2820";
        $dbname = $user;
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);

        $db->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);

        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $local1 = $_REQUEST['Local1'];
        list($latitude1, $longitude1) = explode(",", $local1);
        $local2 = $_REQUEST['Local2'];
        list($latitude2, $longitude2) = explode(",", $local2);
    
    
        $sql = "SELECT anomalia_id, zona, imagem, lingua, ts, descrição, tem_anomalia_redação FROM (((anomalia JOIN incidencia on anomalia.id = incidencia.anomalia_id)anin JOIN item on item.id = anin.item_id)quase
                NATURAL JOIN local_publico)final WHERE final.latitude BETWEEN latitude1=:latitude1 AND latitude2=:latitude2 AND final.longitude BETWEEN longitude1=:longitude1 AND
                 longitude2=:longitude2) ;";
    
        $result = $db->prepare($sql);
        $result->execute([':latitude1' => $latitude1, ':latitude2' => $latitude2, ':longitude1' => $longitude1, ':longitude2' => $longitude2]);
    
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
            echo("<td>{$row['descricao']}</td>\n");
            echo("<td>{$row['tem_anomalia_redacao']}</td>\n");
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
        
