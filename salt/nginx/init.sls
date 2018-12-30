nginx:
  pkg.installed:
    - pkgs:
        - nginx

  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx/sites-enabled/*

  file.absent:
    - name: /etc/nginx/sites-enabled/default
