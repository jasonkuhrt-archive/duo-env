var debug = require('debug')('duo-env')



module.exports = function plugin(config) {

  config = config || {}
  if (config.pick) config.pick = inArray(config.pick)
  config.name = config.name || 'env'
  var env = config.pick ? pickKeys(config.pick, process.env) : process.env
  var first = true

  return function duoEnv(file, duo) {
    if (first) {
      debug('Exposing env vars: %j', env)
      duo.include(config.name, compileHashModule(env))
      first = false
    }
  }
}



// Helpers

function inArray(x){
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
