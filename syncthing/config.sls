{% for name in pillar['syncthing']['users'] %}
syncthing_configdir_{{ name }}:
  file.directory:
    - name: {{ salt['user.info'](name)['home'] }}/.config/syncthing
    - user: {{ name }}
    - makedirs: true


{% if pillar['syncthing']['users'][name] is defined %}
syncthing_config_{{ name }}:
  file.managed:
    - name: {{ salt['user.info'](name)['home'] }}/.config/syncthing/config.xml
    - source: salt://syncthing/files/config.xml
    - replace: False
    - template: jinja
    - context:
        config: pillar['syncthing']['users'][name]
    - require:
        - file: syncthing_configdir_{{ name }}
    - watch_in:
        - service: syncthing_service_{{ name }}
{% endif %}
{% endfor %}
