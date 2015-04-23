---
layout: post
date: 2015-04-23
title: "Algorithms, Binary Search in JavaScript"
index: 3
---

### tl;dr

I'm working through the book
[Grokking Algorithms]('http://www.amazon.com/Grokking-Algorithms-illustrated-programmers-curious/dp/1617292230'){:target="_blank"}{:title="Grokking Algorithms"} and sharing my implementation of binary search written in JavaScript.

# Algorithms Are Just Step By Step Problem Solving Methods.

As someone who has come into a career in software development through unconventional means, I find
myself intrigued by the many things I miseed out on by not pursuing a CS or CE degree back in my college
days.  Currently Algorithms are at the top of my list of Curous Things I Want To Explore.  I'm working
through the book Grokking Algorithms by Aditya Bhargava.  Bhargava is a good teacher, making use of illustrations
and clear explanations, ensuring a topic that could be dry and painful stays interesting.

## Binary Search

The first algorithm in the book is binary search.  Binary search is simply a way to find an item in a list in
the most efficient way possible.  The catch is that the list must be sorted to be effective (1,2,3,4,5, not 5,3,4,2,1).  With a sorted list (sorted is required for this to work), the algorithm is simple.  Guess the halfway point of the list.  If the guess
is too large, ignore everything above.  If the guess is too small, ignore everything below.  Repeat until you
find the item, otherwise return nothing.

Basically, a binary search needs to find the index of the searched item in as few guesses as possible. If
found, it will return the index. If not, it will return -1 (this is standard). My implementation below will
work with a list of numbers or strings.

## So Whats the Big Deal?

Why is binary search interesting?  Bhargava uses a simple example.  Lets say we have a list of 4 billion numbers.  To
figure out if a number is in the list, we would have to loop the entire list and compare every value to what we are
looking for.  The list has to be sorted, but that doesn't mean every number is included (it could be a list of even
numbers, for example).  This means that if our number is the last item in that list, we had to make 4 billion guesses!
But what if we use binary search?  With a binary search, no matter the number the maximum guesses to find it is 32.
Thirty two!  Thats a pretty amazing improvement.

## How does it work?

The function is rather simple.  If the sorted list is 4 billion items long, check the middle item.  If the guess is right, win.
If too high, throw away everything higher. If too low, throw away everything lower. Bam! We now only have 2 billion to go, cutting.  the list in half.  Repeat and there goes another billion, cutting the list in half again.  The next round trims 500 million.
With this algorithm we are able to quickly hone in onto a very small subset of the list to determine if the item we want exists.

## Is it practical?

Binary search is practical, though I don't find myself using it directly very often.  Typically a find is more complex, requiring
a predicate function for comparison (often the item we want is an object), and often our lists are not sorted.  My favorite method
for searching is a hash table, which is always a single guess to find the item, but we will get to that in another post.

## My Implementation

My implementation is in JavaScript, the language I work in most regularly.  Its simple to work through the
basic idea of the algorithm. I'm not worried about edge cases or real world use at this point as I'd use a
library like
[Underscore.js](http://underscorejs.org/){:target="_blank"}{:title="Underscore.js"} or
[lodash](https://lodash.com/){:target="_blank"}{:title="lodash"} or
[Ramda](http://ramdajs.com/docs/){:target="_blank"}{:title="Ramda"}
which are optimized and far more useful (see
[Underscore's indexOf function](http://underscorejs.org/#indexOf){:target="_blank"}).

To see the actual implementation in Underscore.js, checkout the
[annotated source](http://underscorejs.org/docs/underscore.html){:target="_blank"}, and search for the
function `createIndexFinder`.

My simple implementation:

{% highlight javascript %}

var binarySearch = function(list, item) {
    var attempts = 0,
        low = 0,
        high = list.length-1,
        guessIndex,
        guess;

    while(low <= high) {
        guessIndex = Math.floor((low + high)/2);
        guess = list[guessIndex];
        if(guess === item) {
            return guessIndex;
        } else if(guess < item) {
            low = guessIndex + 1;
        } else if (guess > item) {
            high = guessIndex - 1;
        }
    }
    return -1;
}

{% endhighlight %}

And an example of it's use:

{% highlight javascript %}

// a function to generate a list of numbers
var numbers = makeNumberList(0, 1000);
// a hard coded list of states
var states = ['Alabama','Alaska','Arizona','Arkansas','California','Colorado','Connecticut','Delaware','Florida','Georgia','Hawaii','Idaho','Illinois Indiana','Iowa','Kansas','Kentucky','Louisiana','Maine','Maryland','Massachusetts','Michigan','Minnesota','Mississippi','Missouri','Montana Nebraska','Nevada','New Hampshire','New Jersey','New Mexico','New York','North Carolina','North Dakota','Ohio','Oklahoma','Oregon','Pennsylvania Rhode Island','South Carolina','South Dakota','Tennessee','Texas','Utah','Vermont','Virginia','Washington','West Virginia','Wisconsin','Wyoming'];

console.log(binarySearch(numbers, 995)); // returns 995, the index of the number 995 in the list.
console.log(binarySearch(states, 'Michigan')); // returns 20, the index of the string 'Michigan' in the list

{% endhighlight %}

And that's about it.  This is a first pass, so I'm sure ill tinker with it and think of a better solution, but more than
likely my next post will be on another algorithm rather than an update to this one.


