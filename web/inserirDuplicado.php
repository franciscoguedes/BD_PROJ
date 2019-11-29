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

        $input = $_REQUEST['Iduplicado'];

        list($item1, $item2) = explode(",", $input);
    
    
        $sql = "INSERT INTO duplicado VALUES (item1=:item1, item2=:item2);";

        $result = $db->prepare($sql);
        $result->execute([':item1' => $item1, ':item2' => $item2]);
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
