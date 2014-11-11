var debug = require('debug')('duo-env')



module.exports = function duoPlugin(config) {

  config = config || {}
  if (config.pick) config.pick = asArray(config.pick)
  config.name = config.name || 'env'

  var processEnv = config.pick ? pickKeys(config.pick, process.env) : process.env
  var first = true

  return function env(file, duo) {
    if (first) {
      debug('Exposing env vars: %j', processEnv)
      duo.include(config.name, compileHashModule(processEnv), 'js')
      first = false
    }
  }
}



// Helpers

function asArray(x){
  return Array.isArray(x) ? x : [x]
}

function compileHashModule(hash) {
  return 'module.exports = ' + JSON.stringify(hash) + ';'
}

function pickKeys(keys, oldHash) {
  return keys.reduce(function(newHash, key){
    if (oldHash.hasOwnProperty(key)) newHash[key] = oldHash[key]
    return newHash
  }, {})
}
