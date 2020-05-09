#!/bin/bash
sudo yum update -y
sudo yum install -y git 
#Clone salt repo
sudo git clone -b feature-iac https://github.com/juan-bol/aik-portal-iac /srv/saltstack
#Install Salstack
#sudo yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest.el7.noarch.rpm
#sudo yum clean expire-cache;sudo yum -y install salt-minion; chkconfig salt-minion off
sudo curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh
sudo sh bootstrap_salt.sh

#Put custom minion config in place (for enabling masterless mode)
sudo cp -r /srv/saltstack/SaltStack/minion.d /etc/salt/
#echo -e 'grains:\n roles:\n  - frontend\n  - backend' > /etc/salt/minion.d/grains.conf
echo -e 'grains:\n roles:\n  - frontend' | sudo tee /etc/salt/minion.d/grains.conf
## Trigger a full Salt run
sudo salt-call state.apply