DB_NAME="db_client"
DB_USER_APP="app"
DB_PASS_APP="app"
DB_HOST="192.168.56.12"
DB_PORT="3306"

sudo apt -y update && sudo apt -y upgrade 
sudo apt install -y mysql-client-core-8.0 default-jdk git
sudo useradd -m -s /bin/bash app_user 
sudo su app_user -c "mkdir /home/app_user/project_dir && cd /home/app_user/project_dir && git clone https://gitlab.com/reflection21/step_project1.git ."
sudo su app_user -c "mkdir -p /home/app_user/project_dir/PetClinic/target && chmod 777 /home/app_user/project_dir/PetClinic/target"
sudo wget -P /opt/ https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
sudo tar xf /opt/apache-maven-3.9.9-bin.tar.gz -C /opt/ && rm -rf /opt/apache-maven-3.9.9-bin.tar.gz
echo "export PATH=$PATH:/opt/apache-maven-3.9.9/bin" | sudo tee -a /etc/environment
# echo "export MYSQL_USER=${DB_USER_APP}" | sudo tee -a /etc/environment
# echo "export MYSQL_URL=jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME}" | sudo tee -a /etc/environment
# echo "export MYSQL_PASS=${DB_PASS_APP}" | sudo tee -a /etc/environment
sudo su app_user -c "cd /home/app_user/project_dir/PetClinic && mvn package"
sudo su app_user -c "mv /home/app_user/project_dir/PetClinic/target/spring-petclinic-2.3.1.BUILD-SNAPSHOT.jar /home/app_user/app.jar"
# sudo su app_user -c "cd /home/app_user && java -Dspring.profiles.active=mysql -jar app.jar" #> /home/app_user/var.log 2>&1

sudo su app_user -c "cd /home/app_user"
sudo su app_user -c "java -jar /home/app_user/app.jar --spring.profiles.active=mysql --spring.datasource.url=jdbc:mysql://${DB_HOST}:${DB_PORT}/${DB_NAME} --spring.datasource.username=${DB_USER_APP} --spring.datasource.password=${DB_PASS_APP}"




sudo su app_user -c "java -jar /home/app_user/app.jar --spring.profiles.active=mysql --spring.datasource.url=jdbc:mysql://192.168.56.12:3306/db_client --spring.datasource.username=app --spring.datasource.password=app"