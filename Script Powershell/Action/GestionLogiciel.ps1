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
WriteLog "********StartScriptGestionLogiciel********"
WriteLog "Navigation dans le menu de gestion de logiciel"

# Boucle while true pour le menu gestion de logiciel
while ($true) {
    Write-Host "`n<=== MENU GESTION DU LOGICIEL ===>`n" -f $GREEN
    Write-Host "[1] " -f $CYAN -nonewline; Write-Host " Installer un logiciel" -f $NC
    Write-Host "[2] " -f $CYAN -nonewline; Write-Host " Désinstaller un logiciel" -f $NC
    Write-Host "[3] " -f $CYAN -nonewline; Write-Host " Retour au menu principal`n" -f $NC
    $choix = Read-Host "Veuillez choisir une option "

    # Switch pour les choix du menu
    switch ($choix) {
    
        # Installer un logiciel
        "1" {
            Write-Host "`nEntrer le nom du logiciel à installer : `n" -f $GREEN 
            $logiciel = Read-Host "Nom du logiciel "

            Write-Host ""

            $chocoPath = "C:\ProgramData\chocolatey\bin\choco.exe"
            $process = Start-Process -FilePath $chocoPath -ArgumentList "install", $logiciel, "-y" -NoNewWindow -Wait -PassThru

            # Vérification de la procédure d'installation de logiciel
            if ($process.ExitCode -eq 0) {
            Write-Host "`nLe logiciel '$logiciel' a été installé avec succés.`n" -f $GREEN
            WriteLog "$logiciel a été installé avec succés"
            } 
              else {
                   Write-Host "`nErreur lors de l'installation de $logiciel.`n" -f $RED
            }
        }

        # Désinstaller un logiciel
        "2" {
            Write-Host "`nEntrer le nom du logiciel à désinstaller : `n" -f $GREEN
            $logiciel = Read-Host "Nom du logiciel "

            Write-Host ""

            $chocoPath = "C:\ProgramData\chocolatey\bin\choco.exe"
            $process = Start-Process -FilePath "$chocoPath" -ArgumentList "uninstall", $logiciel, "-y" -NoNewWindow -Wait -PassThru

            # Vérification de la procédure de désinstallation de logiciel
            if ($process.ExitCode -eq 0) {
            Write-Host "`nLe logiciel '$logiciel' à été désinstallé avec succés.`n" -f $GREEN
            WriteLog "$logiciel à été désinstallé avec succés"
            }
                else {
                Write-Host "`nErreur lors de la désinstallation de $logiciel.`n" -f $RED
            }
        }
        
        # Retour au menu principal 
        "3" {
            WriteLog "********EndScriptGestionLogiciel********"
            return
        }
        
        # Indique si erreur de saisie et relance le script    
        default {
            Write-Host "[ERREUR]! Option invalide, veuillez reessayer !`n" -f $RED
        }
    }
}
# Fin du script
