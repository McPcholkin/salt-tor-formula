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


{% if salt['pillar.get']('tor:ed25519_signing_cert', False) %}

deploy_tor_signing_cert:
  file.decode:
    - name: {{ map.torrc.DataDirectory }}/keys/ed25519_signing_cert
    - contents_pillar: tor:ed25519_signing_cert
    - encoding_type: base64
    - watch_in:
      - service: install_tor

set_owner_tor_signing_cert:
  file.managed:
    - name: {{ map.torrc.DataDirectory }}/keys/ed25519_signing_cert
    - user: debian-tor
    - group: debian-tor
    - mode: 600
    - reguire:
      - file: deploy_tor_torrc
      - file: deploy_tor_signing_cert
    - watch_in:
      - service: install_tor

{% endif %}


{% if salt['pillar.get']('tor:ed25519_signing_secret_key', False) %}

deploy_tor_signing_secret_key:
  file.decode:
    - name: {{ map.torrc.DataDirectory }}/keys/ed25519_signing_secret_key
    - contents_pillar: tor:ed25519_signing_secret_key
    - encoding_type: base64
    - watch_in:
      - service: install_tor

set_owner_tor_signing_secret_key:
  file.managed:
    - name: {{ map.torrc.DataDirectory }}/keys/ed25519_signing_secret_key
    - user: debian-tor
    - group: debian-tor
    - mode: 600
    - reguire:
      - file: deploy_tor_torrc
      - file: deploy_tor_signing_secret_key
    - watch_in:
      - service: install_tor

{% endif %}


{% if salt['pillar.get']('tor:ed25519_master_id_secret_key', False) %}

deploy_tor_master_id_secret_key:
  file.decode:
    - name: {{ map.torrc.DataDirectory }}/keys/ed25519_master_id_secret_key
    - contents_pillar: tor:ed25519_master_id_secret_key
    - encoding_type: base64
    - watch_in:
      - service: install_tor

set_owner_tor_master_id_secret_key:
  file.managed:
    - name: {{ map.torrc.DataDirectory }}/keys/ed25519_master_id_secret_key
    - user: debian-tor
    - group: debian-tor
    - mode: 600
    - reguire:
      - file: deploy_tor_torrc
      - file: deploy_tor_master_id_secret_key
    - watch_in:
      - service: install_tor

{% endif %}



{% if salt['pillar.get']('tor:ed25519_master_id_public_key', False) %}

deploy_tor_master_id_public_key:
  file.decode:
    - name: {{ map.torrc.DataDirectory }}/keys/ed25519_master_id_public_key
    - contents_pillar: tor:ed25519_master_id_public_key
    - encoding_type: base64
    - watch_in:
      - service: install_tor

set_owner_tor_master_id_public_key:
  file.managed:
    - name: {{ map.torrc.DataDirectory }}/keys/ed25519_master_id_public_key
    - user: debian-tor
    - group: debian-tor
    - mode: 600
    - reguire:
      - file: deploy_tor_torrc
      - file: deploy_tor_master_id_public_key
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


