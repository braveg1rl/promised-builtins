# promised-builtins

Promises that somewhat act like the builtins that are promised.
All in all, this should be considered an experiment in code.

## Usage

Promised builtins are wrap regular [Promise/A+ promises](https://github.com/promises-aplus/promises-spec).

```coffee
deferred = Q.defer() # create a deferred with something, anything
promisedString = new PromisedString deferred.promise
```

Promised builtins are promises, so they support the `then` method.

```coffee
promisedString.then (string) -> console.log string
```

Promised builtins act as builtins as much as they can. When you call a method on them, they return another promised builtin. For example:

```coffee
promisedWords = promisedString.split(", ")
promisedWords.then (words) -> console.log word for word in words
```

But also

```coffee
promisedWords.forEach (word) -> console.log word 
```

Here the actual iteration happens only after the value for words has been resolved.
This means that in some cases, promised builtins work exactly like normal builtins, resulting in very clean code.

### Complete example

```coffee
Q = require "q"
{PromisedString} = require "promised-builtins"

getKeywordsField = ->
  deferredKeywordsField = Q.defer()
  setImmediate ->
    deferredKeywordsField.resolve("promises, deferreds, builtins, javascript, asynchronous")
  new PromisedString deferredKeywordsField.promise

# We play dumb and act like this is synchronous code,
# and like the objects in play are actual builtins.
<<<<<<< HEAD
keywordsField = getKeywordsField() # a promised string
keywords = keywordsField.split ", " # a promised array
keywords.forEach (keyword) -> console.log keyword # works
keywordsField = keywords.join "," # a promised string, again
=======
keywordsField = getKeywordsField()
keywords = keywordsField.split ", "
keywords.forEach (keyword) -> console.log keyword # works
keywordsField = keywords.join ","
>>>>>>> dc39fd5930ab3a031a1f7f2234e1a590ad941f34
keywordsField.then (keywordsField) -> console.log keywordsField
```

## Limitations

* You can't use normal operators on the promised builtins.
* You can't pass the promised builtin as an argument to a function that expects a regular builtin. A function should be specifically adjusted to accept a promised builtin (but this is certainly possible).

Every time you have an accute need for true values, you need to call `promisedValue.then` to get (or rather, wait for) the true value. But in some cases, you may be able to do without. That is, until your (logical) algorithm has finished, and you want to output something.

## Credits

The initial structure of this module was generated by [Jumpstart](https://github.com/meryn/jumpstart), using the [Jumpstart Black Coffee](https://github.com/meryn/jumpstart-black-coffee) template.

## License

promised-builtins is released under the [MIT License](http://opensource.org/licenses/MIT).  
Copyright (c) 2013 Meryn Stol  