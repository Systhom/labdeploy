# Objectif

Déploiement de 2 VMs Debian 11 avec Vagrant et Virtualbox

# Pré-requis 

Installer Vagrant et Virtualbox

# Fonctionnement 

Aller dans le dossier vagrant/debian11 et faire un "vagrant up"

La configuration par défaut est la suivante : 
- Modification du .bashrc
- Autorisation de la connexion via root en SSH 

Pour toutes configuration supplémentaires, les ajouter dans bootstrap.sh
Pour ajouter des VMs supplémentaires, modifier le Vagrantfile et ajouter des lignes : 

{ :hostname => 'node2', :ip => '192.168.56.202', :box => 'debian/bullseye64', :ram => 1024 },
