include:
    - nodejs

aik-ui:
    git.latest:
     - name: https://github.com/juan-bol/aik-portal-front
     - target: /srv/appfront

install_npm_dependencies:
    npm.bootstrap:
      - name: /srv/appfront

run_aik_portal:
    cmd.run:
      - name: "nohup node /srv/appfront/server.js > /dev/null 2>&1 &" 

aik-api:
    git.latest:
     - name: https://github.com/juan-bol/aik-portal-back
     - target: /srv/appback

install_npm_dependencies_back:
    npm.bootstrap:
      - name: /srv/appback

run_aik_portal_back:
    cmd.run:
      - name: "nohup node /srv/appback/server.js > /dev/null 2>&1 &" 
