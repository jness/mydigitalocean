simple_app_user:
  user.present:
    - name: simple_app
    - shell: /bin/false
    - createhome: false

simple_app_directory:
  file.directory:
    - name: /var/www/simple_app/
    - user: simple_app
    - group: root
    - mode: 755
    - makedirs: True

simple_app_requirements:
  file.managed:
    - name: /var/www/simple_app/requirements.txt
    - source: salt://simple_app/files/requirements.txt
    - user: simple_app
    - group: root
    - mode: 644

simple_app_install:
  virtualenv.managed:
    - name: /var/www/simple_app/venv/
    - python: /usr/bin/python3
    - requirements: /var/www/simple_app/requirements.txt

simple_app:
  file.managed:
    - name: /var/www/simple_app/app.py
    - source: salt://simple_app/files/app.py
    - user: simple_app
    - group: root
    - mode: 644
    - watch_in:
      - service: simple_app_service

simple_app_wsgi:
  file.managed:
    - name: /var/www/simple_app/wsgi.py
    - source: salt://simple_app/files/wsgi.py
    - user: simple_app
    - group: root
    - mode: 644

simple_app_systemd:
  file.managed:
    - name: /etc/systemd/system/simple_app.service
    - source: salt://simple_app/files/systemd.conf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: simple_app_service

simple_app_service:
  service.running:
    - name: simple_app
    - enable: True

simple_app_nginx:
  file.managed:
    - name: /etc/nginx/sites-enabled/simple_app
    - source: salt://simple_app/files/nginx.conf
    - user: root
    - group: root
    - mode: 644
