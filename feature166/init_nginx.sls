# init_nginx.sls

nginx:
  pkg.installed:
    - name: nginx

nginx-configuration:
  file.managed:
    - name: /etc/nginx/conf.d/load-balancer.conf
    - source: salt://load-balancer.conf
    - makedirs: true
    - require:
      - pkg: nginx

nginx-service-restart:
  cmd.run:
    - name: rm /etc/nginx/sites-enabled/default && /etc/init.d/nginx restart
    - require:
      - file: nginx-configuration
