#!/bin/bash
# Script projet 2 Lionel => partie Groupe
# connexion ssh à une machine distante en amont via le script MainScript.sh
# choix des sections avec boucle while

# Définir les couleurs des variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # Aucune couleur

# Variables pour les logs
log_file="/var/log/log_evt.log"  # Chemin vers le fichier de log
remote_server="lbartaire@192.168.90.90"  # IP du serveur distant pour l'envoi des logs

# Fonction pour enregistrer les logs dans le fichier avec le bon format
enregistrer_log() {
    local message=$1
    local log_time=$(date "+%Y%m%d-%H%M%S")  # Format: 20241114-105127
    local user=$(whoami)  # Nom de l'utilisateur actuel
    local log_message="${log_time}-${user}-${message}"
    
    # Ajouter le log au fichier avec sudo pour éviter les problèmes de permission
    echo "$log_message" | sudo tee -a $log_file > /dev/null
}

# Fonction pour envoyer les logs vers le serveur distant via SSH
envoyer_logs_distants() {
    echo "Transfert des logs vers le serveur distant..."
    sudo scp $log_file $remote_server:/var/log/log_evt.log
}

while true; do
    echo -e "${GREEN}\n------ MENU GROUPE ------\n "
    echo -e "${CYAN}[1]${NC} Ajout à un groupe"
    echo -e "${CYAN}[2]${NC} Quitter le groupe"
    echo -e "${CYAN}[3]${NC} Retour au menu précédent\n"
    echo -e "Veuillez choisir une option :"
    read choix

    # A chaque choix correspond une commande qui exécute l'action demandée et boucle tant que l'utilisateur ne choisit pas quitter
    case $choix in

        1)      # Ajout à un groupe
            echo -e "\nListe des groupes :"
            groups
            echo ""
            read -p "Dans quel groupe voulez-vous ajouter l'utilisateur ? " add_group
            sudo usermod -aG $add_group $USER
            enregistrer_log "Ajout de l'utilisateur $USER au groupe $add_group"
            envoyer_logs_distants  # Envoi des logs au serveur distant
            ;;

        2)      # Quitter un groupe
            echo -e "\nListe des groupes :"
            groups
            echo ""
            read -p "Quel groupe voulez-vous quitter ? (choisissez parmi la liste ci-dessus) " groupe_a_quitter

            # Vérifier si l'utilisateur fait partie de ce groupe
            if groups "$USER" | grep -qw "$groupe_a_quitter"; then
                sudo gpasswd -d $USER "$groupe_a_quitter"
                echo -e "\nvous avez bien quitté le groupe $groupe_a_quitter\n"
                # Enregistrer l'action dans les logs
                enregistrer_log "L'utilisateur $USER a quitté le groupe $groupe_a_quitter"
                # Envoyer les logs au serveur distant
                envoyer_logs_distants
            else
                echo -e "\nVous n'êtes pas membre du groupe $groupe_a_quitter ou ce groupe n'existe pas."
            fi
            ;;

        3)      # Retour au menu précédent
            echo -e "\nRetour au menu précédent"
            enregistrer_log "Retour au menu précédent"
            envoyer_logs_distants  # Envoi des logs au serveur distant
            break
            ;;

        *)      # Erreur
            echo -e "${RED}\nErreur : choix invalide, veuillez recommencer"
            enregistrer_log "Erreur de saisie, choix invalide"
            envoyer_logs_distants  # Envoi des logs au serveur distant
            ;;

    esac
done
