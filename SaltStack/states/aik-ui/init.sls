include:
    - git
    - nodejs

aik-ui:
    git.latest:
     - name: https://github.com/juan-bol/aik-portal-front
     - target: /srv/appfront
    require:
     - pkg: git

install_npm_dependencies:
    npm.bootstrap:
      - name: /srv/appfront

run_aik_portal:
    cmd.run:
      - name: "nohup node server.js > /dev/null 2>&1 &" 
