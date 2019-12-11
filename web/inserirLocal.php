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

        $input = $_REQUEST['Ilocal'];

        list($latitude, $longitude, $nome) = explode(",", $input); 
    
    
        $sql = "INSERT INTO local_publico VALUES (latitude=:latitude, longitude=:longitude, nome=:nome);";

        $result = $db->prepare($sql);
        $result->execute([':latitude' => $latitude, ':longitude' => $longitude, ':nome' => $nome]);
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
