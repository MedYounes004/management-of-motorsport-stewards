<?php 
/* Paramètres de connexion*/
$serveur = 'localhost'; $utilisateur = 'root'; $motdepasse = ''; $basededonnees = 'pfa';
/* Établir la connexion */ 
$connexion = mysqli_connect($serveur, $utilisateur, $motdepasse, $basededonnees); 

// Style CSS intégré
echo '<style>
body {
    font-family: "Segoe UI", Roboto, sans-serif;
    margin: 0;
    padding: 0;
    background: url("https://source.unsplash.com/random/1920x1080/?law,justice") no-repeat center center fixed;
    background-size: cover;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
}

.message-container {
    background-color: rgba(255, 255, 255, 0.95);
    border-radius: 15px;
    padding: 40px 50px;
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.25);
    text-align: center;
    max-width: 500px;
    backdrop-filter: blur(8px);
    border: 1px solid rgba(255, 255, 255, 0.4);
    animation: fadeIn 0.6s ease-out;
    transition: transform 0.3s ease;
}

.message-container:hover {
    transform: translateY(-5px);
}

.message-icon {
    font-size: 48px;
    margin-bottom: 20px;
    color: #4CAF50;
}

.message-container.error .message-icon {
    color: #e74c3c;
}

.message-title {
    font-size: 28px;
    font-weight: 600;
    margin: 0 0 15px;
    color: #333;
}

.message-content {
    font-size: 16px;
    color: #555;
    margin: 0 0 25px;
    line-height: 1.5;
}

.error-details {
    background: rgba(0,0,0,0.05);
    padding: 10px;
    border-radius: 5px;
    margin-top: 15px;
    font-size: 14px;
    color: #666;
    word-break: break-all;
}

.continue-btn {
    background-color: #4CAF50;
    color: white;
    border: none;
    padding: 12px 30px;
    border-radius: 25px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

.message-container.error .continue-btn {
    background-color: #e74c3c;
}

.continue-btn:hover {
    background-color: #45a049;
    transform: scale(1.05);
}

.message-container.error .continue-btn:hover {
    background-color: #c0392b;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsivité */
@media (max-width: 600px) {
    .message-container {
        margin: 20px;
        padding: 30px;
        max-width: 90%;
    }
    
    .message-title {
        font-size: 24px;
    }
    
    .message-content {
        font-size: 14px;
    }
    
    .continue-btn {
        padding: 10px 25px;
        font-size: 14px;
    }
}
</style>';

// Désactiver l'affichage des erreurs MySQL brutales
mysqli_report(MYSQLI_REPORT_OFF);

/* Vérifier la connexion */
if (!$connexion) { 
    echo '
    <div class="message-container error">
        <div class="message-icon">✗</div>
        <h2 class="message-title">Erreur de connexion</h2>
        <p class="message-content">Impossible de se connecter à la base de données</p>
    </div>';
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['submit_inscription'])) {
    try {
        // Préparation des données (protection minimale contre les injections SQL)
        $id_commissaire = intval($_POST['id_commissaire']);
        $nom = mysqli_real_escape_string($connexion, $_POST['nom']);
        $prenom = mysqli_real_escape_string($connexion, $_POST['prenom']);
        
        $requête = "INSERT INTO COMMISSAIRE VALUES (
            $id_commissaire, 
            ".intval($_POST['id_licence']).", 
            ".intval($_POST['id_CCR']).", 
            ".intval($_POST['id_ASSM']).",
            '$nom', 
            '$prenom', 
            '".mysqli_real_escape_string($connexion, $_POST['telephone'])."', 
            ".floatval($_POST['salaire'])."
        )";
        
        $resultat = mysqli_query($connexion, $requête);
        
        if ($resultat) { 
            echo '
            <div class="message-container success">
                <div class="message-icon">✓</div>
                <h2 class="message-title">Enregistrement réussi</h2>
                <p class="message-content">Le commissaire a été enregistré avec succès</p>
                <button class="continue-btn" onclick="window.location.href=\'index2.html\'">Retour à l\'accueil</button>
            </div>'; 
        } else {
            // Analyse du type d'erreur
            $error_msg = "Une erreur est survenue lors de l'enregistrement";
            
            if(mysqli_errno($connexion) == 1062) {
                $error_msg = "Ce numéro de commissaire existe déjà dans la base de données";
            } elseif(mysqli_errno($connexion) == 1452) {
                $error_msg = "Référence invalide (licence, CCR ou ASSM inexistant)";
            }
            
            echo '
            <div class="message-container error">
                <div class="message-icon">✗</div>
                <h2 class="message-title">Erreur d\'enregistrement</h2>
                <p class="message-content">'.$error_msg.'</p>
                <div class="error-details">Erreur technique: '.htmlspecialchars(mysqli_error($connexion)).'</div>
                <button class="continue-btn" onclick="history.back()">Corriger les données</button>
            </div>';
        }
    } catch(Exception $e) {
        echo '
        <div class="message-container error">
            <div class="message-icon">✗</div>
            <h2 class="message-title">Erreur inattendue</h2>
            <p class="message-content">Une erreur technique est survenue</p>
            <button class="continue-btn" onclick="window.location.href=\'index2.html\'">Retour à l\'accueil</button>
        </div>';
    }
}

mysqli_close($connexion); 
?>