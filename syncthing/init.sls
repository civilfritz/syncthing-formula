syncthing:
  archive:
    - extracted
    - name: {{ pillar['syncthing']['installdir'] }}
    - source: {{ pillar['syncthing']['download_link'] }}
    - archive_format: tar
    - source_hash: md5={{ pillar['syncthing']['download_md5'] }}
    - if_missing: {{ pillar['syncthing']['installdir'] }}/bin/syncthing
  cmd.run:
    - name: mv {{ pillar['syncthing']['installdir'] }}/syncthing-*/syncthing {{ pillar['syncthing']['installdir'] }}/bin/syncthing && rm -rf {{ pillar['syncthing']['installdir'] }}/syncthing-*
    - cwd: /tmp
    - creates: {{ pillar['syncthing']['installdir'] }}/bin/syncthing

syncthing_init:
  file.managed:
    - name: /etc/init/syncthing.conf
    - source: salt://syncthing/config/init/syncthing.conf
    - template: jinja
    - context:
      user: {{ pillar['syncthing']['user'] }}
      group: {{ pillar['syncthing']['group'] }}
      installdir: {{ pillar['syncthing']['installdir'] }}

  service.running:
    - name: syncthing
    - enable: True
    - watch:
      - file: {{ pillar['syncthing']['installdir'] }}/.config/syncthing/config.xml

syncthing_config:
  file.managed:
    - name: {{ pillar['syncthing']['installdir'] }}/.config/syncthing/config.xml
    - source: salt://syncthing/config/syncthing-config
    - template: jinja
