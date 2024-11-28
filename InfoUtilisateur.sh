#!/bin/bash

# Attribution des variables de couleurs
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

# Demande le nom d'utilisateur
read -p "Entrez le nom de l'utilisateur : " Utilisateur

# Vérifie qu'un nom d'utilisateur a été fourni
if [ -z "$USER" ]; 
then
    echo -e "${RED}Erreur: Aucun nom d'utilisateur saisie${NC}"
    read -p "Entrez le nom de l'utilisateur : " Utilisateur
fi

statut=1

# Boucle pour afficher le menu et gérer les choix de l'utilisateur
while [ $statut = 1 ]
do
    echo -e "\n${GREEN}----- MENU INFORMATIONS UTILISATEUR -----\n"
    echo -e "${CYAN}[1]${NC} Date de dernière connexion"
    echo -e "${CYAN}[2]${NC} Date de dernière modification du mot de passe"
    echo -e "${CYAN}[3]${NC} Liste des sessions ouvertes"
    echo -e "${CYAN}[4]${NC} Groupes d'appartenance"
    echo -e "${CYAN}[5]${NC} Historique des commandes"
    echo -e "${CYAN}[6]${NC} Droits sur un dossier"
    echo -e "${CYAN}[7]${NC} Droits sur un fichier"
    echo -e "${CYAN}[8]${NC} Retour au menu precedent\n"
    echo -e "${GREEN}Veuillez choisir une option :${NC}" 
    read CHOIX
    
    case $CHOIX in

		# Date de dernière connexion d’un utilisateur
		"1")
			echo -e "\nDate de dernière connexion de $Utilisateur:"
			commandLine=$(lastlog -u "$Utilisateur")
			echo -e "$commandLine"
			gatherInfo "infoLastLog" 1 "$(date +%Y-%m-%d)" "$commandLine"
		;;
		
		# Date de dernière modification du mot de passe
		"2")
			echo -e "\nDate de dernière modification du mot de passe :"
        	commandLine=$(chage -l "$Utilisateur" | grep "Last password change")
			echo -e "$commandLine"
    		gatherInfo "infoLastPswd" 1 "$(date +%Y-%m-%d)" "$commandLine"
		;;

		# Liste des sessions ouvertes par l'utilisateur
		"3")
			echo -e "\nSessions ouvertes par l'utilisateur $Utilisateur:"
			commandLine=$(who | grep "$Utilisateur" || echo -e "\nAucune session ouverte")
			echo -e "$commandLine"
			gatherInfo "infoOpenSess" 1 "$(date +%Y-%m-%d)" "$commandLine"
		;;

		# Groupe d’appartenance d’un utilisateur
		"4")
			echo -e "\nGroupes d'appartenance:"
			commandLine=$(groups "$Utilisateur")
			echo -e "$commandLine"
			gatherInfo "infoBlgGroups" 1 "$(date +%Y-%m-%d)" "$commandLine"
		;;

		# Historique des commandes exécutées par l'utilisateur
		"5")
		
		HIST_FILE="/home/$Utilisateur/.bash_history"
		if [ -f "$HIST_FILE" ]; 
		then
			echo -e "\nHistorique des 20 dernières commandes hors script:"
			commandLine=$(tail -n 20 "$HIST_FILE") # Affiche les 20 dernières commandes pour limiter la sortie
			echo -e "$commandLine"
			echo -e "\n${YELLOW}En cours de developpement: Historique complete des commandes${NC}"
    		gatherInfo "infoCmdHist" 1 "$(date +%Y-%m-%d)" "$commandLine"
		else
			echo -e "\nHistorique indisponible ou l'utilisateur $Utilisateur n'a pas de fichier .bash_history"
		fi
		;;

		# Droits/permissions de l’utilisateur sur un dossier
		"6")
		echo -e "\nDroits sur un dossier spécifique :"
      		read -p "Entrez le chemin complet du dossier : " CHEMIN_DOSSIER
        	if [ -d "$CHEMIN_DOSSIER" ]; then
		
				commandLine="Dossier: $CHEMIN_DOSSIER"
				
				# Vérification des droits de lecture
				r_permission=$(sudo -u "$Utilisateur" [ -r "$CHEMIN_DOSSIER" ] && echo -e "\nLecture : Oui \n" || echo -e "\nLecture : Non\n")
				commandLine="$commandLine$r_permission"  # Ajoute/concatène le résultat de la lecture
				
				# Vérification des droits d'écriture
				w_permission=$(sudo -u "$Utilisateur" [ -w "$CHEMIN_DOSSIER" ] && echo -e "\nÉcriture : Oui\n" || echo -e "\nÉcriture : Non\n")
				commandLine="$commandLine$w_permission"  # Ajoute/concatène le résultat de l'écriture
				
				# Vérification des droits d'exécution
				e_permission=$(sudo -u "$Utilisateur" [ -x "$CHEMIN_DOSSIER" ] && echo -e "\nExécution : Oui\n" || echo -e "\nExécution : Non\n")
				commandLine="$commandLine$e_permission"  # Ajoute/concatène le résultat de l'exécution

    				echo -e "$commandLine" 
				
				# Passer l'ensemble de la sortie à gatherInfo
				gatherInfo "infoFolderPermissions" 1 "$(date +%Y-%m-%d)" "$commandLine"
        	else
            		echo -e "\nLe dossier n'existe pas"
        	fi
		;;

		# Droits/permissions de l’utilisateur sur un fichier
		"7")
		echo -e "\nDroits sur un fichier spécifique :"
       		read -p "Entrez le chemin complet du fichier : " CHEMIN_FICHIER
		if [ -f "$CHEMIN_FICHIER" ]; then

				commandLine="Fichier: $CHEMIN_FICHIER"
				
				# Vérification des droits de lecture
				r_permission=$(sudo -u "$Utilisateur" [ -r "$CHEMIN_FICHIER" ] && echo -e "\nLecture : Oui \n" || echo -e "\nLecture : Non\n")
				commandLine="$commandLine$r_permission"  # Ajoute/concatène le résultat de la lecture
				
				# Vérification des droits d'écriture
				w_permission=$(sudo -u "$Utilisateur" [ -w "$CHEMIN_FICHIER" ] && echo -e "\nÉcriture : Oui\n" || echo -e "\nÉcriture : Non\n")
				commandLine="$commandLine$w_permission"  # Ajoute/concatène le résultat de l'écriture
				
				# Vérification des droits d'exécution
				e_permission=$(sudo -u "$Utilisateur" [ -x "$CHEMIN_FICHIER" ] && echo -e "\nExécution : Oui\n" || echo -e "\nExécution : Non\n")

    				echo -e "$commandLine" 
	
				commandLine="$commandLine$e_permission"  # Ajoute/concatène le résultat de l'exécution
				
				# Passer l'ensemble de la sortie à gatherInfo
				gatherInfo "infoFilePermissions" 1 "$(date +%Y-%m-%d)" "$commandLine"
		else
			echo -e "\nLe fichier n'existe pas"
		fi
		;;
		
		# Retour au menu precedent
		"8")
		statut=0
		;;

		*)
		echo -e "\n${RED}Erreur: Veuillez choisir une des options suivantes"
		;;
			
	esac	
done
