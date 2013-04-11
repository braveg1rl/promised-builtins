# promised-builtins

Promises that somewhat act like the instances of the builtins that are promised. An instance of `PromisedString` acts somewhat like an instance of `String`. An instance of `PromisedArray` acts somewhat like an instance of `Array`.

All in all, this should be considered a code experiment.

## Project scope

Builtin is short-hand for built-in object. The ECMAScript 5 specification defines a built-in object as follows:

> ### built-in object  
> object supplied by an ECMAScript implementation, independent of the host environment, that is present at the start of the execution of an ECMAScript program.

[ECMAScript5.1 Spec 4.3.7](http://es5.github.io/#x4.3.6)

I'm only concerned about built-in objects of which one can instantiate an instance through a constructor function. These constructor functions are listed in [ECMAScript 5.1 Spec 15.1.4](http://es5.github.io/#x15.1.4). Moreover, I'll limit myself to `Array`, `String`, `Boolean`, `Number` and `Date`, because these are the most typical kinds of objects one regularly deals with in simple scripting.

`Object` and `Function` are certainly interesting too. I'll attend to them in a later stage.

## How promised builtins function

Basically, a promised builtin has the same methods as the builtin that is promised. This is where the similarity ends. Most notable:

* You can't use normal operators (`+-/*`, `&&`, `||`) or any control flow consructs (`if..else..`, `while`, `for`) on the promised builtins.
* You can't safely pass the promised builtin as an argument to a function that expects a regular builtin. A function should be specifically adjusted to accept a promised builtin (but this is certainly possible). 

  To be precise, some non-adapted functions *might* work, since the promised builtins implement the same methods as the regular builtins, but if the function (or any other function it calls) tries to use any operator or control construct to the builtins, the function will fail miserably, surprisingly, or both.

## Usage

You create an instance of a promised builtin by passing a `(resolve, reject)` function to its constructor. This callback is called immediately by the construcor so any calls to `resolve` or `reject` can scheduled. This mirrors  the new instantiation style of [RSVP 2.0](https://github.com/tildeio/rsvp.js).

```coffee
promisedString = new PromisedString (resolve, reject) ->
  setImmediate -> resolve "abc def ghi jkl"
```

You may also pass any regular [Promise/A+ promise](https://github.com/promises-aplus/promises-spec) to the constructor.

```coffee
promisedString = new PromisedString someGenericPromise
```

Promised builtins are promises, so they have a `then` method.

```coffee
promisedString.then (string) -> console.log string
```

Promised builtins act as builtins as much as they can. When you call a method on them, they return another promised builtin. For example:

```coffee
promisedWords = promisedString.split(" ")
promisedWords.then (words) -> console.log word for word in words
```

But also

```coffee
promisedWords.forEach (word) -> console.log word 
```

Here the actual iteration happens only after the value for words has been resolved.
This means that in some (limited) cases, promised builtins work exactly like normal builtins, resulting in very clean code.

### Complete example

```coffee
{PromisedString} = require "promised-builtins"

getKeywordsField = ->
  new PromisedString (resolve, reject) ->
    setImmediate -> 
      resolve("promises, deferreds, builtins, javascript, asynchronous")

# We play dumb and act like this is synchronous code,
# and like the objects in play are actual builtins.
keywordsField = getKeywordsField()
keywords = keywordsField.split ", " # a PromisedArray instance
keywords.forEach (keyword) -> console.log keyword # works
keywordsField = keywords.join "," # a PromisedString instance
keywordsField.then (keywordsField) -> console.log keywordsField # works too
```

## Limitations

Every time you have an accute need for true values, you need to call `promisedValue.then` to get (or rather, wait for) the true value. But in some cases, you may be able to do without. That is, until your (logical) algorithm has finished, and you want to output something.

## Related work

If you think this is interesting, but haven't heard about the following projects, then they definitely deserve your attention.

* [task.js](http://taskjs.org/) uses promises combined with [ECMAScript 6 generators](http://wiki.ecmascript.org/doku.php?id=harmony:generators) to allow for synchronous processing of the results of promises. Here, because the code after the `yield` keyword actually isn't evaluated until the promise has resolved, the values are the truly resolved values. This is not possible without ES6 though.
* [Q](https://github.com/kriskowal/q) allows promises to be used as a proxy, with a HTTP-inspired generic interface. You can do `get`, `put`, `del`, `post` on any (virtual) property of the promise, as well as schedule invocation of arbitrary methods.
* [Wind.js](https://github.com/JeffreyZhao/wind) uses eval to evaluate generated code. Last commit seven months ago.
* [IcedCoffeeScript](http://maxtaco.github.io/coffee-script/) adds `await` and `defer` keywords to CoffeeScript. Last commit seven months ago.

## Credits

The initial structure of this module was generated by [Jumpstart](https://github.com/meryn/jumpstart), using the [Jumpstart Black Coffee](https://github.com/meryn/jumpstart-black-coffee) template.

## License

promised-builtins is released under the [MIT License](http://opensource.org/licenses/MIT).  
Copyright (c) 2013 Meryn Stol