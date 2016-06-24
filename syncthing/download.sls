{% macro syncthing_download_path() -%}
{{ salt['file.find'](salt['file.join'](pillar['syncthing']['download']['prefix'], 'download'), type='d', mindepth=1, maxdepth=1)[0] }}
{%- endmacro %}

syncthing_prefix:
  file.directory:
    - name: {{ pillar['syncthing']['download']['prefix'] }}
    - user: 'root'
    - group: 'root'
    - mode: '0755'

syncthing_download:

  archive.extracted:
    - name: {{ pillar['syncthing']['download']['prefix'] }}/download
    - source: {{ pillar['syncthing']['download']['source'] }}
    - archive_format: {{ pillar['syncthing']['download']['format'] }}
    - source_hash: {{ pillar['syncthing']['download']['hash'] }}
    - require:
        - file: syncthing_prefix

syncthing_install_bin:
  file.managed:
    - name: /usr/bin/syncthing
    - source: {{ syncthing_download_path() }}/syncthing
    - replace: False
    - user: {{ pillar['syncthing']['user'] }}
    - group: {{ pillar['syncthing']['group'] }}
    - mode: '0775'
    - require:
        - archive: syncthing_download

syncthing_init_script:
  file.managed:
{% if grains['init'] == 'upstart' %}
    - name: /etc/init/syncthing.conf
    - source: {{ syncthing_download_path() }}/etc/linux-upstart/system/syncthing.conf
{% elif grains['init'] == 'systemd' %}
    - name: /etc/systemd/system/syncthing@.service
    - source: {{ syncthing_download_path() }}/etc/linux-systemd/system/syncthing@.service
{% endif %}
    - user: 'root'
    - group: 'root'
    - mode: '0644'

{% if grains['init'] == 'systemd' %}
syncthing_init_script_resume:
  file.managed:
    - name: /etc/systemd/system/syncthing-resume.service
    - source: {{ syncthing_download_path() }}/etc/linux-systemd/system/syncthing-resume.service
    - user: 'root'
    - group: 'root'
    - mode: '0644'
{% endif %}
