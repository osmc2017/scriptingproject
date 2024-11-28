# Installation et configuration Admin

## Machines Virtuelles Requises

- **Serveur Debian 12**
- **Client Ubuntu**
- **Serveur Windows Server 2022**
- **Client Windows 10 Pro**

### Configuration Réseau
Toutes les machines virtuelles (VM) doivent être configurées avec une carte réseau "PONT" et une carte réseau "interne" pour permettre les mises à jours potentielle et la communication entre les systèmes.

---

## Étape 1 : Création des Machines Virtuelles

### 1.1 Serveur Debian 12
Créez une nouvelle VM avec les paramètres suivants :

| **Paramètre**       | **Valeur**               |
|---------------------|--------------------------|
| **Nom**             | `SRVLX01`                |
| **OS**              | Linux (Debian 64-bit)    |
| **PROC**            | 2 coeurs                 |
| **RAM**             | 2 Go                     |
| **Disque**          | 25 Go                    |
| **Carte réseau 1**  | PONT                     |
| **Carte réseau 2**  | Interne (nom : `Intnet`) |

Une fois la machine créée, configurez les éléments suivants :
- **Compte utilisateur** : `root`
- **Mot de passe** : `Azerty1***`
- **Adresse IP fixe** : `172.16.10.10/24`

Démarrez la VM avec l’ISO de Debian 12 et suivez les étapes d’installation. Configurez l’adresse IP statique :
- **IP** : `172.16.10.10`
- **Masque** : `255.255.255.0`

---

### 1.2 Client Ubuntu
Créez une nouvelle VM avec les paramètres suivants :

| **Paramètre**       | **Valeur**               |
|---------------------|--------------------------|
| **Nom**             | `CLILIN01`               |
| **OS**              | Linux (Ubuntu 64-bit)    |
| **PROC**            | 2 coeurs                 |
| **RAM**             | 2 Go                     |
| **Disque**          | 25 Go                    |
| **Carte réseau 1**  | PONT                     |
| **Carte réseau 2**  | Interne (nom : `Intnet`) |

Une fois la machine créée, configurez les éléments suivants :
- **Compte utilisateur** : `wilder` (dans le groupe des admins locaux)
- **Mot de passe** : `Azerty1***`
- **Adresse IP fixe** : `172.16.10.30/24`

Démarrez la VM avec l’ISO d’Ubuntu et suivez les étapes d’installation. Configurez l’adresse IP statique :
- **IP** : `172.16.10.30`
- **Masque** : `255.255.255.0`

---

### 1.3 Serveur Windows Server 2022
Créez une nouvelle VM avec les paramètres suivants :

| **Paramètre**       | **Valeur**               |
|---------------------|--------------------------|
| **Nom**             | `SRVWIN01`               |
| **OS**              | Windows Server 2022      |
| **PROC**            | 2 coeurs                 |
| **RAM**             | 2 Go                     |
| **Disque**          | 25 Go                    |
| **Carte réseau 1**  | PONT                     |
| **Carte réseau 2**  | Interne (nom : `Intnet`) |

Une fois la machine créée, configurez les éléments suivants :
- **Compte utilisateur** : `Administrator` (dans le groupe des admins locaux)
- **Mot de passe** : `Azerty1***`
- **Adresse IP fixe** : `172.16.10.5/24`

Démarrez la VM avec l’ISO de Windows Server 2022 et suivez les étapes d’installation. Configurez l’adresse IP statique :
- **IP** : `172.16.10.5`
- **Masque** : `255.255.255.0`

---

### 1.4 Client Windows 10 PRO
Créez une nouvelle VM avec les paramètres suivants :

| **Paramètre**       | **Valeur**               |
|---------------------|--------------------------|
| **Nom**             | `CLIWIN01`               |
| **OS**              | Windows 10 PRO      |
| **PROC**            | 2 coeurs                 |
| **RAM**             | 2 Go                     |
| **Disque**          | 25 Go                    |
| **Carte réseau 1**  | PONT                     |
| **Carte réseau 2**  | Interne (nom : `Intnet`) |

Une fois la machine créée, configurez les éléments suivants :
- **Compte utilisateur** : `wilder` (dans le groupe des admins locaux)
- **Mot de passe** : `Azerty1*`
- **Adresse IP fixe** : `172.16.10.20/24`

Démarrez la VM avec l’ISO de Windows Server 2022 et suivez les étapes d’installation. Configurez l’adresse IP statique :
- **IP** : `172.16.10.20`
- **Masque** : `255.255.255.0`

---
  
## Étape 2 : Configuration des IPs Statiques

### Configuration des IPs sous Debian et Ubuntu
1. **Ouvrir le fichier de configuration réseau :**

`sudo nano /etc/network/interfaces`

Modifier les paramètres IP en ajoutant :

`auto eth0 iface eth0 inet static`<br> 
`address 172.16.10.x` # Remplacer x par l'IP de la machine<br> 
`netmask 255.255.255.0`

---

## Étape 3 : Configuration d'une IP Statique sous Windows

1. Ouvrir les paramètres de la carte réseau :
   - Cliquez sur le menu Démarrer, tapez "Panneau de configuration" et ouvrez-le.
   - Allez dans "Réseau et Internet" > "Centre Réseau et partage".
   - Cliquez sur "Modifier les paramètres de la carte" à gauche.

2. Choisir la carte réseau :
   - Faites un clic droit sur la carte réseau (ex : Ethernet) et sélectionnez "Propriétés".

3. Configurer IPv4 :
   - Sélectionnez "Protocole Internet version 4 (TCP/IPv4)" et cliquez sur "Propriétés".
   - Cochez "Utiliser l'adresse IP suivante".
   - Renseignez les champs :
     - Adresse IP : 172.16.10.x (remplacez `x` par l'IP de la machine, ex : 172.16.10.20).
     - Masque de sous-réseau : 255.255.255.0.

4. Appliquer et tester :
   - Cliquez sur "OK", puis "Fermer".
   - Ouvrez l'invite de commandes (Win + R, tapez `cmd`).
   - Tapez `ipconfig` pour vérifier l'adresse IP.
   - Testez la connectivité : `ping 172.16.10.x`.

Votre IP statique est maintenant configurée.

---

# Étape 3 : Configuration SSH et Accès Sans Mot de Passe

## 3.1 Configuration SSH sur les Machines Linux (Debian et Ubuntu)

### Vérification de l'installation de SSH
1. **Vérifiez si OpenSSH est installé :**
   - Vérifier la version de SSH :
     ```bash
     sshd -V
     ```
   - Si OpenSSH n'est pas installé, installez-le avec la commande suivante :
     ```bash
     sudo apt install openssh-server
     ```
   - Vérifiez l'installation après :
     ```bash
     sshd -V
     ```

2. **Activation et démarrage du service SSH :**
   - Activez SSH pour qu'il démarre automatiquement au démarrage :
     ```bash
     sudo systemctl enable ssh
     ```
   - Démarrez le service SSH :
     ```bash
     sudo systemctl start ssh
     ```
   - Vérifiez le statut du service :
     ```bash
     sudo systemctl status ssh
     sudo systemctl status sshd
     ```

### Configuration réseau pour les connexions
1. **Vérification de la connectivité réseau** :
   - Mettez les machines sur le même réseau (VM en mode pont) et redémarrez le service réseau :
     ```bash
     sudo systemctl restart networking  # ou sudo systemctl restart NetworkManager
     ```
   - Vérifiez l'IP de la machine :
     ```bash
     ip a
     ```
   - Testez la connectivité réseau entre les machines :
     ```bash
     ping <adresse_ip>
     ```

### Déploiement des Clés SSH pour un Accès Sans Mot de Passe
1. **Sur le serveur Linux : Générer une clé SSH** :
   - Exécutez la commande suivante pour générer une clé SSH :
     ```bash
     ssh-keygen -t ecdsa
     ```
     - Acceptez les paramètres par défaut, pas de passphrase nécessaire.

2. **Vérification de la clé générée** :
   - Vérifiez que la clé est présente :
     ```bash
     ls -a ~/.ssh  # Vérifier si id_ecdsa.pub est bien là
     ```

3. **Déployer la clé SSH publique du serveur vers le client** :
   - Copiez la clé publique vers le client avec la commande suivante :
     ```bash
     ssh-copy-id -i ~/.ssh/id_ecdsa.pub client@<ip_client>
     ```
     Vous devrez entrer le mot de passe du client une dernière fois.

4. **Vérification sur les deux machines** :
   - Vérifiez que la clé publique est présente sur le serveur :
     ```bash
     cat ~/.ssh/id_ecdsa.pub  # Sur le serveur
     ```
   - Vérifiez sur le client :
     ```bash
     cat ~/.ssh/authorized_keys  # Sur le client
     ```

5. **Connexion SSH sans mot de passe** :
   - Testez la connexion SSH sans mot de passe :
     ```bash
     ssh client@<ip_client>
     ```
   - Si tout est configuré correctement, la connexion ne vous demandera pas de mot de passe.

---

## 3.2 Configuration SSH sur Windows (Client et Serveur Windows)

### Vérification des Services SSH
1. **Vérification du service SSH sur le client Windows :**
   - Vérifiez si le service SSH est installé :
     ```powershell
     get-service sshd
     ```

2. **Installation et activation de SSH sur le client Windows :**
   - Activez la fonctionnalité client SSH sur Windows via les **Fonctionnalités facultatives** dans les paramètres.
   - Si le serveur SSH n'est pas installé, installez-le via **Paramètres > Applications > Fonctionnalités facultatives > Ajouter une fonctionnalité > Serveur OpenSSH**.

3. **Activation du service OpenSSH sur Windows (client) :**
   - Exécutez PowerShell en tant qu'administrateur et activez OpenSSH :
     ```powershell
     get-service sshd | Set-Service -StartupType Automatic
     ```
   - Démarrez le service SSH :
     ```powershell
     Restart-Service sshd
     ```

4. **Vérification que le service fonctionne :**
   - Vérifiez le statut du service SSH :
     ```powershell
     get-service sshd
     ```

### Connexion SSH et Déploiement des Clés SSH entre Windows et Linux

1. **Vérification de la connexion SSH depuis le serveur :**
   - Testez la connexion SSH du serveur vers le client Windows :
     ```bash
     ssh client@<ip_client> powershell
     ```
     Entrez le mot de passe si demandé, puis tapez `exit`.

2. **Sur le serveur Windows, générer une clé SSH :**
   - Ouvrez PowerShell et générez une clé SSH :
     ```powershell
     ssh-keygen -t ecdsa
     ```

3. **Vérification de la clé générée sur Windows :**
   - Vérifiez où se trouve la clé et si elle a été générée :
     ```powershell
     Set-Location c:\Users\client\.ssh\
     Get-ChildItem
     ```

4. **Déploiement de la clé SSH publique de Windows vers le client :**
   - Copiez la clé publique depuis le serveur Windows vers le client Windows :
     ```powershell
     Get-Content -path .\.ssh\id_ecdsa.pub | ssh client@<ip_client> "echo $(cat >> ~/.ssh/authorized_keys)"
     ```

5. **Désactivation de la demande de mot de passe sur le client Windows :**
   - Ouvrez le fichier de configuration du service SSH sur le client Windows :
     ```powershell
     notepad C:\ProgramData\ssh\sshd_config
     ```
   - Commentez la ligne suivante :
     ```plaintext
     Match Group administrators
     ```
   - Sauvegardez et redémarrez le service SSH :
     ```powershell
     Restart-Service sshd
     ```

6. **Testez la connexion SSH sans mot de passe :**
   - Testez la connexion sans mot de passe :
     ```powershell
     ssh client@<ip_client>
     ```

---

## 3.3 Connexions SSH Inter-Systèmes (Linux ↔ Windows)

### Déploiement de clés entre Linux (Ubuntu) et Windows

1. **Depuis Ubuntu vers Windows :**
   - Copiez la clé publique depuis Ubuntu vers Windows :
     ```bash
     ssh-copy-id -i ~/.ssh/id_ecdsa.pub client@<ip_windows_client>
     ```

2. **Depuis Windows vers Ubuntu :**
   - Copiez la clé publique de Windows vers Ubuntu :
     ```powershell
     Get-Content -path .\.ssh\id_ecdsa.pub | ssh client@<ip_ubuntu_client> "echo $(cat >> ~/.ssh/authorized_keys)"
     ```

3. **Vérification de la connexion SSH :**
   - Testez la connexion SSH depuis Ubuntu vers Windows ou vice versa :
     ```bash
     ssh client@<ip_windows_client>  # ou pour Ubuntu
     ```

Si tout est configuré correctement, vous pourrez vous connecter sans mot de passe.
