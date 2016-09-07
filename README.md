# Delphi-RaspberryPi
Simple projects to show interaction between Delphi and Raspberry Pi

[![Delphi version](https://img.shields.io/badge/delphi-10.1Berlin-red.svg)](https://github.com/JordiCorbilla/Delphi-RaspberryPi/releases/tag/1.0) [![node version](https://img.shields.io/badge/node.js-6.3.1-green.svg)](https://github.com/JordiCorbilla/Delphi-RaspberryPi/releases/tag/1.0)

**License:** MIT License.

## Setup
Create webapi folder

Copy content of repository (src/RaspberryPi) into webapi folder

run the following commands:
```
sudo npm i
npm run build
npm start
```
![Screenshot](https://github.com/JordiCorbilla/Delphi-RaspberryPi/raw/master/webapi.png)

## Web API in action

```javascript
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
```

![Screenshot](https://github.com/JordiCorbilla/Delphi-RaspberryPi/raw/master/Animation.gif)

```pascal
## Delphi App in action
//Example - create list of nodes to scan:
  listNodes := TList<TNode>.create();
  listNodes.Add(TNode.Create('status/picontroller'));
  listNodes.Add(TNode.Create('status/pi01'));
  listNodes.Add(TNode.Create('status/pi02'));
  listNodes.Add(TNode.Create('status/pi03'));

//Use this list to loop through and request the correct node:
procedure TNodeThread.Execute;
var
  node : TNode;
  jValue: TJSONValue;
  LJsonArr   : TJSONArray;
  LJsonValue : TJSONValue;
  LItem : TJSONValue;
  status : string;
begin
  Synchronize(
    procedure ()
    begin
        FAniIndicator.Visible := true;
        FAniIndicator.Enabled := true;
    end
  );

  for node in FListNodes do
  begin
    FRequest.Resource := node.Action;
    try
      FRequest.Execute;
      jValue := FResponse.JSONValue;
      LJsonArr := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(jValue.ToString),0) as TJSONArray;
      //Process results
    except
      on e : Exception do
      begin
        Synchronize(
          procedure ()
          begin
              node.labelNode.Text := 'Timeout';
              node.RoundRect.Fill.Color := node.ColorOff;
          end
        );
      end;
    end;
  end;

  Synchronize(
    procedure ()
    begin
        FAniIndicator.Visible := false;
        FAniIndicator.Enabled := false;
    end
  );
end;
```

![Screenshot](https://github.com/JordiCorbilla/Delphi-RaspberryPi/raw/master/Animation2.gif)

And the layout:

![Screenshot](https://github.com/JordiCorbilla/Delphi-RaspberryPi/raw/master/layout.png)

**Licence**
-------

    The MIT License (MIT)
    
    Copyright (c) 2016 Jordi Corbilla
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
