---
layout: post
date:   2016-10-28
title:  "Loops With Less"
tags: less, sass, css
---

# Loops With less

When I write CSS I like to use utility classes.  When I write
JavaScript, I like to use utility functions.  Utilities are basically
just small, laser focused bits of code.  Underscore and Lodash
provide a great set of utilities for JS, but I find that CSS utilities
often have to be written from scratch.

The following snippet of code is [from a LESS file I wrote](https://github.com/openshift/origin-web-console/commit/b8751aa771d6cc200bb5b2009278dad4cc615f60) a while back
to generate a handful of utility classes:

{% highlight sass %}
// Spacing utility classes
// creates:
//  .pad-sm, .pad-md, .pad-lg, etc
//  .mar-sm, .mar-md, .mar-lg, etc
//  .pad-left-sm, .mar-left-sm, etc
//
@nil: none 0 e('!important');
// @auto 0 auto; is built into the fn below
@xs: xs 3px e('');
@sm: sm 5px e('');
@md: md 10px e('');
@lg: lg 15px e('');
@xl: xl 20px e('');
@xxl: xxl 30px e('');

@sizes: @nil, @xs, @sm, @md, @lg, @xl, @xxl;
@sides: top, right, bottom, left;

.spacer-side(@list, @size, @px, @mod, @i:1) when (@i <= length(@list)) {
  @side: extract(@list, @i);
  .pad-@{side}-@{size} {
    padding-@{side}: @px @mod;
  }
  .mar-@{side}-@{size} {
    margin-@{side}: @px @mod;
  }
  .spacer-side(@list, @size, @px, @mod, @i+1);
}

.spacers(@list, @i:1) when (@i <= length(@list)) {
  @item: extract(@list, @i);
  @key: extract(@item, 1);
  @val: extract(@item, 2);
  @mod: extract(@item, 3);
  .pad-auto-@{key} {
    padding: 0 auto;
  }
  .mar-auto-@{key} {
    margin: 0 auto;
  }
  .pad-@{key} {
    padding: @val @val * 1.5;
  }
  .mar-@{key} {
    margin: @val @val * 1.5;
  }
  .spacer-side(@sides, @key, @val, @mod);
  .spacers(@list, @i+1);
}

.spacers(@sizes);
{% endhighlight %}

The output looks like this:

{% highlight css %}
.pad-auto-none{padding:0 auto}
.mar-auto-none{margin:0 auto}
.pad-none{padding:0}
.mar-none{margin:0}
.pad-top-none{padding-top:0!important}
.mar-top-none{margin-top:0!important}
.pad-right-none{padding-right:0!important}
.mar-right-none{margin-right:0!important}
.pad-bottom-none{padding-bottom:0!important}
.mar-bottom-none{margin-bottom:0!important}
.pad-left-none{padding-left:0!important}
.mar-left-none{margin-left:0!important}
.pad-auto-xs{padding:0 auto}
.mar-auto-xs{margin:0 auto}
.pad-xs{padding:3px 4.5px}
.mar-xs{margin:3px 4.5px}
.pad-top-xs{padding-top:3px}
.mar-top-xs{margin-top:3px}
.pad-right-xs{padding-right:3px}
.mar-right-xs{margin-right:3px}
.pad-bottom-xs{padding-bottom:3px}
.mar-bottom-xs{margin-bottom:3px}
.pad-left-xs{padding-left:3px}
.mar-left-xs{margin-left:3px}
.pad-auto-sm{padding:0 auto}
.mar-auto-sm{margin:0 auto}
.pad-sm{padding:5px 7.5px}
.mar-sm{margin:5px 7.5px}
.pad-top-sm{padding-top:5px}
.mar-top-sm{margin-top:5px}
.pad-right-sm{padding-right:5px}
.mar-right-sm{margin-right:5px}
.pad-bottom-sm{padding-bottom:5px}
.mar-bottom-sm{margin-bottom:5px}
.pad-left-sm{padding-left:5px}
.mar-left-sm{margin-left:5px}
.pad-auto-md{padding:0 auto}
.mar-auto-md{margin:0 auto}
.pad-md{padding:10px 15px}
.mar-md{margin:10px 15px}
.pad-top-md{padding-top:10px}
.mar-top-md{margin-top:10px}
.pad-right-md{padding-right:10px}
.mar-right-md{margin-right:10px}
.pad-bottom-md{padding-bottom:10px}
.mar-bottom-md{margin-bottom:10px}
.pad-left-md{padding-left:10px}
.mar-left-md{margin-left:10px}
.pad-auto-lg{padding:0 auto}
.mar-auto-lg{margin:0 auto}
.pad-lg{padding:15px 22.5px}
.mar-lg{margin:15px 22.5px}
.pad-top-lg{padding-top:15px}
.mar-top-lg{margin-top:15px}
.pad-right-lg{padding-right:15px}
.mar-right-lg{margin-right:15px}
.pad-bottom-lg{padding-bottom:15px}
.mar-bottom-lg{margin-bottom:15px}
.pad-left-lg{padding-left:15px}
.mar-left-lg{margin-left:15px}
.pad-auto-xl{padding:0 auto}
.mar-auto-xl{margin:0 auto}
.pad-xl{padding:20px 30px}
.mar-xl{margin:20px 30px}
.pad-top-xl{padding-top:20px}
.mar-top-xl{margin-top:20px}
.pad-right-xl{padding-right:20px}
.mar-right-xl{margin-right:20px}
.pad-bottom-xl{padding-bottom:20px}
.mar-bottom-xl{margin-bottom:20px}
.pad-left-xl{padding-left:20px}
.mar-left-xl{margin-left:20px}
.pad-auto-xxl{padding:0 auto}
.mar-auto-xxl{margin:0 auto}
.pad-xxl{padding:30px 45px}
.mar-xxl{margin:30px 45px}
.pad-top-xxl{padding-top:30px}
.mar-top-xxl{margin-top:30px}
.pad-right-xxl{padding-right:30px}
.mar-right-xxl{margin-right:30px}
.pad-bottom-xxl{padding-bottom:30px}
.mar-bottom-xxl{margin-bottom:30px}
.pad-left-xxl{padding-left:30px}
.mar-left-xxl{margin-left:30px}
{% endhighlight %}

Usage is something like this (with a little flex mixed in):
{% highlight html %}
<div class="flex-column mar-md pad-sm">
  <div class="flex mar-sm pad-sm">
    Hello
  </div>
  <div class="mar-md pad-md">
    World
  </div>
</div>
{% endhighlight %}

The above could definitely start a war over semantics (I've had that
debate regarding this code) but I'm more in the object oriented CSS
camp (or any that values CSS highly and treats the HTML as "throwaway").

I've not written a lot of Less and found the need to use recursion rather
than a built-in 'for' or 'each' loop a little strange.  Still, it was
interesting working out a way to build nested lists and iterate through them
in this new language.  I intend to write the same thing in SASS soon for the
sake of comparison.
