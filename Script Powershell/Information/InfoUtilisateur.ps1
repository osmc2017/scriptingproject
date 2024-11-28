# Creation des variables Couleurs
$Green = "Green"
$Yellow = "Yellow"
$White = "White"
$Red = "Red"
$Cyan= "Cyan"

# Demande le nom de l'utilisateur
$user = Read-Host -Prompt "Entrez le nom de l'utilisateur "

# Vérifie qu'un nom d'utilisateur a été fourni
if (-not $user) 
{
    Write-Host "Vous devez entrer un nom d'utilisateur."
    exit
}

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
WriteLog "********StartScriptInfoUtilisateur********"
WriteLog "Navigation dans le menu informations de $User"

$statut = $true

while ($statut) 
{
    Write-Host "`n<=== MENU INFORMATIONS UTILISATEUR ===>`n" -f $Green
    Write-Host "[1]" -f $Cyan -NoNewline ; Write-Host " Date de dernière connexion" -f $White;
    Write-Host "[2]" -f $Cyan -NoNewline ; Write-Host " Date de dernière modification du mot de passe" -f $White;
    Write-Host "[3]" -f $Cyan -NoNewline ; Write-Host " Liste des sessions ouvertes" -f $White;
    Write-Host "[4]" -f $Cyan -NoNewline ; Write-Host " Groupes d'appartenance" -f $White;
    Write-Host "[5]" -f $Cyan -NoNewline ; Write-Host " Historique des commandes" -f $White;
    Write-Host "[6]" -f $Cyan -NoNewline ; Write-Host " Droits sur un dossier" -f $White;
    Write-Host "[7]" -f $Cyan -NoNewline ; Write-Host " Droits sur un fichier" -f $White;
    Write-Host "[8]" -f $Cyan -NoNewline ; Write-Host " Retour au menu précédent`n" -f $White;
    $choix_option = Read-Host "Veuillez choisir une option "

 switch ($choix_option) 
 {	

	# Date de derniere connexion
	"1" 
	{
 	    WriteLog "Consultation de la date de dernier connexion de $User"
	    Write-Host "`nDate de dernière connexion :`n" -f $YELLOW
	    $lastLogin = (Get-LocalUser -Name $user).LastLogon
            if ($lastLogin) 
	    {
                Write-Host $lastLogin
            } 
	    else
	    {
                Write-Host "Aucune connexion enregistrée pour cet utilisateur"
            }
	}

  	#  Date de derniere modification du mot de passe
        "2" 
	{
 	    WriteLog "Consultation de la date de dernière modification du mot de passe de $User"
	    Write-Host "`nDate de derniere modification du mot de passe :`n" -f $YELLOW
	    $passwordLastSet = (Get-LocalUser -Name $user).PasswordLastSet
            if ($passwordLastSet) 
	    {
                Write-Host $passwordLastSet
            } 
	    else
	    {
                Write-Host "`nDate de dernière modification du mot de passe non disponible"
            }
	}

  	# Liste des sessions ouvertes
	"3" 
	{
 	    WriteLog "Consultation des sessions ouvertes par $User"
	    Write-Host "`nSessions ouvertes par l'utilisateur :`n" -f $YELLOW
	    $sessions = query user | Select-String $user
            if ($sessions) 
	    {
                $sessions | ForEach-Object { Write-Host $_ }
            } 
	    else 
	    {
                Write-Host "`nAucune session ouverte pour cet utilisateur"
            }
	}

	# Groupes d'appartenance
	"4"
	{
		WriteLog "Consultation des groupes d'appartenance de $user"
		Write-Host "`nGroupes d'appartenance de $user :`n" -f $YELLOW
		$groups = Get-LocalGroup | Where-Object {
   		(Get-LocalGroupMember -Group $_.Name | Where-Object { $_.Name -like "*$user" })
		} | Select-Object -ExpandProperty Name

		if ($groups) 
		{
			$groups -join ", " | Write-Host
		} 
		else 
		{
			Write-Host "Aucun groupe trouvé pour l'utilisateur $user"
		}
	}

	# Historique des commandes
	"5" 
	{
 		WriteLog "Consultation de l'historique des commandes de $User"
		Write-Host "`nHistorique des commandes hors script :`n" -F $YELLOW
		#L'historique des commandes est stocké dans un fichier, par exemple : C:\Users\<NomUtilisateur>\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
		$historyPath = "C:\Users\$user\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
		if (Test-Path $historyPath) 
		{
            		Get-Content $historyPath 
	      		Write-Host "`nEn cours de developpement: Historique Complete des commandes" -f $Yellow
		} 
		else 
		{
         		Write-Host "`nAucun historique des commandes trouve pour l'utilisateur"
		}
	}

  	# Droits sur un dossier
	"6" 
	{
		$folderPath = Read-Host "`nEntrez le chemin du dossier "
		Write-Host "`nDroits sur le dossier :`n" -f $Yellow
		Get-Acl -Path $folderPath | ForEach-Object { $_.Access | Where-Object { $_.IdentityReference -match $user } }
		WriteLog "Consultation des Droits de $User sur le dossier $folderPath"
	}

  	# Droits sur un fichier
	"7" 
	{
		$filePath = Read-Host "`nEntrez le chemin du fichier "
		Write-Host "`nDroits sur le fichier :`n" -f $Yellow
		Get-Acl -Path $filePath | ForEach-Object { $_.Access | Where-Object { $_.IdentityReference -match $user } }
		WriteLog "Consultation des Droits de $User sur le fichier $filePath"
	}

  	# Retour au menu principal 
	"8" 
	{
		WriteLog "********EndScriptInfoUtilisateur********"
  		$statut = $false
	}
 
         # Indique si erreur de saisie et relance le script    
        default {
            Write-Host "[ERREUR]! Option invalide, veuillez reessayer !`n" -f $RED
	}
    }	
}		
