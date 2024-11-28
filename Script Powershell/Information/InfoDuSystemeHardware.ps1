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
WriteLog "********StartScriptInfoDuSystemeHardware********"
WriteLog "Navigation dans le menu informations hardware du systeme"

# Boucle while true pour le menu information système
while ($true) {
    Write-Host "`n<=== MENU INFORMATION SYSTEME HARDWARE ===>`n" -f $GREEN
    Write-Host "[1] " -f $CYAN -nonewline; Write-Host "Type de CPU, nombre de coeurs, etc.." -f $NC
    Write-Host "[2] " -f $CYAN -nonewline; Write-Host "Mémoire RAM totale" -f $NC
    Write-Host "[3] " -f $CYAN -nonewline; Write-Host "Utilisation de la RAM" -f $NC
    Write-Host "[4] " -f $CYAN -nonewline; Write-Host "Utilisation du disque" -f $NC
    Write-Host "[5] " -f $CYAN -nonewline; Write-Host "Utilisation du processeur " -f $NC
    Write-Host "[6] " -f $CYAN -nonewline; Write-Host "Retour au menu principal`n" -f $NC
    $choix = Read-Host "Veuillez choisir une option  "
    
    # Switch pour les choix du menu 
    switch ($choix) {

       # Type de CPU, nombres de coeurs, etc..
       "1" {
            Write-Host ""
            Get-WmiObject -Class Win32_Processor | Select-Object -Property Name, NumberOfCores, NumberOfEnableCore, NumberOfLogicalProcessors, Manufacturer
            Write-Host ""
            WriteLog "Consultation du Type de CPU, nombre de coeurs, etc.."
            }

        # Mémoire totale de la RAM
        "2" {
            $ramTotal = (Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1GB
            Write-Host ("`nLa mémoire totale de la RAM est de {0:N1} Go`n" -f $ramTotal) -ForegroundColor $YELLOW
            WriteLog "Consultation de la memoire totale de la RAM"
            }

        # Utilisation de la RAM
        "3" {
             Get-CimInstance -ClassName Win32_OperatingSystem | ForEach-Object {
             $usedMemory = ($_.TotalVisibleMemorySize - $_.FreePhysicalMemory) / 1MB
             $totalMemory = $_.TotalVisibleMemorySize / 1MB
             Write-Host ("`nUtilisation de la mémoire : {0:N1} Go sur {1:N1} Go`n" -f $usedMemory, $totalMemory) -f $YELLOW
             WriteLog "Consultation de l'utilisation de la RAM"
             }
             }
            
        # Utilisation du disque
        "4" {
            Write-Host ""
            Get-WmiObject Win32_LogicalDisk | ForEach-Object {
            "$($_.DeviceID) - FreeSpace: $([math]::Round($_.FreeSpace / 1GB, 2)) GB, Size: $([math]::Round($_.Size / 1GB, 2)) GB, VolumeName: $($_.VolumeName)"
            }
            Write-Host ""
            WriteLog "Consultation de l'utilisation du disque"
            }
            
        # Utilisation du processeur
        "5" {
             Get-CimInstance -ClassName Win32_Processor | ForEach-Object {
             Write-Host ("`nUtilisation du processeur : {0}%`n" -f $_.LoadPercentage) -f $YELLOW
             WriteLog "Consultation de l'utilisation du processeur"
            }
            }

        # Retour au menu principal
        "6" {
            WriteLog "********EndScriptInfoDuSystemeHardware********"
            return
            }

        # Inique si erreur de saisie et relance le script
        default {
            Write-Host "[Erreur]! Option invalide, veuillez réessayer !`n" -f $RED
            }
    }
} 
# Fin du script
