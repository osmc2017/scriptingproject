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
WriteLog "********StartScriptUserControl********"
WriteLog "Navigation dans le menu de gestion des utilisateurs"

# Fonction pour lister les utilisateurs locaux
function UsersList {
    $users = Get-LocalUser | Where-Object { $_.Name -notlike "Administrator" }
    $users | ForEach-Object { $_.Name }
}

# Fonction pour créer un utilisateur
function UsersCreate {
    write-Host ""
    $new_user = Read-Host "Entrez le nom du compte utilisateur à créer "
    try {
        write-Host ""
        New-LocalUser -Name $new_user -Password (Read-Host "Entrez un mot de passe pour le compte " -AsSecureString)
        Write-Host "`nL'utilisateur '$new_user' a été créé avec succès." -f $YELLOW
        WriteLog "Utilisateur $new_user cree avec succes"
    } catch {
        Write-Host "Erreur lors de la création de l'utilisateur."
    }
}

# Fonction pour modifier un mot de passe
function ChangePasswd {
    $users = UsersList
    Write-Host "`nListe des utilisateurs :`n" -f $YELLOW
    $users | ForEach-Object { Write-Host $_ }
    WriteLog "Consultation de la liste des utilisateurs"
    write-Host ""
    $userpassw_change = Read-Host "Pour quel utilisateur voulez-vous modifier le mot de passe ? "
    if ($users -contains $userpassw_change) {
        write-Host ""
        $new_password = Read-Host "Entrez le nouveau mot de passe " -AsSecureString
        Set-LocalUser -Name $userpassw_change -Password $new_password
        Write-Host "`nMot de passe modifié pour l'utilisateur '$userpassw_change'." -f $YELLOW
        WriteLog "Mot de passe modifie pour l'utilisateur $userpassw_change"
    } else {
        Write-Host "Utilisateur non trouvé."
    }
}

# Fonction pour supprimer un utilisateur
function UsersDelete {
    $users = UsersList
    Write-Host "`nListe des utilisateurs :`n" -f $YELLOW
    $users | ForEach-Object { Write-Host $_ }
    WriteLog "Consultation de la liste des utilisateurs"
    write-Host ""
    $delete_user = Read-Host "Quel compte utilisateur voulez-vous supprimer ? "
    if ($users -contains $delete_user) {
        try {
            Remove-LocalUser -Name $delete_user
            Write-Host "`nLe compte utilisateur '$delete_user' a bien été supprimé." -f $YELLOW
            WriteLog "Compte utilisateur $delete_user supprime"
        } catch {
            Write-Host "Erreur lors de la suppression de l'utilisateur."
        }
    } else {
        Write-Host "Utilisateur non trouvé."
    }
}

# Fonction pour désactiver un utilisateur
function UsersDesactivate {
    # Obtenir la liste des utilisateurs locaux
    $users = Get-LocalUser | Select-Object -ExpandProperty Name
    Write-Host "`nListe des utilisateurs :`n" -f $YELLOW
    
    # Afficher chaque utilisateur
    $users | ForEach-Object { Write-Host $_ }
    
    # Demander à l'utilisateur quel compte désactiver
    write-Host ""
    $desactivate_user = Read-Host "Quel compte utilisateur souhaitez-vous désactiver ? "
    
    # Vérifier si le compte existe et désactiver l'utilisateur
    if ($users -contains $desactivate_user) {
        Disable-LocalUser -Name $desactivate_user
        Write-Host "`nLe compte utilisateur '$desactivate_user' a été désactivé." -f $YELLOW
    } else {
        Write-Host "Utilisateur non trouvé."
    }
}

# Menu principal avec boucle
while ($true) {
    Write-Host "`n<=== MENU GESTION DES UTILISATEURS ===>`n" -f $Green
    Write-Host "[1] "  -ForegroundColor $CYAN -NoNewline; Write-Host "Créer un compte utilisateur"
    Write-Host "[2] "  -ForegroundColor $CYAN -NoNewline; Write-Host "Modifier un mot de passe"
    Write-Host "[3] "  -ForegroundColor $CYAN -NoNewline; Write-Host "Supprimer un compte utilisateur"
    Write-Host "[4] "  -ForegroundColor $CYAN -NoNewline; Write-Host "Désactiver un compte utilisateur"
    Write-Host "[5] "  -ForegroundColor $CYAN -NoNewline; Write-Host "Retour au menu précédent`n"
    
    $choix = Read-Host "Veuillez choisir une option "
    
    switch ($choix) {
        "1" {
            UsersCreate
        
        }
        "2" {
            ChangePasswd
        }
        "3" {
            UsersDelete
        }
        "4" {
            UsersDesactivate
        }
        "5" {
            Write-Host "Retour au menu précédent"
            WriteLog "********EndScriptUserControl********"
            return
        }

        default {
            Write-Host "Choix invalide, veuillez recommencer."
        }
    }
}
