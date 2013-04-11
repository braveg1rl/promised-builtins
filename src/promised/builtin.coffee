makePromise = require "../makePromise"
shelf = require "../shelf"

module.exports = class PromisedBuiltin
  constructor: (arg) ->
    if typeof arg is "function"
      promise = makePromise arg
    else
      promise = arg
    @then = (onResolved, onRejected) -> 
      promise.then onResolved, onRejected
  
  delayOperation: (PromiseType, operation) ->
    new PromiseType makePromise (resolve) ->
      @then (trueBuiltin) -> resolve operation trueBuiltin
  
  awaitArray: (operation) ->
    @delayOperation shelf.getPromisedArray(), operation
    
  awaitString: (operation) ->
    @delayOperation shelf.getPromisedString(), operation
    
  awaitNumber: (operation) ->
    @delayOperation shelf.getPromisedUndefined(), operation
    