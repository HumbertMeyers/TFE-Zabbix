#!/bin/bash

# Télécharge et installe depuis le serveur interne l'agent zabbix pour Cent0S 5 (32bits).
#------------------------------------------	
rpm -i http://10.101.14.60/zabbix-agent-4.0.4-1.el5.i386.rpm
#------------------------------------------	

# Patiente 5 secondes pour passer à la commande suivante.
#------------------------------------------	
sleep 5 
#------------------------------------------	

# Entre dans le répertoire de Zabbix.
#------------------------------------------	
cd /etc/zabbix/
#------------------------------------------	

# Télécharge et décompresse les scripts pour Elastix.
#------------------------------------------	
wget http://10.101.14.60/conf_files_zabbix.tgz
tar xvfz conf_files_zabbix.tgz
rm -f conf_files_zabbix.tgz
#------------------------------------------	

# Modifie les droits des fichiers téléchargés.
#------------------------------------------	
chown zabbix:zabbix *.sh
chmod a+x /etc/zabbix/*.sh
usermod -a -G root zabbix
usermod -a -G asterisk zabbix
#------------------------------------------	


# Modifie le hostname dans le fichier de configuration avec le paramètre donné.
#------------------------------------------	
sed -i -- "s/Hostname=Elastix[HOSTNAME]/Hostname=$1/g" zabbix_agentd.conf
cat /etc/zabbix/zabbix_agentd.conf | grep Hostname

#------------------------------------------	
#Hostname=Elastix[HOSTNAME]
#------------------------------------------

# Modifie le type d'exécution de l'utilisateur zabbix.
#------------------------------------------	
sed -i -- 's/zabbix:x:101:102:Zabbix Monitoring System:\/var\/lib\/zabbix:\/sbin\/nologin/zabbix:x:101:102:Zabbix Monitoring System:\/var\/lib\/zabbix:\/bin\/bash/g' /etc/passwd
cat /etc/passwd | grep Zabbix

# -------
# WARNING: veuillez vous assurer qu'il y ait bien une réponse ayant indiquÃ© qu'il existe une entrée contenant "/bin/bash". Si non, updatez manuellement.
# -------


# Retrait des demande de mot de passe dans pour certains dossier pour l'utilisateur zabbix.
#------------------------------------------
echo "" >> /etc/sudoers
echo "zabbix   ALL = NOPASSWD: /usr/sbin/asterisk" >> /etc/sudoers
echo "zabbix   ALL = NOPASSWD: /usr/bin/fail2ban-client" >> /etc/sudoers
echo "zabbix   ALL = NOPASSWD: /usr/bin/find" >> /etc/sudoers
echo "zabbix   ALL = NOPASSWD: /sbin/service" >> /etc/sudoers
echo "" >> /etc/sudoers
#------------------------------------------

# Crée un fichier utilie seulement pour Zabbix.
#------------------------------------------
touch /var/log/messages_lag
chown zabbix:zabbix /var/log/messages_lag
#------------------------------------------

# Création du lancement automatique de l'agent au démarrage du système.
#------------------------------------------
ln -s /etc/init.d/zabbix-agent /etc/rc.d/rc3.d/S99zabbix
ln -s /etc/init.d/zabbix-agent /etc/rc.d/rc3.d/K99zabbix
#------------------------------------------

# Démarrage du service
#------------------------------------------
/etc/init.d/zabbix-agent start

# Recupération de l'adresse IP pour la configuration dans le serveur Zabbix
#------------------------------------------
ifconfig
#------------------------------------------
