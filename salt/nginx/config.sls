nginx.config:
  
  file.managed:
    - name: /etc/nginx/sites-enabled/default
    - source: salt://nginx/files/default
    - user: root
    - group: root
    - mode: 644
