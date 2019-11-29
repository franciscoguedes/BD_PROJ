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

        $input = $_REQUEST['Ianomalia'];

        list($id, $zona, $imagem, $lingua, $ts, $descricao, $tem_anomalia_redacao) = explode(",", $input); 
    
        $db = new PDO("pgsql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    
        $sql = "INSERT INTO anomalia VALUES (:id, :zona, :imagem, :lingua, :ts, :descricao, :tem_anomalia_redacao);";

    
        $result = $db->prepare($sql);
        $result->execute([':id' => $id, ':zona' => $zona, ':imagem' => $imagem, ':ts' => $ts, ':descricao' => $descricao, ':tem_anomalia_redacao' => $tem_anomalia_redacao]);
    
        $db = null;
    }
    catch (PDOException $e)
    {
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
