# init_tomcat2.sls
tomcat2-installation:
  pkg.installed:
    - name: openjdk-11-jre
    - fromrepo: saltstack

tomcat2-setup:
  cmd.run:
    - name: |
        wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.36/bin/apache-tomcat-9.0.36.tar.gz -P /tmp
        tar xf /tmp/apache-tomcat-9.0.36.tar.gz -C /usr/local
        ln -s /usr/local/apache-tomcat-9.0.36 /usr/local/tomcat2
        echo 'yzohpwsoorzw' > /usr/local/tomcat2/webapps/ROOT/index.html
        chown -R root:root /usr/local/tomcat2
        chmod -R 755 /usr/local/tomcat2

tomcat2-service:
  cmd.run:
    - name: /usr/local/tomcat2/bin/startup.sh
