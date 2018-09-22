#!/bin/sh
CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
TARGET_DIR=${APPLICATION_ROOT_DIRECTORY-''}
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    # this branch is only executed when the container is first started
    cd /tmp
    # prepare the actual Node app from GitHub
    mkdir app
    git clone $GITHUB_URL app
    echo 'GIT repo was cloned to /tmp/app/${!TARGET_DIR}'
    cd /tmp/app/$TARGET_DIR
    #install dependencies for the Node app
    npm install
    #start  both the reload app (in the background) and (using nodemon) the actual Node app
    cd /tmp
    echo "starting reload app and nodemon"
    (echo "start reload";npm start; echo "reload app finished") & 
    cd /tmp/app/$TARGET_DIR; 
    echo "starting nodemon for app cloned from $GITHUB_URL in /tmp/app/${!TARGET_DIR}";
    nodemon
else
    echo "-- Not first container startup --"
    cd /tmp
    (echo "start reload";npm start; echo "reload app finished") &
    cd /tmp/app/$TARGET_DIR; 
    echo "starting nodemon for app cloned from $GITHUB_URL in directory /tmp/app/${!TARGET_DIR}";
    nodemon
fi

