# init_tomcat2.sls
tomcat2-installation:
  pkg.installed:
    - name: openjdk-11-jre
    - fromrepo: ubuntu    # Use the correct repository name for your Ubuntu version

tomcat2-setup:
  cmd.run:
    - name: |
        wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.y/bin/apache-tomcat-9.0.y.tar.gz -P /tmp
        tar xf /tmp/apache-tomcat-9.0.y.tar.gz -C /usr/local
        ln -s /usr/local/apache-tomcat-9.0.y /usr/local/tomcat2
        echo 'yzohpwsoorzw' > /usr/local/tomcat2/webapps/ROOT/index.html
        chown -R root:root /usr/local/tomcat2
        chmod -R 755 /usr/local/tomcat2

tomcat2-service:
  cmd.run:
    - name: /usr/local/tomcat2/bin/startup.sh
