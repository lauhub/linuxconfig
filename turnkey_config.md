# Configuration d'une appliance tunrkey
## Mots de passe
Au premier démarrage, un gros problème se pose: **le clavier est en américain**

Autrement dit: 
- taper sur `a` affiche `q`
- taper sur `z` affiche `w`
- etc

Donc rentrer un mot de passe posera problème par la suite.

Donc notre premier mot de passe sera: `Ertyuiop8` (la touche `8` donne `*`) ce qui donnera un mot de passe en `Ertyuiop*` 

Une fois la machine configurée, on modifiera le clavier et on changera le mot de passe.

###Mot de passe root
Utiliser le mot de passe défini précédemment

### MySQL
Utiliser le mot de passe défini précédemment


## Modification de la configuration du clavier
### Se connecter sur la machine en tant que root
Entrer les commandes suivante:
```
apt-get update
apt-get install console-data
```
Si console-data est déjà installé, tapez:

```
dpkg-reconfigure console-data
```

Choisissez alors `Select keymap from full list`

Et recherchez le clavier français dans la liste: `pc / azerty / French / Same as X11 (latin 9) / Standard`

##Modification du mot de passe 

### Première méthode
Depuis la ligne de commande:
```
passwd
Enter new UNIX password:
```
Entrez deux fois le mot de passe (il est normal que rien ne s'affiche).

### Deuxième méthode 
On va se connecter sur la console d'administration de la machine.

####Récupération de l'IP
Pour cela il faut connaître son adresse IP. Tapez dans la console:
```
ip a
```

L'adresse IP est celle qui correspond à la ligne commençant par `inet` sous la section `eth0`

Ensuite, dans votre navigateur tapez dans la barre d'adresse : `https://<ADRESSE IP>`

En remplaçant `<ADRESSE IP>` par sa valeur.

#### Utilisation de la console Webmin

Cliquez sur Webmin

Entrez le login `root` et le mot de passe actuel.

Cliquez sur `Change passwords`

Modifiez les mots de passe:
-  root
-  mysql
