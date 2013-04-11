types =
  PromisedArray: "array"
  PromisedNumber: "number"
  PromisedString: "string"
  PromisedUndefined: "undefined"

makeAccessor = (name, filename) ->
  =>
    @[name] = require("./promised/#{filename}") unless @[name]
    @[name]

module.exports = {}
module.exports["get#{name}"] = makeAccessor name, filename for name, filename of types
