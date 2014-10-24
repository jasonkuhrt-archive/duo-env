# duo-env [![build status](https://secure.travis-ci.org/jasonkuhrt/duo-env.png)](http://travis-ci.org/jasonkuhrt/duo-env)

Expose Node.js global process.env to compiled client-side code



## Installation

```sh
$ npm install --save duo-env
```



## Example

```js
// file: app.js
var env = require('env').NODE_ENV

var uri = env === 'prod' ? 'api.foobar.io' : 'localhost:8000'

// ...
```
```sh
NODE_ENV=prod duo app.js > build/app.js --use duo-env
# Now "uri" in compiled app will equal 'api.foobar.io'
```



## API

The following settings are available:

- `name` – the literal module name that will be exposed, eg: what you want to `require(NAME)`. Defaults to "env".
- `pick` – expose only a subset of `process.env`. The exposed module is still a hash, but does not include the huge amount of things that `process.env` has  even by default.

Currently these settings are only useable in a scripted duo context, but I want to make it possible to pass these on the CLI too: https://github.com/duojs/duo/issues/362
