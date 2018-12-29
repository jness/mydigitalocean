dungeon_brawl:

  git.cloned:
    - name: https://github.com/jness/dungeon_brawl.git
    - target: /var/www/dungeon_brawl/
    - branch: master

  virtualenv.managed:
    - name: /var/www/dungeon_brawl/venv/
    - python: /usr/bin/python3
    - requirements: /var/www/dungeon_brawl/requirements.txt
