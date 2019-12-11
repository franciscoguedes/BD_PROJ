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

        $input = $_REQUEST['Iincidencia'];

        list($anomalia_id, $item_id, $email) = explode(",", $input); 
    
    
        $sql = "INSERT INTO incidencia  VALUES (anomalia_id=:anomalia_id, item_id=:item_id, email=:email);";


        $result = $db->prepare($sql);
        $result->execute([':anomalia_id' => $anomalia_id, ':item_id' => $item_id, ':email' => $email]);
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
