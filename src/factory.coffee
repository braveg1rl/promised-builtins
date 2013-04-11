shelf = require "./shelf"

module.exports = factory =
  makePromisedArray: (promise) ->
    new (shelf.getPromisedArray()) promise
  makePromisedString: (promise) ->
    new (shelf.getPromisedString()) promise
  makePromisedUndefined: (promise) ->
    new (shelf.getPromisedUndefined()) promise
  makePromisedNumber: (promise) ->
    new (shelf.getPromisedNumber()) promise