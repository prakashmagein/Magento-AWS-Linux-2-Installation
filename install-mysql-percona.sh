#!/bin/bash

REPO_PERCONA="https://repo.percona.com/yum/percona-release-latest.noarch.rpm"
sudo yum install -y -q $REPO_PERCONA
echo "Percona 8.0 database installation:\n"
dnf module disable -y mysql

# https://www.percona.com/blog/2019/05/31/rhel-8-packages-available-for-percona-products/

percona-release setup ps57
sudo dnf install Percona-Server-server-57 Percona-Server-client-57 -y

echo "MySQL ROOT Password:\n"
cat /var/log/mysqld.log |grep generated

mysql -h localhost -p -u root  --connect-expired-password -e 'ALTER USER `root`@`localhost` IDENTIFIED BY "{InsertYourPassword-there123}", `root`@`localhost` PASSWORD EXPIRE NEVER;'


systemctl enable mysqld 

systemctl start mysqld.service
