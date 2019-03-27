{% from "tor/map.jinja" import map with context %}

include:
  - tor.repo
  - tor.install

deploy_tor_torrc:
  file.managed:
    - name: {{ map.config_torrc }}
    - source: salt://{{ slspath }}/files/ini.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defailts:
      config: {{ map.torrc }}
    - reguire:
      - pkg: install_tor
    - watch_in:
      - service: install_tor

deploy_tor_torsocks:
  file.managed:
    - name: {{ map.config_torsocks }}
    - source: salt://{{ slspath }}/files/ini.jinja
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defailts:
      config: {{ map.torsocks }}
    - reguire:
      - pkg: install_tor
    - watch_in:
      - service: install_tor

{% set fingerprint_path = map.torrc.DataDirectory + '/fingerprint' %}

{% if not salt['file.contains'](fingerprint_path, salt['pillar.get']('tor:fingerprint', False) ) %}

{% if salt['pillar.get']('tor:fingerprint', False) %}
deploy_tor_fingerprint:
  file.managed:
    - name: {{ map.torrc.DataDirectory }}/fingerprint
    - contents_pillar: tor:fingerprint
    - user: debian-tor
    - group: debian-tor
    - mode: 600
    - reguire:
      - file: deploy_tor_torrc
    - watch_in:
      - service: install_tor
{% endif %}

{% if salt['pillar.get']('tor:secret_id_key', False) %}
deploy_tor_secret_id_key:
  file.managed:
    - name: {{ map.torrc.DataDirectory }}/keys/secret_id_key
    - contents_pillar: tor:secret_id_key
    - user: debian-tor
    - group: debian-tor
    - mode: 600
    - reguire:
      - file: deploy_tor_torrc
    - watch_in:
      - service: install_tor
{% endif %}

{% if salt['pillar.get']('tor:ed25519_master_id_public_key', False) %}

send_tor_master_id_public_key:
  file.managed:
    - name: /tmp/ed25519_master_id_public_key.base64
    - contents_pillar: tor:ed25519_master_id_public_key
    - user: root
    - group: root
    - mode: 600
    - reguire:
      - file: deploy_tor_torrc
    - require_in:
      - cmd: decode_tor_master_id_public_key

decode_tor_master_id_public_key:
  cmd.run:
    - name: "base64 -d /tmp/ed25519_master_id_public_key.base64 > {{ map.torrc.DataDirectory }}/keys/ed25519_master_id_public_key"
    - reguire:
      - file: send_tor_master_id_public_key
    - require_in:
      - file: set_ownner_tor_master_id_public_key

set_ownner_tor_master_id_public_key:
  file.managed:
    - name: {{ map.torrc.DataDirectory }}/keys/ed25519_master_id_public_key
    - user: debian-tor
    - group: debian-tor
    - mode: 600
    - reguire:
      - file: deploy_tor_torrc
    - watch_in:
      - service: install_tor
    - reguire_in:
      - file: clean_temp_tor_master_id_public_key

clean_temp_tor_master_id_public_key:
  file.absent:
    - name: /tmp/ed25519_master_id_public_key.base64

{% endif %}

{% if salt['pillar.get']('tor:ed25519_master_id_secret_key', False) %}

send_tor_master_id_secret_key:
  file.managed:
    - name: /tmp/ed25519_master_id_secret_key.base64
    - contents_pillar: tor:ed25519_master_id_secret_key
    - user: root
    - group: root
    - mode: 600
    - reguire:
      - file: deploy_tor_torrc
    - require_in:
      - cmd: decode_tor_master_id_secret_key

decode_tor_master_id_secret_key:
  cmd.run:
    - name: "base64 -d /tmp/ed25519_master_id_secret_key.base64 > {{ map.torrc.DataDirectory }}/keys/ed25519_master_id_secret_key"
    - reguire:
      - file: send_tor_master_id_secret_key
    - require_in:
      - file: set_ownner_tor_master_id_secret_key

set_ownner_tor_master_id_secret_key:
  file.managed:
    - name: {{ map.torrc.DataDirectory }}/keys/ed25519_master_id_secret_key
    - user: debian-tor
    - group: debian-tor
    - mode: 600
    - reguire:
      - file: deploy_tor_torrc
    - watch_in:
      - service: install_tor
    - reguire_in:
      - file: clean_temp_tor_master_id_secret_key

clean_temp_tor_master_id_secret_key:
  file.absent:
    - name: /tmp/ed25519_master_id_secret_key.base64

{% endif %}

{% endif %}
