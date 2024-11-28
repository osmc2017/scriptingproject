######################################################################################
# Script de gestion des utilisateurs
# Ce script permet de créer, modifier, supprimer ou désactiver des comptes utilisateurs
# et enregistre les actions dans un fichier de log partagé avec le serveur distant.
######################################################################################

# Définition des couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # Aucune couleur

# Variables
remote_server="lbartaire@192.168.90.90" # IP du serveur distant
log_file="/var/log/log_evt.log" # Chemin vers le fichier de log

# Fonction pour afficher la liste de tous les utilisateurs
lister_utilisateurs() {
    echo -e "\n${CYAN}Liste des utilisateurs existants :${NC}"
    # On suppose que les utilisateurs humains ont des shells comme /bin/bash, /bin/zsh, etc.
    awk -F: '{ if ($7 == "/bin/bash" || $7 == "/bin/zsh") print $1 }' /etc/passwd
    echo -e "\n"
}

# Fonction pour enregistrer les logs dans le fichier avec le bon format
enregistrer_log() {
    local message=$1
    local log_time=$(date "+%Y%m%d-%H%M%S") # Format: 20241114-105127
    local user=$(whoami)  # Nom de l'utilisateur actuel
    local log_message="${log_time}-${user}-${message}"
    
    # Ajouter le log au fichier avec sudo pour éviter les problèmes de permission
    echo "$log_message" | sudo tee -a $log_file > /dev/null
}

# Fonction pour envoyer les logs vers le serveur distant via SSH
envoyer_logs_distants() {
    # Transfert des logs vers le serveur distant
    echo "Transfert des logs vers le serveur distant..."
    sudo scp $log_file $remote_server:/var/log/log_evt.log
}

# Choix des sections avec boucle while
while true; do
    echo -e "${GREEN}\n------ MENU COMPTE UTILISATEUR ------\n"
    echo -e "${CYAN}[1]${NC} Créer un compte utilisateur"
    echo -e "${CYAN}[2]${NC} Modifier un MDP"
    echo -e "${CYAN}[3]${NC} Supprimer un compte utilisateur"
    echo -e "${CYAN}[4]${NC} Désactiver un compte utilisateur"
    echo -e "${CYAN}[5]${NC} Retour au menu précédent\n"
    echo -e Veuillez choisir le chiffre correspondant à l'option:"
    read choix
    
    # A chaque choix correspond une commande qui exécute l'action demandée et boucle tant que l'utilisateur ne choisit pas quitter
    case $choix in
        1)
            lister_utilisateurs  # Afficher la liste de tous les utilisateurs avant de créer un nouvel utilisateur
            echo ""
            read -p "Quel est le nom du compte utilisateur à créer? " new_user
            sudo adduser $new_user
            enregistrer_log "Création du compte utilisateur $new_user"
            envoyer_logs_distants  # Envoi des logs au serveur distant
            ;;
        2)
            lister_utilisateurs  # Afficher la liste de tous les utilisateurs avant de modifier un mot de passe
            echo ""
            read -p "Le mot de passe de quel utilisateur voulez-vous modifier? " userpasswd_change
            sudo passwd $userpasswd_change
            enregistrer_log "Modification du mot de passe de l'utilisateur $userpasswd_change"
            envoyer_logs_distants  # Envoi des logs au serveur distant
            ;;
        3)
            lister_utilisateurs  # Afficher la liste de tous les utilisateurs avant de supprimer un utilisateur
            echo ""
            read -p "Quel compte utilisateur voulez-vous supprimer? " delete_user
            sudo userdel $delete_user
            enregistrer_log "Suppression du compte utilisateur $delete_user"
            envoyer_logs_distants  # Envoi des logs au serveur distant
            ;;
        4)
            lister_utilisateurs  # Afficher la liste de tous les utilisateurs avant de désactiver un utilisateur
            echo ""
            read -p "Quel compte utilisateur souhaitez-vous désactiver? " desactivate_user
            sudo chage -E 0 $desactivate_user
            enregistrer_log "Désactivation du compte utilisateur $desactivate_user"
            envoyer_logs_distants  # Envoi des logs au serveur distant
            ;;
        5) # Retour au menu précédent
            echo -e "\nRetour au menu précédent"
            enregistrer_log "Retour au menu précédent"
            envoyer_logs_distants  # Envoi des logs au serveur distant
            break
            ;;
        *)  # Erreur
            echo -e "${RED}\nErreur: choix invalide, veuillez recommencer${NC}"
            ;;
    esac
done

