{% from "tor/map.jinja" import map with context %}

include:
  - tor.repo

install_tor:
  pkg.installed:
    - pkgs: {{ map.pkgs }}
    - require:
      - pkgrepo: install_tor_repo
  service.running:
    - name: {{ map.service }}
    - restart: True
    - enable: True
    - require:
      - pkg: install_tor
