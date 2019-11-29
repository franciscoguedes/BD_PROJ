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

        $input = $_REQUEST['EPcorreção'];

        list($email, $numero, $data_hora, $texto) = explode(",", $input);
    
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        $sql = "UPDATE proposta_de_correcao SET :texto AND :data_hora WHERE :email AND nro;";

        $result = $db->prepare($sql);
        $result->execute([':texto' => $texto,':data_hora' => $data_hora, ':email' => $email, ':nro' => $numero]);
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
