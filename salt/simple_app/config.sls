simple_app_configuration:
  file.managed:
    - name: /var/www/simple_app/config.yml
    - source: salt://simple_app/files/config.yml
    - user: simple_app
    - group: root
    - mode: 660
    - watch_in:
      - service: simple_app_service
