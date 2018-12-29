#
# Maintain order for dependency requirements.
#

base:

  # execute base install during packer builds
  # and terraform deployments, this will ensure we catch
  # any changes not yet built into base image.
  'web_build or web_config':
    - nginx
    - python
    - dungeon_brawl

  # execute configuration states only during terraform deployments.
  'web_config':
    - nginx.config
    - dungeon_brawl.config

  # 'database_build':
  #
  # 'database_config':
