    /* this program listens for /reload request at port 4500. 
    When it receives such a request, it will perform a Git pull in the app sub directory (from where this application runs) 

    TODO
    - add the option to schedule an automatic periodic git pull
    - expose an endpoint for a GitHub WebHook signal, to respond to a Git commit

    - use https://www.npmjs.com/package/simple-git instead of shelljs plus local Git client (this could allow usage of a lighter base image - e.g. node-slim)
    */

    const RELOAD_PATH = '/reload'
    const APP_DIRECTORY = '\\app'

    var http = require('http');
    var server = http.createServer(function (request, response) {
        console.log('request starting...');
        if (request.method === 'GET' && request.url === RELOAD_PATH) {
            refreshAppFromGit();
            response.write(`RELOADED!!${new Date().toISOString()}`);
            response.end();
        }
        else {
            // respond
            response.write('Reload is live at path '+RELOAD_PATH);
            response.end();
        }
    });
    server.listen(4500);
    console.log('Server running and listening at Port 4500');

    //https://stackoverflow.com/questions/44647778/how-to-run-shell-script-file-using-nodejs
    // https://www.npmjs.com/package/shelljs

    var shell = require('shelljs');
    var pwd = shell.pwd()
    console.info(`current dir ${pwd}`)

    function refreshAppFromGit() {
        if (shell.exec('./gitRefresh.sh').code !== 0) {
            shell.echo('Error: Git Pull failed');
            shell.exit(1);
        } else {
    //        shell.exec('npm install')
        //  shell.exit(0);
        }

    }
