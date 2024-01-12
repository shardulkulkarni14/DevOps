# init_tomcat2.sls
tomcat2-installation:
  pkg.installed:
    - name: openjdk-11-jre
    - fromrepo: ubuntu

tomcat2-setup:
  cmd.run:
    - name: |
        wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.37/bin/apache-tomcat-9.0.37.tar.gz -P /tmp
        tar xf /tmp/apache-tomcat-9.0.37.tar.gz -C /usr/local
        ln -s /usr/local/apache-tomcat-9.0.37 /usr/local/tomcat2
        echo 'eshbfqhnbncl' > /usr/local/tomcat2/webapps/ROOT/index.html
        chown -R root:root /usr/local/tomcat2
        chmod -R 755 /usr/local/tomcat2
        echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> /usr/local/tomcat2/bin/setenv.sh
        echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /usr/local/tomcat2/bin/setenv.sh
        echo 'export CATALINA_HOME=/usr/local/apache-tomcat-9.0.37' >> /usr/local/tomcat2/bin/setenv.sh
        echo 'export PATH=$CATALINA_HOME/bin:$PATH' >> /usr/local/tomcat2/bin/setenv.sh

tomcat2-service:
  cmd.run:
    - name: nohup /usr/local/tomcat2/bin/startup.sh
    - require:
      - cmd: tomcat2-setup
