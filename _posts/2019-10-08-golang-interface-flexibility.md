---
layout: post
date:   2019-10-08
title:  "Golang Interface Flexibility"
tags: golang go interface types strong-type
---

# Golang Interface Flexibility

Coming from JavaScript into Golang, I am used to some of the most extreme
flexibility you can find in programming.  Consider this random snippet:

```JavaScript 
// yay! an array of anything I could possibly imagine!
let allTheThings = [{
    "let's use a string",
    12345,
    "and numbers",
    [1,2,3,4, "welp, and a nested array..."],
    { name: "andAnObject" },
    function() { return "why not a func also?" },
    () => "and an arrow func",
    // etc
}]
```

The value of the above is questionable, it is hard to know what you can do 
with each of the items in the array.  At best, you have an implicit contract
somewhere expecting a certain order of components.  

In Golang, you have strong typing.  This is valuable, but initially feels 
limiting.  Your first list (`slice` in Golang is the most similar to an 
`array` in JavaScript) may look something like:

```golang 
aSetOfThings := []string{
    "all strings",
    "another string",
    "i guess i'll just pass strings",
}
```

Strings is simplistic, however, so let's collect a set of a custom type:

```golang
type Person struct {
    name string
    age int 
}
```

And create a `slice` of persons:

```golang
people := []Person{
    {
        name: "jane",
        age: 25,
    }, {
        name: "john",
        age: 30
    }, {
        name: "jill",
        age: 35,
    }, {
        name: "jeff",
        age: 40,
    }
}
```
This is useful, but is nothing like our original `array` in JavaScript. Lets
add an interface so we can have a `slice` of similar but different objects:

```golang
type Walker interface {
    Walk()
}

// and ensure our Person implements
type Person struct {
    name string
    age int 
}
func(p Person) Walk() {
    fmt.Prinf("%s is walking\n", p.name)
}
func(p Person) Talk() {
    fmt.Prinf("%s is talking\n", p.name)
}

// and add another struct that implements
type Dog struct {
    name string
}
func(d Dog) Walk() {
    fmt.Prinf("%s is walking\n", p.name)
}

func(d Dog) Fetch() {
    fmt.Prinf("%s is fetching\n", p.name)
}

// and now we can have a slice of walkers, which are different objects,
// but comply with the same interface.
walkers := []Walker{
    Person{name: "jill", age: 35},
    Dog{name: "Fido"},
    Person{name: "jack", age: 40}
}
```

Even though the structs are different (`Talk()` vs `Fetch()`), they both 
fulfill the interface, so `Golang` is happy.  

But we can go further.

Lots of things `Bounce`, so lets transition to a `Bouncer` interface.

```golang
type Bouncer interface {
	Bounce()
}
```
And lets add a func that takes a `Bouncer`:

```golang
func BounceIt(b Bouncer) {
	b.Bounce()
}
```
We want to send lots of things to our `BounceIt` func.

Now, the first thing that bounces is likely a `Ball`:

```golang
type Ball struct {
	Radius int
	Material string
}

func(b Ball) Bounce() {
	fmt.Printf("Bouncing ball %+v\n", b)
}
```

We can directly bounce it, or let our bouncer do the bouncing:

```golang
b := Ball{} 
b.Bounce()
BounceIt(b)
```

Nothing crazy yet.  Now, let's add an additional bouncing thing, but 
increase its complexity a bit. The new one will `embed` a separate 
`Bouncer`:

```golang
type Football struct {
	Bouncer
	Radius int
}
```

Which we can create by using our original `Ball`:

```golang
b := Ball{Radius: 5, Material: "leather" }
fb := Football{Bouncer: Ball{}, Radius: 5} 

b.Bounce()
fb.Bounce()
fbf.Bouncer.Bounce() // call it either way.

BounceIt(b)
BounceIt(fb)
```

Nothing too crazy here, our new `struct` still implements the interface.

Let's add another `Bouncer`, that does something a little bit different:

```golang
// embed a pointer to a Ball
type Soccerball struct {
	*Ball
}
func(sb Soccerball) Bounce() {
	fmt.Printf("Bouncing ball %+v\n", sb)
}
```

This is still fine, the `Interface` is a contract, it doesn't care about 
the implementation details:

```golang
b := Ball{} 
f := Football{Ball{}, 5}
sb := Soccerball{&Ball{}}

b.Bounce()
f.Bounce()
f.Bouncer.Bounce() // call it either way.
sb.Bounce()
sb.Ball.Bounce() 

BounceIt(b)
BounceIt(f)
BounceIt(sb)
```

And we might as well add some other things:

```golang
// simple, implements Bouncer itself, nothing embedded
type Jelly struct {
	Radius int
}

func(j Jelly) Bounce() {
	fmt.Printf("Bouncing jelly %+v\n", j)
}

// Rabbit method will use a pointer receiver, just to change
// things up a little bit more
type Rabbit struct {
	Color string
}
// But with a pointer receiver on the method. 
// still fine because the method signature doesn't change.
func(r *Rabbit) Bounce() {
	fmt.Printf("Bouncing rabbit %+v\n", r)
}
```
And usage:

```golang
b := Ball{} 
f := Football{Ball{}, 5}
sb := Soccerball{&Ball{}}
j := Jelly{}
// aha! since the method has a pointer receiver, we need to 
// take the address of rabbit in order to use it.
r := &Rabbit{}

b.Bounce()
f.Bounce()
f.Bouncer.Bounce() // call it either way.
sb.Bounce()
sb.Ball.Bounce() 
j.Bounce()
r.Bounce()

BounceIt(b)
BounceIt(f)
BounceIt(sb)
BounceIt(j)
BounceIt(r)
```

Finally, lets get as close as we can to the flexibility of the original
array example provided in JavaScript.  Let's add a few non-`struct` objects, 
starting with an `int`:

```golang
type BouncyInt int

func(bi BouncyInt) Bounce() {
	fmt.Printf("bouncing int? %+v\n", bi)
}
```
And instantiate:

```golang 
// note the different instantiation rules for this one
var bi BouncyInt      // implicit zero value
bi2 := BouncyInt(0)   // explicit zero value
bi3 := BouncyInt{} // NO! BouncyInt is not a struct, despite the methods

bi.Bounce()

BounceIt(bi)
```

And we might as well have a bouncy func as well:

```golang 
// we need a type for our func
type BouncyFunc func()

// and we can add the methods that will implement the Bouncer interface
func(bf BouncyFunc) Bounce() {
	fmt.Printf("Bouncing func! %+v\n", bf)
}
```
Instantiate:

```golang
// need to cast our func
f := BouncyFunc(func() {})

f.Bounce()

BounceIt(f)
```

And for fun, we might as well make an adapter for this stubborn struct
that refuses to bounce:

```golang
// this won't bounce
type NotBouncer interface {
	Sit()
}

// and this will impl the NotBouncer interface
type DoesntBounce struct {}
func (db DoesntBounce) Sit() {
	fmt.Printf("sit, don't bounce %+v\n", db)
}

// this isn't gonna bounce
nope := DoesntBounce{}

nope.Sit()
nope.Bounce() // error!
```
Until we wrap it:

```golang
type ForceItToBounce struct {
	Bouncer
	// we can embed it and MAKE it bounce
	sits NotBouncer
}
// well, it still sits, but it will respond to bounce...
func (fitb *ForceItToBounce) Bounce() {
	fitb.sits.Sit()
}
```
and:

```golang
fitb := ForceItToBounce{
    sits:    DoesntBounce{},
}
fitb.Bounce()
// note this method was a pointer receiver
BounceIt(&fitb)
```

Finally, might as well implement a `Bouncer` generator:

```golang
// a helper to make BouncyFuncs
func getBouncyFunc() BouncyFunc {
	return BouncyFunc(func() {})
}

// a func to return a func, will encapsulate our strange list of Bouncers
func GetBouncer() func() Bouncer {
	// gotta cycle the seed to stir up the randomness
	rand.Seed(time.Now().UnixNano())

	// huh, the BouncingInt can be a bouncer...
	var bouncingIntegerOfCraziness BouncyInt

    // make a list of things we can return that impl the interface
	bouncers := []Bouncer{
        Ball{},
		Soccerball{},
		Football{},
        Jelly{},
        // watch the pointers
        &Rabbit{},
		// we proved ints are fine
        bouncingIntegerOfCraziness,
        // another one, inline 
        BouncyInt(0),
		// manually make one
        BouncyFunc(func() {}),
		// call the helper
        getBouncyFunc(),
        // and a forced bouncer
        ForceItToBounce{
           sits: DoesntBounce{},
        }

	}
    max := len(bouncers)
    
	return func() Bouncer {
		random := rand.Intn(max)
		// fmt.Printf("%v \n", random)
		return bouncers[random]
	}
}
```

And then use this thing:

```golang
func main() {
    
    bouncer := GetBouncer()
    // lets get 10 bouncers
    for i := 0; i < 10; i++ {
        randBouncingThing := bouncer()
        // and of course see if they bounce :)
        randBouncingThing.Bounce()
        BounceIt(randBouncingThing)
		fmt.Printf("%T - %v\n", randBouncingThing, randBouncingThing)
	}
}
```

Feel free to give the above a copy paste to [Go Playground](https://play.golang.org/).

Initially, it felt like a huge loss of flexibility to move from 
JavaScript into Golang.  However, the above proves that Golang can 
give us quite a bit of flexibility, while also providing type safety.  
I've done enough refactoring of Go code now to realize the value of 
the contracts provided with strict types and interfaces, and have not 
yet missed too many of the crazy schenanigans of JavaScript.