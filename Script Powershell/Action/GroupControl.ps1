# Script PowerShell pour gérer les utilisateurs sous Windows
# Quelques tests à finir + ajouter couleurs

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

# log lancement du script
WriteLog "********StartScriptGroupControl********"
WriteLog "Navigation dans le menu de gestion des groupes"

# Fonction pour lister les groupes
function GroupsList {
    Get-LocalGroup | Select-Object -ExpandProperty Name
    WriteLog "Consultation de la liste des groupes"
}

# Fonction pour ajouter un utilisateur à un groupe
function GroupAdd {
    # Demander le nom du groupe
    write-Host ""
    $group = Read-Host "Dans quel groupe voulez-vous ajouter l'utilisateur ? "
    
    # Vérifier si le groupe existe
    if (Get-LocalGroup -Name $group -ErrorAction SilentlyContinue) {
        # Obtenir le nom de l'utilisateur actuel
        $username = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
        
        # Ajouter l'utilisateur au groupe
        try {
            Add-LocalGroupMember -Group $group -Member $username
            Write-Host "Ajout de $username au groupe $group réussi."
            
            # Vérifier si la fonction WriteLog est définie, puis appeler WriteLog si elle existe
            if (Get-Command -Name WriteLog -ErrorAction SilentlyContinue) {
                WriteLog "Ajout de $username au groupe $group"
            } else {
                Write-Host "Log non enregistré : la fonction WriteLog est introuvable."
            }
        } catch {
            Write-Host "Erreur lors de l'ajout de l'utilisateur au groupe : $_"
        }
    } else {
        Write-Host "Le groupe '$group' n'existe pas."
    }
}

# Fonction pour quitter un groupe
function GroupRemove {
    # Obtenir l'utilisateur actuel
    $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    
    # Vérifier les groupes auxquels appartient l'utilisateur actuel
    $currentGroups = Get-LocalGroup | ForEach-Object {
        if (Get-LocalGroupMember -Group $_.Name -Member $currentUser -ErrorAction SilentlyContinue) {
            $_.Name
        }
    }
    
    # Sélectionner le premier groupe (ou spécifier le groupe cible si nécessaire)
    $currentGroup = $currentGroups | Select-Object -First 1

    if (-not $currentGroup) {
        Write-Host "Vous n'appartenez à aucun groupe local."
        return
    }

    # Demander confirmation à l'utilisateur pour quitter le groupe
    $response = Read-Host "Voulez-vous quitter votre groupe actuel ($currentGroup)? (oui ou non)"
    
    if ($response -eq "oui") {
        # Retirer l'utilisateur du groupe
        Remove-LocalGroupMember -Group $currentGroup -Member $currentUser
        Write-Host "Vous avez bien quitté votre groupe"
        
        # Vérifier si WriteLog est défini avant de l'appeler
        if (Get-Command -Name WriteLog -ErrorAction SilentlyContinue) {
            WriteLog "L'utilisateur $currentUser a quitté le groupe $currentGroup"
        } else {
            Write-Host "Log non enregistré : la fonction WriteLog est introuvable."
        }
    } else {
        Write-Host "Vous restez dans votre groupe actuel"
    }
}

# Boucle du menu
while ($true) {
    Write-Host "`n<=== MENU GESTION DES GROUPES ===>`n" -f $Green
    Write-Host "[1] " -ForegroundColor $CYAN -NoNewline; Write-Host "Ajouter à un groupe"
    Write-Host "[2] " -ForegroundColor $CYAN -NoNewline; Write-Host "Quitter le groupe"
    Write-Host "[3] " -ForegroundColor $CYAN -NoNewline; Write-Host "Retour au menu précédent`n"
    $choix = Read-Host "Veuillez choisir une option "

    switch ($choix) {
        "1" {
            Write-Host "`nListe des groupes :`n" -f $Yellow
            GroupsList
            GroupAdd
        }
        "2" {
            GroupRemove
        }
        "3" {
            Write-Host "Retour au menu précédent"
            WriteLog "********EndScriptGroupControl********"
            return
        }

        default {
            Write-Host "Choix invalide, veuillez recommencer"
        }
    }
}
