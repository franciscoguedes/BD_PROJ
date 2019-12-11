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

        $input = $_REQUEST['EPcorrecao'];

        list($email, $numero, $data_hora, $texto) = explode(",", $input);
    
    
        $sql = "UPDATE proposta_de_correcao SET texto=:texto AND data_hora=:data_hora WHERE email=:email AND nro=:nro;";

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
