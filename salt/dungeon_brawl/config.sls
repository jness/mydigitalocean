dungeon_brawl.config:

  file.managed:
    - name: /var/www/dungeon_brawl/app.conf
    - source: salt://dungeon_brawl/files/app.conf
    - user: root
    - group: root
    - mode: 644
