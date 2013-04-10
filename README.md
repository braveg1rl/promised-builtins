# promised-builtins

Promises that somewhat act like the builtins that are promised.

## Usage


```coffee
promisedString = new PromisedString deferred
```

Promised builtins are promises, so they support the `then` method.

```coffee
promisedString.then (string) -> console.log string
```

Promised builtins act as builtins as much as they can. When you call a method on them, they return another promised builtin.

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

Putting it all together:

```coffee
getKeywords = ->
  deferredKeywordsField = Q.defer()
  promisedKeywordsField = new PromisedString deferredKeywordsField
  setImmediate ->
   deferredKeywords.resolve("promises, deferreds, builtins, javascript, asynchronous")
  promisedKeyWordsField

keywordsField = getKeywords() # We play dumb and act like this is sync code
keywords = keywordsField.split ", "
keywords.forEach (keyword) -> console.log keyword # works
```

## Credits

The initial structure of this module was generated by [Jumpstart](https://github.com/meryn/jumpstart), using the [Jumpstart Black Coffee](https://github.com/meryn/jumpstart-black-coffee) template.

## License

promised-builtins is released under the [MIT License](http://opensource.org/licenses/MIT).  
Copyright (c) 2013 Meryn Stol  