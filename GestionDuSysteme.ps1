# Creation des variables Couleurs
$Green = "Green"
$Yellow = "Yellow"
$White = "White"
$Red = "Red"
$Cyan= "Cyan"

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

$statut = $true

# log lancement du script
WriteLog "********StartScriptGestionDuSysteme********"
WriteLog "Navigation dans le menu de gestion du systeme"

while ($statut) 
{
    Write-Host "`n<=== MENU GESTION DU SYSTEME ===>`n" -f $Green
    Write-Host "[1]" -f $Cyan -NoNewline ; Write-Host " Arrêter le système" -f $White;
    Write-Host "[2]" -f $Cyan -NoNewline ; Write-Host " Redémarrer le système" -f $White;
    Write-Host "[3]" -f $Cyan -NoNewline ; Write-Host " Vérrouiller le système" -f $White;
    Write-Host "[4]" -f $Cyan -NoNewline ; Write-Host " Mettre à jour le système" -f $White;
    Write-Host "[5]" -f $Cyan -NoNewline ; Write-Host " Retourner au menu principal`n" -f $White;
    $choix_option = Read-Host "Veuillez choisir une option "

    switch ($choix_option) 
	{
        
	"1" 
	{
	    $reponse = Read-Host "`nVoulez-vous vraiment arreter le systeme ? (oui/non) "
            while ($reponse -ne "non" -and $reponse -ne "n") 
            {
                if ($reponse -eq "oui" -or $reponse -eq "o") 
                {
                    Write-Host "`nLe systeme est en cours d'arret...`n"  
		    WriteLog "Demande d'arret du systeme"
                    # Executer la commande d'arret du systeme
                    Stop-Computer -Force
                } 
                else 
                {
                    Write-Host -f $Red "`nErreur lors de la saisie"
                    $reponse = Read-Host "`nVoulez-vous vraiment arreter le systeme ? (oui/non) "
                }
            }
            Write-Host "`nRetour au menu des options du systeme"
        }
		
        "2" 
	{
	    $reponse = Read-Host "`nVoulez-vous vraiment redemarrer le systeme ? (oui/non) "
            while ($reponse -ne "non" -and $reponse -ne "n") 
            {
                if ($reponse -eq "oui" -or $reponse -eq "o") 
                {
                    Write-Host "`nLe systeme est en cours de redemarrage..."
		    WriteLog "Demande de redemarrage du systeme"
                    # Executer la commande de redemarrage du systeme
                    Restart-Computer -Force
                } 
                else 
                {
                    Write-Host -f $Red "`nErreur lors de la saisie"
                    $reponse = Read-Host "`nVoulez-vous vraiment redemarrer le systeme ? (oui/non) "
                }
            }
            Write-Host "`nRetour au menu des options du systeme"
        }
		
	"3" 
	{
	    WriteLog "Demande de verrouillage de la session en cours"
            Write-Host "`nFonctionnalite en cours de developpement" -f $Yellow
            #Write-Host "`nVerrouillage du systeme en cours..."
            # Utiliser psshutdown.exe pour verrouiller la session           
            # psshutdown /accepteula -l
            rundll32.exe user32.dll,LockWorkStation
        }
		
        "4" 
	{
            WriteLog "Demande de recherche de mises a jour"
	    Write-Host "`nRecherche des mises a jour disponibles..."
	    Install-Module PSWindowsUpdate -Force -Scope CurrentUser
        $misesAJour = Get-WindowsUpdate
        # Afficher les mises à jour disponibles
	    Write-Host "`nListe des mises a jour disponibles:"
        $misesAJour
                
    # Vérifie si la liste des mises à jour est vide
    if ($misesAJour.Count -eq 0) {
        Write-Host "`nAucune mise a jour disponible. Retour au menu precedent."
        break  # Retourner au menu précédent
    }
	    Write-Host "`nListe des mises a jour disponibles : "
            Get-WindowsUpdate
            $reponse = Read-Host "`nVoulez-vous installer les mises a jour? (oui/non)"
            while ($reponse -ne "non" -and $reponse -ne "n") 
            {
                if ($reponse -eq "oui" -or $reponse -eq "o") 
                {
                    WriteLog "Demande d'installation des mises a jour"
		    # Executer la commande de mise a jour du systeme
                    Install-WindowsUpdate -AcceptAll -AutoReboot
                } 
                else 
                {
                    Write-Host -f $Red "`nErreur lors de la saisie"
                    $reponse = Read-Host "`nVoulez-vous installer les mises a jour ? (oui/non) "
                }
            }
            Write-Host "`nRetour au menu des options du systeme"
        }
		
	"5" 
	{
            WriteLog "********EndScriptGestionDuSysteme********"
	    $statut = $false
        }
	default 
 	{
        	Write-Host "Choix invalide, veuillez recommencer"
        }
    }
}
