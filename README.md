# docker-node-run-live-reload
Use the Dockerfile in this repository to build a container image that can be run with a single environment variable GITHUB_URL that references a git repo with a Node application. 

The container will clone the repo indicated by the URL and run the application (using the package.json scripts.start command). In addition to any port(s) exposed by the Node application, the container also exposes port 4500 where a live reload utility is running at endpoint /reload; with a call to host:4500/reload, the container will perform a git pull and an npm install to get the latest application definition and associated dependencies; when there are any changes, the application is then automatically restarted.

A GitHub WebHook can be configured for the endpoint host:4500/github/push. When a commit is performed on the GitHub repository, the WebHook sends a signal to the reload utility in the container and causes a refresh of the application (git pull followed by npm install and nodemon's restart of the application)

To build:
```
docker build -t "node-run-live-reload:0.3" .
```
To run:
```
docker run --name node-app -p 3006:3001 -p 4500:4500  -e GITHUB_URL=https://github.com/lucasjellema/example-prometheus-nodejs -d node-run-live-reload:0.3
````

in this example, the node application cloned from GitHub exposes port 3001.

To reload the application:
```
curl -i -X GET http://host:4500/reload
```

Note: the Docker Container image based on this repo is published on Docker Hub as: lucasjellema/node-run-live-reload:0.3

##Todo
- allow an automated periodic application refresh to be configured (do a git pull every X seconds) 
- use https://www.npmjs.com/package/simple-git instead of shelljs plus local Git client (this could allow usage of a lighter base image - e.g. node-slim)

##Tips
Some useful commands (I keep forgetting):

```
docker logs nodea-app --follow
docker exec -it node-app /bin/sh

docker tag node-run-live-reload:0.1 lucasjellema/node-run-live-reload:0.3
docker push lucasjellema/node-run-live-reload:0.3

docker  run --name node-app -p 3006:3001 -p 4500:4500  -e GITHUB_URL=https://github.com/lucasjellema/example-prometheus-nodejs -d lucasjellema/node-run-live-reload:0.3
```
