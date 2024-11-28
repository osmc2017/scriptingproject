# MODULE GESTION DES REPERTOIRES

# Définition des couleurs avec ForegroundColor
$RED = "Red"
$GREEN = "Green"
$YELLOW = "Yellow"
$Cyan= "Cyan"
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
WriteLog "********StartScriptGestionDesRepertoires********"
WriteLog "Navigation dans le menu de gestion des repertoires"

# fonction de création de répertoires
function dirCreation {

    WriteLog "Navigation dans le menu de creation de repertoires"
    $cheminActuel = Get-Location
    $userChoiceDirLocation = "" # Variable pour le choix d'emplacement
    Write-Host "`n=== CREER UN REPERTOIRE ===" -f $GREEN
    Write-Host "`nSouhaitez-vous créer votre dossier dans le répertoire courant ($cheminActuel) ou dans un autre emplacement ? `n" -f $YELLOW
    Write-Host "[1] " -f $Cyan -NoNewline; Write-Host "Emplacement actuel" -f $NC
    Write-Host "[2] " -f $Cyan -NoNewline; Write-Host "Autre emplacement" -f $NC
    Write-Host "[3] " -f $Cyan -NoNewline; Write-Host "Retour au menu precedent`n" -f $NC
    $userChoiceDirLocation = Read-Host "Veuillez choisir une option "

    # tant que l'option 3 n'est pas choisie, proposer les options

    while ($userChoiceDirLocation -ne "3") {
        if ($userChoiceDirLocation -eq "1") {
            $newDirectory = Read-Host "`nNom du répertoire "
            # si le répertoire n'existe pas encore dans le dossier courant, on crée le répertoire
            if (-Not (Test-Path $newDirectory)) {
                New-Item -ItemType Directory -Name $newDirectory
                Write-Host "`nLe répertoire '$newDirectory' a bien été crée." -f $YELLOW
                WriteLog "Le répertoire '$newDirectory' a été crée a l'emplacement $cheminActuel"
            } else {
                Write-Host "`nCe répertoire existe deja." -f $RED
            }
        } elseif ($userChoiceDirLocation -eq "2") {
            $newLocationDir = Read-Host "`nVeuillez saisir l'emplacement "
            $newDirectory = Read-Host "`nNom du répertoire "

            # vérifie si le chemin de l'emplacement est valide, et si non, création des répertoires intermédiaires
            if (-Not (Test-Path $newLocationDir)) {
                Write-Host "Cet emplacement n'existe pas, creation du nouveau chemin" -f $RED
                New-Item -ItemType Directory -Path "$newLocationDir\$newDirectory" -Force
                Write-Host "Répertoire crée a l'emplacement $newLocationDir\$newDirectory`n"
                WriteLog "Répertoire crée a l'emplacement $newLocationDir\$newDirectory"
            # dans le cas où l'emplacement existe, création du nouveau répertoire
            } else {
                New-Item -ItemType Directory -Path "$newLocationDir\$newDirectory" -Force
                Write-Host "Répertoire crée a l'emplacement $newLocationDir\$newDirectory`n"
                WriteLog "Répertoire crée a l'emplacement $newLocationDir\$newDirectory"
            }
        } else {
            Write-Host "`n[ERREUR] ! Veuillez saisir une option valide.`n" -f $RED
        }

        # Relecture ici pour relancer la boucle
        Write-Host "`n=== CREER UN REPERTOIRE ===" -f $GREEN
        Write-Host "`nSouhaitez-vous créer votre dossier dans le répertoire courant ($cheminActuel) ou dans un autre emplacement ? `n" -f $YELLOW
        Write-Host "[1] " -f $YELLOW -NoNewline; Write-Host "Emplacement actuel" -f $NC
        Write-Host "[2] " -f $YELLOW -NoNewline; Write-Host "Autre emplacement" -f $NC
        Write-Host "[3] " -f $YELLOW -NoNewline; Write-Host "Retour au menu precedent`n" -f $NC
        $userChoiceDirLocation = read-host "Veuillez choisir une option "

    }

}

# fonction de modification des répertoires
function dirModification {

    Write-Host "`n=== MODIFIER UN REPERTOIRE ===`n" -f $GREEN
    $userDirLocation = Read-Host "Entrez l'emplacement et le nom du répertoire a modifier (chemin complet) "

    # vérification de l'existence de l'emplacement/du répertoire
    if (-Not (Test-Path $userDirLocation)) {
        Write-Host "`nL'emplacement du répertoire a modifier est introuvable." -f $RED
    } else {
        # récupération en deux variables, emplacement et nom du répertoire et récupération du nouveau nom dans une nouvelle variable
        $userDirPath = Split-Path $userDirLocation -Parent
        $userDirName = Split-Path $userDirLocation -Leaf
        $userModDir = Read-Host "`nVeuillez renommer le répertoire '$userDirName' située dans $userDirPath "

        # vérification si l'entrée utilisateur est vide
        if ([string]::IsNullOrEmpty($userModDir)) {
            Write-Host "`nIl ne peut y avoir de nom de répertoire vide." -f $RED
        } else {
            Rename-Item -Path $userDirLocation -NewName "$userDirPath\$userModDir" -ErrorAction Stop
            Write-Host "`nLe dossier '$userDirName' a été renommé en '$userModDir'" -f $YELLOW
            WriteLog "Le dossier $userDirName a été renommé en $userModDir"
        }
    }
}


# fonction de suppression des répertoires
function dirDeletion {
    
    Write-Host "`n=== SUPPRIMER UN REPERTOIRE ===`n" -f $GREEN
    $userDirLocation = Read-Host "Entrez l'emplacement et le nom du répertoire a supprimer (chemin complet) "

    # vérification de l'existence du répertoire
    if (-Not (Test-Path $userDirLocation)) {
        Write-Host "`nL'emplacement du répertoire a supprimer est introuvable." -f $RED
    } else {
        # confirmation avant choix de suppression. Ici on récupère le nom du répertoire depuis le chemin complet.
        $userDirName = Split-Path $userDirLocation -Leaf
        $shortAnswer = Read-Host "`nVoulez-vous vraiment supprimer '$userDirName' ? (oui/non) "

        if ($shortAnswer -eq "oui" -or $shortAnswer -eq "o") {
            Remove-Item -Path $userDirLocation -Recurse -Force -ErrorAction Stop
            Write-Host "`nLe répertoire '$userDirName' a bien été supprimé." -f $YELLOW
            WriteLog "Le répertoire $userDirName a été supprimé."
        } else {
            Write-Host "`nRetour au menu precedent"
        }
    }
}

# Options de gestion de répertoires
# tant que l'option 4 n'est pas choisie, proposer les options

$userChoiceDir = ""

while ($userChoiceDir -ne "4") {
    Write-Host "`n<=== GESTION DES REPERTOIRES ===>" -f $GREEN
    Write-Host "`n[1]" -f $Cyan -NoNewline; Write-Host " Création de répertoire" -f $NC
    Write-Host "[2]" -f $Cyan -NoNewline; Write-Host " Modification de répertoire" -f $NC
    Write-Host "[3]" -f $Cyan -NoNewline; Write-Host " Suppression de répertoire" -f $NC
    Write-Host "[4]" -f $Cyan -NoNewline; Write-Host " Retour au menu précédent`n" -f $NC
    $userChoiceDir = Read-Host "Veuillez choisir une option "


    # appel des fonctions en fonction des options choisies
    switch ($userChoiceDir) {
        "1" { dirCreation }
        "2" { dirModification }
        "3" { dirDeletion }
        "4" { Write-Host "Retour dans le menu precedent"; WriteLog "********EndScriptGestionDesRepertoires********"}
        default { Write-Host "`n[ERREUR] ! Veuillez saisir une option valide.`n" -f $RED }
    }
}
