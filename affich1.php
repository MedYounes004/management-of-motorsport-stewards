
<?php
$serveur = 'localhost'; 
$utilisateur = 'root'; 
$motdepasse = ''; 
$basededonnees = 'pfa';

/* Établir la connexion */ 
$connexion = mysqli_connect($serveur, $utilisateur, $motdepasse, $basededonnees); 

if($connexion) { 
    $req = "SELECT ID_EP,TYPE_EP, DATE_DEB_EP, DATE_FIN_EP
    FROM EPREUVE
    ORDER BY DATE_DEB_EP DESC;";
    $res = mysqli_query($connexion, $req);
    if($res) {
        echo '<table class="table table-striped">';
        echo '<thead><tr>
                <th>ID_EP</th>
                <th>TYPE_EP</th>
                <th>DATE_DEB_EP</th>
                <th>DATE_FIN_EP</th>
              </tr></thead>';
        echo '<tbody>';
        
        while($ligne = mysqli_fetch_assoc($res)) {
            echo '<tr>';
            echo '<td>'.$ligne['ID_EP'].'</td>';
            echo '<td>'.$ligne['TYPE_EP'].'</td>';
            echo '<td>'.$ligne['DATE_DEB_EP'].'</td>';
            echo '<td>'.$ligne['DATE_FIN_EP'].'</td>';
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