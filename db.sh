#!/bin/sh
apt update
apt install mysql-server -y

green() {
  echo -e '\e[32m'$1'\e[m';
}

readonly EXPECTED_ARGS=3
readonly E_BADARGS=65
readonly MYSQL=`which mysql`

# Construct the MySQL query
readonly Q1="CREATE DATABASE IF NOT EXISTS $1;"
readonly Q2="CREATE USER '$2'@'localhost' IDENTIFIED BY '$3';"
readonly Q3="GRANT ALL ON *.* TO '$2'@'localhost' IDENTIFIED BY '$3';"
readonly Q4="CREATE USER '$2'@'%' IDENTIFIED BY '$3';"
readonly Q5="GRANT ALL ON *.* TO '$2'@'%' IDENTIFIED BY '$3';"
readonly Q6="FLUSH PRIVILEGES;"
readonly SQL="${Q1}${Q2}${Q3}${Q4}${Q5}${Q6}"

# Do some parameter checking and bail if bad
if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: $0 dbname dbuser dbpass"
  exit $E_BADARGS
fi

# Run the actual command
$MYSQL -uroot -p -e "$SQL"

# Let the user know the database was created
green "Database $1 and user $2 created with a password you chose"

git clone https://github.com/datacharmer/test_db.git

cd test_db

mysql < employees.sql