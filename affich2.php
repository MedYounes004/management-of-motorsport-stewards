
<?php
$serveur = 'localhost'; 
$utilisateur = 'root'; 
$motdepasse = ''; 
$basededonnees = 'pfa';

/* Établir la connexion */ 
$connexion = mysqli_connect($serveur, $utilisateur, $motdepasse, $basededonnees); 

if($connexion) { 
    $req = "SELECT E.TYPE_EP, COUNT(C.ID_INC) AS NB_INTERVENTIONS
    FROM EPREUVE E
    JOIN CONTENIR C ON E.ID_EP = C.ID_EP
    GROUP BY E.TYPE_EP;
    ";
    $res = mysqli_query($connexion, $req);
    if($res) {
        echo '<table class="table table-striped">';
        echo '<thead><tr>
                
                <th>TYPE_EP</th>
                <th>NB_INTERVENTIONS</th>
              </tr></thead>';
        echo '<tbody>';
        
        while($ligne = mysqli_fetch_assoc($res)) {
            echo '<tr>';
           
            echo '<td>'.$ligne['TYPE_EP'].'</td>';
          echo '<td>'.$ligne['NB_INTERVENTIONS'].'</td>';
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