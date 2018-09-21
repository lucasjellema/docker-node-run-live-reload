# docker-node-run-live-reload
Use the Dockerfile in this repository to build a container image that can be run with a single environment variable GITHUB_URL. The container will clone the repo indicated by the URL and run the application (using the package.json scripts.start command). The container exposes port 4500 where a live reload utility is running at endpoint /reload; with a call to host:4500/reload, the container will perform a git pull and an npm install to get the latest application definition and associated dependencies; when there are any changes, the application is automatically restarted.

To build:
```
docker build -t "node-run-live-reload:0.1" .
```
To run:
```
docker run --name node-app -p 3006:3001 -p 4500:4500  -e GITHUB_URL=https://github.com/lucasjellema/example-prometheus-nodejs -d node-run-live-reload:0.1
````

in this example, the node application cloned from GitHub exposes port 3001.

To reload the application:
```
curl -i -X GET http://host:4500/reload
```

##Todo
- allow an automated periodic application refresh to be configured (do a git pull every X seconds) 
- allow a GitHub WebHook signal to be handled
- use https://www.npmjs.com/package/simple-git instead of shelljs plus local Git client (this could allow usage of a lighter base image - e.g. node-slim)

##Tips
Some useful commands (I keep forgetting):

```
docker logs nodea-app --follow
```
