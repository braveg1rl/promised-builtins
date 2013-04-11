PromisedBuiltin = require "./builtin"
{makePromisedArray} = require "../factory"
  
module.exports = class PromisedString extends PromisedBuiltin
  split: (splitString) ->
    makePromisedArray (resolve) =>
      @then (trueString) -> resolve trueString.split ", "
      