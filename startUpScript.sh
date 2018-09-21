#!/bin/sh
CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    # YOUR_JUST_ONCE_LOGIC_HERE
    cd /tmp
    # install dependencies for reload app
    # npm install
    # prepare the actual Node app from GitHub
    mkdir app
    git clone $GITHUB_URL app
    cd app
    #install dependencies for the Node app
    npm install
    #start  both the reload app and (using nodemon) the actual Node app
    cd ..
    echo "starting reload app and nodemon"
    (echo "starting reload app") & (echo "start reload";npm start; echo "reload app finished") & 
    cd app; 
    echo "starting nodemon for app cloned from $GITHUB_URL";
    nodemon
else
    echo "-- Not first container startup --"
    cd /tmp
    (echo "starting reload app and nodemon") & (echo "start reload";npm start; echo "reload app finished") & (cd app; echo "start nodemon") &
    cd app; 
    echo "starting nodemon for app cloned from $GITHUB_URL";
    nodemon
fi

