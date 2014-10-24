exec = require('child_process').exec

beforeEach (done)-> exec 'rm -r test/examples/components', -> done()
afterEach (done)-> exec 'rm -r test/examples/components', -> done()



describe 'duo-env', ->
  process.env.foo = 'bar'
  process.env.zed = 'ned'

  it 'exposes the whole of process.env as module "env"', ->
    example 'simple'
    .then (logs)->
      eq logs, [process.env]



  describe 'option "pick"', ->
    it 'permits only listed envs to be exposed', ->
      example 'simple', pick: ['foo', 'zed']
      .then (logs)->
        eq logs, [{foo:'bar', zed:'ned'}]

    it 'may be a string literal for case of single desired env', ->
      example 'simple', pick: 'foo'
      .then (logs)->
        eq logs, [{foo:'bar'}]



  describe 'option "name"', ->
    it 'exposes envs as given module "name"', ->
      example 'custom-name', name: 'foo-env'
      .then (logs)->
        eq logs, [process.env]
