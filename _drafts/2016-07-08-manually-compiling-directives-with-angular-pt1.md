---
layout: post
date:   2016-07-08
title:  "Manually Compiling Directives with Angular pt1"
---

### tl;dr
This is pt1 because I don't quite have the time for a full blog post, but I'm
going to at least share a snippet of code!  Hopefully will explain it more Later
(or just update this post).

# Manually Compiling a Directive with Angular

I wrote a diretive a while back called `angular-extension-registry`.  Its a neat directive that sadly I expect to use very little. It provides the concept of `extension-points` to an Angular app.  If you have ever used anthing like Atom, Sublime Text, Adobe Photoshop or Eclipse, you are probably familiar with the concept of extensions.  Extensions allow you to add additional functionality to the application you are using by installing packages.

The extension registry has been integrated into the OpenShift web console. It is how we are allowing customers using OpenShift to extend the interface. At the moment of writing this, there are only a few extension points defined in the console, but more are expected to turn up.

... Stuff...
