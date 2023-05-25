#!/bin/bash
# install-postgresql-ubuntu.sh
# tested: 
# export PG_VERSION='14'

printf "\nInstallation PostgreSQL - $(lsb_release -ds) - $(lsb_release -cs) \n\n"
echo -ne "PostgreSQL Version: "
read PG_VERSION

if [ -z ${PG_VERSION} ]; then
  printf "\n [ERROR]: Version not found.\nExit!\n\n"
  exit 1
fi

# install pgdg
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Signed certificate and key
apt-get -y install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

apt-get update
apt-get upgrade

apt-get -y install postgresql-${PG_VERSION} postgresql-server-dev-${PG_VERSION} postgresql-client-${PG_VERSION}

# restart service
systemctl restart postgresql@${PG_VERSION}-main

# Start automatically
systemctl enable postgresql@${PG_VERSION}-main

# try test
su - postgres -c "psql -l"