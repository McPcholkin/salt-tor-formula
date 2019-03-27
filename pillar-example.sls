tor:
  torrc:
    SOCKSPort: '0.0.0.0:9050' 
    RelayBandwidthRate: '500 KBytes'
    AccountingMax: '20 GBytes'
    AccountingStart: 'day 00:00'
    ContactInfo: '0xFFFFFFFF LOL ??<<lol@example.com>>??'
    # no exits allowed
    ExitPolicy: 'reject *:*' 
    ExitRelay: '0'
    ControlSocket: '0'
    MaxMemInQueues: '800 MB'

  torsocks:
    TorAddress: '0.0.0.0'

  fingerprint: 'Unnamed 88888888888888888888888888888888888888888888'
  
  # base64
  ed25519_master_id_public_key: |
    sOKsdsdsdsdsdsdsdsdsdsdsU5x9SDWcVn
    hl58888888888888888888888888888

  # base64
  ed25519_master_id_secret_key: |
    PT098696986986986986986986986986986986986986986986986986986860fvfXct6B
    nN7q1iIh65463543546354354354354354354354354354354563khAb

  secret_id_key: |
    -----BEGIN RSA PRIVATE KEY-----
    lksj;ljksdflksjedflslkfjdl;skjfglskdjfgl;sdjfglsdjfgl;sdjfglsdfj
    szdklfjskldjfl;kasjdfl;jasdl;fajdfkjdkfjsdkjfkjdfadfjsdkfjlakdjf
    -----END RSA PRIVATE KEY-----

  
