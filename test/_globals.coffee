vm = require('vm')
path = require('path')
Promise = require('bluebird')
Duo = require('duo')
a = require('chai').assert
env = require('..')



GLOBAL.a = a
GLOBAL.eq = a.deepEqual
GLOBAL.example = (filename, duoEnvConfig)->
  (new Promise (resolve, reject)->
    root = path.join(__dirname, 'examples')
    duo = Duo(root)
    duo.entry(path.join(root, "#{filename}.js"))
    duo.use(env(duoEnvConfig))
    duo.run (err, js)->
      if (err) then return reject(err)
      resolve(js)
  ).then(execResult)

execResult = (js)->
  result = []
  ctx = vm.createContext
    console:
      log: (msg)-> result.push(msg)
  vm.runInContext(js, ctx)
  return result
