cp = Promise.promisifyAll require('child_process')



clean = ->
  cp.execAsync "rm -r #{__dirname}/examples/components"
  .catch ->




describe 'duo-env', ->
  before clean
  after clean
  beforeEach ->
    process.env.foo = 'bar'
    process.env.zed = 'ned'

  it 'exposes the whole of process.env as module "env"', ->
    example 'simple.js'
    .get 0
    .then (log)->
      eq log, process.env

  # Will fail if .cache is false
  # looking to resolve this with upstream patches:
  # https://github.com/duojs/duo/issues/386
  it.skip 'busts cache if the env has changed', ->
    example 'simple.js'
    .get 0
    .then (log)->
      eq log, process.env
      delete process.env.foo
      example 'simple.js', pick: 'foo?'
      .get 0
      .then (log)->
        eq log, it: 'changed!'





  describe 'option "pick"', ->

    it 'permits only listed envs to be exposed', ->
      example 'simple.js', pick: ['foo', 'zed']
      .get 0
      .then (log)->
        eq log, foo:'bar', zed:'ned'

    it 'may be a string literal for case of single desired env', ->
      example 'simple.js', pick: 'foo'
      .get 0
      .then (log)->
        eq log, foo:'bar'



  describe 'option "name"', ->

    it 'exposes envs as given module "name"', ->
      example 'custom-name.js', name: 'foo-env'
      .get 0
      .then (log)->
        eq log, process.env
