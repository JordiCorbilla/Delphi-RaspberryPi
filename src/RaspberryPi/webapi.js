/**
 * webapi.js
 * 
 * @version 1.0 : August 2016
 *
 * DESCRIPTION:
 * A simple server-side application to demonstrate running a node 
 * API Application Server on a Raspberry Pi to ping other nodes
 * Uses the Express, http and ping node packages. 
 * 
 * 
 * @throws none
 * @see nodejs.org
 * @see express.org
 * 
 * @author Jordi Corbilla
 * (C) 2016
 * MIT Licensed
 */
'use strict'

var http = require('http');
var express = require('express');
var ping = require('ping');
var app = express();
var DEFAULT_PORT = 3000

// configure Express to deliver index.html and any other static pages stored in the home directory
app.use(express.static(__dirname));

// Express route for incoming requests with method status/xxx where xxx is the machineName
app.get('/status/:machinename', function (req, res) {
    console.log('id = ' + req.params.machinename);
    ping.sys.probe(req.params.machinename, function (isAlive) {
        var msg = isAlive ? 'host ' + req.params.machinename + ' is alive' : 'host ' + req.params.machinename + ' is dead';
        console.log(msg);
        var s = [{host: isAlive ? 'alive' : 'dead'}];
        res.status(200).send(s);
    });
});

// Express route for any other unrecognized incoming requests
app.get('*', function (req, res) {
  res.status(404).send('Unrecognized API call');
});

// Express route to handle errors
app.use(function (err, req, res, next) {
  if (req.xhr) {
    res.status(500).send('Something went wrong!');
  } else {
    next(err);
  }
});

// Start Express Application Server
app.listen(process.env.PORT || DEFAULT_PORT, function () {
    console.log('node.js listening on http://localhost:' + (process.env.PORT || DEFAULT_PORT))
});