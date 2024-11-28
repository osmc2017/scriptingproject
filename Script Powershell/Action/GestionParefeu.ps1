# Définir les couleurs des variables
$RED = "Red"
$GREEN = "Green"
$YELLOW = "Yellow"
$CYAN = "Cyan"
$NC = "White" # Aucune couleur

# Fonction log
$Logfile = "C:\Windows\Temp\log-remote.log"
function WriteLog
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$User = $env:USERNAME
$LogMessage = "$Stamp-$User-$LogString"
Add-content $LogFile -value $LogMessage
}

# log lancement du script
WriteLog "********StartScriptGestionParefeu********"
WriteLog "Navigation dans le menu de gestion du pare-feu"

# Fonction pour menu et choix des règles du pare-feu
function Menu-ReglesPareFeu {

    # Boucle while pour le menu des règles pare-feu
    while ($true) {
        WriteLog "Navigation dans le menu des regles Pare-feu"
        Write-Host "`n<=== MENU DES RÈGLES DU PARE-FEU ===>`n" -f $GREEN
        Write-Host "[1] " -ForegroundColor $CYAN -NoNewline; Write-Host "Ajouter une règle" -f $NC
        Write-Host "[2] " -ForegroundColor $CYAN -NoNewline; Write-Host "Supprimer une règle" -f $NC
        Write-Host "[3] " -ForegroundColor $CYAN -NoNewline; Write-Host "Afficher les règles actuelles" -f $NC
        Write-Host "[4] " -ForegroundColor $CYAN -NoNewline; Write-Host "Retour au menu principal`n" -f $NC
        $choix_regles = Read-Host "Veuillez choisir une option "

        # Switch pour les choix du menu
        switch ($choix_regles) {

            # Ajouter une règle de pare-feu
           "1" {

                # Demander les autres paramètres de la règle
                $ruleName = Read-Host "`nEntrez le nom de la règle "
                $ruleDescription = Read-Host "Entrez la description de la règle "
                $protocol = Read-Host "Entrez le protocole (ex:"TCP" ou "UDP") "
                $port = Read-Host "Entrez le port (ex:"22" ou "80") "

                # Demander à l'utilisateur de saisir la direction
                $direction = Read-Host "Entrez la direction (Inbound ou Outbound)"

                # Vérifier que la direction est valide
                if ($direction -ne "Inbound" -and $direction -ne "Outbound") {
                Write-Host "Direction invalide. Veuillez entrer 'Inbound' ou 'Outbound'."
                exit
                }  

                # Créer la règle avec la direction valide
                New-NetFirewallRule -DisplayName $ruleName -Description $ruleDescription -Direction $direction -Protocol $protocol -LocalPort $port -Action Allow

                # Afficher les détails de la règle, y compris les ports
                Get-NetFirewallRule -DisplayName $ruleName | Format-List *

                Write-Host "La règle de pare-feu '$ruleName' à bien été ajoutée`n" -f $YELLOW
                WriteLog "Regle de pare-feu $ruleName a ete ajoutee"
            }

            # Supprimer une règle de pare-feu
            "2" {
                $regle = Read-Host "`nEntrer la règle à supprimer "
                Write-Host "`nLa règle '$regle' à bien été supprimée`n" -f $YELLOW
                WriteLog "Regle de parfeu $regle a ete supprime"

                $ruleName = "$regle"
                Remove-NetFirewallRule -DisplayName $ruleName
            }
            # Affiche les règles pare-feu actuelles
            "3" {
                Write-Host "`nRègles de pare-feu actuelles :`n" -f $YELLOW
                Get-NetFirewallRule | Format-Table -Property DisplayName, Enabled, Action, Direction
                WriteLog "Consultation des regles de parfeu actuelles"
            }

            # Retour au menu principal
            "4" {
                return 
            }

            # Inique si erreur de saisie et relance le script
            default {
                Write-Host "[Erreur]! Option invalide, veuillez réessayer !`n" -f $RED
            }
        }
    }
}

# Boucle while pour le menu gestion pare-feu
while ($true) {
    Write-Host "`n<=== MENU GESTION DU PARE-FEU ===>`n" -f $GREEN
    Write-Host "[1] " -ForegroundColor $CYAN -NoNewline; Write-Host "Définir les règles de pare-feu" -f $NC
    Write-Host "[2] " -ForegroundColor $CYAN -NoNewline; Write-Host "Activer le pare-feu" -f $NC
    Write-Host "[3] " -ForegroundColor $CYAN -NoNewline; Write-Host "Désactiver le pare-feu" -f $NC
    Write-Host "[4] " -ForegroundColor $CYAN -NoNewline; Write-Host "Retour au menu principal`n" -f $NC
    $choix = Read-Host "Veuillez choisir une option "

    # Switch pour les choix du menu
    switch ($choix) {
        "1" {
            Menu-ReglesPareFeu  # Appelle la fonction pour le menu des règles de pare-feu
        }

        # Activation du pare-feu
        "2" {
            write-Host ""
            $oui = Read-Host "Voulez-vous activer le pare-feu ? (oui/non) "

            # Boucle pour que tant que l'entrée n'est pas "oui" ou "non", on redemande une saisie valide
            while ($oui -ne "oui" -and $oui -ne "non") {
                Write-Host "[ERREUR] Option invalide, veuillez entrer 'oui' ou 'non'." -f $RED
                $oui = Read-Host "Entrer votre choix  "
            }

            # Si la valeur saisie est "oui" alors le pare-feu s'active sinon si la saisie est "non" alors rien ne se passe
            if ($oui -eq "oui") {
                Set-NetFirewallProfile -Profile * -Enabled True
                Write-Host "`nLe pare-feu a bien été activé.`n" -f $YELLOW
                WriteLog "Le pare-feu a ete active"
            } else {
                Write-Host "`nLe pare-feu n'a pas été activé.`n" -f $RED
            }
        }

        # Désactivation du pare-feu
        "3" {
            write-Host ""
            $oui = Read-Host "Voulez-vous désactiver le pare-feu ? (oui/non) "

            # Boucle pour que tant que l'entrée n'est pas "oui" ou "non", on redemande une saisie valide
            while ($oui -ne "oui" -and $oui -ne "non") {
                Write-Host "[ERREUR] Option invalide, veuillez entrer 'oui' ou 'non'." -f $RED
                $oui = Read-Host "Entrer votre choix  "
            }

            # Si la valeur saisie est "oui" alors le pare-feu se désactive sinon si la saisie est "non" alors rien ne se passe
            if ($oui -eq "oui") {
                Set-NetFirewallProfile -Profile * -Enabled False
                Write-Host "`nLe pare-feu a bien été désactivé.`n" -f $YELLOW
                WriteLog "Le pare-feu a ete desactive"
            } else {
                Write-Host "`nLe pare-feu n'a pas été désactivé.`n" -f $RED
            }
        }

        # Retour au menu principal
        "4" {
            WriteLog "********StartScriptGestionParefeu********"
            return
            }

        # Inique si erreur de saisie et relance le script
        default {
            Write-Host "[Erreur]! Option invalide, veuillez réessayer !`n" -f $RED
        }
    }
}
# Fin du script
