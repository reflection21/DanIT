MYSQL_ROOT_PASSWORD="root"
DB_NAME="db_client"
DB_USER_APP="app"
DB_PASS_APP="app"
DB_PASS_HOST="host"
DB_USER_HOST="host"

sudo apt -y update && sudo apt -y upgrade
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASSWORD}"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWORD}"
sudo apt install -y mysql-server
sudo mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE ${DB_NAME};"
sudo mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER '${DB_USER_HOST}'@'localhost' IDENTIFIED BY '${DB_PASS_HOST}';"
sudo mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER '${DB_USER_APP}'@'192.168.56.11' IDENTIFIED BY '${DB_PASS_APP}';"
sudo mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER_HOST}'@'localhost';"
sudo mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER_APP}'@'192.168.56.11';"
sudo mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;" 
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf 
sudo systemctl restart mysql
  


