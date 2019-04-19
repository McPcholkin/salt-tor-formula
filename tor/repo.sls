{% from "tor/map.jinja" import map with context %}
{% set osfamily = salt['grains.get']('os_family', False) %}

{% if osfamily == 'Debian' %}
{% set codename = salt['grains.get']('lsb_distrib_codename') %}

add_apt_https_support_for_tor:
  pkg.installed:
    - name: {{ map.https_support_pkg }}
    - require_in:
      - pkgrepo: install_tor_repo

install_tor_repo:
  pkgrepo.managed:
    - name: deb {{ map.repo_url }} {{ codename }} main
    - file: /etc/apt/sources.list.d/tor.list
    - key_url: {{ map.repo_key_url }}
    - require:
      - pkg: add_apt_https_support_for_tor


{% endif %}
