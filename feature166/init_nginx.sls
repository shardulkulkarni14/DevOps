# init_nginx.sls
nginx-installation:
  pkg.installed:
    - name: nginx

nginx-configuration:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://feature166/nginx.conf
    - user: root
    - group: root
    - mode: 644

nginx-service:
  cmd.run:
    - name: systemctl restart nginx
    - onchanges:
      - file: nginx-configuration
