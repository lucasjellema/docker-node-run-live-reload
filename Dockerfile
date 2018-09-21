FROM node:8
#copy the Node Reload server - exposed at port 4500
COPY package.json /tmp
COPY server.js /tmp
RUN cd /tmp && npm install 
EXPOSE 4500 
RUN npm install -g nodemon
COPY startUpScript.sh /tmp
COPY gitRefresh.sh /tmp
CMD ["chmod", "+x",  "/tmp/startUpScript.sh"]
CMD ["chmod", "+x",  "/tmp/gitRefresh.sh"]
ENTRYPOINT ["sh", "/tmp/startUpScript.sh"]


