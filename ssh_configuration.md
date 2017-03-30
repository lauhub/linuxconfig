# Configuration de ssh

Cette page explique comment configurer ssh pour

-   ne pas avoir à rentrer les mots de passe
-   automatiser l'accès à un serveur

On utilise la notion de client et de serveur.

Le client est la machine d'où est lancée la connection, que ce soit par
ssh ou par une commande comme git (même si dans ce cas, le client
pourrait parfois être considéré comme serveur, mais cela n'a pas
d'importance).

## Gestion des clefs
### Création des clefs privées et publiques sur le client

On doit d'abord créer une clef.

On va commencer par dupliquer les clefs existantes si elles existent
dans `$HOME/.ssh`

```bash
$ mkdir $HOME/.ssh/backup/
$ cp -p $HOME/.ssh/id* $HOME/.ssh/backup/
```

Maintenant on va créer une clef

```bash
$ ssh-keygen -t rsa -C "Mon commentaire sur cette clef"
```

Et on va indiquer :

-   Une passphrase assez longue pour sécuriser notre clef.
-   l'emplacement de sauvegarde des fichiers de clef.

### Envoi de la clef publique sur le serveur

Ensuite, on va pouvoir utiliser la clef publique (.pub) et l'envoyer sur
le serveur pour qu'il puisse reconnaître le client.

```bash
cat ~/.ssh/id_rsa.pub | ssh user@server 'cat ->> ~/.ssh/authorized_keys'
```


### Pour aller plus loin avec la configuration de GitHub

Articles à consulter:

-   [Configuration de Git](https://help.github.com/articles/set-up-git)
-   [Création d'un dépôt](https://help.github.com/articles/create-a-repo)
-   [Cet article sur la génération de clef ssh et la connection à github](https://help.github.com/articles/generating-ssh-keys)
    

## Affichage du fingerprint du serveur

Lorsque l'on  se connecte la première fois, il est demandé de vérifier le Fingerprint du serveur.

Il faut comparer deux chaînes de caractères.

### Commande côté serveur
La chaîne côté serveur est donnée par: 

```bash
ssh-keygen -l -f /etc/ssh/ssh_host_rsa_key.pub
```
### Commande côté client

Côté client, l'affichage du fingerprint se fait automatiquement à la première connexion. 
Cependant, il peut arriver que la méthode de hashage diffère de celle du serveur. Dans ce cas, suivre les instructions suivantes:

#### Pour afficher en md5

```bash
#en MD5
ssh -o FingerprintHash=md5 user@host

#en SHA256
ssh -o FingerprintHash=sha256 user@host
```

## Configuration de l'agent SSH
En se connectant en utilisant la clé générée, la passphrase est demandée systèmatiquement (allez-y, essayez !).

Rajouter les lignes suivantes sur votre fichier d'environnement (`~/.bashrc` sous git-bash pour Windows):


```bash 
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     #ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

```

## Configuration des alias vers les serveurs

Il faut pour cela modifier (ou créer) le fichier `$HOME/.ssh/config`

On y ajoute par exemple les lignes suivantes:

```file
Host serveur
    User moi
    Hostname nom_domaine_ou_adresse_ip.com
    Port 22 
```

`Host` permet de donner un nom particulier à la connection. Pour autant,
ce sera le `Hostname` qui sera utilisé comme adresse et le port donné.

Cependant, on peut aussi ajouter les paramètres suivants afin de
contrôler précisément la méthode d'authentification.

```file
  PreferredAuthentications publickey
  IdentityFile "#path_to_private_key#"
```
## Configuration du keep alive
Ceci permet d'éviter des déconnexions intempestives

### Côté client
Ajouter les lignes suivantes au début de votre fichier `~/.ssh/config`
```
Host *
    ServerAliveInterval 300
    ServerAliveCountMax 2
    IdentitiesOnly yes
```

### Côté serveur
Ajouter ce qui suit à une configuration d'hôte dans `/etc/ssh/ssh_config` sur votre serveur:

```file
    ServerAliveInterval 60
```
