#!/bin/bash

#Définir les couleurs des variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # Aucune couleur

statut=1

while [ $statut = 1 ]
do
	echo -e "${GREEN}\n------ MENU GESTION DU SYSTEME ------\n"
	echo -e "${CYAN}[1]${NC} Arreter le systeme"
	echo -e "${CYAN}[2]${NC} Redemarrer le systeme"
	echo -e "${CYAN}[3]${NC} Verrouiller le systeme"
	echo -e "${CYAN}[4]${NC} Mettre à jour le systeme"
	echo -e "${CYAN}[5]${NC} Retourner au menu principal\n"
	echo -e "${GREEN}Veuillez choisir une option:${NC}"
	read choix_option

	case $choix_option in

 		# case: Arrêt du systeme
		"1")
		echo ""
		read -p "Voulez-vous vraiment arreter le systeme? (oui/non)": reponse
		while [ $reponse != "non" ] && [ $reponse != "n" ];
		do
			if [ $reponse = "oui" ] || [ $reponse = "o" ]
			then 
				echo -e "\nLe systeme est en cours d'arret..."
				#Executer la commande d'arret du systeme
				sudo shutdown now	
				exit 1
			else 
				echo -e "\n${RED}Erreur lors de la saisie\n${NC}"
				read -p "Voulez-vous vraiment arreter le systeme? (oui/non)": reponse
			fi
		done
		# Dans le cas ou reponse= non ou n, on retourne au menu précédent
		echo -e "\nRetour au menu des options du systeme"
		;;

  		#case: Redemarrage du systeme
		"2") 
  		echo ""
		read -p "Voulez-vous vraiment redemarrer le systeme? (oui/non)": reponse
		while [ $reponse != "non" ] && [ $reponse != "n" ];
		do
			if [ $reponse = "oui" ] || [ $reponse = "o" ]
			then 
				echo -e "\nLe systeme est en cours de redemarrage..."
				#Executer la commande de redemarrage du systeme
				sudo reboot
				exit 1
			else 
				echo -e "${RED}Erreur lors de la saisie\n${NC}"
				read -p "Voulez-vous vraiment redemarrer le systeme? (oui/non)": reponse
			fi
		done
		# Dans le cas ou reponse= non ou n, on retourne au menu précédent
		echo -e "\nRetour au menu des options du systeme"
		;;

  		#case: Verrouillage du systeme
		"3")
		echo -e "\nVerouillage du systeme en cours..."
		sleep 3
		loginctl lock-session
		exit 1
		;;

  		# case: Mise à jour du systeme
		"4")
		echo -e "\nRecherche des mises a jour disponibles..."
		sudo apt update
		UPGRADABLE=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | wc -l)

		if [ "$UPGRADABLE" -eq 0 ]; 
		then
			echo -e "${YELLOW}\nAucune mise à jour n'est disponible${NC}"
		else
			echo -e "${YELLOW}\nListe des mises a jour disponibles:"
			apt list --upgradable
			echo ""
			read -p "Voulez-vous installer les mises a jour? (oui/non): " reponse
   
			while [ "$reponse" != "non" ] && [ "$reponse" != "n" ];
			do
				if [ "$reponse" = "oui" ] || [ "$reponse" = "o" ]
				then 
					# Exécuter la commande de mise à jour du système
					sudo apt upgrade -y
					break
				else 
					echo -e "${RED}\nErreur lors de la saisie\n${NC}"
					read -p "Voulez-vous installer les mises a jour? (oui/non): " reponse
				fi
			done
		fi
		echo -e "\nRetour au menu des options du systeme"
		;;

		# Retour au menu principale
		"5")
		statut=0
		;;

		# Indique si erreur de saisie et relance le script 
		"*")
        	echo -e "${RED}\n[Erreur]! Option invalide, veuillez réessayer !${NC}"
       		;;
		
	esac	
done
