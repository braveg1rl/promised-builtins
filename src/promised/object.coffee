PromisedBuiltin = require './builtin'

module.exports = class PromisedObject extends PromisedBuiltin
  getStringAt: (index) ->
    @getPromiseForvalueAt index, PromisedString

  getArrayAt: (index) ->
    @getPromiseForvalueAt index, PromisedArray

  getNumberAt: (index) ->
    @getPromiseForvalueAt index, PromisedNumber

  getObjectAt: (index) ->
    @getPromiseForvalueAt index, PromisedObject
    
  getPromiseForValueAt: (index, PromiseType) ->
    @delayOperation PromiseType, (realObject) ->
      return realObject[index]? if realObject[index]?
      throw new Error "Object has no property '#{index}'"