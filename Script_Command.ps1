# Creation des variables Couleurs
$Green = "Green"
$Yellow = "Yellow"
$White = "White"
$Red = "Red"
$Cyan= "Cyan"   
        
$statut = $true

        while ($statut) 
{
    Write-Host "`nMENU GESTION DU SYSTEME`n" -f $Green
    Write-Host "[1]" -f $Cyan -NoNewline ; Write-Host " Activer le Pare-feu" -f $White;
    Write-Host "[2]" -f $Cyan -NoNewline ; Write-Host " Desactiver le Pare-feu" -f $White;
    Write-Host "[3]" -f $Cyan -NoNewline ; Write-Host " Arreter le systeme" -f $White;
    Write-Host "[4]" -f $Cyan -NoNewline ; Write-Host " Redemarrer le systeme" -f $White;
    Write-Host "[x]" -f $Cyan -NoNewline ; Write-Host " Quitter le script`n" -f $White;
    $choix_option = Read-Host "Veuillez choisir une option"

    switch ($choix_option) 
	{
        
        # Activation du pare-feu
        "1" {
            $oui = Read-Host "Voulez-vous activer le pare-feu ? (oui/non) "

            # Boucle pour que tant que l'entrée n'est pas "oui" ou "non", on redemande une saisie valide
            while ($oui -ne "oui" -and $oui -ne "non") {
                Write-Host "[ERREUR] Option invalide, veuillez entrer 'oui' ou 'non'." -f $RED
                $oui = Read-Host "Entrer votre choix  "
            }

            # Si la valeur saisie est "oui" alors le pare-feu s'active sinon si la saisie est "non" alors rien ne se passe
            if ($oui -eq "oui") {
                ssh wilder@172.16.10.20 "powershell -Command Set-NetFirewallProfile -Profile * -Enabled True"
                Write-Host "`nLe pare-feu a bien été activé.`n" -f $GREEN
            } else {
                Write-Host "`nLe pare-feu n'a pas été activé.`n" -f $RED
            }
        }

        # Désactivation du pare-feu
        "2" {
            $oui = Read-Host "Voulez-vous désactiver le pare-feu ? (oui/non) "

            # Boucle pour que tant que l'entrée n'est pas "oui" ou "non", on redemande une saisie valide
            while ($oui -ne "oui" -and $oui -ne "non") {
                Write-Host "[ERREUR] Option invalide, veuillez entrer 'oui' ou 'non'." -f $RED
                $oui = Read-Host "Entrer votre choix  "
            }

            # Si la valeur saisie est "oui" alors le pare-feu se désactive sinon si la saisie est "non" alors rien ne se passe
            if ($oui -eq "oui") {
                ssh wilder@172.16.10.20 "powershell -Command Set-NetFirewallProfile -Profile * -Enabled False"
                Write-Host "`nLe pare-feu a bien été désactivé.`n" -f $GREEN
            } else {
                Write-Host "`nLe pare-feu n'a pas été désactivé.`n" -f $RED
            }
        }

        # Arreter le systeme
	    "3" 
	    {
	        $reponse = Read-Host "`nVoulez-vous vraiment arreter le systeme? (oui/non)"
            while ($reponse -ne "non" -and $reponse -ne "n") 
            {
                if ($reponse -eq "oui" -or $reponse -eq "o") 
                {
                    Write-Host "`nLe systeme est en cours d'arret...`n"  

                    # Executer la commande d'arret du systeme
                     ssh wilder@172.16.10.20 "powershell -Command Stop-Computer -Force"
		     return
                } 
                else 
                {
                    Write-Host -f $Red "`nErreur lors de la saisie"
                    $reponse = Read-Host "`nVoulez-vous vraiment arreter le systeme? (oui/non)"
                }
            }
            Write-Host "`nRetour au menu des options du systeme"
        }

        # Redemarrer le systeme
        "4" 
	    {
	    $reponse = Read-Host "`nVoulez-vous vraiment redemarrer le systeme? (oui/non)"
            while ($reponse -ne "non" -and $reponse -ne "n") 
            {
                if ($reponse -eq "oui" -or $reponse -eq "o") 
                {
                    Write-Host "`nLe systeme est en cours de redemarrage..."

                    # Executer la commande de redemarrage du systeme
                    ssh wilder@172.16.10.20 "powershell -Command Restart-Computer -Force"
		    return
                } 
                else 
                {
                    Write-Host -f $Red "`nErreur lors de la saisie"
                    $reponse = Read-Host "`nVoulez-vous vraiment redemarrer le systeme? (oui/non)"
                }
            }
            Write-Host "`nRetour au menu des options du systeme"
        }

        # Quitter le script
        "x"
        {
           	    $statut = $false
        }

	    default 
 	    {
        	Write-Host "Choix invalide, veuillez recommencer"
        }


    }
}
