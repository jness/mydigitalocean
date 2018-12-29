nginx:

  pkg.installed:
    - pkgs:
        - nginx

  service.running:
    - enable: True
    - reload: True
