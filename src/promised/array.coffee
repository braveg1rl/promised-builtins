PromisedBuiltin = require "./builtin"

module.exports = class PromisedArray extends PromisedBuiltin
  join: (joinString) ->
    @awaitString (trueArray) -> trueArray.join joinString
  
  forEach: (callback) ->
    @awaitUndefined (trueArray) -> 
      callback value for value in trueArray
      undefined
    
  map: (callback) ->
    @awaitArray (trueArray) -> trueArray.map callback