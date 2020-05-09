include:
    - nodejs

aik-api:
    git.latest:
     - name: https://github.com/juan-bol/aik-portal-back
     - target: /srv/appback

install_npm_dependencies:
    npm.bootstrap:
      - name: /srv/appback

run_aik_portal:
    cmd.run:
      - name: "nohup node /srv/appback/server.js > /dev/null 2>&1 &" 
