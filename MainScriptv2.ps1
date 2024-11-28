# Définition des couleurs avec ForegroundColor
$RED = "Red"
$GREEN = "Green"
$YELLOW = "Yellow"
$NC = "White" # Aucune couleur

# Variables Utilisateurs
$user1 = "wilder@172.16.10.20"
$user2 = "lbartaire@10.0.0.21"

# Variables ACTION
$Exe_script_User = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\UserControl.ps1"'
$Delete_User = 'Remove-Item "C:\Windows\Temp\UserControl.ps1", "C:\Windows\Temp\log-remote.log"'

$Exe_script_Group = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\GroupControl.ps1"'
$Delete_Group = 'Remove-Item "C:\Windows\Temp\GroupControl.ps1", "C:\Windows\Temp\log-remote.log"'

$Exe_script_System = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\GestionDuSysteme.ps1"'
$Delete_System = 'Remove-Item "C:\Windows\Temp\GestionDuSysteme.ps1", "C:\Windows\Temp\log-remote.log"'

$Exe_script_Logiciel = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\GestionLogiciel.ps1"'
$Delete_Logiciel = 'Remove-Item "C:\Windows\Temp\GestionLogiciel.ps1", "C:\Windows\Temp\log-remote.log"'

$Exe_script_Parefeu = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\GestionParefeu.ps1"'
$Delete_Parefeu = 'Remove-Item "C:\Windows\Temp\GestionParefeu.ps1", "C:\Windows\Temp\log-remote.log"'

$Exe_script_Repertoire = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\GestionDesRepertoires.ps1"'
$Delete_Repertoire = 'Remove-Item "C:\Windows\Temp\GestionDesRepertoires.ps1", "C:\Windows\Temp\log-remote.log"'

$Exe_script_InfoUser = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoUtilisateur.ps1"'
$Delete_InfoUser = 'Remove-Item "C:\Windows\Temp\InfoUtilisateur.ps1", "C:\Windows\Temp\log-remote.log"'

$Exe_script_InfoSoftware = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoDuSystemeSoftware.ps1"'
$Delete_InfoSoftware = 'Remove-Item "C:\Windows\Temp\InfoDuSystemeSoftware.ps1", "C:\Windows\Temp\log-remote.log"'

$Exe_script_InfoHardware = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoDuSystemeHardware.ps1"'
$Delete_InfoHardware = 'Remove-Item "C:\Windows\Temp\InfoDuSystemeHardware.ps1", "C:\Windows\Temp\log-remote.log"'

# Variables COLLECTE INFORMATION
$Exe_script_InfoUser = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoUtilisateur.ps1"'
$Delete_InfoUser = 'Remove-Item "C:\Windows\Temp\InfoUtilisateur.ps1", "C:\Windows\Temp\log-remote.log"'

$Exe_script_InfoSoftware = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoDuSystemeSoftware.ps1"'
$Delete_InfoSoftware = 'Remove-Item "C:\Windows\Temp\InfoDuSystemeSoftware.ps1", "C:\Windows\Temp\log-remote.log"'

$Exe_script_InfoHardware = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoDuSystemeHardware.ps1"'
$Delete_InfoHardware = 'Remove-Item "C:\Windows\Temp\InfoDuSystemeHardware.ps1", "C:\Windows\Temp\log-remote.log"'

# Fonction log
$Logfile = "C:\Windows\System32\LogFiles\log-evt.log"
function WriteLog
{
Param ([string]$LogString)
$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$User = $env:USERNAME
$LogMessage = "$Stamp-$User-$LogString"
Add-content $LogFile -value $LogMessage
}

# log lancement du script
WriteLog "********StartScript********"

# Menu principal
while ($true) {

    Write-Host "`n<=== Choisissez la machine sur laquelle vous voulez vous connecter : ===>`n" -f $GREEN
    Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "CLIWIN01" -f $NC
    Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "CLIWIN02" -f $NC
    Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Quitter`n" -f $NC

    $machine = Read-Host "Veuillez choisir une option "
    Write-Host ""

    switch ($machine) {

        # Menu pour CLIWIN01
        "1" {
            WriteLog "Connexion au client CLIWIN01"

            # Variable pour retourner au menu précédent
            $continueCLIWIN01 = $true
            while ($continueCLIWIN01) {

                Write-Host "`n<=== MENU CLIENT CLIWIN01 ===>`n" -f $GREEN
                Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Actions" -f $NC
                Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Informations" -f $NC
                Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Retour au menu principal" -f $NC
                Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Quitter le script`n" -f $NC
                $action = Read-Host "Veuillez choisir une option "
		Write-Host ""

                switch ($action) {

                    # Menu actions pour CLIWIN01
                    "1" {
                        WriteLog "Navigation dans le menu action du client CLIWIN01"

                        # Variable pour retourner au menu précédent
                        $continueActions = $true
                        while ($continueActions) {

                            Write-Host "`n<=== MENU ACTIONS CLIENT CLIWIN01 ===>`n" -f $GREEN
                            Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Gestion des utilisateurs" -f $NC
                            Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Gestion des groupes" -f $NC
                            Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Gestion du système" -f $NC
                            Write-Host "[4] " -f $YELLOW -NoNewline; Write-Host "Gestion des répertoires" -f $NC
                            Write-Host "[5] " -f $YELLOW -NoNewline; Write-Host "Prise en main CLI" -f $NC
                            Write-Host "[6] " -f $YELLOW -NoNewline; Write-Host "Gestion du logiciel" -f $NC
                            Write-Host "[7] " -f $YELLOW -NoNewline; Write-Host "Gestion du pare-feu" -f $NC
                            Write-Host "[8] " -f $YELLOW -NoNewline; Write-Host "Retour au menu précédent" -f $NC
                            Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Fin du script`n" -f $NC
                            $gestion = Read-Host "Veuillez choisir une option "
			    Write-Host ""

                            switch ($gestion) {
                            
                                "1" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion uilisateurs"
                                    scp C:\script_action\UserControl.ps1 ${user1}:/C:/Windows/Temp/UserControl.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_User"
                                    # Récupération du log du client
                                    scp ${user1}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user1 "powershell.exe -Command $Delete_User" 
                                }
                                
                                "2" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion des groupes"
                                    scp C:\script_action\GroupControl.ps1 ${user1}:/C:/Windows/Temp/GroupControl.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Group"
                                    # Récupération du log du client
                                    scp ${user1}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user1 "powershell.exe -Command $Delete_Group"
                                }
                                
                                "3" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion du systeme"
                                    scp C:\script_action\GestionDuSysteme.ps1 ${user1}:/C:/Windows/Temp/GestionDuSysteme.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_System"
                                    # Récupération du log du client
                                    scp ${user1}:/C:/Windows/Temp/log-remote.log C:/Windows/Temp/log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:/Windows/Temp/log-remote.log | Add-Content C:/Windows/System32/LogFiles/log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:/Windows/Temp/log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user1 "powershell.exe -Command $Delete_System" 
                                }
                                
                                "4" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion des repertoires"
                                    scp C:\script_action\GestionDesRepertoires.ps1 ${user1}:/C:/Windows/Temp/GestionDesRepertoires.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Repertoire"
                                    # Récupération du log du client
                                    scp ${user1}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user1 "powershell.exe -Command $Delete_Repertoire" 
                                }
                                
                                "5" { 
                                    WriteLog "Prise de main à distance (CLI) du client CLIWIN01"
                                    ssh -t $user1 
                                }
                                
                                "6" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion Logiciel"
                                    scp C:\script_action\GestionLogiciel.ps1 ${user1}:/C:/Windows/Temp/GestionLogiciel.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Logiciel"
                                    # Récupération du log du client
                                    scp ${user1}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user1 "powershell.exe -Command $Delete_Logiciel" 
                                }
                                
                                "7" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion Parefeu"
                                    scp C:\script_action\GestionParefeu.ps1 ${user1}:/C:/Windows/Temp/GestionParefeu.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Parefeu"
                                    # Récupération du log du client
                                    scp ${user1}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user1 "powershell.exe -Command $Delete_Parefeu"
                                }

                                "8" { 
                                    $continueActions = $false
                                }
                                
                                "x" { 
                                    WriteLog "********EndScript********"
                                    Write-Host "`nExit`n" -f $YELLOW
                                    exit 
                                }
                                
                                default { 
                                    Write-Host "`n[Erreur]! Option invalide, veuillez reessayer !`n" -f $RED 
                                }
                            }
                        }
                    }

                    # Menu informations pour CLIWIN01
                    "2" {
                        WriteLog "Navigation dans le menu information du client CLIWIN01"

                        # Variable pour retourner au menu précédent
                        $continueInformations = $true
                        while ($continueInformations) {

                            Write-Host "`n<=== MENU INFORMATIONS CLIENT CLIWIN01 ===>`n" -f $GREEN
                            Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Informations des utilisateurs" -f $NC
                            Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Informations du système (software)" -f $NC
                            Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Informations du système (hardware)" -f $NC
                            Write-Host "[4] " -f $YELLOW -NoNewline; Write-Host "Recherche des evenement dans le fichier des logs" -f $NC
                            Write-Host "[5] " -f $YELLOW -NoNewline; Write-Host "Retour au menu précédent" -f $NC
                            Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Fin du script`n" -f $NC
                            $information = Read-Host "Veuillez choisir une option "
			    Write-Host ""

                            switch ($information) {
                                "1" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu des Infomations Utilisateur"
                                    scp C:\script_information\InfoUtilisateur.ps1 ${user1}:/C:/Windows/Temp/InfoUtilisateur.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_InfoUser"
                                    # Récupération du log du client
                                    scp ${user1}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user1 "powershell.exe -Command $Delete_InfoUser"
                                }
                                
                                "2" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu des Informations Systeme Software"
                                    scp C:\script_information\InfoDuSystemeSoftware.ps1 ${user1}:/C:/Windows/Temp/InfoDuSystemeSoftware.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_InfoSoftware"
                                    # Récupération du log du client
                                    scp ${user1}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user1 "powershell.exe -Command $Delete_InfoSoftware"
                                }
                                
                                "3" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu des Informations Systeme Hardware"
                                    scp C:\script_information\InfoDuSystemeHardware.ps1 ${user1}:/C:/Windows/Temp/InfoDuSystemeHardware.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_InfoHardware"
                                    # Récupération du log du client
                                    scp ${user1}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user1 "powershell.exe -Command $Delete_InfoHardware"
                                }
                                
                                 "4" { 
                                    WriteLog "Consultation des logs"
     					            Get-Content C:\Windows\System32\LogFiles\log-evt.log
                                }

                                "5" { 
                                    $continueInformations = $false
                                }
                                
                                "x" { 
                                    WriteLog "********EndScript********"
                                    Write-Host "`nExit`n" -f $YELLOW
                                    exit 
                                }
                                default { 
                                    Write-Host "`n[Erreur]! Option invalide, veuillez reessayer !`n" -f $RED 
                                }
                            }
                        }
                    }

                    "3" {
                        $continueCLIWIN01 = $false
                    }
                    
                    "x" {
                        WriteLog "********EndScript********"
                        Write-Host "`nExit`n" -f $YELLOW
                        exit
                    }
                    default { 
                        Write-Host "`n[Erreur]! Option invalide, veuillez reessayer !`n" -f $RED 
                    }
                }
            }
        }

        # Menu pour CLIWIN02
        "2" {
            WriteLog "Connexion au client CLIWIN02"

            # Variable pour retourner au menu précédent
            $continueCLIWIN02 = $true
            while ($continueCLIWIN02) {

                Write-Host "`n<=== MENU CLIENT CLIWIN02 ===>`n" -f $GREEN
                Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Actions" -f $NC
                Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Informations" -f $NC
                Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Retour au menu principal" -f $NC
                Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Quitter le script`n" -f $NC
                $action = Read-Host "Veuillez choisir une option "
		Write-Host ""

                switch ($action) {

                     # Menu actions pour CLIWIN02
                    "1" {
                        WriteLog "Navigation dans le menu action du client CLIWIN02"

                        # Variable pour retourner au menu précédent
                        $continueActions = $true
                        while ($continueActions) {

                            Write-Host "`n<=== MENU ACTIONS CLIENT CLIWIN02 ===>`n" -f $GREEN
                            Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Gestion des utilisateurs" -f $NC
                            Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Gestion des groupes" -f $NC
                            Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Gestion du système" -f $NC
                            Write-Host "[4] " -f $YELLOW -NoNewline; Write-Host "Gestion des répertoires" -f $NC
                            Write-Host "[5] " -f $YELLOW -NoNewline; Write-Host "Prise en main CLI" -f $NC
                            Write-Host "[6] " -f $YELLOW -NoNewline; Write-Host "Gestion du logiciel" -f $NC
                            Write-Host "[7] " -f $YELLOW -NoNewline; Write-Host "Gestion du pare-feu" -f $NC
                            Write-Host "[8] " -f $YELLOW -NoNewline; Write-Host "Retour au menu précédent" -f $NC
                            Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Fin du script`n" -f $NC
                            $gestion = Read-Host "Veuillez choisir une option "
			    Write-Host ""

                            switch ($gestion) {
                            
                                "1" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion uilisateurs"
                                    scp C:\script_action\UserControl.ps1 ${user2}:/C:/Windows/Temp/UserControl.ps1
                                    ssh -t $user2 "powershell.exe -Command $Exe_script_User"
                                    # Récupération du log du client
                                    scp ${user2}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user2 "powershell.exe -Command $Delete_User"
                                }
                                
                                "2" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion des groupes"
                                    scp C:\script_action\GroupControl.ps1 ${user2}:/C:/Windows/Temp/GroupControl.ps1
                                    ssh -t $user2 "powershell.exe -Command $Exe_script_Group"
                                    # Récupération du log du client
                                    scp ${user2}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user2 "powershell.exe -Command $Delete_Group"
                                }
                                
                                "3" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion du systeme"
                                    scp C:\script_action\GestionDuSysteme.ps1 ${user2}:/C:/Windows/Temp/GestionDuSysteme.ps1
                                    ssh -t $user2 "powershell.exe -Command $Exe_script_System "
                                    # Récupération du log du client
                                    scp ${user2}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user2 "powershell.exe -Command $Delete_System"
                                }
                                
                                "4" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion des repertoires"
                                    scp C:\script_action\GestionDesRepertoires.ps1 ${user2}:/C:/Windows/Temp/GestionDesRepertoires.ps1
                                    ssh -t $user2 "powershell.exe -Command $Exe_script_Repertoire"
                                    # Récupération du log du client
                                    scp ${user2}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user2 "powershell.exe -Command $Delete_Repertoire"
                                }
                                
                                "5" { 
                                    WriteLog "Prise de main à distance (CLI) du client CLIWIN02"
                                    ssh -t $user2 
                                }
                                
                                "6" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion Logiciel"
                                    scp C:\script_action\GestionLogiciel.ps1 ${user2}:/C:/Windows/Temp/GestionLogiciel.ps1
                                    ssh -t $user2 "powershell.exe -Command $Exe_script_Logiciel"
                                    # Récupération du log du client
                                    scp ${user2}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user2 "powershell.exe -Command $Delete_Logiciel"
                                }
                                
                                "7" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu de Gestion Parefeu"
                                    scp C:\script_action\GestionParefeu.ps1 ${user2}:/C:/Windows/Temp/GestionParefeu.ps1
                                    ssh -t $user2 "powershell.exe -Command $Exe_script_Parefeu"
                                    # Récupération du log du client
                                    scp ${user2}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user2 "powershell.exe -Command $Delete_Parefeu"
                                }

                                "8" { 
                                    $continueActions = $false
                                }
                                
                                "x" { 
                                    WriteLog "********EndScript********"
                                    Write-Host "`nExit`n" -f $YELLOW
                                    exit 
                                }
                                
                                default { 
                                    Write-Host "`n[Erreur]! Option invalide, veuillez reessayer !`n" -f $RED 
                                }
                            }
                        }
                    }

                    # Menu informations pour CLIWIN02
                    "2" {
                        WriteLog "Navigation dans le menu information du client CLIWIN02"

                        # Variable pour retourner au menu précédent
                        $continueInformations = $true
                        while ($continueInformations) {

                            Write-Host "`n<=== MENU INFORMATIONS CLIENT CLIWIN02 ===>`n" -f $GREEN
                            Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Informations des utilisateurs" -f $NC
                            Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Informations du système (software)" -f $NC
                            Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Informations du système (hardware)" -f $NC
                            Write-Host "[4] " -f $YELLOW -NoNewline; Write-Host "Retour au menu précédent" -f $NC
                            Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Fin du script`n" -f $NC
                            $information = Read-Host "Veuillez choisir une option "
			    Write-Host ""

                            switch ($information) {
                                "1" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu des Infomations Utilisateur"
                                    scp C:\script_information\InfoUtilisateur.ps1 ${user2}:/C:/Windows/Temp/InfoUtilisateur.ps1
                                    ssh -t $user2 "powershell.exe -Command $Exe_script_InfoUser"
                                    # Récupération du log du client
                                    scp ${user2}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user2 "powershell.exe -Command $Delete_InfoUser"
                                }
                                
                                "2" {
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu des Informations Systeme Software"
                                    scp C:\script_information\InfoDuSystemeSoftware.ps1 ${user2}:/C:/Windows/Temp/InfoDuSystemeSoftware.ps1
                                    ssh -t $user2 "powershell.exe -Command $Exe_script_InfoSoftware"
                                    # Récupération du log du client
                                    scp ${user2}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user2 "powershell.exe -Command $Delete_InfoSoftware" 
                                }
                                
                                "3" { 
                                    # Exécution du script distant
                                    WriteLog "Navigation dans le menu des Informations Systeme Hardware"
                                    scp C:\script_information\InfoDuSystemeHardware.ps1 ${user2}:/C:/Windows/Temp/InfoDuSystemeHardware.ps1
                                    ssh -t $user2 "powershell.exe -Command $Exe_script_InfoHardware"
                                    # Récupération du log du client
                                    scp ${user2}:/C:/Windows/Temp/log-remote.log C:\Windows\Temp\log-remote.log
                                    # Ajouter le contenu du fichier temporaire dans le fichier principal log-evt.log
                                    Get-Content C:\Windows\Temp\log-remote.log | Add-Content C:\Windows\System32\LogFiles\log-evt.log
                                    # Suppression du fichier temporaire local après l'ajout
                                    Remove-Item C:\Windows\Temp\log-remote.log
                                    # Suppression du log et du script sur le client après transfert
                                    ssh -t $user2 "powershell.exe -Command $Delete_InfoHardware"
                                }
                                
                                "4" { 
                                    $continueInformations = $false
                                }
                                
                                "x" { 
                                    WriteLog "********EndScript********"
                                    Write-Host "`nExit`n" -f $YELLOW
                                    exit 
                                }
                                default { 
                                    Write-Host "`n[Erreur]! Option invalide, veuillez reessayer !`n" -f $RED 
                                }
                            }
                        }
                    }

                    "3" {
                        $continueCLIWIN02 = $false
                    }
                    
                    "x" {
                        WriteLog "********EndScript********"
                        Write-Host "`nExit`n" -f $YELLOW
                        exit
                    }
                    
                    default { 
                        Write-Host "`n[Erreur]! Option invalide, veuillez reessayer !`n" -f $RED 
                    }
                }
            }
        }

        # Sortie du main script
        "x" {
            WriteLog "********EndScript********"
            Write-Host "`nExit`n" -f $YELLOW
            exit
        }

        default {
            Write-Host "`n[Erreur]! Option invalide, veuillez reessayer !`n" -f $RED
        }
    }
} 
