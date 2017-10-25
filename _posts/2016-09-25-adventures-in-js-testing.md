---
layout: post
date:   2016-09-25
title:  "Adventures in JS Testing"
tags: javascript node.js testing unit e2e karma protractor angular
---


### tl;dr

Finally, I wrote some tests!

# Testing an Angular Directive... a good place to start?

I've been wanting to get serious about writing tests for a couple of years now.  Without a doubt the protection against regressions is extremely appealing.  While working on an Angular module called [Angular Key Value Editor](https://github.com/benjaminapetersen/angular-key-value-editor), I found myself getting more and more uneasy about adding features.  The think was becoming a monster to do regression testing.  Initially, I made a small battalion of html files for manual testing.  All kinds of fun.  Eventually, after reading a bunch of blog posts about testing with Karma (but ignoring a book I had purchased, heh) I bit the bullet.  

Before going any further, here is a [link to the PR](https://github.com/openshift/angular-key-value-editor/commit/64df409446251143ee1f438e196996a062f36429).  I don't know that an Angular Directive is the best thing to cut your teeth on testing with.  The problem is that many of the things that need testing are user interactions, which lends best to E2E style tests.  But according to the [testing pyramid](http://martinfowler.com/bliki/TestPyramid.html) (and another [great article on testing](https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html) from Google), E2E tests are bad.  Unit tests are a much better investment.  

I happen to agree, but ended up writing a number of E2E style tests simply because click events are essential interactions to this directive.  I began with my `test/manual` directory where I put the above mention html files.  Then, using Karma and a gulp task, I wrote a set of E2E style tests in `test/e2e`.  Following that, I wrote some unit tests in `test/unit`.  Initially it was difficult deciding what kind of test to write for each feature.  Some things could be tested either way. Since I absolutely needed generated HTML for pretty much anything to work, driving the browser via E2E seemed to win out.  Manually compiling the directive for a unit test was awkward, but I think my solution to [generating html a few different ways](https://github.com/benjaminapetersen/angular-key-value-editor/blob/master/test/unit/spec/directives/add-row-link.spec.js) to test setting attributes worked out.


Here is a snippet from [one of my test files](https://github.com/benjaminapetersen/angular-key-value-editor/blob/master/test/unit/spec/directives/defaults.spec.js):

{% highlight javascript %}

/* ... */

var withDefaults = function() {
  elem = angular.element('<key-value-editor entries="entries"></key-value-editor>');
};

/* ... */

it('should generate a set-focus class for the key', function() {
  withDefaults();
  standardEntries();
  render();
  scope.$apply();
  var isolate = elem.isolateScope();
  expect(isolate.setFocusKeyClass).toEqual('key-value-editor-set-focus-key-1000');
});

/* ... */

{% endhighlight %}

The flow of named functions seemed to work well.  `withDefaults()` represented the HTML to render, including the attributes set to modify behavior.  Then `standardEntries()` represented a standard set of data to pass to the directive.  Finally `render()` took care of manually compiling the directive.  The `scope.$apply()` call would trigger the digest loop and get the directive into the right state.  After that an `expect()` statement could be written.  Its al ot of setup each time.

On the flip side, [in my e2e tests](https://github.com/benjaminapetersen/angular-key-value-editor/blob/master/test/e2e/cannot-add.js) I found that setup basically involved navigating to the page.  Since its black box and unaware of the details of Angular, it was much easier to get rolling.  No manually compiling HTML, no scope to fuss with, no digest loop to trigger.  I went with the page object approach, and found [this set of slides](http://ramonvictor.github.io/protractor/slides/#/49) pretty helpful.
