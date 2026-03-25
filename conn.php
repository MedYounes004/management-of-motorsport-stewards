<?php 
/* Paramètres de connexion */
$serveur = 'localhost';
$utilisateur = 'root';
$motdepasse = '';
$basededonnees = 'pfa';

/* Désactiver l'affichage des erreurs brutales */
mysqli_report(MYSQLI_REPORT_OFF);

/* Établir la connexion */
$connexion = mysqli_connect($serveur, $utilisateur, $motdepasse, $basededonnees);

// Style CSS intégré
echo '<style>
* {
    box-sizing: border-box;
}

body {
    font-family: "Inter", -apple-system, BlinkMacSystemFont, sans-serif;
    margin: 0;
    padding: 0;
    background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
    background-size: cover;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
}

.message-container {
    background: rgba(255, 255, 255, 0.98);
    border-radius: 20px;
    padding: 40px;
    box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
    text-align: center;
    max-width: 550px;
    width: 90%;
    backdrop-filter: blur(12px);
    border: 1px solid rgba(255, 255, 255, 0.2);
    animation: slideIn 0.5s ease-out;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.message-container:hover {
    transform: translateY(-8px);
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.4);
}

.message-icon {
    font-size: 64px;
    margin-bottom: 20px;
    transition: transform 0.3s ease;
}

.success .message-icon {
    color: #2ecc71;
    text-shadow: 0 2px 4px rgba(46, 204, 113, 0.3);
}

.error .message-icon {
    color: #e74c3c;
    text-shadow: 0 2px 4px rgba(231, 76, 60, 0.3);
}

.message-container:hover .message-icon {
    transform: scale(1.15);
}

.message-title {
    font-size: 30px;
    font-weight: 700;
    margin: 0 0 15px;
    color: #2d3436;
    letter-spacing: 0.3px;
}

.message-content {
    font-size: 16px;
    line-height: 1.6;
    color: #636e72;
    margin: 0 0 25px;
}

.error-details {
    background: rgba(231, 76, 60, 0.1);
    padding: 12px;
    border-radius: 8px;
    font-size: 14px;
    color: #e74c3c;
    margin-top: 15px;
    word-break: break-word;
}

.continue-btn {
    background: linear-gradient(90deg, #0984e3 0%, #00b894 100%);
    color: white;
    border: none;
    padding: 14px 35px;
    border-radius: 50px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 5px 15px rgba(9, 132, 227, 0.4);
    text-transform: uppercase;
    letter-spacing: 1px;
}

.error .continue-btn {
    background: linear-gradient(90deg, #e74c3c 0%, #d63031 100%);
    box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
}

.continue-btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(9, 132, 227, 0.5);
    background: linear-gradient(90deg, #0778d1 0%, #00a381 100%);
}

.error .continue-btn:hover {
    box-shadow: 0 8px 25px rgba(231, 76, 60, 0.5);
    background: linear-gradient(90deg, #d43f30 0%, #c1272d 100%);
}

.continue-btn:active {
    transform: translateY(1px);
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(40px) scale(0.9);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

/* Responsivité */
@media (max-width: 600px) {
    .message-container {
        padding: 30px;
        margin: 15px;
    }

    .message-title {
        font-size: 26px;
    }

    .message-content {
        font-size: 14px;
    }

    .message-icon {
        font-size: 50px;
    }

    .continue-btn {
        padding: 12px 30px;
        font-size: 14px;
    }
}
</style>';

/* Vérifier la connexion */
if (!$connexion) {
    echo '
    <div class="message-container error">
        <div class="message-icon">✗</div>
        <h2 class="message-title">Erreur de connexion</h2>
        <p class="message-content">Impossible de se connecter à la base de données.</p>
        <button class="continue-btn" onclick="window.location.href=\'index2.html\'">Retour à l\'accueil</button>
    </div>';
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && empty($_POST['submit_epreuve'])) {
    try {
        // Éviter les injections SQL en échappant les données
        $id_epreuve = intval($_POST['id_epreuve']);
        $id_ASSM = intval($_POST['id_ASSM']);
        $type_epreuve = mysqli_real_escape_string($connexion, $_POST['type_epreuve']);
        $adresse_epreuve = mysqli_real_escape_string($connexion, $_POST['adresse_epreuve']);
        $date_fin = mysqli_real_escape_string($connexion, $_POST['date_fin']);
        $date_debut = mysqli_real_escape_string($connexion, $_POST['date_debut']);

        $re = "INSERT INTO epreuve VALUES ($id_epreuve, $id_ASSM, '$type_epreuve', '$adresse_epreuve', '$date_fin', '$date_debut')";
        $resl = mysqli_query($connexion, $re);

        if ($resl) {
            echo '
            <div class="message-container success">
                <div class="message-icon">✓</div>
                <h2 class="message-title">Enregistrement réussi</h2>
                <p class="message-content">Les données ont été correctement sauvegardées dans la table epreuve.</p>
                <button class="continue-btn" onclick="window.location.href=\'index2.html\'">Retour à l\'accueil</button>
            </div>';
        } else {
            throw new Exception(mysqli_error($connexion), mysqli_errno($connexion));
        }
    } catch (Exception $e) {
        $error_msg = "Une erreur est survenue lors de l'enregistrement.";
        $error_details = htmlspecialchars($e->getMessage());

        // Personnalisation des messages d'erreur
        if ($e->getCode() == 1062) {
            $error_msg = "Cet identifiant d'épreuve existe déjà dans la base de données.";
        } elseif ($e->getCode() == 1452) {
            $error_msg = "L'identifiant ASSM spécifié est invalide ou n'existe pas.";
        }

        echo '
        <div class="message-container error">
            <div class="message-icon">✗</div>
            <h2 class="message-title">Erreur d\'enregistrement</h2>
            <p class="message-content">' . $error_msg . '</p>
            <div class="error-details">Détails techniques : ' . $error_details . '</div>
            <button class="continue-btn" onclick="history.back()">Corriger les données</button>
        </div>';
    }
}

mysqli_close($connexion);
?>