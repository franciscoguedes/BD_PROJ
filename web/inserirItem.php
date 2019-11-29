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

        $input = $_REQUEST['Iitem'];

        list($id, $descricao, $localizacao, $latitude, $longitude) = explode(",", $input); 
    
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        $sql = "INSERT INTO item VALUES (:id, :descricao, :localizacao, :latitude, :longitude);";
    
        $result = $db->prepare($sql);
        $result->execute([':id' => $id, ':descricao' => $descricao, ':localizacao'=> $localizacao, ':latitude' => $latitude, ':longitude' => $longitude]);
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
