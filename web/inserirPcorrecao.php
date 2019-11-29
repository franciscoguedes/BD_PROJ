<html>
    <body>
<?php
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist190701";
        $password = "xxxxxxx";
        $dbname = $user;

        $input = $_REQUEST['IPcorreção'];

        list($email, $numero, $data_hora, $texto) = explode(",", $input);
    
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        $sql = "INSERT INTO proposta_de_correcao VALUES (:email, :nro, :data_hota, :texto);";

        $result = $db->prepare($sql);
        $result->execute([':email' => $email, ':nro' => $numero, ':nome' => $nome]);
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
