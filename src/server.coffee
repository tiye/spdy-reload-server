
fs = require 'fs'
spdy = require 'spdy'
path = require 'path'
mime = require 'mime'

bufferCache = {}

options =
  key: fs.readFileSync (path.join __dirname, '../certificate/server.key')
  cert: fs.readFileSync (path.join __dirname, '../certificate/server.crt')
  ca: fs.readFileSync (path.join __dirname, '../certificate/server.csr')

server = spdy.createServer  options, (req, res) ->
  dest = req.url
  if dest is '/'
    Object.keys(bufferCache).forEach (key) ->
      headers =
        'Content-Type': mime.lookup(key)
        'charset': 'utf-8'
      console.log 'push:', key
      res.push key, headers, (err, stream) ->
        stream.end bufferCache[key]
    res.writeHeader 200, 'Content-Type': 'text/html'
    fs.readFile 'app.html', 'utf8', (err, content) ->
      res.end content
  else
    console.log 'get:', dest
    res.writeHeader 200, 'Content-Type': mime.lookup(dest)
    filepath = path.join process.env.PWD, dest
    fs.readFile filepath, 'utf8', (err, content) ->
      bufferCache[dest] = content
      res.end content

server.listen 3000