#!/bin/sh
CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    # this branch is only executed when the container is first started
    cd /tmp
    # prepare the actual Node app from GitHub
    mkdir app
    git clone $GITHUB_URL app
    cd app
    #install dependencies for the Node app
    npm install
    #start  both the reload app (in the background) and (using nodemon) the actual Node app
    cd ..
    echo "starting reload app and nodemon"
    (echo "start reload";npm start; echo "reload app finished") & 
    cd app; 
    echo "starting nodemon for app cloned from $GITHUB_URL";
    nodemon
else
    echo "-- Not first container startup --"
    cd /tmp
    (echo "start reload";npm start; echo "reload app finished") &
    cd app; 
    echo "starting nodemon for app cloned from $GITHUB_URL";
    nodemon
fi

