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

        $input = $_REQUEST['Icorrecao'];

        list($email, $numero, $anomalia_id) = explode(",", $input); 
    
    
        $sql = "INSERT INTO correcao VALUES (email=:email, nro=:nro, anomalia_id=:anomalia_id);";
    
        $result = $db->prepare($sql);
        $result->execute([':email' => $email, ':nro' => $numero, ':anomalia_id' => $anomalia_id]);
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
