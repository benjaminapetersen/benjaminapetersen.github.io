---
layout: post
date:   2016-06-23
title:  "My Angular Modules"
---

### tl;dr

Blogging is hard. I have not posted in a very long time, So to kickstart a habit of posting (even little articles), here is a list of angular modules I've been working on over the past few months.

# A few Angular Mods I've been working on

I've been working for [Red Hat](https://www.redhat.com/en) for over a year now.  Its really been a great workplace.  I started this blog shortly before taking my current position, thus writing more posts has taken a back seat to my ramp-up efforts.  I'm working on a product called [OpenShift](https://github.com/openshift/origin), a Platform-as-a-Service (PaaS), essentially a container orchestration platform built on top of [Kubernetes](http://kubernetes.io/), which is built on top of [Docker](https://www.docker.com/).  Thats a mouthful, probably a run-on sentence, and a lot to digest.  Specifically I contribute to the [web console](https://github.com/openshift/origin-web-console) packaged with OpenShift.  

Since the web console is built with [Angular (1.x)](https://github.com/angular/angular.js), I've spent the last year sharpening my skills with this technology (and lamenting that 2.0 is moving to typescript, but thats another story).

I've spun off a few angular modules, some that have been integrated into OpenShift, and some just for fun.  I'll list them in this post and perhaps write a bit more on the more interesting modules in the future:

- [angular-extension-registry](https://github.com/openshift/angular-extension-registry)
- [angular-element-query](https://github.com/benjaminapetersen/angular-element-query)
- [angular-key-value-editor](https://github.com/benjaminapetersen/angular-key-value-editor)  
- [angular-simple-pubsub](https://github.com/benjaminapetersen/angular-simple-pubsub)
- [angular-hide-if-empty](https://github.com/benjaminapetersen?tab=repositories)
- [angular-promise-for-storage](https://github.com/benjaminapetersen/angular-promise-for-storage)

Rather than alphabetizing, I ranked these by usefulness/viability.  The top repos have been used in real world products, have matured enough to be usable, and perhaps have been registered with [bower](https://bower.io/) or [npm](https://www.npmjs.com/).
