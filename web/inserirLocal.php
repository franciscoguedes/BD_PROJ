<html>
    <body>
<?php
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist190701";
        $password = "xxxxxxx";
        $dbname = $user;

        $input = $_REQUEST['Ilocal'];

        list($latitude, $longitude, $nome) = explode(",", $input); 
    
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        $sql = "INSERT INTO local_publico VALUES (:latitude, :longitude, :nome);";

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
