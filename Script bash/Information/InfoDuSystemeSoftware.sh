#!/bin/bash


#couleur

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
        echo -e "${RED}La cible n'est pas  valide, elle doit être à 0 (hôte) ou à 1 (utilisateur)${NC} \n"
        return 1
    fi

    # générer le fichier
    local fileName="$HOME/Documents/${infoType}_${target}_$(date +%Y-%m-%d).txt"

    # récupérer la sortie et l'insérer dans le fichier texte
    echo "$commandLine" > "$fileName"
    echo -e "\n${YELLOW}Les informations concernant ${NC}$infoType${YELLOW} ont été enregistrées dans ${NC}$fileName$"
}


function showOsVersion {

    # filtre en conservant la première ligne du fichier os-release, puis sed s'occupe de traiter le texte d'affichage et supprime le texte corrsponsant à PRETTY_NAME et aux guillements

    local commandLine=$(grep '^PRETTY_NAME=' /etc/os-release | sed 's/^PRETTY_NAME="//;s/"$//')
    echo -e "La version du systeme d'exploitation est : $commandLine"
    gatherInfo "infoOsVersion" 0 "$(date +%Y-%m-%d)" "$commandLine"
}

function showNbDisks {

    # lsblk liste les périphériques de stockage, ces options ne retiennent que les disques en affichant le path complet sur lequel on applique un filtre pour ne conserver que les "disk", ensuite wc compte son apparition.
    
    local commandLine=$(lsblk -d -n -p | grep ' disk ' | wc -l)
    echo -e "Nombre de disque(s) présent(s) sur la machine : $commandLine"
    gatherInfo "infoNbDisks" 0 "$(date +%Y-%m-%d)" "$commandLine"
}

function showPartsByDisks {

    # même principe, mais le filtre conserve les partitions relatives au ou aux disque(s)
    
    local commandLine=$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT | grep -E 'disk|part')
    echo -e "\nListe des partitions par disque : \n" 
    echo -e "$commandLine"
    gatherInfo "infoPartsByDisks" 0 "$(date +%Y-%m-%d)" "$commandLine"
}

function showInstalledAppPackages {

    echo -e " ${GREEN}<< AFFICHER DES EXECUTABLES >>${NC} \n \n Souhaitez-vous afficher les paquets installés ou les applications installées? \n ${CYAN}[1]${NC} paquets installés \n ${CYAN}[2]${NC} applications installées \n ${CYAN}[3]${NC} Retour au menu précédent \n \n Choisir le chiffre correspondant à l'option:"

    read userChoiceInfoApp

    while [[ $userChoiceInfoApp != "3" ]]; do

        if [[ $userChoiceInfoApp == "1" ]]; then

            # liste uniquement les paquets installés en excluant ceux prêts à être désinstallés.
            local commandLine=$(dpkg --get-selections | grep -v deinstall)
            echo -e "\nListe des paquets déjà installés : \n"
            echo -e "$commandLine"
            if [[ $? = 0 ]]; then
                gatherInfo "infoInstalledPack" 0 "$(date +%Y-%m-%d)" "$commandLine"
                break
            else
                echo -e "${RED}Une erreur est survenue${NC}"
                break
            fi

            

        elif [[ $userChoiceInfoApp == "2" ]]; then

            # liste les applications avec interface graphique (exécutables à destination d'utilisateur) tout en retirant la partie texte de l'extension de fichier .desktop
            local commandLine=$(ls /usr/share/applications/ | sed 's/\.desktop$//')
            echo -e "Liste des applications (exécutables avec interface graphique) installées : \n"
            echo -e "$commandLine"
            if [[ $? = 0 ]]; then
                gatherInfo "infoInstalledApp" 0 "$(date +%Y-%m-%d)" "$commandLine"
                break
            else
                echo -e "${RED}Une erreur est survenue${NC}"
                break
            fi
            
            

        else 
            echo -e "${RED}Veuillez saisir une option valide${NC}\n"

        fi
    done

}

function showRunningServices {

    # récupère la liste des type services, état en cours, désactive la pagination de sortie, quiet pour ne conserver que l'essentiel des lignes, plain pour enlever le formatage de sortie. Enfin awk ne conserve que la première colonne de sortie correspondant au nom dans les résultats de systemctl
    local commandLine=$(systemctl list-units --type=service --state=running --no-pager --quiet --plain | awk '{print $1}')
    echo -e "\nListe des services en cours : \n"
    echo -e "$commandLine"
    gatherInfo "infoServices" 0 "$(date +%Y-%m-%d)" "$commandLine"

    #systemctl list-units --type=service --state=running
}

function showLocalUsers {

    # on récupère le champ 3 de la liste dans /etc/passwd, qui correspond à l'UID de l'utilisateur. Comme les utilisateurs dont l'UID est supérieur ou égal à 1000 ne sont pas des utilisateurs "système" mais plutôt ceux nécessitant d'ouvrir une session, ou en d'autres termes des humains, pour les distinguer d'une autre liste. En champ 6 on filtre ceux disposant d'un répertoire /home et on finit par récupérer uniquement le début de la ligne pour obtenir uniquement le nom de l'utilisateur. Le filtre de l'UID permet d'éviter d'obtenir des utilisateurs tels que "syslog" ou "cups-pk-helper" qui ne seraient pas pertinents.
    local commandLine=$(awk -F: '$3 >= 1000 && $6 ~ /^\/home/ {print $1}' /etc/passwd)
    echo -e "Liste des utilisateurs locaux : \n"
    echo -e "$commandLine"
    gatherInfo "infoLocalUsers" 0 "$(date +%Y-%m-%d)" "$commandLine"



}


userChoiceDir=""

while [[ $userChoiceDir != "x" ]]; do

    echo -e "\n ${GREEN}------ MENU INFORMATION SOFTWARE ------${NC} \n \n ${CYAN}[1]${NC} Afficher la version de l'OS \n ${CYAN}[2]${NC} Afficher le nombre de disques \n ${CYAN}[3]${NC} Afficher les partitions par disque \n ${CYAN}[4]${NC} Afficher la liste des applications/paquets installés \n ${CYAN}[5]${NC} Afficher la liste des services en cours d'exécution \n ${CYAN}[6]${NC} Afficher la liste des utilisateurs locaux \n ${CYAN}[7]${NC} Revenir au menu précédent \n \n ${GREEN}Veuillez choisir une option :${NC}"
    read userChoiceDir

    case "$userChoiceDir" in 

        1)
            showOsVersion
            ;;
        2)
            showNbDisks
            ;;
        3)
            showPartsByDisks
            ;;
        4)
            showInstalledAppPackages
            ;;
        5)
            showRunningServices
            ;;
        6)
            showLocalUsers
            ;;
        7)
            echo "Retour au menu précédent"
            break
            ;;
        *)
            echo -e "\n Veuillez choisir une option valide \n"
            ;;
    esac
done
