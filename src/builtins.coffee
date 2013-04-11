require "setimmediate"

shelf = require "./shelf"

module.exports =
  PromisedArray: shelf.getPromisedArray()
  PromisedString: shelf.getPromisedString()  
  PromisedNumber: shelf.getPromisedNumber()
  PromisedUndefined: shelf.getPromisedUndefined()