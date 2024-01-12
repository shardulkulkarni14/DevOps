install package:
    pkg.latest: 
      - pkgs:
        - openjdk-11-jre-headless
        - perl
        - openssl
tomcat-install:
    file.managed:
     - name: /usr/local/src/apache-tomcat-9.0.36.tar.gz
     - source: https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.36/bin/apache-tomcat-9.0.37.tar.gz
     - source_hash: {{ salt['cmd.shell']('echo "md5=`curl -s "https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.36/bin/apache-tomcat-9.0.36.tar.gz" | md5sum | cut -c -32`"') }}
    cmd.run:
     - name: cd /usr/local/src && tar xf apache-tomcat-9.0.36.tar.gz && mv apache-tomcat-9.0.36 /usr/local/apache-tomcat-9.0.36
tomcat-setup:
    cmd.run:
     - name: |
         export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
         export PATH=$JAVA_HOME/bin:$PATH
         export CATALINA_HOME=/usr/local/apache-tomcat-9.0.36
         export PATH=$CATALINA_HOME/bin:$PATH
         cd /usr/local/apache-tomcat-9.0.36/webapps/ROOT
         echo "<p> yzohpwsoorzw </p>" > index.jsp
         cat index.jsp  
tomcat-start:
    cmd.run:
     - name: nohup /usr/local/apache-tomcat-9.0.36/bin/startup.sh