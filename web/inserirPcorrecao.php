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

        $input = $_REQUEST['IPcorrecao'];

        list($email, $numero, $data_hora, $texto) = explode(",", $input);
    
    
        $sql = "INSERT INTO proposta_de_correcao VALUES (email=:email, nro=:nro, data_hora=:data_hora, texto=:texto);";

        $result = $db->prepare($sql);
        $result->execute([':email' => $email, ':nro' => $numero, ':data_hora' => $data_hora, ':texto' => $texto]);
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
