```javascript

// bind
Function.prototype.bind

// lolwut?
// binding bind... to call?
Function.prototype.bind.bind(Function.prototype.call);

// makes an unbinder
var unbind = Function.prototype.bind.bind(Function.prototype.call);

// so you can essentially pop fns off the prototype
var map = Function.prototype.bind.bind(Function.prototype.call)(Array.prototype.map);

// or
var map = unbind(Array.prototype.map);

// so now can change OOP style:
[1,2,3].map(function(item, i) {

});
// into fn style:
map([1,2,3], function(item, i) {

});

// why?
// objects are data + functions + state...
// vs fns acting on data, input & output

```
