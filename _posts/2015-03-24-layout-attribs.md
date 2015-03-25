---
layout: post
date: 2015-03-24
title: "Layout attribs, Angular Material & Polymer"
index: 3
---

<link href="/assets/bower/angular-material/angular-material.css" rel="stylesheet">

<style>

.outline {
    outline: 1px solid #990000;
}

.p10,
[p10] {
    padding: 10px;
}
</style>

### tl;dr

One thing I really enjoyed about
[Polymer](https://www.polymer-project.org/0.5/){:target="_blank"}{:title="Polymer Web Components"}
was using attributes for layout (via
[flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/){:target="_blank"}{:title="A Complete Guide to Flexbox"}).
The [Angular Material](https://github.com/angular/material){:target="_blank"}{:title="Material Design for Angular"} library provides a very similar approach.

# Layout Attributes?

I'm obviously talking about html.  Layout attributes provide an interesting way to give the html
an extra job.  Essentially we extract layout from our CSS, using classes for theme or skin, but
letting the HTML itself describe the basic layout.  The Angular Material library has already done the
grunt work for this, I believe taking its cue from Polymer.  The two libraries are subtly different
in the layout attributes provided, but in the end they meet the same goals.

## But... semantic HTML?!?!

I'm all for semantics html in the appropriate context.  Back in the day when I was first getting into
web development, [CSS Zen Garden](http://www.csszengarden.com/){:target="_blank"} was the greatest site
out there.  It showcased a single html file with over a hundred different css files that completely
changed the look and feel of the page.  Having this kind of separation of html &amp; is extremely
valuable... if the product of your website is content (text) and you need to freshen up the skin
every year or two.

## Application Development Isn't About Text

Application development is a whole different animal.  The product is typically a service, not content.
In this world, the html is throw away, markup that mainly serves the purpose of gluing functionality
together.  The JavaScript and CSS are the components that take the most time to develop.  Finding ways
to make the HTML meaningful, reducing JavaScript & CSS to maintain is a big win.

## A Simple Layout

Simply getting a few divs to line up in a row has been historically far trickier than it should be.
It can be accomplished with floats, inline-block styles, and other tricks, but flex based layout
is finally making it simple to get html to do what we've always wanted it to do.  Take this example,
adding only the [Angular Material CSS file](https://github.com/angular/material/blob/master/src/core/style/layout.scss){:target="_blank"}:

{% highlight html %}

<div layout="row">
    <div> left block </div>
    <div flex> center block </div>
    <div>right block </div>
</div>

{% endhighlight %}

It produces this (with some outlines added to the divs):

<div class="p">
    <div layout="row" class="outline">
        <div class="outline"> left block </div>
        <div flex class="outline"> center block </div>
        <div class="outline">right block </div>
    </div>
</div>

Its not pretty yet, but with two simple attributes on our HTML we have the standard website layout
with a center, left and right column.  How does this work?  Well, the <code>layout="row"</code> attribute
on the outer div changes everything.  Using flexbox, the css rule <code>flex-direction: row;</code> (vendor
prefixes ignored) is applied.  This sets up the main axis to be horizontal, causing the child divs to
line up left to right.

The <code>flex</code> attribute added to the div in the center is pretty neat.  It applies
<code>flex: 1</code> to this div, which basically just says "fill up the extra space".  No width set.
Its a "blocky" kind of element, will not collapse but also will not expand to take up the whole area.
It "knows" how to expand enough to swallow up all the extra pixels left over by it's siblings (which
take up only the space needed by their content).

But what about the spacing?  In the old float days, adding padding or margin to a floated div would
break the layout.  The simplest way to do this was to nest divs or p tags within the parent layout,
applying styles to these components.  With flexbox, the math is taken care of for us.  i'm going to add
a class that will add an arbitrary 10px of padding to all of the divs:

{% highlight html %}

<style>
.p10 {
    padding: 10px;
}
</style>

<div layout="row" class="p10">
    <div class="p10"> left block </div>
    <div flex class="p10"> center block </div>
    <div class="p10">right block </div>
</div>

{% endhighlight %}

Which produces:

<div class="p">
    <div layout="row" class="p10 outline">
        <div class="p10 outline"> left block </div>
        <div flex class="p10 outline"> center block </div>
        <div class="p10 outline">right block </div>
    </div>
</div>

Whoa.  No math.  No need to figure out width + padding + margin (don't forget to add padding and
margin px twice since they are added to both sides) to ensure your floats don't explode.  Flexbox
allows us to trust the browser to do the math.  The padding is applied to the divs, and then the
browser simply adjust everything to fit the given space.  Even the padding on the parent is taken
into account!  This is so much less brittle.

## Adding Our Own Attributes

So far, the attributes used are those provided by Angular Material. But it could be argued that the
10 pixel padding is really for layout purposes.  Therefore, we can change <code>.p10 { padding: 10px}</code>
to <code>[p10] { padding: 10px}</code> to make it a layout attribute as well.  The markup would look like:

{% highlight html %}

<style>
[p10] {
    padding: 10px;
}
</style>

<div layout="row" p10>
    <div p10> left block </div>
    <div flex p10> center block </div>
    <div p10>right block </div>
</div>

{% endhighlight %}

And the results:

<div class="p">
    <div layout="row" p10 class="outline">
        <div p10 class="outline"> left block </div>
        <div p10 flex class="outline"> center block </div>
        <div p10 class="outline">right block </div>
    </div>
</div>

When we drop the <code>class="p10"</code> and replace it with the <code>p10</code> attribute,
the markup becomes much more readable, and our HTML is now clearly declaring the layout to us.
This is very simple, and very powerful.

This post really only scratches the surface of flexbox and attributes.  I'm sure many will still
hate the idea of dirtying up HTML by marrying it to the layout, but in my app development experience,
it is much more satisfying to tweak a few layout attirbutes to make subtle changes to components than
it is to fuss with the cascade of CSS.  CSS has its place, certainly, but I like the approach because
it leaves the framing in the html and lets the CSS control the paint job.

