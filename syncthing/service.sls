{% from "syncthing/map.jinja" import map with context %}

{% if map.service.endswith('@') %}
{% if pillar['syncthing']['users'] is defined %}
{% for name in pillar['syncthing']['users'] %}
syncthing_service_{{ name }}:
  service.running:
    - name: syncthing@{{ name }}
    - enable: True
{% endfor %}
{% endif %}
{% else %}
syncthing_service:
    service.running:
    - name: syncthing
    - enable: True
{% endif %}
