trueKeywordsField = "promises, deferreds, builtins, javascript, asynchronous"
trueKeywords = trueKeywordsField.split(", ")

{PromisedArray,PromisedString} = require "../"

makePromise = require "../lib/makePromise"
assert = require "assert"
getKeywordsField = -> 
  new PromisedString (resolve, reject) ->
    setImmediate -> resolve trueKeywordsField

describe "PromisedString", ->
  describe "then method", ->
    it "should exists", ->
      assert.ok getKeywordsField().then?
    it "should work", (next) ->
      getKeywordsField().then (keywords) -> 
        assert.equal keywords, trueKeywordsField
        next null
  
  describe "split method", ->
    it "should exists", ->
      assert.ok getKeywordsField().split?
    it "should work", ->
      keywords = getKeywordsField().split(", ")
    it "should return a PromisedArray", ->
      keywords = getKeywordsField().split(", ")
      assert.ok(keywords instanceof PromisedArray)
    it "should return a PromisedArray that resolves to right value", (next) ->
      keywords = getKeywordsField().split(", ")
      keywords.then (words) ->
        assert.deepEqual(words, trueKeywords)
        next null