# init_tomcat1.sls
tomcat1-installation:
  pkg.installed:
    - name: openjdk-11-jre
    - fromrepo: ubuntu    # Use the correct repository name for your Ubuntu version

tomcat1-setup:
  cmd.run:
    - name: |
        wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.35/bin/apache-tomcat-9.0.35.tar.gz -P /tmp
        tar xf /tmp/apache-tomcat-9.0.35.tar.gz -C /usr/local
        ln -s /usr/local/apache-tomcat-9.0.35 /usr/local/tomcat1
        echo 'jqrgntsqbfwz' > /usr/local/tomcat1/webapps/ROOT/index.html
        chown -R root:root /usr/local/tomcat1
        chmod -R 755 /usr/local/tomcat1

tomcat1-service:
  cmd.run:
    - name: nohup /usr/local/tomcat1/bin/startup.sh
    - require:
      - cmd: tomcat1-setup
