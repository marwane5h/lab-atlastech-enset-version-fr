# Rapport de TP — Déploiement & Administration d'un serveur Linux (AtlasTech)

**Établissement :** ENSET Mohammedia  
**Filière :** LP ACSRC (2026–2027)  
**Module :** Administration Linux (LPIC-1 / LPIC-2)  
**Enseignant :** Pr. Azeddine KHIAT  
**Étudiant :** Marwane Hamouyat  

---

## 1. Fiche d'audit technique du serveur (Mission 5)

| Rubrique | Commande utilisée | Valeur relevée |
| :--- | :--- | :--- |
| **Distribution et version** | `cat /etc/os-release` | Ubuntu 24.04.5 LTS (Noble Numbat) |
| **Version du noyau** | `uname -a` | Linux 6.17.0-1020-oracle x86_64 |
| **Nom d'hôte** | `hostname` | `marouanehamouyat-ce344594` |
| **Processeurs logiques** | `nproc` | 2 vCPU |
| **Mémoire RAM totale** | `free -h` | 3.8 GiB |
| **Capacité disque `/`** | `df -h /` | 45 GB (Utilisé: 6%) |
| **Durée de fonctionnement**| `uptime` | 16 min (Load average: 0.00) |
| **Utilisateur (UID / GID)**| `id` | `ubuntu` (UID: 1001, GID: 1001) |

### Réponses aux questions d'audit (Q5.a & Q5.b)
* **Différence entre Linux et Ubuntu :** **Linux** désigne le noyau (kernel) qui gère le matériel. **Ubuntu** est une distribution complète construite autour du noyau Linux avec un ensemble d'utilitaires, d'outils système et le gestionnaire de paquets APT.
* **Fonction du noyau :** Le noyau assure l'interfaçage entre le matériel (CPU, RAM, disques) et les applications logicielles.
* **Différence Nom / UID / GID :** Le **Nom** (`ubuntu`) est l'identifiant humain, l'**UID** (`1001`) est l'identifiant numérique unique du compte utilisateur pour le noyau, et le **GID** (`1001`) est l'identifiant du groupe principal.

---

## 2. Structure FHS et Arborescence AtlasTech (Missions 6 & 7)

### Rôle des répertoires standard Linux (Tableau 6.4)
| Répertoire | Fonction au sein de la norme FHS |
| :--- | :--- |
| `/` | Racine unique du système de fichiers Linux. |
| `/etc` | Fichiers de configuration du système et des services installés. |
| `/home` | Répertoires personnels des utilisateurs du système. |
| `/var` | Données variables (journaux/logs, spools, bases de données). |
| `/usr` | Programmes, utilitaires et bibliothèques partagées. |
| `/tmp` | Fichiers temporaires réinitialisés au redémarrage. |
| `/srv` | Données des services hébergés par le système (Web, FTP). |
| `/root` | Dossier personnel de l'administrateur système (root). |

* **Chemin absolu vs relatif (Défi 6.a) :** Un chemin absolu commence à la racine `/` (`/home/ubuntu/lab-atlastech`), tandis qu'un chemin relatif démarre du répertoire courant (`entreprise/finance`).

### Réponses aux questions sur la gestion de fichiers (Q7.a & Q9.a)
1. **Rôle de `mkdir -p` :** Crée la structure complète des dossiers parents sans erreur s'ils existent déjà.
2. **Opérateur `>` :** Redirige la sortie d'une commande vers un fichier en **écrasant** son contenu.
3. **Différence `cat` vs `ls` :** `cat` lit et affiche le contenu d'un fichier ; `ls` liste le contenu d'un dossier.
4. **Différence `find` vs `grep` :** `find` cherche des fichiers selon leurs métadonnées ; `grep` recherche une chaîne de texte à l'intérieur d'un fichier.
5. **Différence `>` vs `>>` :** `>` écrase le fichier cible ; `>>` ajoute du texte à la fin du fichier (*append*).
6. **Caractère Pipe `|` :** Redirige la sortie standard d'une commande vers l'entrée standard de la suivante.

---

## 3. Matrice des permissions Linux (Mission 10)

| Mode octal | Notation symbolique | Signification |
| :---: | :---: | :--- |
| **`600`** | `-rw-------` | Lecture/Écriture pour le propriétaire uniquement. |
| **`640`** | `-rw-r-----` | Lecture/Écriture pour le propriétaire, Lecture seule pour le groupe. |
| **`700`** | `drwx------` | Droits totaux pour le propriétaire, aucun accès pour le reste. |
| **`755`** | `drwxr-xr-x` | Droits totaux pour le propriétaire, Lecture/Traversée pour groupe/autres. |
| **`644`** | `-rw-r--r--` | Lecture/Écriture pour le propriétaire, Lecture seule pour groupe/autres. |

* **Effet de `umask 077` (Q10.a) :** Le masque `077` retire systématiquement tous les droits (`rwx`) aux membres du groupe et aux autres utilisateurs lors de la création d'un fichier ou d'un dossier.

---

## 4. Options de l'outil d'archivage `tar` (Mission 11)

| Option `tar` | Rôle de l'option |
| :---: | :--- |
| **`-c`** | Créer une nouvelle archive (*create*). |
| **`-x`** | Extraire les fichiers d'une archive (*extract*). |
| **`-t`** | Lister le contenu d'une archive sans l'extraire (*list*). |
| **`-z`** | Compresser/décompresser via `gzip`. |
| **`-f`** | Spécifier le nom du fichier d'archive (*file*). |
| **`-C`** | Spécifier le dossier de destination pour l'extraction. |

* **Fiabilité des sauvegardes (Q11.a) :** Une sauvegarde ne peut pas être jugée fiable sans test de restauration car l'archive pourrait être altérée ou corrompue ; seul un test de décompression et un contrôle d'intégrité (`diff -r`) valident la possibilité d'un rétablissement en cas de sinistre.

---

## 5. Rapport d'incident (Mission 13)

| Rubrique | Valeur / Description |
| :--- | :--- |
| **Symptôme observé** | `-bash: entreprise/finance/budget.txt: Permission denied` |
| **Commande d'identification** | `ls -l entreprise/finance/budget.txt` |
| **Cause technique** | Droits d'écriture supprimés sur le fichier (permission définie à `400` / `-r--------`). |
| **Correction appliquée** | `chmod 600 entreprise/finance/budget.txt` pour réattribuer l'écriture au propriétaire. |
| **Preuve de rétablissement** | Écriture réussie de la ligne *"Ajustement budgétaire validé 2026"* et vérification via `cat`. |

---

## 6. Synthèse personnelle

1. **Responsabilités d'un administrateur Linux :** Garantir la disponibilité du système, la sécurité des accès, la gestion des privilèges utilisateur, l'automatisation des tâches récurrentes et l'intégrité des données à travers des stratégies de sauvegarde.
2. **Importance de SSH :** Offre un canal d'administration chiffré et sécurisé à distance, remplaçant les protocoles non sécurisés comme Telnet.
3. **Intérêt de la norme FHS :** Standardise l'organisation des répertoires pour garantir qu'un administrateur puisse retrouver facilement les configurations (`/etc`), journaux (`/var/log`) ou exécutables (`/usr/bin`) sur n'importe quelle distribution Linux.
4. **Protection des permissions :** Garantit le principe du moindre privilège, évitant les fuites de données confidentielles (RH/Finance) ou l'altération involontaire de fichiers système.
5. **Diagnostic d'erreur en CLI :** S'appuie sur la consultation méthodique des codes de retour d'erreur, la vérification des droits (`ls -l`), l'analyse des métadonnées (`stat`) et le filtrage des journaux d'erreurs (`grep ERROR /var/log/...`).
