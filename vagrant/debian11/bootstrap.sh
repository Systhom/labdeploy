co="\e[27m"
lor="\e[0m"
gen_password=$(sudo openssl rand -base64 12)
get_ip=$(sudo ip address show dev eth1 | grep "global" | awk '{print $2}') 
components_to_install=(vim) 

sudo sed -i '/#PermitRootLogin/c\PermitRootLogin yes' /etc/ssh/sshd_config
sudo sed -i '/PasswordAuthentication/c\PasswordAuthentication yes' /etc/ssh/sshd_config
sudo echo -e "$gen_password\n$gen_password" | sudo passwd root
sudo apt update
sudo systemctl restart sshd
sudo apt install $components_to_install -y

sudo cat << EOF > /root/.bashrc
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls \$LS_OPTIONS'
alias ll='ls \$LS_OPTIONS -l'
alias l='ls \$LS_OPTIONS -lA'

export HISTTIMEFORMAT="%h/%d - %H:%M:%S "

# lignes de l'historique par session bash
export HISTSIZE=5000
# lignes de l'historique conservées
export HISTFILESIZE=256000
# supporte des terminaux redimensionnables (xterm et screen -r)
shopt -s checkwinsize

# une commande fréquemment utilisée
alias ll='ls -l'
# utilisation des couleurs pour certaines commandes
eval "`dircolors -b`"
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ajout des couleurs pour les logs
cless() { ccze -A < \$1 | less -R; }
ctail() { ccze -A < \$1 | tail \$2; }
ccat() { ccze -A < \$1 | cat \$2; }

# affichage sympathique de la ligne de commande
PS1="[\t] \[\e[01;94m\]\u@\h\[\e[00m\]:\[\e[01;91m\]\w\[\e[00m\]\$ "

# permettre une complétion plus "intelligente" des commandes (question de goût)
if [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
    fi

    # Correction automatique des petites typos
    shopt -s cdspell
EOF

echo -e "$co ----------------- $lor"
echo -e "$co User : root $lor"
echo -e "$co Password : $gen_password $lor" 
echo -e "$co Adresse IP : $get_ip $lor" 
echo -e "$co Hostname : $HOSTNAME $lor"
echo -e "$co ----------------- $lor"

