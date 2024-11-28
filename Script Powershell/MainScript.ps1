# Définition des couleurs avec ForegroundColor
$RED = "Red"
$GREEN = "Green"
$YELLOW = "Yellow"
$NC = "White" # Aucune couleur

# Variables Utilisateurs
$user1 = "wilder@192.168.1.80"
$user2 = "lbartaire@10.0.0.21"

# Variables ACTION
$Exe_script_User = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\UserControl.ps1"'
$Delete_User = 'Remove-Item "C:\Windows\Temp\UserControl.ps1"'

$Exe_script_Group = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\GroupControl.ps1"'
$Delete_Group = 'Remove-Item "C:\Windows\Temp\GroupControl.ps1"'

$Exe_script_System = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\GestionDuSysteme.ps1"'
$Delete_System = 'Remove-Item "C:\Windows\Temp\GestionDuSysteme.ps1"'

$Exe_script_Logiciel = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\GestionLogiciel.ps1"'
$Delete_Logiciel = 'Remove-Item "C:\Windows\Temp\GestionLogiciel.ps1"'

$Exe_script_Parefeu = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\GestionParefeu.ps1"'
$Delete_Parefeu = 'Remove-Item "C:\Windows\Temp\GestionParefeu.ps1"'

$Exe_script_Repertoire = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\GestionDesRepertoires.ps1"'
$Delete_Repertoire = 'Remove-Item "C:\Windows\Temp\GestionDesRepertoires.ps1"'

$Exe_script_InfoUser = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoUtilisateur.ps1"'
$Delete_InfoUser = 'Remove-Item "C:\Windows\Temp\InfoUtilisateur.ps1"'

$Exe_script_InfoSoftware = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoDuSystemeSoftware.ps1"'
$Delete_InfoSoftware = 'Remove-Item "C:\Windows\Temp\InfoDuSystemeSoftware.ps1"'

$Exe_script_InfoHardware = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoDuSystemeHardware.ps1"'
$Delete_InfoHardware = 'Remove-Item "C:\Windows\Temp\InfoDuSystemeHardware.ps1"'

# Variables COLLECTE INFORMATION
$Exe_script_InfoUser = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoUtilisateur.ps1"'
$Delete_InfoUser = 'Remove-Item "C:\Windows\Temp\InfoUtilisateur.ps1"'

$Exe_script_InfoSoftware = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoDuSystemeSoftware.ps1"'
$Delete_InfoSoftware = 'Remove-Item "C:\Windows\Temp\InfoDuSystemeSoftware.ps1"'

$Exe_script_InfoHardware = 'powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\InfoDuSystemeHardware.ps1"'
$Delete_InfoHardware = 'Remove-Item "C:\Windows\Temp\InfoDuSystemeHardware.ps1"'

# Menu principal
while ($true) {

    Write-Host "Choisissez la machine sur laquelle vous voulez vous connecter :`n" -f $GREEN
    Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Client UBUNTU 1" -f $NC
    Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Client UBUNTU 2" -f $NC
    Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Quitter`n" -f $NC

    $machine = Read-Host "Votre choix "

    switch ($machine) {

        # Menu pour Ubuntu 1
        "1" {
            # Variable pour retourner au menu précédent
            $continueUbuntu1 = $true
            while ($continueUbuntu1) {

                Write-Host "`nMenu Client UBUNTU 1 :`n" -f $GREEN
                Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Actions" -f $NC
                Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Informations" -f $NC
                Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Retour au menu principal" -f $NC
                Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Quitter le script`n" -f $NC
                $action = Read-Host "Choisissez une option "

                switch ($action) {

                    # Menu actions pour Ubuntu 1
                    "1" {
                        # Variable pour retourner au menu précédent
                        $continueActions = $true
                        while ($continueActions) {

                            Write-Host "`nMenu action Client UBUNTU 1 :`n" -f $GREEN
                            Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Gestion utilisateurs" -f $NC
                            Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Gestion des groupes" -f $NC
                            Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Gestion du système" -f $NC
                            Write-Host "[4] " -f $YELLOW -NoNewline; Write-Host "Gestion des Répertoires" -f $NC
                            Write-Host "[5] " -f $YELLOW -NoNewline; Write-Host "Prise en main CLI" -f $NC
                            Write-Host "[6] " -f $YELLOW -NoNewline; Write-Host "Gestion Logiciel" -f $NC
                            Write-Host "[7] " -f $YELLOW -NoNewline; Write-Host "Gestion du Parefeu" -f $NC
                            Write-Host "[8] " -f $YELLOW -NoNewline; Write-Host "Retour au menu précédent" -f $NC
                            Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Fin du script`n" -f $NC
                            $gestion = Read-Host "Votre choix "

                            switch ($gestion) {
                                "1" { 
                                    scp C:\script_action\UserControl.ps1 ${user1}:/C:/Windows/Temp/UserControl.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_User"
                                    ssh -t $user1 "powershell.exe -Command $Delete_User" 
                                }
                                "2" { 
                                    scp C:\script_action\GroupControl.ps1 ${user1}:/C:/Windows/Temp/GroupControl.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Group"
                                    ssh -t $user1 "powershell.exe -Command $Delete_Group"
                                }
                                "3" { 
                                    scp C:\script_action\GestionDuSysteme.ps1 ${user1}:/C:/Windows/Temp/GestionDuSysteme.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_System"
                                    ssh -t $user1 "powershell.exe -Command $Delete_System" 
                                }
                                "4" { 
                                    scp C:\script_action\GestionDesRepertoires.ps1 ${user1}:/C:/Windows/Temp/GestionDesRepertoires.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Repertoire"
                                    ssh -t $user1 "powershell.exe -Command $Delete_Repertoire" 
                                }
                                "5" { 
                                    ssh -t $user1 
                                }
                                "6" { 
                                    scp C:\script_action\GestionLogiciel.ps1 ${user1}:/C:/Windows/Temp/GestionLogiciel.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Logiciel"
                                    ssh -t $user1 "powershell.exe -Command $Delete_Logiciel" 
                                }
                                "7" { 
                                    scp C:\script_action\GestionParefeu.ps1 ${user1}:/C:/Windows/Temp/GestionParefeu.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Parefeu"
                                    ssh -t $user1 "powershell.exe -Command $Delete_Parefeu"
                                }

                                "8" { 
                                    $continueActions = $false
                                }
                                "x" { 
                                    Write-Host "`nExit`n" -f $YELLOW
                                    exit 
                                }
                                default { 
                                    Write-Host "`n[Erreur]! Option invalide, veuillez réessayer !`n" -f $RED 
                                }
                            }
                        }
                    }

                    # Menu informations pour Ubuntu 1
                    "2" {
                        
                        # Variable pour retourner au menu précédent
                        $continueInformations = $true
                        while ($continueInformations) {

                            Write-Host "`nMenu informations Client UBUNTU 1 :`n" -f $GREEN
                            Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Informations Utilisateur" -f $NC
                            Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Informations Système Software" -f $NC
                            Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Informations Système Hardware" -f $NC
                            Write-Host "[4] " -f $YELLOW -NoNewline; Write-Host "Retour au menu précédent" -f $NC
                            Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Fin du script`n" -f $NC
                            $information = Read-Host "Votre choix "

                            switch ($information) {
                                "1" { 
                                    scp C:\script_information\InfoUtilisateur.ps1 ${user1}:/C:/Windows/Temp/InfoUtilisateur.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_InfoUser "
                                    ssh -t $user1 "powershell.exe -Command $Delete_InfoUser"
                                }
                                "2" { 
                                    scp C:\script_information\InfoDuSystemeSoftware.ps1 ${user1}:/C:/Windows/Temp/InfoDuSystemeSoftware.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_InfoSoftware"
                                    ssh -t $user1 "powershell.exe -Command $Delete_InfoSoftware"
                                }
                                "3" { 
                                    scp C:\script_information\InfoDuSystemeHardware.ps1 ${user1}:/C:/Windows/Temp/InfoDuSystemeHardware.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_InfoHardware"
                                    ssh -t $user1 "powershell.exe -Command $Delete_InfoHardware"
                                }
                                "4" { 
                                    $continueInformations = $false
                                }
                                "x" { 
                                    Write-Host "`nExit`n" -f $YELLOW
                                    exit 
                                }
                                default { 
                                    Write-Host "`n[Erreur]! Option invalide, veuillez réessayer !`n" -f $RED 
                                }
                            }
                        }
                    }

                    "3" {
                        $continueUbuntu1 = $false
                    }
                    "x" {
                        Write-Host "`nExit`n" -f $YELLOW
                        exit
                    }
                    default { 
                        Write-Host "`n[Erreur]! Option invalide, veuillez réessayer !`n" -f $RED 
                    }
                }
            }
        }

        "2" {
            # Variable pour retourner au menu précédent
            $continueUbuntu2 = $true
            while ($continueUbuntu2) {

                Write-Host "`nMenu Client UBUNTU 2 :`n" -f $GREEN
                Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Actions" -f $NC
                Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Informations" -f $NC
                Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Retour au menu principal" -f $NC
                Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Quitter le script`n" -f $NC
                $action = Read-Host "Choisissez une option "

                switch ($action) {

                    "1" {
                        # Variable pour retourner au menu précédent
                        $continueActions = $true
                        while ($continueActions) {

                            Write-Host "`nMenu action Client UBUNTU 2 :`n" -f $GREEN
                            Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Gestion utilisateurs" -f $NC
                            Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Gestion des groupes" -f $NC
                            Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Gestion du système" -f $NC
                            Write-Host "[4] " -f $YELLOW -NoNewline; Write-Host "Gestion des Répertoires" -f $NC
                            Write-Host "[5] " -f $YELLOW -NoNewline; Write-Host "Prise en main CLI" -f $NC
                            Write-Host "[6] " -f $YELLOW -NoNewline; Write-Host "Gestion Logiciel" -f $NC
                            Write-Host "[7] " -f $YELLOW -NoNewline; Write-Host "Gestion du Parefeu" -f $NC
                            Write-Host "[8] " -f $YELLOW -NoNewline; Write-Host "Retour au menu précédent" -f $NC
                            Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Fin du script`n" -f $NC
                            $gestion = Read-Host "Votre choix "

                            switch ($gestion) {
                                "1" { 
                                    scp C:\script_action\UserControl.ps1 ${user1}:/C:/Windows/Temp/UserControl.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_User"
                                    ssh -t $user1 "powershell.exe -Command $Delete_User"
                                }
                                "2" { 
                                    scp C:\script_action\GroupControl.ps1 ${user1}:/C:/Windows/Temp/GroupControl.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Group"
                                    ssh -t $user1 "powershell.exe -Command $Delete_Group"
                                }
                                "3" { 
                                    scp C:\script_action\GestionDuSysteme.ps1 ${user1}:/C:/Windows/Temp/GestionDuSysteme.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_System "
                                    ssh -t $user1 "powershell.exe -Command $Delete_System"
                                }
                                "4" { 
                                    scp C:\script_action\GestionDesRepertoires.ps1 ${user1}:/C:/Windows/Temp/GestionDesRepertoires.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Repertoire"
                                    ssh -t $user1 "powershell.exe -Command $Delete_Repertoire"
                                }
                                "5" { 
                                    ssh -t $user2 
                                }
                                "6" { 
                                    scp C:\script_action\GestionLogiciel.ps1 ${user1}:/C:/Windows/Temp/GestionLogiciel.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Logiciel"
                                    ssh -t $user1 "powershell.exe -Command $Delete_Logiciel"
                                }
                                "7" { 
                                    scp C:\script_action\GestionParefeu.ps1 ${user1}:/C:/Windows/Temp/GestionParefeu.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_Parefeu"
                                    ssh -t $user1 "powershell.exe -Command $Delete_Parefeu"
                                }

                                "8" { 
                                    $continueActions = $false
                                }
                                "x" { 
                                    Write-Host "`nExit`n" -f $YELLOW
                                    exit 
                                }
                                default { 
                                    Write-Host "`n[Erreur]! Option invalide, veuillez réessayer !`n" -f $RED 
                                }
                            }
                        }
                    }

                    # Menu informations pour Ubuntu 2
                    "2" {
                        # Variable pour retourner au menu précédent
                        $continueInformations = $true
                        while ($continueInformations) {

                            Write-Host "`nMenu informations Client UBUNTU 2 :`n" -f $GREEN
                            Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Informations Utilisateur" -f $NC
                            Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Informations Système Software" -f $NC
                            Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Informations Système Hardware" -f $NC
                            Write-Host "[4] " -f $YELLOW -NoNewline; Write-Host "Retour au menu précédent" -f $NC
                            Write-Host "[x] " -f $YELLOW -NoNewline; Write-Host "Fin du script`n" -f $NC
                            $information = Read-Host "Votre choix "

                            switch ($information) {
                                "1" { 
                                    scp C:\script_information\InfoUtilisateur.ps1 ${user1}:/C:/Windows/Temp/InfoUtilisateur.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_InfoUser "
                                    ssh -t $user1 "powershell.exe -Command $Delete_InfoUser"
                                }
                                "2" {
                                    scp C:\script_information\InfoDuSystemeSoftware.ps1 ${user1}:/C:/Windows/Temp/InfoDuSystemeSoftware.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_InfoSoftware"
                                    ssh -t $user1 "powershell.exe -Command $Delete_InfoSoftware" 
                                }
                                "3" { 
                                    scp C:\script_information\InfoDuSystemeHardware.ps1 ${user1}:/C:/Windows/Temp/InfoDuSystemeHardware.ps1
                                    ssh -t $user1 "powershell.exe -Command $Exe_script_InfoHardware"
                                    ssh -t $user1 "powershell.exe -Command $Delete_InfoHardware"
                                }
                                "4" { 
                                    $continueInformations = $false
                                }
                                "x" { 
                                    Write-Host "`nExit`n" -f $YELLOW
                                    exit 
                                }
                                default { 
                                    Write-Host "`n[Erreur]! Option invalide, veuillez réessayer !`n" -f $RED 
                                }
                            }
                        }
                    }

                    "3" {
                        $continueUbuntu2 = $false
                    }
                    "x" {
                        Write-Host "`nExit`n" -f $YELLOW
                        exit
                    }
                    default { 
                        Write-Host "`n[Erreur]! Option invalide, veuillez réessayer !`n" -f $RED 
                    }
                }
            }
        }
        "x" {
            Write-Host "`nExit`n" -f $YELLOW
            exit
        }
        default {
            Write-Host "`n[Erreur]! Option invalide, veuillez réessayer !`n" -f $RED
        }
    }
} 
