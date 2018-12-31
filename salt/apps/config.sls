{% for app, config in pillar.get('apps').items() %}

  {{ app }}_configuration:
    file.serialize:
      - name: /var/www/{{ app }}/config.json
      - dataset: {{ config }}
      - formatter: json
      - user: {{ app }}
      - group: root
      - mode: 660
      - watch_in:
        - service: {{ app }}_service

{% endfor %}
