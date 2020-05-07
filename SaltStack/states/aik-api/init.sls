include:
    - git
    - nodejs

aik-ui:
    git.latest:
     - name: https://github.com/juan-bol/aik-portal-back
     - target: /srv/appback
    require:
     - pkg: git

install_npm_dependencies:
    npm.bootstrap:
      - name: /srv/appback

run_aik_portal:
    cmd.run:
      - name: "nohup node server.js > /dev/null 2>&1 &" 
