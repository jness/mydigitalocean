{% for app, config in pillar.get('apps').items() %}

  {{ app }}_user:
    user.present:
      - name: {{ app }}
      - shell: /bin/false
      - createhome: false

  {{ app }}_directory:
    file.directory:
      - name: /var/www/{{ app }}/
      - user: {{ app }}
      - group: root
      - mode: 755
      - makedirs: True

  {{ app }}_requirements:
    file.managed:
      - name: /var/www/{{ app }}/requirements.txt
      - source: salt://apps/files/requirements.txt
      - user: {{ app }}
      - group: root
      - mode: 644

  {{ app }}_install:
    virtualenv.managed:
      - name: /var/www/{{ app }}/venv/
      - user: {{ app }}
      - python: /usr/bin/python3
      - requirements: /var/www/{{ app }}/requirements.txt

  {{ app }}:
    file.managed:
      - name: /var/www/{{ app }}/app.py
      - source: salt://apps/files/app.py
      - user: {{ app }}
      - group: root
      - mode: 644
      - watch_in:
        - service: {{ app }}_service

  {{ app }}_wsgi:
    file.managed:
      - name: /var/www/{{ app }}/wsgi.py
      - source: salt://apps/files/wsgi.py
      - user: {{ app }}
      - group: root
      - mode: 644

  {{ app }}_systemd:
    file.managed:
      - name: /etc/systemd/system/{{ app }}.service
      - source: salt://apps/files/systemd.conf
      - user: root
      - group: root
      - mode: 644
      - app: {{ app }}
      - workers: {{ config.workers }}
      - template: jinja
      - watch_in:
        - service: {{ app }}_service

  {{ app }}_service:
    service.running:
      - name: {{ app }}
      - enable: True

  {{ app }}_nginx:
    file.managed:
      - name: /etc/nginx/sites-enabled/{{ app }}
      - source: salt://apps/files/nginx.conf
      - user: root
      - group: root
      - mode: 644
      - app: {{ app }}
      - server_name: {{ config.server_name }}
      - template: jinja

{% endfor %}
