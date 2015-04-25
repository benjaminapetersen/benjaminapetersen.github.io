---
layout: post
date: 2015-04-23
title: "Algorithms 101 - Binary Search"
description: "Taking a look at Grokking Algorithms by Aditya Bhargava and experimenting with Binary Search in JavaScript"
index: 3
---

# Algorithms 101 - Binary Search

<img class="book img-in-text f-right" src="{{'/assets/img/book_grokking_algorithms.jpg' | prepend: site.baseurl}}" />
As someone who has come into a career in software development through unconventional means, I find
myself intrigued by the many things I missed out on by not pursuing a CS/CE degree back in my college
days.  Currently Algorithms are at the top of my list of Curious Things I Want To Explore.  I recently began
working through the book
[Grokking Algorithms](http://www.amazon.com/Grokking-Algorithms-illustrated-programmers-curious/dp/1617292230){:target="_blank"}{:title="Grokking Algorithms"}
by Aditya Bhargava in order to dive into the topic of algorithms.

The first algorithm in the book is binary search.  Binary search is simply a way to find an item in a
list in as few steps as possible.  The point?  Efficiency. We want to efficiently search extremely large
data sets without needing to iterate over every single item in the list.

## The Catch

The catch is that the list must be sorted to be effective (1,2,3,4,5, not 5,3,4,2,1, for example).
With a sorted list, the algorithm is simple. If the list isn't sorted, it simply will not work.


## So how does it work?

Basically, a binary search is used to find the index of the searched item in the list in as few guesses
as possible.  If found, it will return the index of the item. If not, it will return -1 (this is standard).
On each search iteration, if the guess is too large, every item above it will be ignored from this point on.
If the guess is too small, every item below will be ignored.  The cycle is repeated until either the item is
found or the min/max ranges meet, indicating that it does not exist.

## So Whats the Big Deal?

Why is binary search interesting?  Bhargava uses a simple example.  Lets say we have a list of 4 billion
numbers and we need to find one in that list.  WIthout binary search, we would have to loop the entire
list and compare every value to what we are looking for.  That would take a very, very long time. If our
number is the last item in that list, we had to make 4 billion guesses to find it!  But what if we use
binary search?  With a binary search, the maximum number of guesses will be 32. Thirty two!  Thats a lot
less than 4 billion, and a pretty amazing improvement.

## How does it work?

The function is rather simple.  Start with a sorted list.  Check the middle item.  If the guess is right,
win.  If too high, throw away everything higher. If too low, throw away everything lower. Repeat until the
item is found or the minimum and maximum ranges meet.

Lets go back to our list of 4 billion and assume we are looking for the number 32.  In 4 billion, we guess
the half way mark of 2 billion.  Is 2 billion larger than 32? Yup! So, throw away everything greater than
2 billion. We just got rid of a lot of numbers.  Now repeat.  Half way between 0 and 2 billion is 1 billion.
Still too high, throw everything above away.  The next guess will be 500 million.  Again, we throw a lot of
items away. With this algorithm we are able to quickly hone in on to a very small subset of the list to
determine if the item we want exists.

## Is it practical?

Binary search is practical, though I don't find myself using it (directly) very often.  Most of the real
searching I've needed in real world app development required a predicate function for comparison or
transformation. Lists are rarely conveniently sorted, so some sort of prep work is needed.  If I'm going
to transform my list anyway, I tend towards using a hash table, which ensures a single guess lookup, but
thats for a later post.

## My Implementation

My implementation is in JavaScript, the language I work in most regularly. I'm not worried about edge cases
or real world use at this point, just the basic algorithm.  In a real app I'd use a library like
[Underscore.js](http://underscorejs.org/){:target="_blank"}{:title="Underscore.js"},
[lodash](https://lodash.com/){:target="_blank"}{:title="lodash"} or
[Ramda](http://ramdajs.com/docs/){:target="_blank"}{:title="Ramda"}
which are optimized and provide a host of useful tools. (For example, see
[Underscore's indexOf function](http://underscorejs.org/#indexOf){:target="_blank"}, and
to see the actual implementation in Underscore.js, checkout the
[annotated source](http://underscorejs.org/docs/underscore.html){:target="_blank"}, and search for the
function `createIndexFinder()`.

My simple implementation is as follows:

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
// a hardcoded list of states
var states = ['Alabama','Alaska','Arizona','Arkansas','California','Colorado','Connecticut','Delaware','Florida','Georgia','Hawaii','Idaho','Illinois Indiana','Iowa','Kansas','Kentucky','Louisiana','Maine','Maryland','Massachusetts','Michigan','Minnesota','Mississippi','Missouri','Montana Nebraska','Nevada','New Hampshire','New Jersey','New Mexico','New York','North Carolina','North Dakota','Ohio','Oklahoma','Oregon','Pennsylvania Rhode Island','South Carolina','South Dakota','Tennessee','Texas','Utah','Vermont','Virginia','Washington','West Virginia','Wisconsin','Wyoming'];

console.log(binarySearch(numbers, 995)); // returns 995, the index of the number 995 in the list.
console.log(binarySearch(states, 'Michigan')); // returns 20, the index of the string 'Michigan' in the list

{% endhighlight %}

And that's about it.  This is a first pass, so I'm sure ill tinker with it and think of a better solution, but more than
likely my next post will be on another algorithm rather than an update to this one.



