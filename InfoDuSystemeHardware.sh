#!/bin/bash

# Définir les couleurs des variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
GREY='\033[0;30m'
NC='\033[0m' # Aucune couleur

# la fonction gatherInfo permet de récupérer les informations demandées et de les stocker dans fichier texte dans les Documents de l'utilisateur.

function gatherInfo {


    local infoType=$1 # variable qui récupère le type d'info récolté. Les variables locales ont une portée limitée, l'attribution d'une valeur n'est valable que dans la fonction, localement, où elles sont définies.
    local target=$2 # le type de cible, user = 1 (true) ou host = 0 (false)
    local date=$3 # va récupérer la date à laquelle est exécutée la commande
    local commandLine=$4 # va contenir la ligne de commande dont on a besoin à deux reprises, à la fois pour afficher le résultat direct et pour l'enregistrer

    # l'information concerne la cible utilisateur ou ordinateur
    if [[ $target -eq 1 ]]; then
        target=$USER # si target est vrai, alors on récupère l'utilisateur courant
    elif [[ $target -eq 0 ]]; then
        target=$HOSTNAME # si target est faux, alors on récupère l'hôte
    else 
        echo -e "La cible n'est pas  valide, elle doit être à 0 (hôte) ou à 1 (utilisateur) \n"
        return 1
    fi

    # générer le fichier
    local fileName="$HOME/Documents/${infoType}_${target}_$(date +%Y-%m-%d).txt"

    # récupérer la sortie et l'insérer dans le fichier texte
    echo "$commandLine" > "$fileName"
    echo -e "\n${YELLOW}Les informations concernant ${NC}$infoType${YELLOW} ont été enregistrées dans ${NC}$fileName$"
}


# Boucle while true pour faire un menu sur les informations systèmes
while true; do
    echo -e "\n${GREEN}------ MENU INFORMATION SYSTEME HARDWARE ------\n"
    echo -e "${CYAN}[1]${NC} Type de CPU, nombre de coeurs, etc.."
    echo -e "${CYAN}[2]${NC} Mémoire RAM totale"
    echo -e "${CYAN}[3]${NC} Utilisation de la RAM"
    echo -e "${CYAN}[4]${NC} Utilisation du disque"
    echo -e "${CYAN}[5]${NC} Utilisation du processeur "
    echo -e "${CYAN}[6]${NC} Retour au menu principal\n"
    echo -e "${GREEN}Veuillez choisir une option : ${NC}"
    read choix
    
    # Case pour faire un bloc avec les choix correspondants au menu 
    case $choix in

       # Type de CPU, nombres de coeurs, etc..
       1)
            commandLine=$(lscpu)
            echo -e "$commandLine"
            gatherInfo "infoSysComponents" 0 "$(date +%Y-%m-%d)" "$commandLine"
            echo ""
            ;;

        # Mémoire totale de la RAM
        2)
            commandLine=$(free -h | grep Mem | awk '{print $2}')
            echo -e "$commandLine"
            gatherInfo "infoMemoRam" 0 "$(date +%Y-%m-%d)" "$commandLine"
            echo ""
            ;;

        # Utilisation de la RAM
        3)
            commandLine=$(free -h)
            echo -e "$commandLine"
            gatherInfo "infoMemoRamUsage" 0 "$(date +%Y-%m-%d)" "$commandLine"
            echo ""
            ;;
            
        # Utilisation du disque
        4)
            commandLine=$(df -h)
            echo -e "$commandLine"
            gatherInfo "infoDiskUsage" 0 "$(date +%Y-%m-%d)" "$commandLine"
            echo ""
            ;;
            
        # Utilisation du processeur
        5)
            commandLine=$(top -b -n 1)
            echo -e "$commandLine"
            gatherInfo "infoProcUsage" 0 "$(date +%Y-%m-%d)" "$commandLine"
            echo ""
            ;;
            
        # Retour au menu principal
        6)
            break
            ;;

        # Inique si erreur de saisie et relance le script
        *)
            echo -e "${RED}[Erreur]! Option invalide, veuillez réessayer !${NC}\n"
            ;;
    esac
done 
# Fin du script
