#!/bin/bash
apt update
apt install openjdk-17-jdk -y
apt install maven -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
cd /tmp/ && wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.95/bin/apache-tomcat-9.0.95.tar.gz
sudo tar -xf /tmp/apache-tomcat-9.0.95.tar.gz -C /opt/tomcat/
sudo ln -s /opt/tomcat/apache-tomcat-9.0.95 /opt/tomcat/latest
sudo chown -R tomcat: /opt/tomcat
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'
TOMCAT_SERVICE="[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment=\"JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64\"
Environment=\"JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true\"
Environment=\"CATALINA_BASE=/opt/tomcat/latest\"
Environment=\"CATALINA_HOME=/opt/tomcat/latest\"
Environment=\"CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid\"
Environment=\"CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC\"
ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target"

# Create the tomcat.service file
echo "$TOMCAT_SERVICE" > /etc/systemd/system/tomcat.service

sudo systemctl daemon-reload
sudo systemctl enable --now tomcat
sudo systemctl start tomcat
sudo systemctl stop tomcat
sudo systemctl restart tomcat
sudo sed -i '/<\/tomcat-users>/i \
<role rolename="admin-gui"/>\n\
<role rolename="manager-gui"/>\n\
<user username="admin" password="admin_password" roles="admin-gui,manager-gui"/>' /opt/tomcat/latest/conf/tomcat-users.xml
sudo sed -i 's/<Valve className="org.apache.catalina.valves.RemoteAddrValve"/<!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"/g' /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml

sudo sed -i 's/" \/>/" \/> -->/g' /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml
sudo sed -i 's/<Valve className="org.apache.catalina.valves.RemoteAddrValve"/<!-- <Valve className="org.apache.catalina.valves.RemoteAddrValve"/g' /opt/tomcat/latest/webapps/manager/META-INF/context.xml

sudo sed -i 's/" \/>/" \/> -->/g' /opt/tomcat/latest/webapps/manager/META-INF/context.xml
sudo sed -i 's/port="8080"/port="8085"/g' /opt/tomcat/latest/conf/server.xml
sudo systemctl restart tomcat

sudo chown -R jenkins:jenkins /opt/tomcat/latest/webapps/
sudo chmod -R 775 /opt/tomcat/latest/webapps/
#!/bin/bash

# Add Jenkins to sudoers if not already present
sudo grep -q '^jenkins ALL=(ALL) NOPASSWD: ALL' /etc/sudoers || echo 'jenkins ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers

# Validate sudoers file to ensure there are no syntax errors
sudo visudo -c

if [ $? -eq 0 ]; then
    echo "Jenkins added to sudoers successfully."
else
    echo "Error: Invalid sudoers file."
fi

sudo usermod -aG $USER jenkins

#!/bin/bash

# Update package index
sudo apt update

# Install MySQL server
sudo apt install mysql-server -y

# Start MySQL service
sudo systemctl start mysql

# Secure MySQL installation
# The 'mysql_secure_installation' command will prompt for various settings
# We will use 'expect' to automate this

sudo apt install expect -y

# Create an expect script to automate the mysql_secure_installation
cat <<EOF | sudo expect -
spawn mysql_secure_installation

expect "Enter current password for root (enter for none):"
send "Prasanna@2024\r"

expect "Set root password? \[Y/n\]"
send "y\r"

expect "New password:"
send "Prasanna@2024\r"

expect "Re-enter new password:"
send "Prasanna@2024\r"

expect "Remove anonymous users? \[Y/n\]"
send "y\r"

expect "Disallow root login remotely? \[Y/n\]"
send "y\r"

expect "Remove test database and access to it? \[Y/n\]"
send "y\r"

expect "Reload privilege tables now? \[Y/n\]"
send "y\r"

expect eof
EOF

# Run the ALTER USER command to use mysql_native_password authentication
mysql -u root -pPrasanna@2024 -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Prasanna@2024';"

# Create the database 'spring_security_custom_user_demo'
mysql -u root -pPrasanna@2024 -e "CREATE DATABASE spring_security_custom_user_demo;"

# Print completion message
echo "MySQL installation, configuration, and database creation complete."

