<?php
$serveur = 'localhost'; 
$utilisateur = 'root'; 
$motdepasse = ''; 
$basededonnees = 'pfa';

/* Établir la connexion */ 
$connexion = mysqli_connect($serveur, $utilisateur, $motdepasse, $basededonnees); 

if($connexion) { 
    $req = "select * from commissaire";
    $res = mysqli_query($connexion, $req);
    if($res) {
        echo '<table class="table table-striped">';
        echo '<thead><tr>
                <th>ID</th>
                <th>ID Licence</th>
                <th>ID CCR</th>
                <th>ID ASSM</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Téléphone</th>
                <th>Salaire</th>
              </tr></thead>';
        echo '<tbody>';
        
        while($ligne = mysqli_fetch_assoc($res)) {
            echo '<tr>';
            echo '<td>'.$ligne['ID_COM'].'</td>';
            echo '<td>'.$ligne['ID_LIC'].'</td>';
            echo '<td>'.$ligne['ID_CCR'].'</td>';
            echo '<td>'.$ligne['ID_ASSM'].'</td>';
            echo '<td>'.$ligne['NOM_COM'].'</td>';
            echo '<td>'.$ligne['PRENOM_COM'].'</td>';
            echo '<td>'.$ligne['TELEPHONE_COM'].'</td>';
            echo '<td>'.$ligne['SALAIRE_COM'].'</td>';
            echo '</tr>';
        }
        
        echo '</tbody></table>';
    } else {
        echo "Erreur dans la requête";
    }
} else {
    echo "Échec de la connexion à la base de données";
}
?>