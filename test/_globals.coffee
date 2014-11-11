vm = require('vm')
path = require('path')
Promise = require('bluebird')
Duo = require('duo')
a = require('chai').assert
env = require('..')


GLOBAL.Promise = Promise
GLOBAL.a = a
GLOBAL.eq = a.deepEqual

GLOBAL.example = (filename, duoEnvConfig)->
  (new Promise (resolve, reject)->
    root = path.join __dirname, 'examples'
    Duo root
    .entry path.join(root, "#{filename}.js")
    .use env duoEnvConfig
    .cache false
    .run (err, js)->
      if (err) then return reject err
      resolve js
  ).then(execResult)

execResult = (js)->
  result = []
  ctx = vm.createContext
    console:
      log: (msg)-> result.push(msg)
  vm.runInContext(js, ctx)
  return result
