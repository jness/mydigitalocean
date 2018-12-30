python:
  pkg.installed:
    - pkgs:
        - python3
        - python3-pip
        - python3-dev
        - python-virtualenv
        - python-pip  # needed for saltstack's pip.installed
